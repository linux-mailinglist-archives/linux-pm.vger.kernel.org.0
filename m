Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CE0241D43
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 17:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgHKPdx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 11:33:53 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62204 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgHKPdw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 11:33:52 -0400
Received: from 89-64-89-44.dynamic.chello.pl (89.64.89.44) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 2461079d11a94e2c; Tue, 11 Aug 2020 17:33:50 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v7] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Tue, 11 Aug 2020 17:33:49 +0200
Message-ID: <4931766.VNY61sLD3B@kreacher>
In-Reply-To: <87mu32atsy.fsf@riseup.net>
References: <4981405.3kqTVLv5tO@kreacher> <122847018.uQ7iJ9lzrg@kreacher> <87mu32atsy.fsf@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, August 11, 2020 2:51:41 AM CEST Francisco Jerez wrote:
> 
> --==-=-=
> Content-Type: multipart/mixed; boundary="=-=-="
> 
> --=-=-=
> Content-Type: text/plain; charset=utf-8
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Allow intel_pstate to work in the passive mode with HWP enabled and
> > make it set the HWP minimum performance limit (HWP floor) to the
> > P-state value given by the target frequency supplied by the cpufreq
> > governor, so as to prevent the HWP algorithm and the CPU scheduler
> > from working against each other, at least when the schedutil governor
> > is in use, and update the intel_pstate documentation accordingly.
> >
> > Among other things, this allows utilization clamps to be taken
> > into account, at least to a certain extent, when intel_pstate is
> > in use and makes it more likely that sufficient capacity for
> > deadline tasks will be provided.
> >
> > After this change, the resulting behavior of an HWP system with
> > intel_pstate in the passive mode should be close to the behavior
> > of the analogous non-HWP system with intel_pstate in the passive
> > mode, except that in the frequency range below the base frequency
> > (ie. the frequency retured by the base_frequency cpufreq attribute
> > in sysfs on HWP systems) the HWP algorithm is allowed to make the
> > CPU run at a frequency above the floor P-state set by intel_pstate,
> > with or without hardware coordination of P-states among CPUs in the
> > same package.
> >
> 
> The "frequency range below the base frequency" part of the paragraph
> above seems somewhat misleading, since AFAICT the same thing will happen
> in the P-state range above the base frequency. 

Fair enough.  I rephrased the changelog when applying the patch.

> Another minor comment below, other than that LGTM:

And this one has been fixed too.

> Reviewed-by: Francisco Jerez <currojerez@riseup.net>

Thanks!



