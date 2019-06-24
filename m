Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556A051A0F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 19:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbfFXRwT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 13:52:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46136 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732637AbfFXRwT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 13:52:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so15376380qtn.13;
        Mon, 24 Jun 2019 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DUehOKaKbmwsiJTMRsk7x0Iv9OZWXYb75DfFdFGEUAQ=;
        b=X1FrshOAnVb06slfQ6Uzg7JUl3fP3SFdxfmUtnqk0qEHtZKlecuHFxCg1SPSo34/Ei
         yp378qNJRQteKzkLgIHCqjGn80L3FI+XnK3jlQLLtSI+EndS9zrEOeBCEgs1RlXoTuzd
         85dY+wOGPUW0di+v7Nmi25nW79KrIw3XBhNLR4fsWtc72C8tjlmUN3HNaOpjccRHfkIB
         E3O4PQxSmh93ciC5ka0yYMT+3YlbL3NP8BjOTdkJSnmWn8MrKWgiz2w5taw16sS6yk9v
         CAgo45v28go2LzKwArDaNyCa71NxZu9cwxheOY2vGgXvfk8MlLOYCG8+bTpzm6vk96xO
         SMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DUehOKaKbmwsiJTMRsk7x0Iv9OZWXYb75DfFdFGEUAQ=;
        b=qHIIIcgQaimm8wyIFWbvINGlZNx/vX1Ju1Prmd6wyYNbkRfLH1IhmOs9PIwuAoHIUD
         s/T8G8HhwOrQBcwvcHiDDRBSM220KNyZB3V1KqlTYCLomV4Gs0FaUfbJoMNbTwBTQtba
         /bWHVb+88Q/IcJNbM/uY3C44nVkYbNsd3GtXdsIaEAKwGNo1d01PXsNswyZXG9q/43B1
         Y7aFIpOzF77zI1gW/rlpx9l5GdFtUviphCKm9IF5hwMF7LlnhUSMLiCZrJL7FH3WZ3n+
         UKbN2W3xyxBt+dXkicUFFyD4+DoOBeM9pa59NPvi/S1ns0Hwy5LUYDrFzye1PQqtMS6V
         9NZw==
X-Gm-Message-State: APjAAAW/hkxQnzVRSmU84Rz1DXYmI6NUwS12sMcyquWOQjDRYwmB7XPe
        uBdh7/xhT0qfcCSIJJyq1MQ=
X-Google-Smtp-Source: APXvYqzjCnUylz9GQtg/dNMrIvqiSPb+C4zRkESgjrcIohNLwXW1smZFNd7A9eXuk9ZgS2LyYvrDnw==
X-Received: by 2002:ac8:520e:: with SMTP id r14mr1661289qtn.50.1561398737711;
        Mon, 24 Jun 2019 10:52:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::2c48])
        by smtp.gmail.com with ESMTPSA id x1sm5660776qkj.22.2019.06.24.10.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 10:52:16 -0700 (PDT)
Date:   Mon, 24 Jun 2019 10:52:15 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v10 12/16] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190624175215.GR657710@devbig004.ftw2.facebook.com>
References: <20190621084217.8167-1-patrick.bellasi@arm.com>
 <20190621084217.8167-13-patrick.bellasi@arm.com>
 <20190622150332.GM657710@devbig004.ftw2.facebook.com>
 <20190624172906.3d3w6352ji4izjgo@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624172906.3d3w6352ji4izjgo@e110439-lin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey, Patrick.

On Mon, Jun 24, 2019 at 06:29:06PM +0100, Patrick Bellasi wrote:
> > I kinda wonder whether the term bandwidth is a bit confusing because
> > it's also used for cpu.max/min.  Would just calling it frequency be
> > clearer?
> 
> Maybe I should find a better way to express the concept above.
> 
> I agree that bandwidth is already used by cpu.{max,min}, what I want
> to call out is that clamps allows to enrich that concept.
> 
> By hinting the scheduler on min/max required utilization we can better
> defined the amount of actual CPU cycles required/allowed.
> That's a bit more precise bandwidth control compared to just rely on
> temporal runnable/period limits.

I see.  I wonder whether it's overloading the same term too subtly
tho.  It's great to document how they interact but it *might* be
easier for readers if a different term is used even if the meaning is
essentially the same.  Anyways, it's a nitpick.  Please feel free to
ignore.

> > > +	tg = css_tg(of_css(of));
> > > +	if (tg == &root_task_group) {
> > > +		ret = -EINVAL;
> > > +		goto out;
> > > +	}
> > 
> > I don't think you need the above check.
> 
> Don't we want to forbid attributes tuning from the root group?

Yeah, that's enforced by NOT_ON_ROOT flag, right?

> > So, uclamp.max limits the maximum freq% can get and uclamp.min limits
> > hte maximum freq% protection can get in the subtree.  Let's say
> > uclamp.max is 50% and uclamp.min is 100%.
> 
> That's not possible, in the current implementation we always enforce
> the limit (uclamp.max) to be _not smaller_ then the protection
> (uclamp.min).
> 
> Indeed, in principle, it does not make sense to ask for a minimum
> utilization (i.e. frequency boosting) which is higher then the
> maximum allowed utilization (i.e. frequency capping).

Yeah, I'm trying to explain actually it does.

> > It means that protection is not limited but the actual freq% is
> > limited upto 50%, which isn't necessarily invalid.
> > For a simple example, a user might be saying
> > that they want to get whatever protection they can get from its parent
> > but wanna limit eventual freq at 50% and it isn't too difficult to
> > imagine cases where the two knobs are configured separately especially
> > configuration is being managed hierarchically / automatically.
> 
> That's not my understanding, in v10 by default when we create a
> subgroup we assign it uclamp.min=0%, meaning that we don't boost
> frequencies.
> 
> It seems instead that you are asking to set uclamp.min=100% by
> default, so that the effective value will give us whatever the father
> allow. Is that correct?

No, the defaults are fine.  I'm trying to say that min/max
configurations don't need to be coupled like this and there are valid
use cases where the configured min is higher than max when
configurations are nested and managed automatically.

Limits always trump protection in effect of course but please don't
limit what can be configured.

Thanks.

-- 
tejun
