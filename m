Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BE2786E90
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 13:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjHXL6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 07:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbjHXL6C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 07:58:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6340198B
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 04:58:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31781e15a0cso5776981f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692878279; x=1693483079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJxcx5frNQXkYV/X/egqJX1bVKcX1pTwoP7jqJ1144I=;
        b=k0hMp2u31mQozJNXkF4Xjxi+515sNZ4urf9nwrAAGLaS4H51X1eRQ3t5c6mC1xvBL6
         zJea8O673llzwqoQk+Cu/hKSaB2eQl9lj/1Ch95rzIomRjIO77Yd5Oyb0SBXDPzgpgBg
         2HanzId01SYOl1qUU201Uc17FPkKrLQDlYQWzDT/h5Tvx53d3ovpg3REHD8MIpste+dj
         xe+M0dXrKBUDpc7sk/y6Wsuy6ATvv8pvXbrrY+B8gOzLef2rQlgVqANB+vGBhbjBY/pu
         oKYX0GWGvcIN3jdUUHKaK2JNtahEm1P6tz3SorvwAQul5BHc6MWpIsQ0nIXUX9iZvMkU
         Frtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692878279; x=1693483079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJxcx5frNQXkYV/X/egqJX1bVKcX1pTwoP7jqJ1144I=;
        b=kahJcCTZaRtlEgRozBLMKp05SW0PQCzKKyeiA2AfyH/lXy/kck/KZTS7Y0XS4Itl12
         COfY+FwaNOydlD/nQyVYaaQXL3UAKCDFkZvGE87sDZHQA83txfztSJPTwmamHlxhBv7p
         Q3bnwWJXE3XTOGEgKFMYShR9QZIAHiZE1pxtBUKeiAwtgVqjyYBrbnTOLByuDNCmxKxI
         O7+1VthRx8QFOA2k/WHBgJHoqmedL/BoetpGFOc9sd6+vlJ4n+FqnFdJDP+0mfCTF3as
         MW2aO97TCHfPr9ldJyLKQhomWIfhVei3N8CRypFnFqCR5ILhkJzX5SqUz4GZ/WptqD2S
         XFfw==
X-Gm-Message-State: AOJu0YzXlf3W2SnA9ydJVexY8Idda0C1kKGbsZ2ckaPsWrOvhq0y8FOE
        sNIaDRxQqJ17mqQ+c4lBhUhxpmSJ1G3cSx0pbeE=
X-Google-Smtp-Source: AGHT+IHWMQgd4HYGzz/BTDhAQJ1D2dDhE5LAslhrJ2XEGmTIhTDgSZ/C2FP7OxhoECjyS9f6z1lwRw==
X-Received: by 2002:adf:ffc9:0:b0:319:52da:8f0b with SMTP id x9-20020adfffc9000000b0031952da8f0bmr12281382wrs.17.1692878279072;
        Thu, 24 Aug 2023 04:57:59 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id d11-20020adffd8b000000b0031c7682607asm2056063wrr.111.2023.08.24.04.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 04:57:58 -0700 (PDT)
Message-ID: <a2a613ce-be6e-6bd9-774d-9e3ed994f45e@linaro.org>
Date:   Thu, 24 Aug 2023 13:57:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] thermal: imx8mm: Allow reboot after critical
 temperature
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
References: <20230824112705.451411-1-festevam@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230824112705.451411-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Fabio,

On 24/08/2023 13:27, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Currently, after the board reaches the critical temperature, the system
> goes through a poweroff mechanism.
> 
> In some cases, such behavior does not suit well, as the board may be
> unattended in the field and rebooting may be a better approach.
> 
> The bootloader may also check the temperature and only allow the boot to
> proceed when the temperature is below a certain threshold.
> 
> Introduce a reboot_on_critical parameter to indicate that the board
> will go through a reboot after the critical temperature is reached.
> 
> When this parameter is not selected, the default behavior of forcing a
> shutdown is preserved.
> 
> Tested on a imx8mm-evk board by passing 'imx8mm_thermal.reboot_on_critical'
> via kernel command line.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - Introduce a module_param() instead of a devicetree property.
> 
>   drivers/thermal/imx8mm_thermal.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
> index e89b11b3f2b9..2427bd46ac6c 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -10,9 +10,11 @@
>   #include <linux/err.h>
>   #include <linux/io.h>
>   #include <linux/module.h>
> +#include <linux/moduleparam.h>
>   #include <linux/nvmem-consumer.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
> +#include <linux/reboot.h>
>   #include <linux/slab.h>
>   #include <linux/thermal.h>
>   
> @@ -75,6 +77,11 @@
>   #define TMU_VER1		0x1
>   #define TMU_VER2		0x2
>   
> +static bool reboot_on_critical;
> +module_param(reboot_on_critical, bool, 0444);
> +MODULE_PARM_DESC(reboot_on_critical,
> +		 "Reboot the system after the critical temperature is reached.");
> +
>   struct thermal_soc_data {
>   	u32 num_sensors;
>   	u32 version;
> @@ -146,8 +153,20 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>   	return tmu->socdata->get_temp(sensor, temp);
>   }
>   
> +static void tmu_critical(struct thermal_zone_device *tz)
> +{
> +	if (reboot_on_critical) {
> +		dev_emerg(thermal_zone_device(tz), "%s: critical temperature reached\n",
> +			  thermal_zone_device_type(tz));
> +		kernel_restart(NULL);
> +	} else {
> +		thermal_zone_device_critical(tz);
> +	}
> +}

Is it possible to set the .critical ops at init time instead and get rid 
of the thermal_zone_device_critical(tz) call ?

>   static const struct thermal_zone_device_ops tmu_tz_ops = {
>   	.get_temp = tmu_get_temp,
> +	.critical = tmu_critical,
>   };
>   
>   static void imx8mm_tmu_enable(struct imx8mm_tmu *tmu, bool enable)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

