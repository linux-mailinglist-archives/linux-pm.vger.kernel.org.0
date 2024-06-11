Return-Path: <linux-pm+bounces-8934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 156C79038D9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 12:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52E91F21E69
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8060516F839;
	Tue, 11 Jun 2024 10:29:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2607D54750;
	Tue, 11 Jun 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101754; cv=none; b=I9AUI5lWMT8zHWSJKKjVMLI+FMB+yyK/NBZgxlO5KlAVqOIHOQ8Img8QnYlWgY6YgXtC4rf1GgXCXs3y2e6cj4LTxVqMXbRLDQL5ml+1z2KSfQSUaMyponLzRUgn3v6KdZ101GnnkLI+92sy27N0edZSWOvFlEjaE2zzFZEO6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101754; c=relaxed/simple;
	bh=spQe+xwhZKKiF/RCCKP3Pjjjdr5YBWx9tejQ73rOtyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgq19yUl97nkzmJJTe5LyC/6lCLYuKhwegV84mpTwjT73rNLkvHo7QV2fFC1kXjkwPxjIMjVbA9S+ztU43EWWNZuctSR6hhcgXm9m37kLxhZkwlRLhLgY3akTiclS3k9JXrSEM4+4gcOXlLQmG4xU+EwUb69Z83Vf4p4N/UUdQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 090BF1424;
	Tue, 11 Jun 2024 03:29:36 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 275103F5A1;
	Tue, 11 Jun 2024 03:29:11 -0700 (PDT)
Date: Tue, 11 Jun 2024 11:29:09 +0100
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "liwei (JK)" <liwei728@huawei.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	rafael@kernel.org, al.stone@linaro.org, ashwin.chaugule@linaro.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	liwei391@huawei.com, liaoyu15@huawei.com
Subject: Re: [PATCH] cpufreq/cppc: changing highest_perf to nominal_perf in
 cppc_cpufreq_cpu_init()
Message-ID: <Zmgm9Rf0piqFqnrI@arm.com>
References: <20240428092852.1588188-1-liwei728@huawei.com>
 <20240429104945.esdukn6ayudgyumc@vireshk-i7>
 <ZjoBrF4bAK5ukm7H@arm.com>
 <be312b75-eede-44f5-b7f3-b50f50c6fb56@huawei.com>
 <ZmB1qKucR5fXk100@arm.com>
 <20240606072031.lxr7tykl7sdgjwva@vireshk-i7>
 <ZmgbRh+m9MmEaopK@arm.com>
 <20240611094526.vcirawlsdefbkuhf@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611094526.vcirawlsdefbkuhf@vireshk-i7>

On Tuesday 11 Jun 2024 at 15:15:26 (+0530), Viresh Kumar wrote:
> On 11-06-24, 10:39, Ionela Voinescu wrote:
> > Makes sense! But maybe we should no longer update policy->cur to the
> > current/hardware frequency once a request comes through from a
> > governor, and we have a first actually requested value.
> 
> Hmm, not sure I understood that. When the request comes from governor,
> we only update policy->cur to the requested frequency and not the
> actual hardware frequency. And it is very much required. policy->cur

Yes, I mean we should only update policy->cur to a requested frequency
from a governor, after we start it (cpufreq_start_governor()).

But currently policy->cur gets updated to the .get() returned value in
multiple places, via cpufreq_verify_current_freq() (for example from 
show_cpuinfo_cur_freq() or cpufreq_get().

.get() is meant to return the current frequency of the hardware and that
can opportunistically be different from the last request made.

(+ we probably should force the first request from a governor to go
through to the driver to make sure the policy->cur obtained before,
via .get(), did not just happen to coincide with the governor request,
therefore making the request no longer go through to the driver: see
__cpufreq_driver_target)

> needs to be up to date all the times, it is an important part of the
> entire working of the cpufreq core..
> 

When you say that "policy->cur must be kept up to date at all times",
I suppose you mean that it should be kept up to date with any frequency
change requests not with any changes happening in hardware?

Thanks,
Ionela.

> -- 
> viresh

