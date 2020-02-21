Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECAFD168365
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 17:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgBUQad (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 11:30:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40709 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgBUQad (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 11:30:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so2557822wmi.5
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 08:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/hpmr3iDEF7VesVIhUJxr+wlTQe7A6k8UmT2pP9gqsk=;
        b=E+aIP1PS+y/CidHXVepd4cUIkrlKoYLDO6dl2UeIw3Ml0MfaCUl3hY2pkYthaAFgOg
         Ad1ennzZ4H+O6PaStCgipayhBrpYB4QlnwhYqzNdPEYkB4eMQAuDvatGMEvJALwGJIYz
         MWefy7+GCKzuaKE9IaBzU4+w0zyRXz3FJK30mBYeTp8JKgXTqPchwA18uLVM+HBf/5zZ
         DziJGa6kM4BkWrjhQSd/nn5wL4YowBsz9HY83ZuQvRuHVxXLw9DctNYqNCuGYeljvZ8L
         S7vK18NlhoEklerzBB+rFu4qUxmNtH2ij7pAT8sXufJ27O1igPKaQaRVxz+sTvyrlAk4
         9rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/hpmr3iDEF7VesVIhUJxr+wlTQe7A6k8UmT2pP9gqsk=;
        b=T7+XuuRLk+Bw4Nxa8DUS1m82psezKs3WdLNLe5Cc81H9UWT+qZKg0LqgprhFlA3nOj
         3zcHtPU9LTC39v8QJo+nXVkn95lnp0J1Ll/uNljjeesh6sGCJgwfTLjtbcfy0U9ZKy8H
         JLd2eRTK1HfsddKeLdGWmERcYILqpXZ4urupG4wcDNpCJLJJMgwmgI02G2fB8uPaoXFY
         wpQdzlMUE6XbgahC9hO7o/y8QxP2z5ccYgoxSIfPVVnKbloGz8f1dgV6ZAEfpEZbaaO7
         Q4RTt7Tey681sejz3/E2+7o3PItfZtqjD3Bt/ZNrZKmpa0Uv5cnPVwLr5i35hx09REt8
         QcJw==
X-Gm-Message-State: APjAAAXGdmBw+GCucU+GurO4YpNukkObjJu7peYbQSKxGjQcun8S4suW
        5G/vXj6cy5Tcq3bbf2syniyy7A==
X-Google-Smtp-Source: APXvYqy84yAGhqFaCP2VYwJRbeW1uviJEpEW2HrCyNvsXZW5mAZhvBYKDFwAqaEBRKtnFNxyZIzMpg==
X-Received: by 2002:a1c:238e:: with SMTP id j136mr4784182wmj.33.1582302631058;
        Fri, 21 Feb 2020 08:30:31 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id u62sm4588304wmu.17.2020.02.21.08.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 08:30:30 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:30:28 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 16/17] ARM: multi_v7_defconfig: Enable Tegra cpuidle
 driver
Message-ID: <20200221163028.GR10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-17-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200212235134.12638-17-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 02:51:33AM +0300, Dmitry Osipenko wrote:
> The Tegra CPU Idle driver was moved out into driver/cpuidle/ directory and
> it is now a proper platform driver.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 017d65f86eba..7c8a1c310bbb 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -113,6 +113,7 @@ CONFIG_CPU_IDLE=y
>  CONFIG_ARM_CPUIDLE=y
>  CONFIG_ARM_ZYNQ_CPUIDLE=y
>  CONFIG_ARM_EXYNOS_CPUIDLE=y
> +CONFIG_ARM_TEGRA_CPUIDLE=y
>  CONFIG_KERNEL_MODE_NEON=y
>  CONFIG_RASPBERRYPI_FIRMWARE=y
>  CONFIG_TRUSTED_FOUNDATIONS=y
> -- 
> 2.24.0
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
