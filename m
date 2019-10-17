Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B206DAAF5
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 13:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392327AbfJQLLY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 07:11:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34184 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394164AbfJQLLX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 07:11:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id j11so1887429wrp.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 04:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+zYZA+RgbruuoZvP4gkp7U+7iA9beMBCPXED1O6rxro=;
        b=Ojv0y5NOzDLkEhMe+JvYEQ5b68BsGM46pvx0kl7Scs0gXDS6BmgeIZuqZb6REC5csc
         0LcdLYiFote/zJL4TQLOI4dlimKEvU2jxYwSf94j9n3z5kai++Y8KXpmEonGdnTGL13B
         gbro3mPG58ZggyTYyTfR6lH9gJrtmZCgdfAS/xATycYBeY1i383OgUhjqRu9wOip/ukr
         pqhy4pFxZ3b8ekWCqV7UKacLskxCValbHEeCU9VDeD6Zps3jfQLxHL+VRFclSQJdEOAD
         BUz/q2ec1vg60IAstc9b7rz5USv1l+a5CkH3RrnuhzoJy5n9oLFghrylBWxxDtQD3mPp
         axTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+zYZA+RgbruuoZvP4gkp7U+7iA9beMBCPXED1O6rxro=;
        b=EtkQaist+oCmy8h+FyeBdsrO4lQKitq/DOyeYUkmWnw7tIarcJLovRcAfS+hj1JJHT
         pUuAxua51J2x8uIrl0EtiOc0q9AmmAGFeIxHCgD79FkE38/u7gnQRgucDWnYSAr5lWmd
         GqriyWM+ys0xxnXP4sx9yV2oY0s+G9DeK+kpJDneAmJ81ejVZVSQScpPIwnjAT62guBa
         eDT6TNOlJ7Pnbxy7OdVvHplxBiEW81vlfa4UbfburcVldamcxLYUppC5UQdn01DFx5+Y
         b/nQahEdXzK6S5MSW8S8Y8IWWN3dr9XKL1+CqLfGMt66Fvb9RHQiBxZ0qjPZC8W9pyWw
         KhWA==
X-Gm-Message-State: APjAAAUTB4SCxvJu+3SXtkknTmW9cldhH0wfsmY078JhlrRQxjgK8n8s
        5mySbFR6h+566TAprtlEhrRR1w==
X-Google-Smtp-Source: APXvYqzL2rz8o/7HAh35iFK8WOl7olxFOTAEgWWsnB008UBi/LWdcLZvpXnwlj6NQC5/VD0TIl7kBQ==
X-Received: by 2002:adf:df05:: with SMTP id y5mr2740030wrl.84.1571310680779;
        Thu, 17 Oct 2019 04:11:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7687:11a4:4657:121d])
        by smtp.gmail.com with ESMTPSA id a204sm2447892wmh.21.2019.10.17.04.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 04:11:20 -0700 (PDT)
Date:   Thu, 17 Oct 2019 12:11:16 +0100
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Douglas Raillard <douglas.raillard@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: Re: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
Message-ID: <20191017111116.GA27006@google.com>
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191014145315.GZ2311@hirez.programming.kicks-ass.net>
 <a1ce67d7-62c3-b78b-1d87-23ef4dbc2274@arm.com>
 <20191017095015.GI2311@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017095015.GI2311@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 17 Oct 2019 at 11:50:15 (+0200), Peter Zijlstra wrote:
> Now, the thing is, we use map_util_freq() in more places, and should we
> not reflect this increase in C for all of them? That is, why is this
> patch changing get_next_freq() and not map_util_freq().
> 
> I don't think that question is answered in the Changelogs.
> 
> Exactly because it does change the energy consumption (it must) should
> that not also be reflected in the EAS logic?

Right that shouldn't hurt and keep things consistent. That probably
won't have a huge impact in practice (the boost should be != 0 only when
the util signals haven't converged IIUC, which is a case where the EAS
calculation is already 'wrong' anyway), but that still feels like the
right thing to do.

> I'm still thinking about the exact means you're using to raise C; that
> is, the 'util - util_est' as cost_margin. It hurts my brain still.

+1 ...

Thanks,
Quentin
