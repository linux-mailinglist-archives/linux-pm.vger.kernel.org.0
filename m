Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E31E6B2835
	for <lists+linux-pm@lfdr.de>; Thu,  9 Mar 2023 16:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCIPGQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Mar 2023 10:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjCIPF5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2023 10:05:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFAF31E05
        for <linux-pm@vger.kernel.org>; Thu,  9 Mar 2023 07:03:30 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1paHnj-0000VI-0M; Thu, 09 Mar 2023 16:03:27 +0100
Message-ID: <700de2ce-36f6-6140-92d5-75175eb709d6@pengutronix.de>
Date:   Thu, 9 Mar 2023 16:03:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: NOC (interconnect) lockup on i.MX8MP during resume
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>
References: <2176690.usQuhbGJ8B@steina-w>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <2176690.usQuhbGJ8B@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Alexander,

On 09.03.23 15:57, Alexander Stein wrote:
> Hi,
> 
> while debugging another issue regarding suspend/resume I noticed that the imx
> interconnect driver locks up the system when writing into registers. This
> happens during resume of the 'g2' power domain. imx8m_blk_ctrl_power_on()
> will eventually call down to imx_icc_node_set(). Using the debug diff furthe
> down I get this output:
> 
> [   71.493062] imx_icc_node_set: node: VPU G2
> [   71.497163] imx_icc_node_set: peak_bw: 1
> [   71.501091] imx_icc_node_set: prio: 0x80000303
> <freeze here>
> 
> Unfortunately there is absolutely no documentation regarding NOC in the
> reference manual, so no idea whats happening here.
> This is on next-20230309 using imx8mp-tqma8mpql-mba8mpxl.dts with USB
> disabled (prevents suspend) and Ethernet-PHY-IRQ disabled (the issue I'm
> tackling).
> Is there some idea what do in order to support resume on i.MX8MP?

Could it be that you don't have a fully featured 8MP, but a 8MPUL
or 8MPL, which lacks VPUs? In that case, it's not enough to disable
the VPU nodes in the DT, but you need to disable the VPU power domains as well.

Cheers,
Ahmad

> 
> Best regards,
> Alexander
> 
> ---8<---
> diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
> index 979ed610f704..93ec79cc7c06 100644
> --- a/drivers/interconnect/imx/imx.c
> +++ b/drivers/interconnect/imx/imx.c
> @@ -44,13 +44,18 @@ static int imx_icc_node_set(struct icc_node *node)
>         u32 prio;
>         u64 freq;
>  
> +       pr_info("%s: node: %s\n", __func__, node->name);
> +       pr_info("%s: peak_bw: %u\n", __func__, node->peak_bw);
>         if (node_data->setting && node->peak_bw) {
>                 base = node_data->setting->reg + node_data->imx_provider->noc_base;
>                 if (node_data->setting->mode == IMX_NOC_MODE_FIXED) {
>                         prio = node_data->setting->prio_level;
>                         prio = PRIORITY_COMP_MARK | (prio << 8) | prio;
> +                       pr_info("%s: prio: %#x\n", __func__, prio);
>                         writel(prio, base + IMX_NOC_PRIO_REG);
> +                       pr_info("%s: mode: %#x\n", __func__, node_data->setting->mode);
>                         writel(node_data->setting->mode, base + IMX_NOC_MODE_REG);
> +                       pr_info("%s: ext_control: #%x\n", __func__, node_data->setting->ext_control);
>                         writel(node_data->setting->ext_control, base + IMX_NOC_EXT_CTL_REG);
>                         dev_dbg(dev, "%s: mode: 0x%x, prio: 0x%x, ext_control: 0x%x\n",
>                                 node_data->desc->name, node_data->setting->mode, prio,
> ---8<---
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

