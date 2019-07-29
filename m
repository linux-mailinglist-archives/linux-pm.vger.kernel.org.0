Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005A078659
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 09:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfG2H0S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 03:26:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41227 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfG2H0R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 03:26:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so27050483pls.8
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 00:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AAOCHi1uoiP/+mbnKKUKoIyKr6l7IjQC5tq27atwBuQ=;
        b=H+ykbA9Z7NONKWqLzOkdKL3UOrUarVOJRcCf1+onRhzFuJhb18OdlPeAtKETJJ1XkN
         R1n6c98gsxeQTFLoiPUGb0ZtFy2UKoATYernPJ9xV2RMWbicXQBsRE+58TAoRYrU3zcJ
         RH4fDzCD3bIO3KBmPCFm+UmrIHZ2vnYP/c2vEE5aBClJshOVztzKcFGWpYSEPlJ2amuD
         6ifapqhfLwc8PQVGDI7tAIqCkvRoyPWOCE2eccpANl4bec9Rr2n7foLLaVlk4O4P2AVf
         ygYYGCvzDnEC9NzvKgHMtF2jONebX8M6KWAWATNEPzfvU5EnLaCEyKQvWqMGGecV4PIs
         /5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AAOCHi1uoiP/+mbnKKUKoIyKr6l7IjQC5tq27atwBuQ=;
        b=oG8zBjAm1TjjMAAi/kQUAjZsJiKD9hM7qKpuQpMmLGOTeXVsc/ykCqriWDMKhvyJWz
         7ODboMkj8kij8GmtyaRV6E6tgy9y7VcrBWtqgkqLuNW4v0O4UYvOh8P5yhtRSOQXyfvc
         SggSCVK6nRzVXLEVq761e+VZEivfBU++SVeBnJl+NLoDm69J3JUa5LWn/juXBVVXx/qT
         o3g9K0f8Db52m+gZYrA4f3bq2r/Si4bPHov/vABXf6jiBFDBBkYY0ztBtOyLEylg8Hom
         z1OkzF90pnNoG0WtCk8hh8j7NOWS8g2XFHsWsxOLyX5AUFiswgs/87W9IfSND1AHH+Af
         ygGg==
X-Gm-Message-State: APjAAAU2LxujQ62BS09LcSvgLuxQNukUM/xblqV4nMI7XT/pmtS1ZmaP
        gRuBulEPQEMTavSy1mSK7r2qMg==
X-Google-Smtp-Source: APXvYqzeSUgYBjLmUxMN/eajyMOfgJ2IquYEV7suGComdhNLaKvFwMtsVuDl7rPB1qsHt6hLYsUK9A==
X-Received: by 2002:a17:902:2ae7:: with SMTP id j94mr108558587plb.270.1564385176808;
        Mon, 29 Jul 2019 00:26:16 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id e189sm38867037pgc.15.2019.07.29.00.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 00:26:15 -0700 (PDT)
Date:   Mon, 29 Jul 2019 12:56:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
Message-ID: <20190729072612.pdxoguwheawtrf6d@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-4-saravanak@google.com>
 <20190723102842.t2s45zzylsjuccm4@vireshk-i7>
 <CAGETcx-6M9Ts8tfMf6aA8GjMyzK5sOLr069ZCxTG7RHMFPLzHw@mail.gmail.com>
 <20190725030712.lx3cjogo5r7kc262@vireshk-i7>
 <CAGETcx8QTs2Dqqppb_gwiUa2fte92K_q+B+j_CreRgqU52L7EA@mail.gmail.com>
 <20190725051742.mn54pi722txkpddg@vireshk-i7>
 <CAGETcx9yO7HCz-rvqRMQf6srN_9-O_wc1bb7HadL+4QxvuqyWA@mail.gmail.com>
 <CAGETcx9UAAc6u=qFPN49Pn2u4xiMCroL-PhHqLZrBPRSXBbHBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9UAAc6u=qFPN49Pn2u4xiMCroL-PhHqLZrBPRSXBbHBw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-07-19, 14:23, Saravana Kannan wrote:
