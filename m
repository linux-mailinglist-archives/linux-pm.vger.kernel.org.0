Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D746410F9C3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 09:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfLCIYq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 03:24:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42142 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLCIYq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 03:24:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id i5so1330531pgj.9
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 00:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ePyWpgO6SpDrkwgrOacCpFzQ/j20hTY+sW9Shl7aHi4=;
        b=WrQNp+5gaTi99HubsuUWY6+TPybVxVIy7K33TJMN6dkjxskbH8MgX/EfawEULeEv2m
         YRdy5kBChVwI2ybVNPQJwTMuCFTEqT7vqNy92OEzphn8q829Msb6uIk+5N2s9+i3tZuD
         cJItlyjxcvybI3I9QU/ssLAvnC5hVnGceiR10V2tOx3o2kD8d80BdmCUGGBoUMheWzhm
         zV5+HitRVdsAFOfUEKsJPuMRynuM4IIC5fqvWHfyMaHlN8RrsDjCxDjJQEevYnZgtX/N
         cQzqDn6rBsxPQ/cyG2DXpN9rgudaaDL6dMMTfMxebOxfNqHRfh08RqY7KN0APfZ4llCc
         z5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ePyWpgO6SpDrkwgrOacCpFzQ/j20hTY+sW9Shl7aHi4=;
        b=V5iwveRBu9aCljkhJMoJ9N2UyJHxNIMB8hzFo/oJltrp1+3aMX5vSBFpcwVSITpXaw
         ICsvELQufyuFhHaZnIsDUflg7DjQb9cwZQb2AVGEYEfFaMgv5f44GL1gjDI0ftwU9+0K
         +3s9q7PfBuSfCcXiRUUnINUrIpLHiAmzeVSjBZ3GyotZNkV3frtC8ccose2EMSSeQVsr
         69HfcGLRWR9AjKQbke1ipSImMQsYFkZMUpQU4chrcHSdCg6366DyeLKoFzZXISCCvVF6
         2AhRL+Rfi3iAZTPVAYfarhcLITUYYTgIGU0s4DgGUqwNqL8haM4Xkh6M7nJFlOzVb9C4
         smRw==
X-Gm-Message-State: APjAAAU2Y7QqgJdIl6JyNjsm4uwyxwNjWy3G2gF+ABtTOxoIkCCejBmQ
        7n2ZZJy+amxfY5DjId3eow/lTg==
X-Google-Smtp-Source: APXvYqywMuHAbETMeQr0BvdpfwYyzAXKj1Ia6vHnnLBFcNh+6+z/idLccu1jFpbRBS/g1rDnpDQGpw==
X-Received: by 2002:a62:1d90:: with SMTP id d138mr3549471pfd.223.1575361485999;
        Tue, 03 Dec 2019 00:24:45 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id u24sm2288069pfh.48.2019.12.03.00.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 00:24:45 -0800 (PST)
Date:   Tue, 3 Dec 2019 13:54:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, rjw@rjwysocki.net, edubezval@gmail.com,
        linux-pm@vger.kernel.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/4] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Message-ID: <20191203082443.p6aeg3ijkiva4ugb@vireshk-i7>
References: <20191202202815.22731-1-daniel.lezcano@linaro.org>
 <20191202202815.22731-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202202815.22731-3-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-12-19, 21:28, Daniel Lezcano wrote:
> The cpu idle cooling device offers a new method to cool down a CPU by
> injecting idle cycles at runtime.
> 
> It has some similarities with the intel power clamp driver but it is
> actually designed to be more generic and relying on the idle injection
> powercap framework.
> 
> The idle injection cycle is fixed while the running cycle is variable. That
> allows to have control on the device reactivity for the user experience.
> 
> An idle state powering down the CPU or the cluster will allow to drop
> the static leakage, thus restoring the heat capacity of the SoC. It
> can be set with a trip point between the hot and the critical points,
> giving the opportunity to prevent a hard reset of the system when the
> cpufreq cooling fails to cool down the CPU.
> 
> With more sophisticated boards having a per core sensor, the idle
> cooling device allows to cool down a single core without throttling
> the compute capacity of several cpus belonging to the same clock line,
> so it could be used in collaboration with the cpufreq cooling device.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  V2:
>    - Remove idle_duration_us field and use idle_inject API instead (Viresh Kumar)
>    - Fixed function definition wheh CPU_IDLE_COOLING is not set
>    - Inverted the initialization in the init function (Viresh Kumar)
> ---
>  drivers/thermal/cpuidle_cooling.c | 233 ++++++++++++++++++++++++++++++

This needs to go in MAINTAINERS file btw :)

-- 
viresh
