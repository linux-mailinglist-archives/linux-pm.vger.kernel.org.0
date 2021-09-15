Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2424240BE57
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 05:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbhIODjL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Sep 2021 23:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhIODjK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Sep 2021 23:39:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767BBC061574;
        Tue, 14 Sep 2021 20:37:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b7so1381559pfo.11;
        Tue, 14 Sep 2021 20:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=spn4en1wfCALlInYrzPB6PufsSAlB1YYpPOo+pD9FLo=;
        b=E+ckviagp6gxglvMpmTOPvzOomn6/c07uTzDVb/K3hOs7n+xuIZVucN+PrsQEWBQrP
         X/CQKhzx7ATsswuT6qEQHtwg7CkFvsIxxmS/45XLabsQ/dZGekih9oJ9+0jrwKNaaiLr
         f+rpxSPsZ9Fx8txUlqxFunsDyt8lMFjgHOdSUi49oHJreNtfDqtGu0LcuCdNDInX7FC4
         UY2Ozyxhlln4DtkhhGl4Kg7d3Gy2dDpYuvJOyuwVRJf9kd/WPAGzhq2C9AWL57fz1mST
         nbG6tAnAR9LoY0fgVedqP6Q+IiCqRoofbnK5G39Qw+Tjg44cF8de7oJTH1lUB+xoktu2
         QRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=spn4en1wfCALlInYrzPB6PufsSAlB1YYpPOo+pD9FLo=;
        b=XdktAZ2Q0wj6qo7QVrbG2XjlAH4dicL02L8lTM2BXzQ/yNl4Xv9JHEP2K+UIrnHfz9
         uhXxr4Kupqm8YvZCDg5ctJwqhq2RV+BlzqhBvVOCzsNPDwrkKbwCUBfezveAo1yMBZgy
         kGSKJa+fnW9PSZapR7cxKZUT/rGTtM1wuaMvR9F7jmHvGt1UUwvmj+bjtWYjPTg+TYYM
         Edil4zb62UwP7mP+dCue7Y4Kb0LfCj96MgeDkDxFRxvquzOEyik6IJleieJ/3fR5GdjG
         9sKYwbrw1lP+EYvPhboMIWWDT+wa8yIBI74aLWMnErWMMpbWKKRycrDtV6FfDR/uGE6m
         GaKg==
X-Gm-Message-State: AOAM532ps3B1sQTXHGRUFwatCyIEIO+3cknL7xL/Ohv/YZ76yl+NCa2D
        enM11egVgVUK/6GZjp3OVaU=
X-Google-Smtp-Source: ABdhPJzSEyDgqJC609VHGYsT1KbShRf/0W/gwbOvhh5jQ+uWJAK6pkqMx+HcWxCDriM8hYYTvySZ0w==
X-Received: by 2002:a62:55c2:0:b0:3ec:c066:495c with SMTP id j185-20020a6255c2000000b003ecc066495cmr8275916pfb.38.1631677071899;
        Tue, 14 Sep 2021 20:37:51 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id 73sm11934665pfu.92.2021.09.14.20.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 20:37:51 -0700 (PDT)
Subject: Re: [RFC 06/19] devfreq: imx8m-ddrc: Add late system sleep PM ops
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
 <1631554694-9599-7-git-send-email-abel.vesa@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <dbb4f5a5-e303-7df2-9d42-819a4abac98b@gmail.com>
Date:   Wed, 15 Sep 2021 12:37:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1631554694-9599-7-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

As I commented on patch5, you keep the OPP list on devicetree file
and then you better to use the 'suspend_opp' property
for setting the highest frequency during suspend/resume.

On 21. 9. 14. 오전 2:38, Abel Vesa wrote:
> Seems that, in order to be able to resume from suspend, the dram rate
> needs to be the highest one available. Therefore, add the late system
> suspend/resume PM ops which set the highest rate on suspend and the
> latest one used before suspending on resume.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>   drivers/devfreq/imx8m-ddrc.c | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index f18a5c3c1c03..f39741b4a0b0 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -72,6 +72,8 @@ struct imx8m_ddrc {
>   	struct clk *dram_alt;
>   	struct clk *dram_apb;
>   
> +	unsigned long suspend_rate;
> +	unsigned long resume_rate;
>   	int freq_count;
>   	struct imx8m_ddrc_freq freq_table[IMX8M_DDRC_MAX_FREQ_COUNT];
>   };
> @@ -271,6 +273,22 @@ static int imx8m_ddrc_target(struct device *dev, unsigned long *freq, u32 flags)
>   	return ret;
>   }
>   
> +static int imx8m_ddrc_suspend(struct device *dev)
> +{
> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> +
> +	priv->resume_rate = clk_get_rate(priv->dram_core);
> +
> +	return imx8m_ddrc_target(dev, &priv->suspend_rate, 0);
> +}
> +
> +static int imx8m_ddrc_resume(struct device *dev)
> +{
> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> +
> +	return imx8m_ddrc_target(dev, &priv->resume_rate, 0);
> +}
> +
>   static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long *freq)
>   {
>   	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> @@ -324,6 +342,9 @@ static int imx8m_ddrc_init_freq_info(struct device *dev)
>   
>   		if (dev_pm_opp_add(dev, freq->rate * 250000, 0))
>   			return -ENODEV;
> +
> +		if (index ==  0)
> +			priv->suspend_rate = freq->rate * 250000;
>   	}
>   
>   	return 0;
> @@ -399,11 +420,16 @@ static const struct of_device_id imx8m_ddrc_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, imx8m_ddrc_of_match);
>   
> +static const struct dev_pm_ops imx8m_ddrc_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(imx8m_ddrc_suspend, imx8m_ddrc_resume)
> +};
> +
>   static struct platform_driver imx8m_ddrc_platdrv = {
>   	.probe		= imx8m_ddrc_probe,
>   	.driver = {
>   		.name	= "imx8m-ddrc-devfreq",
> -		.of_match_table = imx8m_ddrc_of_match,
> +		.pm = &imx8m_ddrc_pm_ops,
> +		.of_match_table = of_match_ptr(imx8m_ddrc_of_match),
>   	},
>   };
>   module_platform_driver(imx8m_ddrc_platdrv);
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