> I was taking a closer look at the OPP framework code to try and do
> what you ask above, but it's kind of a mess. The whole "the same OPP
> table can be used by multiple devices without the opp-shared flag set"
> is effectively breaking "required-opps" at a minimum and probably a
> lot more cases. I don't think I can rewrite my patch the way you want
> it without fixing the existing bugs.
> 
> Let's take this example DT (leaving out the irrelevant part):
> 
> OPP table 1:
>     required-opps = <OPP table 2 entry>;
> 
> OPP table 2:
>     <opp-shared property not set>
> 
> Device A:
>     operating-points-v2 = <&OPP table 1>
> 
> Device B:
>     operating-points-v2 = <&OPP table 2>
> 
> Device C:
>     operating-points-v2 = <&OPP table 2>
> 
> Let's say device B and C add their OPP tables. They both get their own
> "in-memory" copy of the OPP table. They can then enabled/disable
> different OPP entries (rows) and not affect each other's OPP table.
> Which is how it's expected to work.
> 
> Now if device A adds its OPP table 1, the "in-memory"
> required_opp_tables pointer of OPP table 1 can end up pointing to
> either Device A's copy of the OPP table or Device B's copy of the OPP
> table depending on which happens to be added first. This effectively
> random linking of OPP tables is mutually exclusive to the point of
> required-opps.

> Also, at a DT definition level, OPP table 1 pointing to OPP table 2
> when OPP table 2 is used by more than one device doesn't make any
> sense. Which device/genpd is OPP table 1 saying it "requires to
> operate at a certain level"?

I will say that this data is present at least for the present set of
users, i.e. power domains. Just that it isn't present so directly
within the OPP table. But if you look at the device's node, it will
point you to some power domain, etc.

I didn't do anything about it earlier because it required more work
and I thought "required-opps" property is there to get us some data
and it does get that data to us right now. Just that we don't know the
device for which this data is there in the OPP core.

If we do want to get this linking, how should we get it ?

- Using another property in device's DT node, like
  "required-opp-devices" ? I didn't like it earlier because that would
  be like duplicating data we already had for the power domains.

- Using some in-kernel function, using which other drivers can give us
  this data ? Maybe yes. Probably that's the best way of doing it ?

> So I propose that we should consider the OPP table DT configuration
> invalid if one OPP table points to another OPP tables that's NOT
> shared but is ALSO pointed to by multiple devices. Basically the
> example above would be considered an invalid DT configuration. Does
> that sound okay to you? If I make changes to enforce that, will that
> be acceptable?

I don't think that would be the right thing to do as the idea of
sharing the DT OPP tables to avoid duplicate tables in DT was the
correct thing to do and is getting used very much right now as well.

Perhaps we should fix the problem instead.

> If this sounds okay to you, then in the example above, assume Device C
> isn't present. Then when OPP table 1 is added by device A, if OPP
> table 2 hasn't been added already, I can just go ahead and allocate
> OPP table 2. And then when device B tries to add OPP table 2, I can
> just tie device B to OPP table 2 and fill up any of the missing
> pieces.

I can assure you that it would be a big mess. Specially the reference
counting using which we free OPP tables and OPPs right now will come
in your way.

> This sounds better than trying to loop through existing OPP tables and
> seeing if any other table is waiting for the newly added table and
> marking the waiting tables as "linked". Especially because it gets a
> lot more complicated and inefficient when you consider a chain of OPP
> tables and many-to-many linking of OPP tables.

Firstly, this is all going to be initialization code and will not run
after boot normally. And we will probably not have very complex
linking cases as well I believe. Maybe 2-3 levels at the best. And
this will keep code much simpler compared to the above idea.

So here is the thing. I think you should separate out the lazy-linking
thing from this patchset as this is a completely different problem you
are trying to solve and is unnecessarily blocking other patches.

And if you don't want to get into solving the lazy linking thing
yourself, because that is consuming your time unnecessarily, then I
can see if I can put some of my cycles on it.

-- 
viresh
