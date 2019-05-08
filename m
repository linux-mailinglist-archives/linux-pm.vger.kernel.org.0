Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A98616FB4
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 05:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfEHDyH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 23:54:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46615 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfEHDyH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 23:54:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id j11so9736094pff.13
        for <linux-pm@vger.kernel.org>; Tue, 07 May 2019 20:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cVIqQuQhPNK8bauPkhz1EwiDMHC+lDayWMP+2CUUfv0=;
        b=DhU6DoiKidW/7p6JsZv10IZ/XDAWdrhdxkMqTcB+c0Qdhxwatdtvd57A02FxSV/pyX
         mCHLQyV0CgIToWefPLues8oVW5cmhEMZEjFHmJ9BJHdneraVo3PGQRhMfpB+eEKRKH3u
         HzA/4I5+nmpMdFakyMCTX//lwuxC7Xcp+Z+TJ11hYWfMQQLswPAzrusv2hQlhdxPVudn
         faH4mp2I3YnSMUD2S3Pj0lXxdMLkRPBNnC+SE7Qes1Cvs4hjO01b+h25Qge4pzDTs72W
         1nYxvEYOrjOQJcUb/TL8lJodz1/EZVenBG+XNl7pV132kvdLBsfBsYmXeOr2xaL9erUW
         T5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cVIqQuQhPNK8bauPkhz1EwiDMHC+lDayWMP+2CUUfv0=;
        b=a9WUwjCOC4QlnVZQ3NnnQfdElvEkB7fGVziOwNlBn4rwdGR/jwS9ijMj6+f8nn0OzQ
         SjpPZiKkqRj7SagEDiMXyJjgedEsu9nFsTHVWBlJsoGYhZvV8bP2BmBCeecFLKphtNml
         s2v+wzztbEvzQzusItc/Ui8E2eBAJE4DxHH9N8Nem8EijN90GLWx8O/0NPjSOorMoVFm
         Sg4XJFS/lQnMuA6vH7smP2MUxs8bsOUNFoWT0zTHkhvwr41Ffv7K5RJ9r4W7QijabKDq
         bQF93Cmywa6HazCYFeoMWUSOq6BDpRqkYjcN3pisUYl4KBoyIAErJZg3Gj7BkdAYfOef
         9JmA==
X-Gm-Message-State: APjAAAXA29yXnLwnVoWCjHF3Y9HmtkOBxr5KWgbe3pl353YPSKoPZ7O1
        uHiFfIFUaa5W8Yh6ZI2Tf+9x7Q==
X-Google-Smtp-Source: APXvYqxfvhpxtDtzrYT9I5+J5woyqtPOqke43/sMpYFxgaxbSBZA6lUQ9FQDpN6Smn0aLtYKbbTrZg==
X-Received: by 2002:a63:360e:: with SMTP id d14mr44517659pga.188.1557287646303;
        Tue, 07 May 2019 20:54:06 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id 13sm18559568pfi.172.2019.05.07.20.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 20:54:04 -0700 (PDT)
Date:   Wed, 8 May 2019 09:24:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/4] cpufreq: Add imx-cpufreq-dt driver
Message-ID: <20190508035402.7pbikzpkzxxesmlw@vireshk-i7>
References: <cover.1557236799.git.leonard.crestez@nxp.com>
 <607242a278a4532d0b4285e0fb56abfd5767fdd1.1557236799.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <607242a278a4532d0b4285e0fb56abfd5767fdd1.1557236799.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-05-19, 13:52, Leonard Crestez wrote:
> Right now in upstream imx8m cpufreq support just lists a common subset
> of OPPs because the higher ones should only be attempted after checking
> speed grading in fuses.
> 
> Add a small driver which checks speed grading from nvmem cells before
> registering cpufreq-dt.
> 
> This driver allows unlocking all frequencies for imx8mm and imx8mq and
> could be applied to other chips like imx7d
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> ---
>  drivers/cpufreq/Kconfig.arm          | 10 +++
>  drivers/cpufreq/Makefile             |  1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |  3 +
>  drivers/cpufreq/imx-cpufreq-dt.c     | 96 ++++++++++++++++++++++++++++
>  drivers/soc/imx/soc-imx8.c           |  3 +
>  5 files changed, 113 insertions(+)
>  create mode 100644 drivers/cpufreq/imx-cpufreq-dt.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 179a1d302f48..78ed9ef49e68 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -90,10 +90,20 @@ config ARM_IMX6Q_CPUFREQ
>  	help
>  	  This adds cpufreq driver support for Freescale i.MX6 series SoCs.
>  
>  	  If in doubt, say N.
>  
> +config ARM_IMX_CPUFREQ_DT
> +	tristate "Freescale i.MX8M cpufreq support"
> +	depends on ARCH_MXC && CPUFREQ_DT
> +	default m if ARCH_MXC && CPUFREQ_DT

As I said in the previous version, the if block above is redundant and
not required.

> +	help
> +	  This adds cpufreq driver support for Freescale i.MX8M series SoCs,
> +	  based on cpufreq-dt.
> +
> +	  If in doubt, say N.

-- 
viresh
