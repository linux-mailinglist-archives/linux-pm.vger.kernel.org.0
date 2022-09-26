Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEC35E9706
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 02:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiIZAEk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Sep 2022 20:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIZAEi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Sep 2022 20:04:38 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE4726E8
        for <linux-pm@vger.kernel.org>; Sun, 25 Sep 2022 17:04:35 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 47F3B84AEB;
        Mon, 26 Sep 2022 02:04:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1664150673;
        bh=j349grgiD+qDGFyqq7yYemiJ/SibokcKVoA3tOP6tso=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=L6jOFk27Emj1l4xEvxKViGQcJzOUo1eRHFyI2MM8wivdk+zPbVA1/gJOFM7OnS41q
         uoEgpf4HTt99fswgTBGZLTxsYDlkCY/ouYBrchvnVfEFbGlh7I2gtyC6nCP4aDnQT6
         kA5QGhNC82FVuTGCLgKYZ7KbD7HAUV4Q2/wr6sTDyf8B98+vo4ZC6/QhOer+c5nJ3B
         D1QEXTrKD+NsfCdWKr7AYVnDPUG2bbM1JsqKsOEkNXHr+YqBDsYHxqS1uHJW+nzjns
         msxTXINn4wJ84fJYkTsYGGR4YlEJpzYxMk9xueok7vBh+5ezwVxaybiEDvjj6akfc6
         iU8EphBx1EzDw==
Message-ID: <09bb716b-1f6b-c422-8469-fd2a0ac9f946@denx.de>
Date:   Mon, 26 Sep 2022 02:04:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Help: i.MX8MP AUDIOMIX BLK-CTRL CLK driver support
To:     Peng Fan <peng.fan@oss.nxp.com>, abelvesa@kernel.org,
        Lucas Stach <l.stach@pengutronix.de>, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        aisheng.dong@nxp.com, kernel@pengutronix.de,
        Shawn Guo <shawnguo@kernel.org>, s.hauer@pengutronix.de,
        festevam@gmail.com, Stephen Boyd <sboyd@kernel.org>
References: <d23cacb6-4914-7eba-ed6e-c8490b9b771a@oss.nxp.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <d23cacb6-4914-7eba-ed6e-c8490b9b771a@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/23/22 05:41, Peng Fan wrote:
> Hi All,

Hi,

> I would start a discussion about the A/B B/A lock issue when make 
> audiomix blk ctrl function as clk provider.
> 
> I not have good idea on this, hope you have any suggestions.
> 
> major issue is: the blk ctrl clk has a power domain supplier
> The power domain supplier also use clk API to prepare_enable clks.
> The blk ctrl clk driver has runtime pm enabled.
> 
> The NXP downstream:
> The dts:
> https://github.com/nxp-imx/linux-imx/blob/lf-5.15.y/arch/arm64/boot/dts/freescale/imx8mp.dtsi#L1872
> 
> The driver:
> https://github.com/nxp-imx/linux-imx/blob/lf-5.15.y/drivers/clk/imx/clk-imx8mp.c
> https://github.com/nxp-imx/linux-imx/blob/lf-5.15.y/drivers/clk/imx/clk-blk-ctrl.c
> 
> Note: The following log was reproduced with NXP downstream. For upstream
> I think we have similar issue if we still take audiomix blk ctrl as clk
> driver. Because the gpcv2 also use clk prepare enable API.
> 1. deadlock 1:
> Callchain after enable some lock debug:
> clk_ignore_unused will use lock seq: take prepare lock, take blk-ctrl 
> parent power domain genpd lock
> genpd_power_off_work_fun will use lock seq: take the power domain genpd 
> lock, take prepare lock.

There is also this driver which does not suffer from the problem, at 
least I didn't trigger it while using it for months:

https://patchwork.kernel.org/project/linux-clk/patch/20220625013235.710346-3-marex@denx.de/
