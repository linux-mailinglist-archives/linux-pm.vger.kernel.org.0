Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5A63B120D
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 05:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFWDRh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 23:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhFWDRh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 23:17:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C18DC061574
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 20:15:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l11so672804pji.5
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 20:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TuCy8+xkSVnt5Wvjvnwh0oeMFS0ejFv9priNd5TkRqQ=;
        b=cG4bJf/iowDxrn+Pd0mzF9l2OghEQ+/GMmF/toFW3RtBNfInDieq+h2fdr7W5WG+L2
         qGWY3jPZ/AzziJ6L7uNKCa3PT10hUP0g3weLHm2iayaxC2O/OhnicSbZxaNDIoj3gHsX
         BaFM7FXs5/07EmMkot4IgozRn6BxtZ5vV5FKA1KRDthBO/6GuaHq9CxBQVstAcGLkTot
         dSdG4utG32FVNZ5MnWysmwkbNXzokFJuXpvH4R0AJGWfKXh/goCoOBs1L8zYjcZypuYW
         modgX+u4ldDMD8h3FZF8f/YWXdVeazndwdVgMsyPsw7VT5UuUXkftXcHCrFw4KHUZW6g
         1fEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TuCy8+xkSVnt5Wvjvnwh0oeMFS0ejFv9priNd5TkRqQ=;
        b=gD9PPnHruyyPtM3A7f7kmpV/emAf41HL34Du0aSDzJXtnbtXrcM2VNZ27rhO6HDMLn
         P1CVIk1S7gijqJ8lQDKAEFKRQhbOw1Cs/y8PnQhH24SkjTmr9Ne1QQ0tgWf19HxM/wHh
         Dl1yHqkkr4bZl+LzvzJGgrZi+eN/Es8E602AMuX4lWVD1kbgDzymqlErFzc+KpF76HtJ
         E0ffPskRgGmI/vJ/80JW2V2n6tdC+t1vmWb7Se4TzVenWu1lx4GOx5VJL10ajaTM0uUU
         AJO6K5J9Xo5uWAy58Sbf/cMncXPEVazQlaZKEZq0Sy00K+fnLHlRa1UKgcBtcEt5l+/V
         FiVA==
X-Gm-Message-State: AOAM5338y+UZfBbhdWcnNPoeX1eGKXLRbDmaBNsyYvMBtsOHgpc3AaNy
        mDN3S2XvJ+z1fHMpdNfgXjS2PA==
X-Google-Smtp-Source: ABdhPJzJQB81msBICR6glRTkaUTRQt50ey4SO5o8UwaeyNGNaaBktoTMV8qvj3S/aH9E7OXeSZOVVA==
X-Received: by 2002:a17:902:b7c9:b029:122:ee2d:25f1 with SMTP id v9-20020a170902b7c9b0290122ee2d25f1mr18423595plz.14.1624418119745;
        Tue, 22 Jun 2021 20:15:19 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id j15sm3490167pjn.28.2021.06.22.20.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 20:15:19 -0700 (PDT)
Date:   Wed, 23 Jun 2021 08:45:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        dietmar.eggemann@arm.com, Chris.Redpath@arm.com,
        Beata.Michalska@arm.com, rjw@rjwysocki.net, amit.kachhap@gmail.com
Subject: Re: [RFC PATCH 3/4] cpufreq: Add Active Stats calls tracking
 frequency changes
Message-ID: <20210623031517.tldkue7dcx4bt7gn@vireshk-i7>
References: <20210622075925.16189-1-lukasz.luba@arm.com>
 <20210622075925.16189-4-lukasz.luba@arm.com>
 <20210622093258.lddlznwsndpw5mju@vireshk-i7>
 <a5d5d6b8-f358-d1d6-86d0-750af76b0cfb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d5d6b8-f358-d1d6-86d0-750af76b0cfb@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-06-21, 12:07, Lukasz Luba wrote:
> That cpufreq_stats_record_transition() is present only if
> CONFIG_CPU_FREQ_STAT is set. I didn't wanted to be dependent on
> this config.

Right, but you can also update the dummy
cpufreq_stats_record_transition() function as well and you won't
depend on the CONFIG then.

> > 
> > Plus don't you need to record this for all policy->cpus instead of
> > just policy->cpu ?
> > 
> 
> It will be accounted for all cpus in that freq domain. The
> active_stats_cpu_freq_fast_change() implementation uses
> a shared structure (single for whole domain) 'shared_ast':
> _active_stats_cpu_freq_change(ast->shared_ast, freq, ts)
> (from patch 1/4)

Ahh, I missed that then.

-- 
viresh
