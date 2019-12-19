Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483A7126EDF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 21:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfLSU0d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 15:26:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:49788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbfLSU0d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 15:26:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4AEDDB3A2;
        Thu, 19 Dec 2019 20:26:31 +0000 (UTC)
Message-ID: <1576787539.8929.15.camel@suse.cz>
Subject: Re: [PATCH v4 3/6] x86,sched: Add support for frequency invariance
 on XEON_PHI_KNL/KNM
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Date:   Thu, 19 Dec 2019 21:32:19 +0100
In-Reply-To: <20191218202236.GJ11457@worktop.programming.kicks-ass.net>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
         <20191113124654.18122-4-ggherdovich@suse.cz>
         <20191218202236.GJ11457@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-12-18 at 21:22 +0100, Peter Zijlstra wrote:
> On Wed, Nov 13, 2019 at 01:46:51PM +0100, Giovanni Gherdovich wrote:
> > The scheduler needs the ratio freq_curr/freq_max for frequency-invariant
> > accounting. On Xeon Phi CPUs set freq_max to the second-highest frequency
> > reported by the CPU.
> > 
> > Xeon Phi CPUs such as Knights Landing and Knights Mill typically have either
> > one or two turbo frequencies; in the former case that's 100 MHz above the base
> > frequency, in the latter case the two levels are 100 MHz and 200 MHz above
> > base frequency.
> > 
> > We set freq_max to the second-highest frequency reported by the CPU. This
> > could be the base frequency (if only one turbo level is available) or the first
> > turbo level (if two levels are available). The rationale is to compromise
> > between power efficiency or performance -- going straight to max turbo would
> > favor efficiency and blindly using base freq would favor performance.
> > 
> > For reference, this is how MSR_TURBO_RATIO_LIMIT must be parsed on a Xeon Phi
> > to get the available frequencies (taken from a comment in turbostat's sources):
> > 
> >     [0] -- Reserved
> >     [7:1] -- Base value of number of active cores of bucket 1.
> >     [15:8] -- Base value of freq ratio of bucket 1.
> >     [20:16] -- +ve delta of number of active cores of bucket 2.
> >     i.e. active cores of bucket 2 =
> >     active cores of bucket 1 + delta
> >     [23:21] -- Negative delta of freq ratio of bucket 2.
> >     i.e. freq ratio of bucket 2 =
> >     freq ratio of bucket 1 - delta
> >     [28:24]-- +ve delta of number of active cores of bucket 3.
> >     [31:29]-- -ve delta of freq ratio of bucket 3.
> >     [36:32]-- +ve delta of number of active cores of bucket 4.
> >     [39:37]-- -ve delta of freq ratio of bucket 4.
> >     [44:40]-- +ve delta of number of active cores of bucket 5.
> >     [47:45]-- -ve delta of freq ratio of bucket 5.
> >     [52:48]-- +ve delta of number of active cores of bucket 6.
> >     [55:53]-- -ve delta of freq ratio of bucket 6.
> >     [60:56]-- +ve delta of number of active cores of bucket 7.
> >     [63:61]-- -ve delta of freq ratio of bucket 7.
> 
> Does it make sense to write a complete decoder and pass a @size
> parameter just like the skx/glm case?
> 
> (I've no idea on the 4 I passed in, probably wants to be something else)

I see your point: it's better to have a @size parameter so that if there is a
better value, we can easily change the number in the future. It also uniforms
to how the others are handled.

But from the little I've learned on Xeon Phi, the best parameter to
characterize the choice is not the @size of the buckets, but the number of
non-zero @delta's of freq ratio that you encounter while parsing the MSR.

The number of those non-zero freq ratio @delta's corresponds to how many freq
ratios you can have, and the documentation says this can be either 1 or 2. My
"documentation" is actually the 4-pages leaflet at [1], but I breafly asked
Len Brown and he said it made sense. So that's how I would parametrize the
code.

If I use your function, in order to extract the max_freq value I want from the
Xeon Phi machine I have, @size should be a number between 31 and 68 cores (see
example below). Not that there is anything wrong with 31 <= size <= 68, it's
just that I can make an assumption on how many freq ratios there are and
I'd like to do it.

My Xeon Phi test machine:

Xeon Phi CPU 7255 (Knights Mill)

    Max Efficiency:   1000 MHz
    Base Frequency:   1100 MHz
    68 cores turbo:   1100 MHz
    30 cores turbo:   1200 MHz

You can see the above has only 1 non-zero delta freq ratio; the base freq is
1100 MHz and max turbo is 1100+100 MHz.

If I could at least check a Knights Landing (which I don't have) and confirm
that 31 <= size gives me the second-highest freq ratio, I'd use your function,
but at the moment using @delta as a parameter seems safer.

[1] https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/xeon-phi-processor-product-brief.pdf
---> footnote #3, last page:
   "Frequency listed is nominal (non-AVX) TDP frequency. For all-tile turbo
   frequency, add 100 MHz. For single-tile turbo frequency, add 200 MHz. For
   high-AVX instruction frequency, subtract 200 MHz."
