Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7F543B797
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 18:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhJZQxe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 12:53:34 -0400
Received: from foss.arm.com ([217.140.110.172]:34932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236197AbhJZQx2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Oct 2021 12:53:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FCBE1FB;
        Tue, 26 Oct 2021 09:51:04 -0700 (PDT)
Received: from [192.168.185.184] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F9823F70D;
        Tue, 26 Oct 2021 09:50:59 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] thermal: cpufreq_cooling: Use new thermal pressure
 update function
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
References: <20211015144550.23719-1-lukasz.luba@arm.com>
 <20211015144550.23719-3-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <495d461a-d643-5dbf-7da8-74ddbdc486ca@arm.com>
Date:   Tue, 26 Oct 2021 18:51:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015144550.23719-3-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/10/2021 16:45, Lukasz Luba wrote:

[...]

> @@ -479,10 +478,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>  	if (ret >= 0) {
>  		cpufreq_cdev->cpufreq_state = state;
>  		cpus = cpufreq_cdev->policy->related_cpus;
> -		max_capacity = arch_scale_cpu_capacity(cpumask_first(cpus));
> -		capacity = frequency * max_capacity;
> -		capacity /= cpufreq_cdev->policy->cpuinfo.max_freq;

Took me a while to realize that `cpufreq_cdev->policy->cpuinfo.max_freq`
is 1000 * per_cpu(freq_factor, cpu), the latter being used now in
arch_thermal_pressure_update(). Maybe worth mentioning in the patch header?
