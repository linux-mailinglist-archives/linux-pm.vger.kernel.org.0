Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DF032D827
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 17:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbhCDQzQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 11:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238720AbhCDQzK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 11:55:10 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB5EC06175F
        for <linux-pm@vger.kernel.org>; Thu,  4 Mar 2021 08:54:30 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u14so28426650wri.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Mar 2021 08:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cCLKoMFPN0gPx/rfyorI0twY4bbHy1nmLr1AxawYDHU=;
        b=mOCVJrRupIKBqltJhO/hxffcZOiabNKzUrjWiiEl5nNPYF+CqEOmIl9yWWh7RQCCOt
         c1aKLGID9U62OoI2uVF/cGTlokFOWuR6DgcdMxha5K5zg/owKCIS8gHdvnGfJfpXk3eO
         iTw0Y/5nTCeGqlqIW/k2uwednxdTKegLaGc2FY/bKtmc+oD0VHye+ZkquYpoLFbDpEnL
         /stI/unoZkmvPnrc0+M9nyzuOPVu6GWW8GJ66ROL+a37ocYrDpE7jx43bv9YiBn2xIAZ
         va42vr8HJmnXt52Vi1iTj6byuKhMhqOVtG4RCqP38TKGyxF9xGPpVTwrh80Fwf5Luivq
         kbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cCLKoMFPN0gPx/rfyorI0twY4bbHy1nmLr1AxawYDHU=;
        b=TTNYxza26C3Nmw9CWzllZyVLElqu5RBH856BoicGXCuS143+2x+BWLRo9w20Qs6Ocv
         ozymCTY7xtv7Cy3OGlWk4amBxXwbP5lFL68Z+zfeTIj+3mZikoMwVRwLHab5LsZZyljc
         LkqOot4q1yVTh8Y5stRAffpe9TL0YMSSRCp6IOjqfEMRQAXfbtkxNO8IqsDWSRTSxWG4
         iqvX9UKKL5ZcjFyz8sZb99nhdZYW/K/U8V11ecSYcdxDpiDEUGbBO7fPggKSsI6qSZ7e
         RNozDk5WwHyM2L3HRNi179nUk+yxt+3Jr1eTSzEv/qL6cIPi00LBGRfbb+KGHWIGbdN3
         hjGw==
X-Gm-Message-State: AOAM532yCdSQkqke0fEsyI7Z3/pDLurGK8Y2W3wflyEwmuKMOVTMXYKE
        t1Xnto/rUBTm1MH1Ps1JCswk4Q==
X-Google-Smtp-Source: ABdhPJzU8MAa7xzsW9jiUKg20K9ykL5kVNj6KlOTciEUf7Wp5tDMw82GCSRJJf5DbLGtrPkwRNcwKw==
X-Received: by 2002:a5d:6a81:: with SMTP id s1mr4964478wru.401.1614876868875;
        Thu, 04 Mar 2021 08:54:28 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id l2sm38451757wrv.50.2021.03.04.08.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 08:54:28 -0800 (PST)
Subject: Re: [PATCH] devfreq: Register devfreq as a cooling device
To:     Chanwoo Choi <cwchoi00@gmail.com>, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "open list:DRM DRIVERS FOR LIMA" <dri-devel@lists.freedesktop.org>,
        "moderated list:DRM DRIVERS FOR LIMA" <lima@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>
References: <20210304125034.28404-1-daniel.lezcano@linaro.org>
 <97e495cb-c685-e163-0909-0311530a5332@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <91afb936-71d7-057d-4d66-4a2e41b52332@linaro.org>
Date:   Thu, 4 Mar 2021 17:54:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <97e495cb-c685-e163-0909-0311530a5332@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/03/2021 16:06, Chanwoo Choi wrote:
> Hi Daniel,
> 
> As Lukasz's comment, actually some devfreq devices like memory bus
> might not affect the thermal critically. In the mainline,
> there are four types devfreq as following:
> 1. GPU
> 2. UFS Storage
> 3. DMC (Memory Controller)
> 4. Memory bus like AMBA AXI
> 
> I think that you can specify this devfreq device will be used
> for cooling device by editing the devfreq_dev_profile structure.

Thanks for the suggestion, it makes sense.

I will do the change following your example below.

  -- Daniel

> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bf3047896e41..77966a17d03f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -935,6 +935,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
> 
>         mutex_unlock(&devfreq_list_lock);
> 
> +       if (devfreq->profile->is_cooling_device) {
> +               devfreq->cdev = devfreq_cooling_em_register(devfreq, NULL);
> +               if (IS_ERR(devfreq->cdev))
> +                       dev_info(dev,
> +                               "Failed to register devfreq cooling
> device\n");
> +       }
> +
>         return devfreq;
> 
>  err_init:
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 26ea0850be9b..26dc69f1047b 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -103,6 +103,7 @@ struct devfreq_dev_profile {
>         unsigned long initial_freq;
>         unsigned int polling_ms;
>         enum devfreq_timer timer;
> +       bool is_cooling_device;
> 
>         int (*target)(struct device *dev, unsigned long *freq, u32 flags);
>         int (*get_dev_status)(struct device *dev,
> 



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
