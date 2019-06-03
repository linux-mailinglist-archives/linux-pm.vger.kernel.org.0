Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F83280E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 07:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfFCFi6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 01:38:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42167 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfFCFi6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 01:38:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so6343848pgd.9
        for <linux-pm@vger.kernel.org>; Sun, 02 Jun 2019 22:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6l/t3TPXvfJk0FS5YLye4jJo2DVIjuavG0t1rw643+k=;
        b=ktlv2Mm+By5P70XspYlFjdpSJ4FlQUI0eZS4JlIBkO/7/R5LyitYYA50M/cEXEQ2sA
         nqUh/zQ26C7HTbHeGzl8tZcGwKECYp61JdNHaqddmXtgebc8aWJJ37uZr/ARaS907BpA
         mPqLEydS8bIEj2b2bfV+te5IErDpqLzBS53VmN9aPDNau0llfo7GMgeNt2UZ/UcODWhS
         DwSbpELYfj5kPrLS2W4tM3uLQwjuGFtCSTH0yXivvXXY26bjZnkAxR2rRCQKCsCRjjXd
         bOn/eFPHnIKuX75JrjoTEu0NHK9AQ/y4Iaw4vSh4u/vCMV8qObPUWooWjoB5k+0A5H94
         rVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6l/t3TPXvfJk0FS5YLye4jJo2DVIjuavG0t1rw643+k=;
        b=Ta40moN/rJhMIr7yVG+yiawcB3ngWuIKuNpZce4gHcbALsXZ4kc782FgNDMY5ph868
         6j2aWNIyizTu5rbbClu4mMopXufS5iEoWYhckVMkRCM5bFNnH1leF4XonUObI9mkJRNP
         OahH6Yua7tavudk+kywkM6Vap7Dznib5g+K+VqGZftwsvlR6QelDoKnlsiEjNYk3ni03
         7wqgSBVUNgZJhsd9Hh0+1Ndkw1oaRlFXW/PUH4+C6xO0x2mvZnufKB2pKvkrxIZBLkir
         acSnDc80LO/yhDTb5JfOgr7aQ5TiQ02slpOG8FmL34xnd3ITqxtMa8997F6c0UiBLBFs
         8/2A==
X-Gm-Message-State: APjAAAWEusZbA4Nu6Np7f1KSXrZzkr95V3Hkb5SQXY+oAEGIrfkauPIH
        DcF3XRb2diHyCb5p1FiVoeI5iA==
X-Google-Smtp-Source: APXvYqxPwjgggsw3vyhv07YeyRgvqkFWuIU3POtBpFlAjIwDxc07WYB9GVgYDELUGf58CTZeMA36Dw==
X-Received: by 2002:a17:90a:de14:: with SMTP id m20mr27355763pjv.36.1559540337621;
        Sun, 02 Jun 2019 22:38:57 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id w187sm15573923pfb.4.2019.06.02.22.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 22:38:53 -0700 (PDT)
Date:   Mon, 3 Jun 2019 11:08:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] cpufreq: Switch imx7d to imx-cpufreq-dt for speed
 grading
Message-ID: <20190603053850.tkskdzcloir4k3kw@vireshk-i7>
References: <b6a9b9f80534af5c12db30a0bb699ec850f85be7.1559131365.git.leonard.crestez@nxp.com>
 <8787934ff35e7e55837f2caabc0d5bf65828d971.1559131365.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8787934ff35e7e55837f2caabc0d5bf65828d971.1559131365.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-05-19, 12:03, Leonard Crestez wrote:
> This driver can handle speed grading bits on imx7d just like on imx8mq
> and imx8mm.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  arch/arm/mach-imx/mach-imx7d.c       | 7 +++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 +-
>  drivers/cpufreq/imx-cpufreq-dt.c     | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
> index 26ca744d3e2b..0b77412795c9 100644
> --- a/arch/arm/mach-imx/mach-imx7d.c
> +++ b/arch/arm/mach-imx/mach-imx7d.c
> @@ -95,10 +95,16 @@ static void __init imx7d_init_machine(void)
>  
>  	imx_anatop_init();
>  	imx7d_enet_init();
>  }
>  
> +static void __init imx7d_init_late(void)
> +{
> +	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
> +		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
> +}
> +
>  static void __init imx7d_init_irq(void)
>  {
>  	imx_init_revision_from_anatop();
>  	imx_src_init();
>  	irqchip_init();
> @@ -111,7 +117,8 @@ static const char *const imx7d_dt_compat[] __initconst = {
>  };
>  
>  DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual (Device Tree)")
>  	.init_irq	= imx7d_init_irq,
>  	.init_machine	= imx7d_init_machine,
> +	.init_late      = imx7d_init_late,
>  	.dt_compat	= imx7d_dt_compat,
>  MACHINE_END
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 19c1aad57e26..eb282dff9f2c 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -38,11 +38,10 @@ static const struct of_device_id whitelist[] __initconst = {
>  	{ .compatible = "hisilicon,hi3660", },
>  
>  	{ .compatible = "fsl,imx27", },
>  	{ .compatible = "fsl,imx51", },
>  	{ .compatible = "fsl,imx53", },
> -	{ .compatible = "fsl,imx7d", },
>  
>  	{ .compatible = "marvell,berlin", },
>  	{ .compatible = "marvell,pxa250", },
>  	{ .compatible = "marvell,pxa270", },
>  
> @@ -106,10 +105,11 @@ static const struct of_device_id whitelist[] __initconst = {
>   */
>  static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "calxeda,highbank", },
>  	{ .compatible = "calxeda,ecx-2000", },
>  
> +	{ .compatible = "fsl,imx7d", },
>  	{ .compatible = "fsl,imx8mq", },
>  	{ .compatible = "fsl,imx8mm", },
>  
>  	{ .compatible = "marvell,armadaxp", },
>  
> diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
> index 5061503cb0a1..ce26ffc18ce6 100644
> --- a/drivers/cpufreq/imx-cpufreq-dt.c
> +++ b/drivers/cpufreq/imx-cpufreq-dt.c
> @@ -18,10 +18,11 @@
>  #define OCOTP_CFG3_SPEED_GRADE_MASK	(0x3 << 8)
>  #define OCOTP_CFG3_MKT_SEGMENT_SHIFT    6
>  #define OCOTP_CFG3_MKT_SEGMENT_MASK     (0x3 << 6)
>  
>  static const struct of_device_id imx_cpufreq_dt_match_list[] = {
> +	{ .compatible = "fsl,imx7d" },
>  	{ .compatible = "fsl,imx8mm" },
>  	{ .compatible = "fsl,imx8mq" },
>  	{}
>  };

What is the purpose of this array and can we get rid of it instead ? I am asking
as this driver gets probed only if the platform code has created the
imx-cpufreq-dt device and it shouldn't get created for other machines than what
is supported.

-- 
viresh
