Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631C25A5B18
	for <lists+linux-pm@lfdr.de>; Tue, 30 Aug 2022 07:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiH3F31 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Aug 2022 01:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiH3F31 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2022 01:29:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF4B83061
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2022 22:29:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p18so10045702plr.8
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2022 22:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=uWEBkpLPAzW86KS2iBzrvsWZ9+AQq4lk7JpjaOcqCjM=;
        b=vmpEiDFhjQpnNGxL3nzpiV+mjpTNKokSm028yOakWFyQ8Wg5ifS6wL9Vdf/3VFDRkz
         wdwxaoWiLnjqDGr2YNwZCvRFr7svCKVQbiuw3BwXHjfVyuWMPTPX7mGs8P43oNQPH1+C
         aFI+FKVBDA1DkRNRbWoatywiP9Elz/wIjYSoNiB+mhyI/v/ENzcfmS0GX0rNEsUs2gkh
         9WBIUD86LufJw4GVKLleqFWxZiQ7+dAoNRMluxlcN8nhqYRdS7G4sw2r0+wIupX45/av
         n+zPCzM4QCizLeTQp1/nDRKm8u1AuhFX2eD/c4BQHqrsCFQL7nxvVyVNb7KEv6fIr2n6
         UOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=uWEBkpLPAzW86KS2iBzrvsWZ9+AQq4lk7JpjaOcqCjM=;
        b=eit2OvXFVcX0p0I7j6ZtemGFhEafmTCrEJx5htmRSP3MxfD/6Yg1qJkmiHY84YD8Y/
         KyvKV/fUa0CA0Y8RvqVyzOhuBKVPegsUpm3BiD8HPhLa57t9VsFGpMPH4fbB2X45/Q2Y
         J73zxfYEK5LDdn9g8ct19qow05yTphrhxAhtcwRKR550pAHwLNaZ/m4fxu/jUdZrO30w
         oAXNY/AzzlmB0inhYbg4gY0UbBpVnoZa0cyPIR4L+KuvFI25rQt948EFBF1t+JvWy7vA
         HAZd0H153+8G+RLPxJt+kQP4pRlixvYyK0Ctgruu/XsY8KywHm0WzWAXL1XxvxqKDiFy
         9YdQ==
X-Gm-Message-State: ACgBeo2QGxkb+50XLm6wqpwoUDvx6aZ7PCgPvUBAXF0KHXiJD6oO87kk
        4WqFjs+sHndBfZr93JOmuqGObw==
X-Google-Smtp-Source: AA6agR5r7v3ekniKFDq3Yd8i82DJTnpF/vQ2AV3Fin9Inuhx6CAdS3trwKvOizJ7SlsRIMzU9WgcgA==
X-Received: by 2002:a17:90b:388c:b0:1fb:6738:6e50 with SMTP id mu12-20020a17090b388c00b001fb67386e50mr21959682pjb.231.1661837365810;
        Mon, 29 Aug 2022 22:29:25 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090a4c8300b001ef81574355sm5462463pjh.12.2022.08.29.22.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 22:29:25 -0700 (PDT)
Date:   Tue, 30 Aug 2022 10:59:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhang Jianhua <chris.zjh@huawei.com>
Cc:     mmayer@broadcom.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: bmips-cpufreq: Use module_init and add
 module_exit
Message-ID: <20220830052922.aedexy7ovdus5pzk@vireshk-i7>
References: <20220826021845.2283648-1-chris.zjh@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826021845.2283648-1-chris.zjh@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-08-22, 10:18, Zhang Jianhua wrote:
> - Use module_init instead of device_initcall.
> - Add a function for module_exit to unregister driver.
> 
> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
> ---
>  drivers/cpufreq/bmips-cpufreq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/bmips-cpufreq.c b/drivers/cpufreq/bmips-cpufreq.c
> index f7c23fa468f0..21c0417c95e1 100644
> --- a/drivers/cpufreq/bmips-cpufreq.c
> +++ b/drivers/cpufreq/bmips-cpufreq.c
> @@ -156,7 +156,7 @@ static struct cpufreq_driver bmips_cpufreq_driver = {
>  	.name		= BMIPS_CPUFREQ_PREFIX,
>  };
>  
> -static int __init bmips_cpufreq_probe(void)
> +static int __init bmips_cpufreq_driver_init(void)
>  {
>  	struct cpufreq_compat *cc;
>  	struct device_node *np;
> @@ -176,7 +176,13 @@ static int __init bmips_cpufreq_probe(void)
>  
>  	return cpufreq_register_driver(&bmips_cpufreq_driver);
>  }
> -device_initcall(bmips_cpufreq_probe);
> +module_init(bmips_cpufreq_driver_init);
> +
> +static void __exit bmips_cpufreq_driver_exit(void)
> +{
> +	cpufreq_unregister_driver(&bmips_cpufreq_driver);
> +}
> +module_exit(bmips_cpufreq_driver_exit)

Semicolon ? Did you even compile this ? :)

>  
>  MODULE_AUTHOR("Markus Mayer <mmayer@broadcom.com>");
>  MODULE_DESCRIPTION("CPUfreq driver for Broadcom BMIPS SoCs");
> -- 
> 2.31.0

-- 
viresh
