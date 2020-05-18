Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F65C1D7B2A
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEROYa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 10:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgEROYa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 10:24:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E7DC061A0C
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 07:24:30 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so9488236wmj.3
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gxl1wSXHlnpysyDsyA8FWVoM1yPL9bBFV3IzCMi6c7o=;
        b=TGGdv3VRngLGC8Wsl+ibShnAJ/GlVId9YZ5+5W7dCRjmE4V3+U/3nxO0pXtXyussS6
         bA40zzH0WhnEDaMi4DdhENigbd86xGRE8CiFcfhbVZmoDw1hK0Ey/IKr7wxb84B4+WI6
         1NL/8DCtF4cECKb5mLGcOjUDRb9Ys9aLGigQcR9NFAhcRb2PPVrsyoeIat9UOZP/q1D8
         hMIZmTSBaKxJejFB93vBbhXHG8k2Pn5xJE/ZvjR0HKrePcqq2wtYY1UpNeoNA3l1h0jZ
         0v/CdAd8iNxqgJcD1Jr7+qOuvJqDRyICLZlG/7ftRykuo1psScAO3IQjz5MI5oNmS8Ee
         vP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gxl1wSXHlnpysyDsyA8FWVoM1yPL9bBFV3IzCMi6c7o=;
        b=D3qs7vs17feL9Hk1r7OU7oWOCgLBCgbdCRV2kl0kdyqubqvLm9fKvwcp9oAIUx6FvK
         2P4rv+rlFftRGhk898m6IYgYIUCwcvo8/ehfuZE7kulrD+KuXAUw7mVkTJ5+UFjsROeX
         806t7TshkL3ldhbgvK+KQrmTJ28R6NGC/yEX/cbqeDgkyNo4g7pnyCEQr3eebyuQpBCR
         ydotl7ZjIxfs4AVvBgoSFPcWy0CK2H6vYUlEeNWDC+bboaAFk+FJsZ7H/TsCKNy2YFYI
         1IJeqeFGlRK/6xAmveN7SCUc3KKyTQPR2gMk+9K9Qa1yQmkoHGzvXWIZAxqa74i3QitA
         o7/A==
X-Gm-Message-State: AOAM533VqAWXWipTPj7CYEBiHdDbiuzcYkwGNGHK7b8RiTXySK9Y0+mQ
        xEQJ5zugCizcLsu4VlNjkWMF7bbzD30=
X-Google-Smtp-Source: ABdhPJyBj7qnpvZnEG8g3TlaEVRGdfYI+bM54ywG/vmAzOdqMqoE1O7zebi6D6nB6Xv3J/pG5+QygQ==
X-Received: by 2002:a7b:c358:: with SMTP id l24mr4774810wmj.13.1589811868817;
        Mon, 18 May 2020 07:24:28 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8? ([2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8])
        by smtp.googlemail.com with ESMTPSA id y4sm17169630wro.91.2020.05.18.07.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 07:24:28 -0700 (PDT)
Subject: Re: [RFC v2 PATCH 3/6] cpuidle: Make cpuidle governor switchable to
 be the default behaviour
To:     Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Smythies <dsmythies@telus.net>
Cc:     linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <1588235987-12300-1-git-send-email-guohanjun@huawei.com>
 <1588235987-12300-4-git-send-email-guohanjun@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e41bb53c-79fa-fce3-0f17-ec4124bff0d0@linaro.org>
Date:   Mon, 18 May 2020 16:24:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588235987-12300-4-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/04/2020 10:39, Hanjun Guo wrote:
> For now cpuidle governor can be switched via sysfs only when the
> boot option "cpuidle_sysfs_switch" is passed, but it's important
> to switch the governor to adapt to different workloads, especially
> after TEO and haltpoll governor were introduced.
> 
> Add available_governors and current_governor into the default
> attributes, but reserve the current_governor_ro for temporal
> compatibility.
> 
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
