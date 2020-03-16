Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FB71860C5
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 01:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgCPA2V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 20:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbgCPA2U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Mar 2020 20:28:20 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E12C7205ED;
        Mon, 16 Mar 2020 00:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584318499;
        bh=7mS3ixlj3Z2fEufutJZBKCVTlxROm0o1iSECfEWYPus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kj2QyDQgDqMp3oWKZVS49hoxbhcJ/SEABJVxKM04nCqfSe2w+BJ2BWY1e/kiIKZam
         lgwtJEsQ5HS4dobQ+gsyXayKxneTQBPsR2s3Gcpcgj8Ifb+0HH4JdYJvF8O1X5JWpv
         UgJ8cXyz6Sj8Ns5lqRnIEQ3sEeNlDYXgvvb2OlSk=
Date:   Mon, 16 Mar 2020 08:28:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        dmitry.torokhov@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        wim@linux-watchdog.org, linux@roeck-us.net, daniel.baluta@nxp.com,
        linux@rempel-privat.de, gregkh@linuxfoundation.org,
        tglx@linutronix.de, m.felsch@pengutronix.de,
        andriy.shevchenko@linux.intel.com, arnd@arndb.de, robh@kernel.org,
        yuehaibing@huawei.com, ronald@innovation.ch, krzk@kernel.org,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Message-ID: <20200316002803.GL29269@dragon>
References: <1583544359-515-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583544359-515-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Mar 07, 2020 at 09:25:53AM +0800, Anson Huang wrote:
> Add stubs for those i.MX SCU APIs to make those modules depending
> on IMX_SCU can pass build when COMPILE_TEST is enabled.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Already had such a patch from Peng Fan.

Shawn

> ---
> new patch.
> ---
>  include/linux/firmware/imx/ipc.h | 11 +++++++++++
>  include/linux/firmware/imx/sci.h | 19 +++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/include/linux/firmware/imx/ipc.h b/include/linux/firmware/imx/ipc.h
> index 8910574..3fff0e2 100644
> --- a/include/linux/firmware/imx/ipc.h
> +++ b/include/linux/firmware/imx/ipc.h
> @@ -34,6 +34,7 @@ struct imx_sc_rpc_msg {
>  	uint8_t func;
>  };
>  
> +#ifdef CONFIG_IMX_SCU
>  /*
>   * This is an function to send an RPC message over an IPC channel.
>   * It is called by client-side SCFW API function shims.
> @@ -55,4 +56,14 @@ int imx_scu_call_rpc(struct imx_sc_ipc *ipc, void *msg, bool have_resp);
>   * @return Returns an error code (0 = success, failed if < 0)
>   */
>  int imx_scu_get_handle(struct imx_sc_ipc **ipc);
> +#else
> +static inline int imx_scu_call_rpc(struct imx_sc_ipc *ipc, void *msg, bool have_resp)
> +{
> +	return 0;
> +}
> +static inline int imx_scu_get_handle(struct imx_sc_ipc **ipc)
> +{
> +	return 0;
> +}
> +#endif
>  #endif /* _SC_IPC_H */
> diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
> index 17ba4e4..4688b60 100644
> --- a/include/linux/firmware/imx/sci.h
> +++ b/include/linux/firmware/imx/sci.h
> @@ -16,8 +16,27 @@
>  #include <linux/firmware/imx/svc/misc.h>
>  #include <linux/firmware/imx/svc/pm.h>
>  
> +#ifdef CONFIG_IMX_SCU
>  int imx_scu_enable_general_irq_channel(struct device *dev);
>  int imx_scu_irq_register_notifier(struct notifier_block *nb);
>  int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
>  int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable);
> +#else
> +static inline int imx_scu_enable_general_irq_channel(struct device *dev)
> +{
> +	return 0;
> +}
> +static inline int imx_scu_irq_register_notifier(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +static inline int imx_scu_irq_unregister_notifier(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +static inline int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
> +{
> +	return 0;
> +}
> +#endif
>  #endif /* _SC_SCI_H */
> -- 
> 2.7.4
> 
