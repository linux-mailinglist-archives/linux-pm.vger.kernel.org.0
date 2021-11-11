Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5F644D039
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 04:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhKKDSa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 22:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKKDS1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 22:18:27 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4150CC061767
        for <linux-pm@vger.kernel.org>; Wed, 10 Nov 2021 19:15:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso3554419pjo.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Nov 2021 19:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/5zkR3U2FQC1tqa/YXJsmNW9KSbiqa9Q8aOa7ULbmu4=;
        b=Appp1grQ5h6Bhe7d7I9ZhKx2QfuE8WSF7AAoqJtcrm+tDQHU5H8+JaW2/5W9jFE3KB
         njnGrrF50di67jm6cQjGFY6VqtW+sWLY60X4dRAJCW57HALocHSbwyjgbmGXpMsxpgLU
         F+Vkrj1+yvee9xjrumG9sd6vmOlO8ONwPrDlXgEEM8c/P4cfGRBlODoys2ZYde/Kxofa
         XFv8zVURXKnY/AMF8aZhGyrTaRWGgJbkM39hgDGXZHm/qKEaW3wKb+QGaBx2oYrXKT3J
         JH6O54n2kDXiv/0GqI0lRnhEsy09EVh6hyEWioCZ7ADd/rYdGWrOe4/ooqnJqo/6lXA4
         CWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/5zkR3U2FQC1tqa/YXJsmNW9KSbiqa9Q8aOa7ULbmu4=;
        b=zQ2R9YMAyPBMCOJOhvJRfqtZJzz6xXKJFq/YlyGsRUXSHMetaimsVIyx6h6PNbHWu0
         RuluHpo8zPH4AJ/OvlzHeO2dYDd6fqFml0dUcQsBt2npYnz+UG4JHDVrz1bDCBCwh33b
         kXB1KfuxtUSkiUFWLqsIaD+6iM9FDff9O8aCM8dpLLZiAbmyAYj5NtrictGdV8kqVWkh
         DwnEI0u3el+GjtgxuFTaNbgmMWI8Lu2yYLk8lhQ6uxaP+/dKwSeSjtUBsx8cS5RCc1uY
         iGNTp5pKBC7b6r0FWTrOP+SQBhTR86rqJ921f8/AQBqiOYodLW8jIvIKurRnkpY8BKd+
         JGjg==
X-Gm-Message-State: AOAM533/I7J0ug8uWXi0PrNZ7vIRQMnZvpUR7Wbj5GY8y/ZnUnb8r+2n
        M3mRKk1aCkEhttemORHWabEDzA==
X-Google-Smtp-Source: ABdhPJzSUgcU1oaYTZGUY3vF8OjvMrZt81Tp+bZfQn0DdzSFapXI/ftNA9h7SfKmVtv2FCnX/gneaQ==
X-Received: by 2002:a17:90b:230c:: with SMTP id mt12mr22334741pjb.63.1636600538658;
        Wed, 10 Nov 2021 19:15:38 -0800 (PST)
Received: from localhost ([223.226.77.81])
        by smtp.gmail.com with ESMTPSA id nn4sm842601pjb.38.2021.11.10.19.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 19:15:37 -0800 (PST)
Date:   Thu, 11 Nov 2021 08:45:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, steev@kali.org,
        sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, amitk@kernel.org, daniel.lezcano@linaro.org,
        amit.kachhap@gmail.com, thara.gopinath@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org
Subject: Re: [PATCH v4 0/5] Refactor thermal pressure update to avoid code
 duplication
Message-ID: <20211111031535.nvrngqqffdmw2jgz@vireshk-i7>
References: <20211109195714.7750-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109195714.7750-1-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-11-21, 19:57, Lukasz Luba wrote:
> Hi all,
> 
> This patch set v4 aims to refactor the thermal pressure update
> code. There are already two clients which do similar thing:
> convert the capped frequency value into the capacity of
> affected CPU and call the 'set' function to store the 
> reduced capacity into the per-cpu variable.
> There might be more than two of these users. In near future
> it will be scmi-cpufreq driver, which receives notification
> from FW about reduced frequency due to thermal. Other vendors
> might follow. Let's avoid code duplication and potential
> conversion bugs. Move the conversion code into the arch_topology.c
> where the capacity calculation setup code and thermal pressure sit.
> 
> Apart from that $subject patches, there is one patch (3/5) which fixes
> issue in qcom-cpufreq-hw.c when the thermal pressure is not 
> updated for offline CPUs. It's similar fix that has been merged
> recently for cpufreq_cooling.c:
> 2ad8ccc17d1e4270cf65a3f2
> 
> The patch 4/5 fixes also qcom-cpufreq-hw.c driver code which did
> the translation from frequency to capacity wrongly when there
> was a boost frequency available and stored in 'policy->cpuinfo.max_freq'.

LGTM. I will apply this in a few days so people get time to Ack/Review
the patches.

-- 
viresh
