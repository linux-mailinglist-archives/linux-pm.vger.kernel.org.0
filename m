Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99EF10FAEF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 10:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfLCJki (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 04:40:38 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:43624 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJkh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 04:40:37 -0500
Received: by mail-pj1-f68.google.com with SMTP id g4so1289398pjs.10
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 01:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eDtRwpmvkr7nLn8lvbaPiT2Oly+RU0HidwiYKFl5BFw=;
        b=up6sP10zLBlDXpgSmInJDNKgMYP/4Qs6vwyakXQSYJUgaLH3GZNvHvLYOfWdwUiaaN
         IOy9kHP8a3g/uXFjNlKW7yfvoJARphBC2cUyiOxT0Z4zaHF1C1eYRuN3Fn4VY/nQI9tl
         1UB9Q3xdLvYnnjBwZvZyB0vylXEFVGUDRhnRfdw8Y7HOm8WRKaCorkADMCZEsandP9Af
         rSXqVT5WC7EuNqmQmnE1GZCBsgj7JKusu8tRn3JW7PPabXfQmujFxsKeU3ItmvZKLHak
         rwVC8vRsM6hKMW2505RxyQ4McrdAOJ2L/kNP241SiPl3WbGXi8nmbJA9IFOUbGuV13Og
         X9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eDtRwpmvkr7nLn8lvbaPiT2Oly+RU0HidwiYKFl5BFw=;
        b=Dguf7IwbEtJYGmTIcaNtSE2UF6S4UFEqdw57AER9RTm7ByzpWVNSNC/Yqo0q468bJF
         qOM7rtR5waLMn6AvGe6G0euEBkb7SnBK/Ov24H6WooNIb8NARMb2AqoeEr3SczGkC/QK
         7h5c13nSNrgbHDFHFrqkSgBAZwgDKkCUB3y8sYio1K1FDEaQ2pjOw6CD2YVp2CMX9s3R
         Jug6MyACzBv+DmGTEvuxGVWv0uXiNrbJrjTe2ioLbKPftB8GAYHBcYF9k+cG1xWUesoM
         TeLHW2MYu+0GkC1bGueIiWmPbL2r/JkQH/TkjHhtQfsbQiiq6hTtZ3+eLGI36dTQ0g/n
         SlPg==
X-Gm-Message-State: APjAAAXTE2Nd6g0IVULTKIN6ONqpDmrlqszkZaflIwsdtVd0ae0Oqag9
        U+9Eg68phfgj0l9j2sweldQpSA==
X-Google-Smtp-Source: APXvYqzAnDgGZLeG8SDgrKu6WlnLCeGOpRS/4bUlMqKPQZxFXMpqoKVKF3o/bDAkM5Pwf1lQHqw2zA==
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr4477702pjd.131.1575366037148;
        Tue, 03 Dec 2019 01:40:37 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id y3sm2729669pfe.183.2019.12.03.01.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 01:40:36 -0800 (PST)
Date:   Tue, 3 Dec 2019 15:10:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, rjw@rjwysocki.net, edubezval@gmail.com,
        linux-pm@vger.kernel.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/4] thermal/drivers/cpu_cooling: Rename to
 cpufreq_cooling
Message-ID: <20191203094034.smijr6e3apmftyz3@vireshk-i7>
References: <20191203093704.7037-1-daniel.lezcano@linaro.org>
 <20191203093704.7037-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203093704.7037-4-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-12-19, 10:37, Daniel Lezcano wrote:
> As we introduced the idle injection cooling device called
> cpuidle_cooling, let's be consistent and rename the cpu_cooling to
> cpufreq_cooling as this one mitigates with OPPs changes.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   V3:
>     - Fix missing name conversion (Viresh Kumar)
> ---
>  Documentation/driver-api/thermal/exynos_thermal.rst  | 2 +-
>  MAINTAINERS                                          | 2 +-
>  drivers/thermal/Makefile                             | 2 +-
>  drivers/thermal/clock_cooling.c                      | 2 +-
>  drivers/thermal/{cpu_cooling.c => cpufreq_cooling.c} | 6 +++---
>  include/linux/clock_cooling.h                        | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
>  rename drivers/thermal/{cpu_cooling.c => cpufreq_cooling.c} (99%)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
