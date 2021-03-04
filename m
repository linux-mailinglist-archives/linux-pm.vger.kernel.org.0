Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5371432D538
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 15:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240498AbhCDOXP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 09:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241807AbhCDOWy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 09:22:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6C7C061760
        for <linux-pm@vger.kernel.org>; Thu,  4 Mar 2021 06:22:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id h7so564687wmf.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Mar 2021 06:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DXnsbnWFOqtizEGNVzz0O9y/t7Y86TdU8DtG5CSinK0=;
        b=EEyj+/YytSZwGzpXDR0jJeDVT9TQtKwdJVX8CaQE9Z5YD9zkW7RvrptBgDYZVui5vr
         iydBa8Nnn0YGEvEMO019ctaMB1kKxH0RoKV1q0XmoLkNIy8CFJ3Qy+QoRJHMgd/ujSsU
         dh4Za+F4AVgvW1Va2n1PAw6rRlF83YTkuMyMl4OymXV68di0tuX+NnrkK3TJttascnIQ
         BdBOanNXG4g2kcIV7Kb1Q5IiZaMjA4BdeMrQ4INuCVMNqPIU9PyH+h40MGksqGkQfs40
         BrqBC9EoVQN5cLDomshVV6yHsKUq4yNy3zBYxWUpw48pal72x8fUMzXIQ5Eudm8EXH96
         5jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DXnsbnWFOqtizEGNVzz0O9y/t7Y86TdU8DtG5CSinK0=;
        b=NP41mwboZNFWT1qJ+wXdt2Tdg7t+s3290RzgK6qTA2IXWEcJ5tQ/ouK4c+pFrSwRC1
         szNaphzSsJjR83i7CG1mu3dNOt31VfAIEXRFV0A737GT1oveiKx6dZVQaPLFMYQ1tYHv
         2qVI/4YPoEPaH5eSz2PmeGtuUaVtjXQfdKQZgCcV1KKkRMeVr5jFt/8Q7BmiRkKNtscQ
         W64kGp2UpTmQ1oAvXH+Ceh37VyL5n4P33HuqQn1pLUJyZT+xio6gSCQeVIFK9b8HmPAF
         8/Q8T5GQ+ldwqZ8nmYTlm3/la8Alf8gmk+kwVyAzvdhceIBgKcdRXN2lb8+zCX27OBtx
         9bOw==
X-Gm-Message-State: AOAM532HWflk+QZXhZEybK7wVAjGsv5ARgzyo0EGod3SwnP8qETlsY9N
        SWfVDsMW1Wddfjs9gFgeec1gCQ==
X-Google-Smtp-Source: ABdhPJxA2gGfnsfgogpMkW3Rwf/yIOt+WFMXxGAlxB8j6kCyeIhYtCYZqAcDXQjWxrhuOHW931qWtg==
X-Received: by 2002:a05:600c:4292:: with SMTP id v18mr4182021wmc.23.1614867732804;
        Thu, 04 Mar 2021 06:22:12 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id c3sm35870214wrr.29.2021.03.04.06.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 06:22:12 -0800 (PST)
Subject: Re: [PATCH RESEND v2 2/2] cpuidle: tegra: Remove do_idle firmware
 call
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anton Bambura <jenneron@protonmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210302095405.28453-1-digetx@gmail.com>
 <20210302095405.28453-2-digetx@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c5a45dbf-9cb6-f213-6a78-411fa1823f57@linaro.org>
Date:   Thu, 4 Mar 2021 15:22:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210302095405.28453-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/03/2021 10:54, Dmitry Osipenko wrote:
> The do_idle firmware call is unused by all Tegra SoCs, hence remove it in
> order to keep driver's code clean.
> 
> Tested-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
