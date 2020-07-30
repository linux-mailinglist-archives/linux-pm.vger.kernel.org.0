Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5410232BE3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 08:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgG3GYU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 02:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgG3GYT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 02:24:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8511BC0619D2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 23:24:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so15969828pgb.6
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 23:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XPnPVe/hBWV8ylTxStT4hqgYjjgVSOD9uWxEIWOaFgQ=;
        b=ldIuMhjRCKAjbwoGPa+nSN6KncO7fsi1IvDYGFsNSnDyaQ+H/cnJ2f3w7dEo5QgvPh
         xtEqOV1uuf/gmhfscqmAA2ExohCpn3Zz+GXwzguHX1VAmjy6p2iBuNi2VejPqhC81xxw
         etkEWT9Vuu6P1PiO3NYhSe2KtJKglpTZUWrU9sn/Kgi4AZjoqS/Sk95euSmpJS4gg/X+
         IFFnCag173v57OWvBfRdhrSnu2LcIOlURV7JFtawULXaFhaZXDl5yULkxre5yrA2Spp3
         JQTO0XIuJ0tD2zZMmwmHfX/Tei4B3OXhvJ61prZxsJDwBDM3XqnHsCHjl7aWfE4TW40s
         rTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XPnPVe/hBWV8ylTxStT4hqgYjjgVSOD9uWxEIWOaFgQ=;
        b=kN4XY9fICTxTpy3trszGvts45HBXxaUL38VQxHxZL69K5iC8kXKCtbPfDz4yg5zYPq
         ZhtFdmq/mBHpvaCtASoj99JkepAoy5UM8g+aZ+k6Vr+S9I08kDKLrBn7BNt6+TnokbCf
         7X+w+mvaHAfNH0qisWzSJoQ3pHMQQMAeOR3MQy7LbrG95/xFM3hxgJmliaiMxLBogPk2
         1122N5SJ764kKqoow5lhpoGv9VNXynNbC2srSJicfqVUM40kBMWowjBfzxd9YdQEs7fo
         M4nZb+uwZZ+h6oLz/lZV9kSVCsG9QQCwFTZVu64OMDG1jbeFddzUrbBlEQiUi2ofCdxi
         6F6g==
X-Gm-Message-State: AOAM532Mlcgzjc3944p4ClbcH7b0U2MT3QXNDXN3sTKItKDdpW6mS1o+
        zKMRjZX+zZ3AOZc6XvuMDT8xWHukNH4=
X-Google-Smtp-Source: ABdhPJx3x1DBRy4eexY/OhOFytaYU7ysFTqceScvV/5SpmHvZFAmx47nY0u/kZ3Cq7/6tuca1ZuNbQ==
X-Received: by 2002:a62:1951:: with SMTP id 78mr1751266pfz.137.1596090257777;
        Wed, 29 Jul 2020 23:24:17 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id 3sm3489881pfv.109.2020.07.29.23.24.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 23:24:17 -0700 (PDT)
Date:   Thu, 30 Jul 2020 11:54:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20200730062414.uq3ip7ukpu7nkiyg@vireshk-mac-ubuntu>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net>
 <681fb3e8-d645-2558-38de-b39b372499de@arm.com>
 <CAKfTPtA+BPegK2h6PQMFs+p4dpxO+sk1FDQuOfJvSpGCJ-rBrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA+BPegK2h6PQMFs+p4dpxO+sk1FDQuOfJvSpGCJ-rBrA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-07-20, 11:46, Vincent Guittot wrote:
> On Thu, 16 Jul 2020 at 16:24, Lukasz Luba <lukasz.luba@arm.com> wrote:
> > On 7/16/20 12:56 PM, Peter Zijlstra wrote:
> > > Currently cpufreq_cooling appears to estimate the CPU energy usage by
> > > calculating the percentage of idle time using the per-cpu cpustat stuff,
> > > which is pretty horrific.
> >
> > Even worse, it then *samples* the *current* CPU frequency at that
> > particular point in time and assumes that when the CPU wasn't idle
> > during that period - it had *this* frequency...
> 
> So there is 2 problems in the power calculation of cpufreq cooling device :
> - How to get an accurate utilization level of the cpu which is what
> this patch is trying to fix because using idle time is just wrong
> whereas scheduler utilization is frequency invariant

Since this patch is targeted only towards fixing this particular
problem, should I change something in the patch to make it acceptable
?

> - How to get power estimate from this utilization level. And as you
> pointed out, using the current freq which is not accurate.

This should be tackled separately I believe.

-- 
viresh
