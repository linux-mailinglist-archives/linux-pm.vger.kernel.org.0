Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BF73B69D6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 22:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhF1Uoe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 16:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbhF1Uod (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jun 2021 16:44:33 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A04C061760
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 13:42:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso924070wmj.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vNRV3itx7pMsiiugyK3tzY2fHU61F4+pgKugCprFr3c=;
        b=MfEBoRE5CRHknCE5QvsyM8bx4ESq7z42JrOI7nrZ6IpUM1C7TT+D4flpJOnRBUdQwI
         +lrBYxXPMq7d+yGlI44EAx2RXRWUypWkQfYJWfijieTRq0DlceO6MuA513BISs5D+dbO
         /RUulRbybrDM56YwDSJI4nmRpFsQf7fOFAQfGHaqGVjd7hffhTQVAyYmaTP8v8pKpevK
         hSb0zIzvB5tK+O1bYHpfd3d1X5loEcfr1uUQcQuAM/g1UyQS8vgbObzBeoHFtovlzBEo
         zlAtDw64l8Uyk7/M9OxSFbsfN9Qx5HLOstC5ROZts5/aGJ9fL7vS1f/c/xm3s4QwEJ7k
         TFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vNRV3itx7pMsiiugyK3tzY2fHU61F4+pgKugCprFr3c=;
        b=Gescy7uplDNRIFaGS02tKYWls298LKheSIWCns2BOXBtu4ceoBqv9owFFOeFVU6pFU
         nyLblhueM7YOCMT4S9+nzdllqTpngPgOTOmt74pu30upIY+VdFdeKYQRNqvOr0DsPl2V
         wPzDb07KqNOgt5MsDC9bWMGRzzQbmBBJx6no8bbqqtb1A0imN6Y2kl8vDfGoRRjOmk3C
         eLI5cAmRp0/AL0wZ6R43cR8uSmTzKcjtPt88Q6rfYEY4os6cRhGLkqXsOO2jiRqO1fAI
         vJAVG+ctx0OntCyH5k6r3KehWwwsGKKFaeh72/ERD00/9OeZBUHXD+ZBuh9ef+v0dK6v
         YjIw==
X-Gm-Message-State: AOAM532d/+q1MCGqdjoXZk26bAk5izNpGcONSIznrNaoWgDX7L4w+p/W
        acvktxbRIoyTu+xl+2pLp+gsaw==
X-Google-Smtp-Source: ABdhPJzq5J6/KsC0KiiiYk4JEhSPYiMe3j0R+wKOGnC9g5BAb+QwIzDDZ4QBwN5tiLjexNkdSpTNuA==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr27592491wmb.167.1624912925699;
        Mon, 28 Jun 2021 13:42:05 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c9b2:a9e9:8b67:65fc? ([2a01:e34:ed2f:f020:c9b2:a9e9:8b67:65fc])
        by smtp.googlemail.com with ESMTPSA id g17sm11125539wrw.31.2021.06.28.13.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 13:42:05 -0700 (PDT)
Subject: Re: [PATCH] thermal: int340x: processor_thermal: Fix tcc setting
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210628201012.68642-1-srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <649bc24b-331d-9ffd-e374-18eed5555816@linaro.org>
Date:   Mon, 28 Jun 2021 22:42:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628201012.68642-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/06/2021 22:10, Srinivas Pandruvada wrote:
> The following fixes are done for tcc sysfs interface:
> - TCC is 6 bits only from bit 29-24
> - TCC of 0 is valid
> - When BIT(31) is set, this register is read only
> - Check for invalid tcc value
> - Error for negative values
> 

Fixes: fdf4f2fb8e899 ("Export sysfs interface for TCC")

?

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../processor_thermal_device.c                | 20 +++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index de4fc640deb0..0f0038af2ad4 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -78,24 +78,27 @@ static ssize_t tcc_offset_degree_celsius_show(struct device *dev,
>  	if (err)
>  		return err;
>  
> -	val = (val >> 24) & 0xff;
> +	val = (val >> 24) & 0x3f;
>  	return sprintf(buf, "%d\n", (int)val);
>  }
>  
> -static int tcc_offset_update(int tcc)
> +static int tcc_offset_update(unsigned int tcc)
>  {
>  	u64 val;
>  	int err;
>  
> -	if (!tcc)
> +	if (tcc > 63)
>  		return -EINVAL;
>  
>  	err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
>  	if (err)
>  		return err;
>  
> -	val &= ~GENMASK_ULL(31, 24);
> -	val |= (tcc & 0xff) << 24;
> +	if (val & BIT(31))
> +		return -EPERM;
> +
> +	val &= ~GENMASK_ULL(29, 24);
> +	val |= (tcc & 0x3f) << 24;
>  
>  	err = wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
>  	if (err)
> @@ -104,14 +107,15 @@ static int tcc_offset_update(int tcc)
>  	return 0;
>  }
>  
> -static int tcc_offset_save;
> +static unsigned int tcc_offset_save;
>  
>  static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
>  				struct device_attribute *attr, const char *buf,
>  				size_t count)
>  {
> +	unsigned int tcc;
>  	u64 val;
> -	int tcc, err;
> +	int err;
>  
>  	err = rdmsrl_safe(MSR_PLATFORM_INFO, &val);
>  	if (err)
> @@ -120,7 +124,7 @@ static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
>  	if (!(val & BIT(30)))
>  		return -EACCES;
>  
> -	if (kstrtoint(buf, 0, &tcc))
> +	if (kstrtouint(buf, 0, &tcc))
>  		return -EINVAL;
>  
>  	err = tcc_offset_update(tcc);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
