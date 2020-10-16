Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB4128FDCE
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 07:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbgJPFqx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 01:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390934AbgJPFpz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 01:45:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC02C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 22:45:55 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so811382pfp.13
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 22:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Iox0f97PdfROSzFUQgLo8vkQuUFWUr6O8qnG9IL8Hyo=;
        b=dzDzI5F39hY8jXbyQBZeBkaEMQ1ZUu2e1PeEZomBUhHUTuegJIaMQuLDzZK29keBQN
         y/+Y2kOqQrME1RTptt8nGbzY67cj2Ivtum+T9IY4u9Di7KotQn4AHSWZBvfUc0DkeYSK
         YcmS5TctGoYCjmusCTu8YyybT2YnZFreqxOwVOYsTm7V2A9tJrnZ7GheC1qWBZJvh4dp
         3O/zPxmFvAMNaKBdHjMfoBIQmHwxYRpYBg/fiNAo/PfThRgzmZYSrINfoqXPqGbihWv4
         9ZWpXC/axXlmH6inBm+CihWnVZ0MnR3DJorNrvDXv1IHK8v1K126P4inwa0nP/z44rp9
         zyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iox0f97PdfROSzFUQgLo8vkQuUFWUr6O8qnG9IL8Hyo=;
        b=eAr3ALVvYEjbaPIlGeKULZbmPZyCpxzS8atGZjZXRZq6B1NVnluEk7U7RZSwW18wgA
         B1e/J+wmviSAW5tnWcclBRMCZE/DXSA8US8tdiKOwElFJE2OhLWM5YbhUKhHMzTbBDle
         18O+s88h2RZPqZzTJ0Xhiw+Ubj0wj8zWh7IvFjFBB0GA+n0hdYjBCRlSH9h2m/UWsslc
         x7yHv/LKpcscgiftiycnYIvCTn7iPQfFzXFh0kwuadchMNQxH0lepIBaPbxOtchkUh7Y
         uItWD41RUTc/HvOSP7tXbfEQjvOmdomUfeszlalO92dBQZBphxMK8xgnBRIS6IjyeAmM
         Qksw==
X-Gm-Message-State: AOAM531Yiyh5OQfO4R75Q9E4fNTsUtsUH69rO4HBXvMG1t1lLgRbiCvm
        wR+hnN+hS1wHdGiGRaYFplrM2Q==
X-Google-Smtp-Source: ABdhPJxDK+1Ye5nb3j+GL6B1SPF/7OIW2+L+AYAcXw/CnPftBnCxVYjZGLx8agf1VuGO2xSgTrpNaQ==
X-Received: by 2002:a63:2dc1:: with SMTP id t184mr1853195pgt.325.1602827154725;
        Thu, 15 Oct 2020 22:45:54 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id i126sm1236775pfc.48.2020.10.15.22.45.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 22:45:53 -0700 (PDT)
Date:   Fri, 16 Oct 2020 11:15:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, sbhanu@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>, nm@ti.com
Subject: Re: WARNING: at drivers/opp/core.c:678
 dev_pm_opp_set_rate+0x4cc/0x5d4 - on arm x15
Message-ID: <20201016054551.jwxk2xdvvnk7o5yy@vireshk-i7>
References: <CA+G9fYvK5UkERLuBSRH5t2=j5==dbtw45GTMta9MafyJDqFsFA@mail.gmail.com>
 <20200827094651.3grvs6ungv3dh7y3@vireshk-i7>
 <20200827211832.3ebeda8a@canb.auug.org.au>
 <20200828045128.y7ybkd7dnvn4h6dt@vireshk-i7>
 <CA+G9fYsn1S-SieuP85-Z4qKO+aNyqJarrBR0xx0X-YbtF9eo0g@mail.gmail.com>
 <20200831044132.jb7aflr2sfbart2z@vireshk-i7>
 <CA+G9fYsLd77Wuz6Fdwr0w4eFvs=rX5ooewrztFtSe7MeyRJeGQ@mail.gmail.com>
 <20200831060203.7guhirtxb72odow2@vireshk-i7>
 <CA+G9fYv5WKQkDvjZsc+xth54X_MK3qUmuUTXhUDVUHpS3UhNpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYv5WKQkDvjZsc+xth54X_MK3qUmuUTXhUDVUHpS3UhNpQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+Dave,

On 15-10-20, 15:26, Naresh Kamboju wrote:
> The arm x15 boot failed on Linus 's mainline version 5.9.0.

Don't mention the version as this doesn't give the right information.
You tested it over 5.9 + 5.10-rc1 material.

> I have listed the latest commits on drivers/opp/ .
> 
> metadata:
>   git branch: master
>   git repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
>   git commit: 3e4fb4346c781068610d03c12b16c0cfb0fd24a3
>   git describe: v5.9-4105-g3e4fb4346c78
>   make_kernelversion: 5.9.0
>   kernel-config:
> https://builds.tuxbuild.com/2BB2g61t29VaadVLXEl4cQ/kernel.config
> 
> 
> ------------[ cut here ]------------
> [   13.530971] sdhci-omap 4809c000.mmc: Got CD GPIO
> [   13.535647] WARNING: CPU: 0 PID: 137 at drivers/opp/core.c:678
> dev_pm_opp_set_rate+0x4cc/0x5d4

Looks like the stuff from drivers/opp/ti-opp-supply.c supply didn't
work as expected.

One of the major changes came with these patches:

dc279ac6e5b4 cpufreq: dt: Refactor initialization to handle probe deferral properly
dd461cd9183f opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER

And that's where I think it may have gone wrong.

Dave: Will you (or someone else from TI) can have a look at it as well
?

-- 
viresh
