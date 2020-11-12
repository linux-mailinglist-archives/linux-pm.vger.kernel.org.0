Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B942B03C6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 12:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKLLYL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 06:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgKLLYJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 06:24:09 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5CBC0613D4
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 03:24:08 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so5556952wrr.13
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 03:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=szqL77OyEVf5vlwPlO5u0pCoBC9WdDfxlvV/jS14f7E=;
        b=W+eu3SDUj96qApW3fPXVb+xDPNnyinb5iqfjnyWgB2qExiVq0mQwKnClSWWjqkt8OZ
         fJkNHuW70oPJ/doSMrRfRizxIy6jPW2wSlMD8toIvwPk5bh3fOAjgdTBYKG/Aus9N9t3
         1bJoWq2anjY3zJZ1pi/FzmllzANSkW2psCgx/vfhv4AXT2YLr/yavichSFSXUCCwNrvZ
         BHE5035iiBFf6o7siVYZHXjfPiHIdnlGvxplVVriBuEdYHoBIAItWvqRUCeFfG2E6LEa
         boMBxnUabqFVx09Y8reV5qhqsNMi1rHBANv77VZJ8stUSMd8Y4OfMQ2Vnr292kt8GE6m
         oE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=szqL77OyEVf5vlwPlO5u0pCoBC9WdDfxlvV/jS14f7E=;
        b=Z5krF4aC2HbqK4gTKxvWsZMBM6b2SW6NUNnb35LPPxJ8S+c1EHrsHsynPl5FrTgoNA
         Njby7Sc4me4EbOTpbgSOXBU6e3LzkYYRUXt+/jL69OqQ+m4cyXWeZxcJFGqLof3osTAJ
         Ge5vofwZ9uJL04l026IDgK+34bOHa6dWiHsoMj/Ol5kO2aztTJ2uprFo469U/MsfMPjR
         vBmNJzf98dhfVeYoAW336WAozTlxGY+3u4fpB8Zuq9VVwa7SHAFJQAd4OcNGzVKawC93
         8CMp7kMCPUTofKEHIORfL2z0lEqyZTV39wmBQx4vQ6gbSqQmLs2sJ0+76B+VJ/2MFb/H
         iSCQ==
X-Gm-Message-State: AOAM531UdrC+YLlcvddT21N9bpug9DqUFiT198EPpls3rh9Q0HxmRQZY
        HB87kBMcIrtI5Jt0UjvAT+vCzQ==
X-Google-Smtp-Source: ABdhPJxH7/ZKgWoWnVYh+D4j8m7LwUtdScXYKtOerDowIYHrkBFRK+sNKPZHBUWJnvIbUw7Xl+MMVw==
X-Received: by 2002:a5d:444c:: with SMTP id x12mr23015463wrr.6.1605180247340;
        Thu, 12 Nov 2020 03:24:07 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id q7sm6837706wrg.95.2020.11.12.03.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 03:24:06 -0800 (PST)
Subject: Re: [PATCH v2] thermal/drivers/cpufreq_cooling: Update cpufreq_state
 only if state has changed
To:     zhuguangqing83@gmail.com, viresh.kumar@linaro.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhuguangqing <zhuguangqing@xiaomi.com>,
        "v5 . 4+" <stable@vger.kernel.org>
References: <20201106092243.15574-1-zhuguangqing83@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <55b484fb-1532-e130-3b05-5a7f5e18a536@linaro.org>
Date:   Thu, 12 Nov 2020 12:24:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106092243.15574-1-zhuguangqing83@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/11/2020 10:22, zhuguangqing83@gmail.com wrote:
> From: Zhuguangqing <zhuguangqing@xiaomi.com>
> 
> If state has not changed successfully and we updated cpufreq_state,
> next time when the new state is equal to cpufreq_state (not changed
> successfully last time), we will return directly and miss a
> freq_qos_update_request() that should have been.
> 
> Fixes: 5130802ddbb1 ("thermal: cpu_cooling: Switch to QoS requests for freq limits")
> Cc: v5.4+ <stable@vger.kernel.org> # v5.4+
> Signed-off-by: Zhuguangqing <zhuguangqing@xiaomi.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
