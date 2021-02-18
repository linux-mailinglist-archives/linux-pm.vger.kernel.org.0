Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BE031E7EE
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 10:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhBRJWs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 04:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhBRJJa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 04:09:30 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D94C061756
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:08:04 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t2so1057873pjq.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f3r3WiCVRBxkJr6r7AbTWnygN26Y0ayRcsLAMnhB5sE=;
        b=QJfuhgpsfxJIGJA7L4EjIiY6DEyWcy2XeX11Sjdmp0tnL/xm2fhNRDfpqeekkVc68k
         cLciEQQLeXHIRRP+jUMf2De00Lbh7phPXh0yOG5xkNS48/lVAT8mUjDQxA69cfwTrIis
         IBgJaAMLrVxQL1AAxvXWf2V2WYfo2v5zB8KcwrOF4PKSwZj50SJNI0Ys/RiaCyS3ZlIC
         6akcb3M+uBkGQDezg1KslPejWH2IGR3y9FcvQy5y/FzlKdepiqmW1GLqV6bAcrI9HbtG
         oHkWOUa56WYOHmkYaVbA9dWQtXkexHHawm1not80EdWu+sz2+Z5XmVQU23WRw0izsdno
         cx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f3r3WiCVRBxkJr6r7AbTWnygN26Y0ayRcsLAMnhB5sE=;
        b=YmFyOgH9tL3Aid2E6rn6LxU1bNqjIIJlje/LyZlOqNEvS6wS3VYWFkrt4LWd3wvCpu
         vd0j6kW30wSYLVnIrwELsJP8axXzgp4iho0cGDwH7uJtcmteJTrITRfNUTZDEobzJ3bL
         wRet3+ZOVrZZ70Fhm+DfEr2jxnCEVEwC6e0St4tJmeWxmwaSHZmfDARaia4T4ywixuEW
         1llvsGRiKlmV8h02KEjpc80vLfOsn9ppiB3+r5NsnrWhaRA3fZ/LiYuI6pAtsUweCCGQ
         dc2nJdpSIaM+GwQXzFLdBDPAIEtyapZ0mD94r7+L1dyTiHNWANKf7/JFtg9lgWObfVsz
         cscQ==
X-Gm-Message-State: AOAM530knCYSKf2VdWQtYnB7/Q9nsheOknf/pGJra8sKk5JfxWoni4dd
        ZTRAiwaacvJw1AbOgV7f0bmUAg==
X-Google-Smtp-Source: ABdhPJwH5Yb+V9WU6Cx8sm3sVmtL3vGefTKbMlzySB2jw+pGKiq2ngMGNLoDQ2nRFJ7mn1EAz9Gghw==
X-Received: by 2002:a17:90a:7108:: with SMTP id h8mr3022005pjk.98.1613639284464;
        Thu, 18 Feb 2021 01:08:04 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id fz24sm4783688pjb.35.2021.02.18.01.08.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 01:08:03 -0800 (PST)
Date:   Thu, 18 Feb 2021 14:38:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-pm@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Remove the needless sg_policy
 parameter to ignore_dl_rate_limit()
Message-ID: <20210218090802.x2znazuw7fxnvhtn@vireshk-i7>
References: <20210218090132.1556-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218090132.1556-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-02-21, 17:01, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Since sg_policy is a member of struct sugov_cpu. Also remove the local
> variable in sugov_update_single_common() to make the code more clean.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
