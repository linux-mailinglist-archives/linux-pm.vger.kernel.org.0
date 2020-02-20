Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE061665B3
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 19:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgBTSAs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 13:00:48 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37413 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgBTSAs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 13:00:48 -0500
Received: by mail-ed1-f67.google.com with SMTP id t7so23155375edr.4;
        Thu, 20 Feb 2020 10:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JuWavBe6OXyRFy5qql3DEFdCwPYGMywA79SDbY508v4=;
        b=ZAdsux1lXeRKDT//oS/PZRqYIHiJBgSn720SlCyHD31cakfxNNnwcbjAnmt8DLPe98
         FVZy7RaYvo+l1arPYoZlddPxxsz1WK5LKUN2zDkJNIHV5rxePheJYa1Cc5ByyfK7JuCJ
         4P/xqSYQt69fjd4gxXflBBtRlXGEYBcs55Tx0Low7nZG9alOXHxsvmS6MwIdeVM1LRbV
         4/pGqOhBOT3PtEYtR1UPSHqZ3WW2LF+MFhP+O7U/cFrjNZoCIbALdSzeyj/zHah7Yhf4
         8CTCaW5qVrbM/ARBCR5WB9j8Mn07QkE8LqNFqpzkYAZvP9vD1/lITos88bggs3ZgVNgt
         Huew==
X-Gm-Message-State: APjAAAXGja9/sJJlc4zfEyN/mysWkzReY4K1FTiiDomhFpXTw1WetHui
        liyAhRf2Fg18ucACDyWwGNo=
X-Google-Smtp-Source: APXvYqwN5Yx4Jc42BqpycwqSM0vNnKWMTJp0qMmgsdSQ1M3eTaby6XleOAjAIb1VUKWVgqrdjO6gCg==
X-Received: by 2002:a17:906:19c8:: with SMTP id h8mr31704573ejd.250.1582221644629;
        Thu, 20 Feb 2020 10:00:44 -0800 (PST)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id yh21sm14798ejb.62.2020.02.20.10.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 10:00:43 -0800 (PST)
Date:   Thu, 20 Feb 2020 19:00:40 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, kgene@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com,
        dietmar.eggemann@arm.com
Subject: Re: [RESEND PATCH v2 0/2] Enable Odroid-XU3/4 to use Energy Model
 and Energy Aware Scheduler
Message-ID: <20200220180040.GA8338@kozik-lap>
References: <20200220095636.29469-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220095636.29469-1-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 09:56:34AM +0000, Lukasz Luba wrote:
> Hi all,
> 
> This is just a resend, now with proper v2 in the patches subject.
> 
> The Odroid-XU4/3 is a decent and easy accessible ARM big.LITTLE platform,
> which might be used for research and development.
> 
> This small patch set provides possibility to run Energy Aware Scheduler (EAS)
> on Odroid-XU4/3 and experiment with it. 
> 
> The patch 1/2 provides 'dynamic-power-coefficient' in CPU DT nodes, which is
> then used by the Energy Model (EM).
> The patch 2/2 enables SCHED_MC (which adds another level in scheduling domains)
> and enables EM making EAS possible to run (when schedutil is set as a CPUFreq
> governor).
> 
> 1. Test results
> 
> Two types of different tests have been executed. The first is energy test
> case showing impact on energy consumption of this patch set. It is using a
> synthetic set of tasks (rt-app based). The second is the performance test
> case which is using hackbench (less time to complete is better).
> In both tests schedutil has been used as cpufreq governor. In all tests
> PROVE_LOCKING has not been compiled into the kernels.
> 
> 1.1 Energy test case
> 
> 10 iterations of 24 periodic rt-app tasks (16ms period, 10% duty-cycle)
> with energy measurement. The cpufreq governor - schedutil. Unit is Joules.
> The energy is calculated based on hwmon0 and hwmon3 power1_input.
> The goal is to save energy, lower is better.
> 
> +-----------+-----------------+------------------------+
> |           | Without patches | With patches           |
> +-----------+--------+--------+----------------+-------+
> | benchmark |  Mean  | RSD*   | Mean           | RSD*  |
> +-----------+--------+--------+----------------+-------+
> | 24 rt-app |  21.56 |  1.37% |  19.85 (-9.2%) | 0.92% |
> |    tasks  |        |        |                |       |
> +-----------+--------+--------+----------------+-------+
> 
> 1.2 Performance test case
> 
> 10 consecutive iterations of hackbench (hackbench -l 500 -s 4096),
> no delay between two successive executions.
> The cpufreq governor - schedutil. Units in seconds.
> The goal is to see not regression, lower completion time is better.
> 
> +-----------+-----------------+------------------------+
> |           | Without patches | With patches           |
> +-----------+--------+--------+----------------+-------+
> | benchmark | Mean   | RSD*   | Mean           | RSD*  |
> +-----------+--------+--------+----------------+-------+
> | hackbench |  8.15  | 2.86%  |  7.95 (-2.5%)  | 0.60% |
> +-----------+--------+--------+----------------+-------+
> 
> *RSD: Relative Standard Deviation (std dev / mean)

Nice measurements!

Applied both, thank you.

Best regards,
Krzysztof

