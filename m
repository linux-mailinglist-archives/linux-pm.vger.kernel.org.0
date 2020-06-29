Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51FE20E061
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 23:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbgF2Upy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 16:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbgF2TN5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:13:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70532C08EACB
        for <linux-pm@vger.kernel.org>; Sun, 28 Jun 2020 23:17:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so4103910pje.0
        for <linux-pm@vger.kernel.org>; Sun, 28 Jun 2020 23:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/iWF9Aktns6tjUCoIAHOc+DKzNhTAu9vb8oX3epUC60=;
        b=blY5505ygN1qt1Y8DSpy0SiYhbAhUtlzOYCJQL61xLBe5ORTR3pWGY2BSrDFUf/frY
         D2KvctYi0X9Ru4JBVk6rpW0KJGoE6oLqz2VhAUynepoFHbJ2tVw3/pYv2ujjSLBKo+cZ
         xJsCdaCDR1eK+PCnlmrpDahrh6/Q/7Ls9G6cjc2mnEoLxWf8SRWVkadedQsCIsOXQcog
         QbspxLbknbwM3pgGBz+VC2c9ai4fqnMqPyOi2JVK+m+Y8+R7SofQf6PYyPWFqo4q/6Lg
         9DW1LM6RJ/DvVtF9/5oFhneRt9RQoGxAXSwjuwZVCv7KOp0aPb2jd6ycudIjnuVJqhNz
         l6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/iWF9Aktns6tjUCoIAHOc+DKzNhTAu9vb8oX3epUC60=;
        b=T0HFFlgY6Oueo57agY0AkgrgHUaz7K4AMhfW0FP4Is7qecKcKjIlf39Wh3KDWv55Os
         kUnEsjpeieDDPdf/ONVC3zZAJnREt5OUnat03zloqBLJwFKNsYHtfR/llkppdchfkLtQ
         8pzkdFfXfKUXA2KZx17YqJ++XhJCLRYWnoG+ztOtqDP7Ve+8jRYFqj/Ob5S7yVNiFmE9
         vjvO2gqC8f01pfTg7X9pV/k6XElKFROY+WuU2eUspKP7HucHf05sGbi0R1YLDEyYV2Ig
         htQAKaCdwbs7r2BTewhKIdVUJDM+OQWKe/xfSzyYgBly/LAZ4TUANd9wFspMv3kLRWpq
         oLzw==
X-Gm-Message-State: AOAM530A6jrY84ipDhQE40xg0ISRrgY1YBENUOVQdjOxkycOi+ejG1wJ
        zfW/bP335J2yrG5XRoA25KX1IA==
X-Google-Smtp-Source: ABdhPJwTKfFVHzwQAGzguT3A58qTDtSwnwdELyYHjDiWd5nJqHRq6K6pp1+oar1iZXy/qT8C+R3bhQ==
X-Received: by 2002:a17:902:201:: with SMTP id 1mr12567598plc.195.1593411464987;
        Sun, 28 Jun 2020 23:17:44 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id t184sm3828984pfd.49.2020.06.28.23.17.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jun 2020 23:17:44 -0700 (PDT)
Date:   Mon, 29 Jun 2020 11:47:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v4 4/4] arm64: defconfig: Enable
 CONFIG_ARM_TEGRA194_CPUFREQ
Message-ID: <20200629061742.26pd4rzswlb5wegx@vireshk-i7>
References: <1593186236-12760-1-git-send-email-sumitg@nvidia.com>
 <1593186236-12760-5-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593186236-12760-5-git-send-email-sumitg@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-06-20, 21:13, Sumit Gupta wrote:
> Enable Tegra194 CPU frequency scaling support by default.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f9d378d..385bd35 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -91,6 +91,7 @@ CONFIG_ARM_QCOM_CPUFREQ_NVMEM=y
>  CONFIG_ARM_QCOM_CPUFREQ_HW=y
>  CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
>  CONFIG_ARM_TEGRA186_CPUFREQ=y
> +CONFIG_ARM_TEGRA194_CPUFREQ=y
>  CONFIG_QORIQ_CPUFREQ=y
>  CONFIG_ARM_SCPI_PROTOCOL=y
>  CONFIG_RASPBERRYPI_FIRMWARE=y

Instead of this, maybe you can rather add a default y thing in the
Kconfig itself as this is a single platform driver.

-- 
viresh
