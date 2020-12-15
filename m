Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A842DA711
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 05:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgLOERb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 23:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgLOERX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 23:17:23 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5FBC06179C
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 20:16:43 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w5so13594386pgj.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 20:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J7c5AfAAdB3hbte5dGITb7/JkaaBGAndXgJATibg+l8=;
        b=DjATrwToVmaTslB3bj50TIdNQig9BPfFbnRX0jKYqzxdc09k20RyiM14MhIGBSGuYK
         kyC40/RcPdeeou6hQb6NfgZ7iQRykG77KqYXHnqIGyNmnDqINXyKR1LxG2x4K8viFrPO
         O/fG51oNNDZRAC8bKFJ4jPNgG2le+MQccG98krSeaDYkqekW4OAy6kOBUHvJCW/e/NLI
         8LpaPDRV3K6+Fr/OY9+5qYCibImBJdXiuJ9e47QIlOPYK+ir/g+y7xh3JJIYfyrc1cwM
         pT42XFTfjDrGMgFW7nSPIyBBS/v63RQLsElcEgqK2pTGNDzAL0ABAO8g2/pfRpRI0jgg
         qxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J7c5AfAAdB3hbte5dGITb7/JkaaBGAndXgJATibg+l8=;
        b=qunMoIrSKAS7j1g/La/kxo5/xw3nFF46Np9vEVPGLKcK9NTxahYDvrsIYtey8YVusR
         qlwCvrQr07OK3JkaHHfGO5Ra5zKWU6tinDMMkpRilr58hEmRcet2wJRzxbKLIB/13L9m
         SJKZKiqUahQdToSfp/BkgIfagkwHvScgQ7JmF9TON2lEQPGi6jrroC2fImUVgwLpY4p0
         YTILxD7CUmTKKlnWrydP0gmIE0v+snn/JkwsnNdhyJXYLUnpHbZOzLKgA9dqy/lEtOQU
         QA/zJTUgxmY+J5SLMMgdlc4z8iH9iCrn/HGOQjBId39Fing+hdKav36aKX690Hf2finA
         q/hQ==
X-Gm-Message-State: AOAM531w032ZyyvgYMsns4/szsQ4K5UGec3GHjr5759OEAKPsd9qHzsU
        MA0m75zyedRpxNlcbtVjDhZmTQ==
X-Google-Smtp-Source: ABdhPJwgN6wzWmvyEJzyCriV1xjQXEHZC5rIujqvRAbSaPTfK42dqnuzbRqj8+QE3cwW03XPBb12dg==
X-Received: by 2002:a63:d45:: with SMTP id 5mr26897386pgn.424.1608005802699;
        Mon, 14 Dec 2020 20:16:42 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id b24sm19804332pjq.10.2020.12.14.20.16.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 20:16:41 -0800 (PST)
Date:   Tue, 15 Dec 2020 09:46:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: Re: [PATCH v1 3/4] cpufreq: Add special-purpose fast-switching
 callback for drivers
Message-ID: <20201215041636.yfgyswqjslg4hlff@vireshk-i7>
References: <20360841.iInq7taT2Z@kreacher>
 <146138074.tjdImvNTH2@kreacher>
 <20201208090207.sz4v43bwvm7yugrb@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208090207.sz4v43bwvm7yugrb@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-12-20, 14:32, Viresh Kumar wrote:
> On 07-12-20, 17:35, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > First off, some cpufreq drivers (eg. intel_pstate) can pass hints
> > beyond the current target frequency to the hardware and there are no
> > provisions for doing that in the cpufreq framework.  In particular,
> > today the driver has to assume that it should not allow the frequency
> > to fall below the one requested by the governor (or the required
> > capacity may not be provided) which may not be the case and which may
> > lead to excessive energy usage in some scenarios.
> > 
> > Second, the hints passed by these drivers to the hardware need not be
> > in terms of the frequency, so representing the utilization numbers
> > coming from the scheduler as frequency before passing them to those
> > drivers is not really useful.
> > 
> > Address the two points above by adding a special-purpose replacement
> > for the ->fast_switch callback, called ->adjust_perf, allowing the
> > governor to pass abstract performance level (rather than frequency)
> > values for the minimum (required) and target (desired) performance
> > along with the CPU capacity to compare them to.
> > 
> > Also update the schedutil governor to use the new callback instead
> > of ->fast_switch if present.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > Changes with respect to the RFC:
> >  - Don't pass "busy" to ->adjust_perf().
> >  - Use a special 'update_util' hook for the ->adjust_perf() case in
> >    schedutil (this still requires an additional branch because of the
> >    shared common code between this case and the "frequency" one, but
> >    IMV this version is cleaner nevertheless).
> > 
> > ---
> >  drivers/cpufreq/cpufreq.c        |   40 ++++++++++++++++++++++++++++++++
> >  include/linux/cpufreq.h          |   14 +++++++++++
> >  include/linux/sched/cpufreq.h    |    5 ++++
> >  kernel/sched/cpufreq_schedutil.c |   48 +++++++++++++++++++++++++++++++--------
> >  4 files changed, 98 insertions(+), 9 deletions(-)
> > 
> > Index: linux-pm/include/linux/cpufreq.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/cpufreq.h
> > +++ linux-pm/include/linux/cpufreq.h
> > @@ -320,6 +320,15 @@ struct cpufreq_driver {
> >  					unsigned int index);
> >  	unsigned int	(*fast_switch)(struct cpufreq_policy *policy,
> >  				       unsigned int target_freq);
> > +	/*
> > +	 * ->fast_switch() replacement for drivers that use an internal
> > +	 * representation of performance levels and can pass hints other than
> > +	 * the target performance level to the hardware.
> > +	 */
> > +	void		(*adjust_perf)(unsigned int cpu,
> > +				       unsigned long min_perf,
> > +				       unsigned long target_perf,
> > +				       unsigned long capacity);
> 
> With this callback in place, do we still need to keep the other stuff we
> introduced recently, like CPUFREQ_NEED_UPDATE_LIMITS ?

Ping

-- 
viresh
