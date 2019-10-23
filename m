Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B618E192D
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 13:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403842AbfJWLis (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 07:38:48 -0400
Received: from [217.140.110.172] ([217.140.110.172]:49132 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2390678AbfJWLis (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Oct 2019 07:38:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33944494;
        Wed, 23 Oct 2019 04:38:27 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74B523F718;
        Wed, 23 Oct 2019 04:38:26 -0700 (PDT)
Date:   Wed, 23 Oct 2019 12:38:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: vexpress-spc: find and skip duplicates when
 merging frequencies
Message-ID: <20191023113824.GC29654@bogus>
References: <20191023110811.15086-1-sudeep.holla@arm.com>
 <20191023110811.15086-2-sudeep.holla@arm.com>
 <20191023112537.pywnhihvmokcveeu@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023112537.pywnhihvmokcveeu@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 23, 2019 at 04:55:37PM +0530, Viresh Kumar wrote:
> On 23-10-19, 12:08, Sudeep Holla wrote:
> > Currently the cpufreq core aborts the validation and return error
> > immediately when it encounter duplicate frequency table entries.
> > This change was introduced long back since commit da0c6dc00c69
> > ("cpufreq: Handle sorted frequency tables more efficiently").
> >
> > However, this missed the testing with modified firmware for long time.
> > Inorder to make it work with default settings, we need to ensure the
> > merged table for bL switcher contains no duplicates. Find the duplicates
> > and skip them when merging the frequenct tables of A15 and A7 clusters.
> >
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/cpufreq/vexpress-spc-cpufreq.c | 35 ++++++++++++++++++++------
> >  1 file changed, 28 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> > index 093ef8d3a8d4..921dbd42b3bb 100644
> > --- a/drivers/cpufreq/vexpress-spc-cpufreq.c
> > +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> > @@ -242,6 +242,19 @@ static inline u32 get_table_max(struct cpufreq_frequency_table *table)
> >  	return max_freq;
> >  }
> >
> > +static bool search_frequency(struct cpufreq_frequency_table *table, int size,
> > +			     unsigned int freq)
> > +{
> > +	int count;
> > +
> > +	for (count = 0; count < size; count++) {
> > +		if (table[count].frequency == freq)
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  static int merge_cluster_tables(void)
> >  {
> >  	int i, j, k = 0, count = 1;
> > @@ -256,13 +269,21 @@ static int merge_cluster_tables(void)
> >
> >  	freq_table[MAX_CLUSTERS] = table;
> >
> > -	/* Add in reverse order to get freqs in increasing order */
> > -	for (i = MAX_CLUSTERS - 1; i >= 0; i--) {
> > -		for (j = 0; freq_table[i][j].frequency != CPUFREQ_TABLE_END;
> > -		     j++, k++) {
> > -			table[k].frequency =
> > -				VIRT_FREQ(i, freq_table[i][j].frequency);
> > -		}
>
> I think we can still use this single loop, which already starts from
> A7 cluster. Just that we can add an if (A15) block inside it as the
> first line.
>

Yes, I can do that.

> > +	/* Add A7_CLUSTER first to get freqs in increasing order */
> > +	for (j = 0; freq_table[A7_CLUSTER][j].frequency != CPUFREQ_TABLE_END;
> > +	     j++, k++) {
> > +		table[k].frequency =
> > +			VIRT_FREQ(A7_CLUSTER, freq_table[A7_CLUSTER][j].frequency);
> > +	}
> > +	count = k;
> > +
> > +	/* And then A15_CLUSTER checking for duplicates */
> > +	for (j = 0; freq_table[A15_CLUSTER][j].frequency != CPUFREQ_TABLE_END;
> > +	     j++) {
> > +		if (search_frequency(table, count,
> > +				     freq_table[A15_CLUSTER][j].frequency))
> > +			continue; /* skip duplicates */
> > +		table[k++].frequency = freq_table[A15_CLUSTER][j].frequency;
> >  	}
>
> How many duplicate entries are there anyway in the firmware? Or do we
> really need to make it that generic? I mean, only the last of A7 and
> first of A15 should be overlapping, in that case why search entire
> table again ?
>

Yes I thought about the same. But since one can play with the firmware
table, I thought it's better to keep it generic instead of assuming that.
Since I had changed the firmware table, I didn't notice this issue. I
don't want to get into similar situation again ;)

But if you still insist that we can assume and work only for default, I
am fine by that, just that someone else may face the same issue if they
have some modified/experimental firmware table.

--
Regards,
Sudeep
