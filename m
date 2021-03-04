Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133EC32D47F
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 14:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbhCDNsf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 08:48:35 -0500
Received: from foss.arm.com ([217.140.110.172]:38514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238758AbhCDNsa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Mar 2021 08:48:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30CE731B;
        Thu,  4 Mar 2021 05:47:44 -0800 (PST)
Received: from [10.57.19.206] (unknown [10.57.19.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAF7F3F766;
        Thu,  4 Mar 2021 05:47:39 -0800 (PST)
Subject: Re: [PATCH] devfreq: Register devfreq as a cooling device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     cwchoi00@gmail.com, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "open list:DRM DRIVERS FOR LIMA" <dri-devel@lists.freedesktop.org>,
        "moderated list:DRM DRIVERS FOR LIMA" <lima@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>
References: <20210304125034.28404-1-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <5f06e0c5-b2d9-5e11-01b6-fdd0dac635a7@arm.com>
Date:   Thu, 4 Mar 2021 13:47:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210304125034.28404-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 3/4/21 12:50 PM, Daniel Lezcano wrote:
> Currently the default behavior is to manually having the devfreq
> backend to register themselves as a devfreq cooling device.
> 
> There are no so many and actually it makes more sense to register the
> devfreq device when adding it.
> 
> Consequently, every devfreq becomes a cooling device like cpufreq is.
> 
> Having a devfreq being registered as a cooling device can not mitigate
> a thermal zone if it is not bound to this one. Thus, the current
> configurations are not impacted by this change.

There are also different type of devices, which register into devfreq
framework like NoC buses, UFS/eMMC, jpeg and video accelerators, ISP,
etc.
In some platforms there are plenty of those devices and they all would
occupy memory due to private freq_table in devfreq_cooling, function:
devfreq_cooling_gen_tables().

IIRC in OdroidXU4 there are ~20 devfreq devs for NoC buses.

It's true that they will not affect thermal zones, but unnecessarily,
they all will show up in the /sys/class/thermal/ as
thermal-devfreq-X.

IMO the devfreq shouldn't be tight with devfreq cooling thermal.

CpuFreq is different because it handles only CPUs. Here we have
many different devices.

Regards,
Lukasz
