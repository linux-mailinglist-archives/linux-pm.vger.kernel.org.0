Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C5940BE3C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 05:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhIODar (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Sep 2021 23:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhIODaq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Sep 2021 23:30:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4E0C061574;
        Tue, 14 Sep 2021 20:29:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so3910991pjr.1;
        Tue, 14 Sep 2021 20:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uT7lgy6zBb7N/ehnvHKTQrLcgZmZaL4s6/TKynv0i24=;
        b=m+DuAAM4oo4JFjhBYvWp9e7IS0bTVvDEMaBXA4Y3u+GXxoTUVLTm3vptrIvHhUsf+J
         kgSMV0idgr0HmbfsbOviUd6iHLYZDv1yL1egEIyX5MIqsl/2z7JYA+xbG3RlVBV8uz2U
         lnUKtd4eDEz4ikmEDkq11lSTTU6Y5VI32cvNv/5qnaVYOYeUEVfKsXb3S8+2NoC/pfCI
         jSgz8HsY8Wkq/9b+xQhOYyZoA4pyWgO0GeiNFDjWDjLTvRO2HPixRjRbEN3xrm+ZWwsl
         yDS7qKcfVbCA+exu6QivRCCt1Ty2PC8GdhxK377Y/Au5U1wcds2fwLvyv/n7BCZpDr5e
         LtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uT7lgy6zBb7N/ehnvHKTQrLcgZmZaL4s6/TKynv0i24=;
        b=lcF3oZJt5GOEkeZa5ERIJ2m2shBz3ojVWxPOyBfvAw7Yy+xYjauAdJJTUMFRSgOKVa
         NP4mXV9gRnivECqy8VaZ259pi/ZVFFZLnPtdhlXDN4O/MDyECAMCLOItozOfHNtcPeYZ
         x/q447rS12OmLYsxSZvqkcwZWyiB+9mNYQd7GJJS9trEGyNkz1HTzkqDbrzojXc1Wpvu
         Qzv913wkFkns10LhJmd1bM4zgOsbaPSvVYnB+D2kQlT+BT7mBUzLeiLcPrYDVr++t8+6
         sTlX+xgySd/iLmUxcgx00mbBgc2SgF4FfVqq2xDruH1SRYHgB5wE2XYge/Je8Ydh9Ubx
         CVNA==
X-Gm-Message-State: AOAM532dF+kSEOBEoN1i/OOSoG0CeoHpa8aIUrjff6GvYlPmuqam5a+A
        C894Q2Jqaq5ygz9Z/Heq8Kg=
X-Google-Smtp-Source: ABdhPJynoM/BujMCmyDoKceEwK7oXabTKhQCj975dn97xRe9dewS669tscUlGx7ManitvurHLVc2qQ==
X-Received: by 2002:a17:90a:718c:: with SMTP id i12mr5934342pjk.182.1631676568267;
        Tue, 14 Sep 2021 20:29:28 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id t13sm3256731pjj.1.2021.09.14.20.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 20:29:27 -0700 (PDT)
Subject: Re: [RFC 05/19] devfreq: imx8m-ddrc: Use the opps acquired from EL3
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
 <1631554694-9599-6-git-send-email-abel.vesa@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <b52430cc-1216-8b3e-baec-7d3fffc1274a@gmail.com>
Date:   Wed, 15 Sep 2021 12:29:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1631554694-9599-6-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

OPP is mandatory for devfreq driver. Also, must need to add
the OPP levels to  devicetree file, it is better to show
the supported OPP list for the developer who don't know
the detailed background of driver. If there are no any
critical issue. I prefer the existing approach for the readability.

On 21. 9. 14. 오전 2:38, Abel Vesa wrote:
> i.MX8M platforms get their dram OPPs from the EL3.
> We don't need to duplicate that in the kernel dram dts node.
> We should just trust the OPPs provided by the EL3.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>   drivers/devfreq/imx8m-ddrc.c | 50 +++---------------------------------
>   1 file changed, 3 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index 583123bf2100..f18a5c3c1c03 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -321,38 +321,9 @@ static int imx8m_ddrc_init_freq_info(struct device *dev)
>   		if (freq->dram_core_parent_index == 2 &&
>   				freq->dram_alt_parent_index == 0)
>   			return -ENODEV;
> -	}
> -
> -	return 0;
> -}
> -
> -static int imx8m_ddrc_check_opps(struct device *dev)
> -{
> -	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> -	struct imx8m_ddrc_freq *freq_info;
> -	struct dev_pm_opp *opp;
> -	unsigned long freq;
> -	int i, opp_count;
> -
> -	/* Enumerate DT OPPs and disable those not supported by firmware */
> -	opp_count = dev_pm_opp_get_opp_count(dev);
> -	if (opp_count < 0)
> -		return opp_count;
> -	for (i = 0, freq = 0; i < opp_count; ++i, ++freq) {
> -		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> -		if (IS_ERR(opp)) {
> -			dev_err(dev, "Failed enumerating OPPs: %ld\n",
> -				PTR_ERR(opp));
> -			return PTR_ERR(opp);
> -		}
> -		dev_pm_opp_put(opp);
>   
> -		freq_info = imx8m_ddrc_find_freq(priv, freq);
> -		if (!freq_info) {
> -			dev_info(dev, "Disable unsupported OPP %luHz %luMT/s\n",
> -					freq, DIV_ROUND_CLOSEST(freq, 250000));
> -			dev_pm_opp_disable(dev, freq);
> -		}
> +		if (dev_pm_opp_add(dev, freq->rate * 250000, 0))
> +			return -ENODEV;
>   	}
>   
>   	return 0;
> @@ -360,7 +331,6 @@ static int imx8m_ddrc_check_opps(struct device *dev)
>   
>   static void imx8m_ddrc_exit(struct device *dev)
>   {
> -	dev_pm_opp_of_remove_table(dev);
>   }
>   
>   static int imx8m_ddrc_probe(struct platform_device *pdev)
> @@ -407,16 +377,7 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	ret = dev_pm_opp_of_add_table(dev);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to get OPP table\n");
> -		return ret;
> -	}
> -
> -	ret = imx8m_ddrc_check_opps(dev);
> -	if (ret < 0)
> -		goto err;
> -
> +	priv->profile.polling_ms = 1000;

This change is not related to role of this patch.
Need to make the separate patch.

>   	priv->profile.target = imx8m_ddrc_target;
>   	priv->profile.exit = imx8m_ddrc_exit;
>   	priv->profile.get_cur_freq = imx8m_ddrc_get_cur_freq;
> @@ -427,13 +388,8 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
>   	if (IS_ERR(priv->devfreq)) {
>   		ret = PTR_ERR(priv->devfreq);
>   		dev_err(dev, "failed to add devfreq device: %d\n", ret);
> -		goto err;
>   	}
>   
> -	return 0;
> -
> -err:
> -	dev_pm_opp_of_remove_table(dev);
>   	return ret;
>   }
>   
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
