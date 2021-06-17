Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48253AB966
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 18:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhFQQUp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhFQQUl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 12:20:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F035C061768
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 09:18:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o39-20020a05600c5127b02901d23584fd9bso3968865wms.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vMtbRKlE5Idkm6Rw+lkoZXWCjk6ZpMLnhEVNBvkvbRc=;
        b=lM40ahywSF0wIP6JdGUL4V1dao3i+wLW9SeDeJDRxzMxAjtLxuVKSQwHGGv/YcxS6p
         23+/9VMISZD4QWKxj5T+dzoqVqJb5W9u1XwqodFgpU1Xf3rMZRJx9vg4ozFqQzSMjLBK
         u0R9JRVoAU41FrYTiNeCkZWxlUAXIpKXA/wzCRz2sHhjAI7tbTzws/RrQzWl08TuUL0F
         epnX69iw6KfFtLrbOy/KsoRnKxHBareOaanPxQY6a1naA9iwK6ESqcYgutsd8kO4pmfW
         Ksv3eW4oo4p799Rd8BT7flwQAlYbyPMZNmkc0LT2XVZ2XQ/MW4gnptV5/dV56Oliavci
         PQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vMtbRKlE5Idkm6Rw+lkoZXWCjk6ZpMLnhEVNBvkvbRc=;
        b=kyB6pRajWjSuMsvwiNPBoMBNMtgkL0cEg/+WMsAwfX8z7pgI9cQArJHyFvbZb4t1l/
         FZRS8EwVIzPNZ374+1eH5BhqpRzbaCOPzTbD7lJ9ZcbKQa7o4LOH5dAj40ELPr4JSfg9
         NABbGbVh5C192ekzsg/h4LJlRYDYxJ2pfokkK2yLUJ7tNLEDdFdnOBf2NuYuNgvGlbyQ
         X06BW9Z0fMAeClteAXRDdaE5SVoTnA/jbcnYcOZVbFST1HsD5qJRY1l9SJfKIxMPBntU
         EN0RK+bjRxPorkjvqCNyraJq//inixwUk1/JARC58j9ZX8wwLj2D4QpRKHLxcQjcJvMi
         A3xg==
X-Gm-Message-State: AOAM530ZcL0LqgNZHfOxz7LMX+gyTB+pRRg50yj764Vrr6V22H+TBO9q
        TFjWKfkC9vTc2hcgv+w40NBxPVV7m926nAUV
X-Google-Smtp-Source: ABdhPJw5OD//7tdjT1k/9amBR/tlrqHcxGCs5h1IeoejZ3d1KIBkd6tNRr2HbaC/GfGdsVkShfbYNQ==
X-Received: by 2002:a05:600c:3b9e:: with SMTP id n30mr6137831wms.48.1623946709720;
        Thu, 17 Jun 2021 09:18:29 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a8dd:a686:47bc:b03a? ([2a01:e34:ed2f:f020:a8dd:a686:47bc:b03a])
        by smtp.googlemail.com with ESMTPSA id r6sm5868719wrt.21.2021.06.17.09.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 09:18:29 -0700 (PDT)
Subject: Re: [PATCH RESEND v10 03/11] thermal: Use generic HW-protection
 shutdown API
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pm@vger.kernel.org
References: <cover.1622628333.git.matti.vaittinen@fi.rohmeurope.com>
 <5531e89d9e710f5d10e7cdce3ee58957335b9e03.1622628333.git.matti.vaittinen@fi.rohmeurope.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1c33f42c-4986-b758-da53-631ac0b82c6f@linaro.org>
Date:   Thu, 17 Jun 2021 18:18:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5531e89d9e710f5d10e7cdce3ee58957335b9e03.1622628333.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/06/2021 07:41, Matti Vaittinen wrote:
> The hardware shutdown function was exported from kernel/reboot for
> other subsystems to use. Logic is copied from the thermal_core. The
> protection mutex is replaced by an atomic_t to allow calls also from
> an IRQ context. Also the WARN() was replaced by pr_emerg() based on
> discussions here:
> https://lore.kernel.org/lkml/YJuPwAZroVZ%2Fw633@alley/
> and here:
> https://lore.kernel.org/linux-iommu/20210331093104.383705-4-geert+renesas@glider.be/
> 
> Use the exported API instead of implementing own just for the
> thermal_core.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> 

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
