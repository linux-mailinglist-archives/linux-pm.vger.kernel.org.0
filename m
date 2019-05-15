Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F131EA5F
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfEOIqN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 04:46:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33476 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOIqN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 04:46:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so4150909wme.0
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 01:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SjTzfocxmV9Q3qyS3D6y8G341QPk5z6P8wHPvkJzRmA=;
        b=vQ9ihMC4KeD1sH00RphG8WvBfibZMVI/ROw8bblIJDIs8HTOvbDXNSMqLjOxF4bNk9
         TsH5l1YoWQZsBNaLx7rJtxAaKPc6SvWC+hWDrYXHPvhWJFRowZ1/Spgad36aezY0tnaR
         4xlJODtu7vv9+bIolowJECSdosWGHjI0WB4F52pdrrl2G1B6LYFvNZB7lnKDxnUuOaLl
         fUzbGxZPiWSl88ur7+527fb37qoDhotzbeWTKHZlbjoP/jMXMPMZxlPK+slNWKZcMcPF
         mmFxRulwbNrCCp/Rr/K/miufZnZWsLUBUE+4DM9vWh1ugs8GaxiAGdRp9Jw3/IVSKxeY
         vfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SjTzfocxmV9Q3qyS3D6y8G341QPk5z6P8wHPvkJzRmA=;
        b=kA5a5jL/H7Yf5MX4UMxCkwa9t6aFwodQ9/OK0LihiNjX6k7z4/8iys12eWbN0dC8Zv
         eGVANShsjS/vg1Yx73qtfYKgODJcyLo9yuv/zif3n2q8LhO1FF92703ec61C7QutF5YT
         TqGDXuo0Mcl1cp3h0WmVyfV758jk/9/STuv7P0+nzfPqJs61bqp+pLK+pPrkGVlo7BNy
         k/nwAZ+BZqD0AWswFz1C2riMc31U75I71M2zOI2WjT6A8eFJ2kdBYVfBY33qclFkdX/K
         WsUwVzgQNOuEMcleWGkW0EsPkUmnXqEaJU+PrrRPzw6USm17/9MgVfoVoOH+RODhqQBx
         l+wQ==
X-Gm-Message-State: APjAAAVUza4Q5QCL47++uksjuPBV8k/vY6JYCOKELhoyQoDZWaWXOKJr
        j2ChXOHbFIV5xAFc5UO3qBTgWA==
X-Google-Smtp-Source: APXvYqykhcOsSF5cy288Wi7AKFIvGeafQ6EecV8kQ8OJaAyCvPprwNnZr8e/TsvC0TI1SiLtaInomA==
X-Received: by 2002:a1c:ac07:: with SMTP id v7mr21293143wme.49.1557909971165;
        Wed, 15 May 2019 01:46:11 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id l16sm2111672wrb.40.2019.05.15.01.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 01:46:10 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] arm64: defconfig: Enable CONFIG_ENERGY_MODEL
To:     Quentin Perret <quentin.perret@arm.com>, edubezval@gmail.com,
        rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-2-quentin.perret@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2f598ea3-752d-0f1d-fd33-f07cda3b7bd0@linaro.org>
Date:   Wed, 15 May 2019 10:46:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515082318.7993-2-quentin.perret@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/05/2019 10:23, Quentin Perret wrote:
> The recently introduced Energy Model (EM) framework manages power cost
> tables for the CPUs of the system. Its only user right now is the
> scheduler, in the context of Energy Aware Scheduling (EAS).
> 
> However, the EM framework also offers a generic infrastructure that
> could replace subsystem-specific implementations of the same concepts,
> as this is the case in the thermal framework.
> 
> So, in order to prepare the migration of the thermal subsystem to use
> the EM framework, enable it in the default arm64 defconfig, which is the
> most commonly used architecture for IPA. This will also compile-in all
> of the EAS code, although it won't be enabled by default -- EAS requires
> to use the 'schedutil' CPUFreq governor while arm64 defaults to
> 'performance'.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 2d9c39033c1a..4881a752ab3f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -97,6 +97,7 @@ CONFIG_XEN=y
>  CONFIG_COMPAT=y
>  CONFIG_HIBERNATION=y
>  CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> +CONFIG_ENERGY_MODEL=y
>  CONFIG_ARM_CPUIDLE=y
>  CONFIG_CPU_FREQ=y
>  CONFIG_CPU_FREQ_STAT=y
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

