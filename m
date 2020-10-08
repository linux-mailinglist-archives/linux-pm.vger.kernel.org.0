Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB4128730F
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 13:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgJHLCq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 07:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgJHLCq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 07:02:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBD8C0613D3
        for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2020 04:02:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u24so4001812pgi.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2020 04:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=seYFO3MZi0exVs/ZUxcuhNhvgzjGR2rTrbYBZtZEJqA=;
        b=kMyxFGgBawxNBTQkES346ihp5Px1Yewo0rFQz6YH6VmOiboGAuW+Kc7SatGALM65E0
         iT7DA4ut81fCnHG53ACbd2vu34dEZt/jAsbai6qqt17HAlTY+4prLKD5NUX9C8CMaYvJ
         9RjhhL8f+09SPFEHjXfh+qlAghK5R1SmwXPAKuaVyXPJMtWeTQdCZcP0F5Lc6BvXWxYJ
         fVeS6xoGB+hlBizvf9oPRFdHnG0QTdXc8u/4In2veNI0XJs1J84buFuAh/xIHy47ZFk4
         r/HiywwhpNlOyDBX80X5tKVXy4JNljsxJzA9cGD6qr0tkGXNNqF7WXoOli+64cPW9BwG
         aXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=seYFO3MZi0exVs/ZUxcuhNhvgzjGR2rTrbYBZtZEJqA=;
        b=bIfhLh23WCxwWu5o4y+1fyp/UUGUMAnZlYsPr7MVUEgJsQLpwwmegwdehhac1UoWHC
         9rqJ768zOfZhoLSlTmLHa02rWlyMVKADrxqeDKH7I/CZ3rvPMar6CK9d7AEFZUxAlge5
         eNTROFkGiJcnuzBEZNNlnQA9GZBAUckoOMkU5FFq1Jkwgno2TvzqS7WxLRlfLluwlI5p
         EDGkECTDpfHafy+HukDZHLOAWbYvr0Ljb5GOEN4vpcrpcRtlVgs3WtkVhnkhiWXE/jLx
         17sYasB2jOgSKdWTgatEanxGLjBzZFEN8ofytXrECN+/2cuT9XUAKugYeOVH83vvNCiv
         xVWA==
X-Gm-Message-State: AOAM533R3wu4MgRqu203nASOvpfYKwJUS5fV8MDD+PPK8xNlVaURIqEc
        UAG2WBvznEo0A+ekJrFPWZJVTqRcDVMYaQ==
X-Google-Smtp-Source: ABdhPJxjpMounYBj09y8+gSGlN9nIF2DacFiUHEb7lVsdfQZ7veWAJwaqYxBeajp2YolegGCcyBJ+Q==
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr6743483pgj.74.1602154965062;
        Thu, 08 Oct 2020 04:02:45 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id v3sm7015641pjk.23.2020.10.08.04.02.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Oct 2020 04:02:44 -0700 (PDT)
Date:   Thu, 8 Oct 2020 16:32:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, daniel.lezcano@linaro.org,
        morten.rasmussen@arm.com, chris.redpath@arm.com
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7>
References: <20200924095347.32148-1-nicola.mazzucato@arm.com>
 <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-10-20, 13:58, Nicola Mazzucato wrote:
> Hi Viresh,
> 
> performance controls is what is exposed by the firmware through a protocol that
> is not capable of describing hardware (say SCMI). For example, the firmware can
> tell that the platform has N controls, but it can't say to which hardware they
> are "wired" to. This is done in dt, where, for example, we map these controls
> to cpus, gpus, etc.
> 
> Let's focus on cpus.
> 
> Normally we would have N of performance controls (what comes from f/w)
> that that correspond to hardware clock/dvfs domains.
> 
> However, some firmware implementations might benefit from having finer
> grained information about the performance requirements (e.g.
> per-CPU) and therefore choose to present M performance controls to the
> OS. DT would be adjusted accordingly to "wire" these controls to cpus
> or set of cpus.
> In this scenario, the f/w will make aggregation decisions based on the
> requests it receives on these M controls.
> 
> Here we would have M cpufreq policies which do not necessarily reflect the
> underlying clock domains, thus some s/w components will underperform
> (EAS and thermal, for example).
> 
> A real example would be a platform in which the firmware describes the system
> having M per-cpu control, and the cpufreq subsystem will have M policies while
> in fact these cpus are "performance-dependent" each other (e.g. are in the same
> clock domain).

If the CPUs are in the same clock domain, they must be part of the
same cpufreq policy.

> This performance dependency information is essential for some
> components that take information from the cpufreq policy.
> 
> To restore functionality we can use the optional node
> 'cpu-performance-dependencies' in dt which will provide such dependency
> information and we can add a new cpumask 'dependency_cpus' in policy.
> 
> Hope it gives some clarity.

Some, but I am still confused :(

Can you give a real example, with exact number of CPUs, how they share
clocks/voltage domains and what else the firmware needs in terms of
performance-domains ? That may make it easier for me to understand it.

-- 
viresh
