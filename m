Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860AD3B6DBE
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 06:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhF2EsA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 00:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhF2Er6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jun 2021 00:47:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30C6C061760
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 21:45:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y4so16152071pfi.9
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 21:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FgDtIS5nzZ8aSR8Tc0jaozyyA+YsZVdTeRCKNqHLJP8=;
        b=s+7hfDSlxD/Y9a7eABn6WMMoSmQi/YCkYcPpVxgDJeowPogFtVhq8UmJPpz5h7oBm1
         yjuOC+N+NcfKGIW2fa+h54NgV7wTxtPvYZxPl1bmMcx/ikaLrtup3v5AZ2M9lYH0PTt6
         uG4XXUJis4pLbInL2bVnVHHO5uUzd0R/LLxnf/S+aBBAfxTxsqmHkihRV/DdToPexsmx
         yRzCvO6SaRB9MUIElb3fOaTRr5CtwqWiN4hEQKa+6lxjMnPQ46Oks12EdtYSuj6FKWha
         ybm5ch2WewxpIlUljrw9BSYI6V0rf+6O+IZodfEQC8OV5ZsjDPbVxuB8om9xkKir9LHx
         FJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FgDtIS5nzZ8aSR8Tc0jaozyyA+YsZVdTeRCKNqHLJP8=;
        b=W/946rtxpsWk//u54f3QcZyDtu5WzUWFkwVH9Wd68Dsu+FFA5hZPpbJXB5OZ8V9HWU
         aGxCACCK3CBrTsKff6pCveAJAeBCVUgSl0dERo+nqgahUlhg8EEcZTwCCCAuVRqID00z
         nO+1SPzyj+Zds132IYFGkFsONmos2YBaB6LKCRuhEQQ3doDn8/eqoQ97Ym08gXVAwG5L
         /X0djHoOwMrN4w5fhVzUsabuyJ1xeuvtOOKD/I9zJz8SA5OcZLLOQOpStNMyR6GN49B0
         9pSCa00GMB+cL3tQTYUur/ZQlNzAl4oMhNJhYaQAzN/QZajPtsybGbd8gpf5Kdt7RhGI
         6PMQ==
X-Gm-Message-State: AOAM531/lL9Lxh7Rh294LFkwj6iGX01J8EgHvh5ZgMiM7nOBbfxEnEhr
        k8Y8evNwxJBsj2ct74fV9y1oTA==
X-Google-Smtp-Source: ABdhPJyyV23LoaJhFLvW21uIRAbYnKp8mhRHkcZsUNszFfhAX1Hc2/+IYCqwwk8iqymOvqOkOrGDgg==
X-Received: by 2002:a63:4706:: with SMTP id u6mr26204029pga.152.1624941930251;
        Mon, 28 Jun 2021 21:45:30 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id p3sm1278076pjt.0.2021.06.28.21.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 21:45:29 -0700 (PDT)
Date:   Tue, 29 Jun 2021 10:15:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 0/4] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210629044527.puvaxcf5fxdly6tz@vireshk-i7>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <09a39f5c-b47b-a931-bf23-dc43229fb2dd@quicinc.com>
 <20210623041613.v2lo3nidpgw37abl@vireshk-i7>
 <2c540a58-4fef-5a3d-85b4-8862721b6c4f@quicinc.com>
 <20210624025414.4iszkovggk6lg6hj@vireshk-i7>
 <CAKfTPtAXMYYrG1w-iwSWXb428FkwFArEwXQgHnjShoCEMjdYcw@mail.gmail.com>
 <20210624104734.GA11487@arm.com>
 <daf1ddf5-6f57-84a8-2ada-90590c0c94b5@quicinc.com>
 <20210625102113.GB15540@arm.com>
 <1f83d787-a796-0db3-3c2f-1ca616eb1979@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f83d787-a796-0db3-3c2f-1ca616eb1979@quicinc.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-06-21, 09:31, Qian Cai wrote:
> The problem is that all CPUs are never scaling down.
> "cpuinfo_cur_freq" and "scaling_cur_freq" are always the 2800 MHz on
> all CPUs on this idle system. This looks like a regression somewhere
> as in 5.4-based kernel, I can see "cpuinfo_cur_freq" can go down to
> 2000 MHz in the same scenario. I'll bisect a bit unless you have
> better ideas?

Few things which may let us understand the readings properly.

- cpuinfo_cur_freq: eventually makes a call to cppc_cpufreq_get_rate()
  and returns the *actual* frequency hardware is running at (based on
  counter diff around 2 us delay).

- scaling_cur_freq: is the frequency the cpufreq core thinks the
  hardware is running at, it would more in sync with what schedutil
  (or other governors) wants the CPU to run at. This can be different
  from what the hardware is running at, i.e. given by
  cpuinfo_cur_freq.

-- 
viresh
