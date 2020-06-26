Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AECB20AFA3
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 12:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFZKXd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 06:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgFZKXd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 06:23:33 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45784C08C5C1;
        Fri, 26 Jun 2020 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ASpUXbnvo/0VDAeS0TyPVWgNFspSgXgseIn4f7xZxPc=; b=qwu2yMgy5BThOXWrDUapjLrSV6
        txuZSYikIU7jWa7JRQ8tUOVIVT2TM49/sdb6qw+j39mRUNdhIWblGnE0MZwQ8h5qiPe+kuI+czOE/
        YF2twioWb8ir6cCORecBBaNvfBwi1kTxu7eeVS36gZX6dHJdHsh2CXEIGqaF2IbCxJ4iuMGDsl/4l
        OTjf+YQimxazrPgNOwsH99cYpgHEmGVC6epHgpD45NnhLmbYP6cmM/eSVKRn3Ca44o3glTZaVOxY+
        saCbhQ7C+g3krN532L+2yThN6s+Xn/YZiE/x8EINeHJUp5eOcEbMxk5V6VqDC8nR3DG8B9nsDvUb4
        lFWyHXGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jolVZ-0001HA-Ir; Fri, 26 Jun 2020 10:22:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7B6B13003E3;
        Fri, 26 Jun 2020 12:22:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6DCA8213E2C14; Fri, 26 Jun 2020 12:22:55 +0200 (CEST)
Date:   Fri, 26 Jun 2020 12:22:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        dsmythies@telus.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [UPDATE][PATCH v3 1/2] cpufreq: intel_pstate: Allow
 enable/disable energy efficiency
Message-ID: <20200626102255.GZ4817@hirez.programming.kicks-ass.net>
References: <20200625224931.1468150-1-srinivas.pandruvada@linux.intel.com>
 <20200626084903.GA27151@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626084903.GA27151@zn.tnic>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 26, 2020 at 10:49:03AM +0200, Borislav Petkov wrote:
> On Thu, Jun 25, 2020 at 03:49:31PM -0700, Srinivas Pandruvada wrote:
> > +static ssize_t store_energy_efficiency_enable(struct kobject *a,
> > +					      struct kobj_attribute *b,
> > +					      const char *buf, size_t count)
> > +{
> > +	u64 power_ctl;
> > +	u32 input;
> > +	int ret;
> > +
> > +	ret = kstrtouint(buf, 10, &input);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_lock(&intel_pstate_driver_lock);
> > +	rdmsrl(MSR_IA32_POWER_CTL, power_ctl);
> > +	if (input)
> 
> This is too lax - it will be enabled for any !0 value. Please accept
> only 0 and 1.

kstrtobool() ftw
