Return-Path: <linux-pm+bounces-26805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF3CAAE064
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 15:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838FE17209C
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE818288C15;
	Wed,  7 May 2025 13:12:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055E028980B;
	Wed,  7 May 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623563; cv=none; b=E9PH5BFoKlPo6lNi1I/wGFF4HGASxKIHUWYkuBCHcYBBvPsLZiMvCFeQZkwG1QWh0sMwb2TyNv0hHysxEC/7Y8ocYPcsnTc/p+E4560Uv3SiaUxSBkF2WW3akReEAAB1e9r81E3kHD9bYbZokZNiEGenaZGErLYwcDHjYI33+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623563; c=relaxed/simple;
	bh=5oGKT4p4RhA8bQiJxWoQbeHy9td1b06sEcFen13gzl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/UxkIzbV+hjHCdaMk5GMeLS3kuqqSlW/XDxCdjzHbk7ZgL+84txdrXO2wxQMmZHXRhbYZRCcsePikmyxPKFcxhApQHsDrJmO5Gqeu5EoJ8+2uzWsSQa3CCR2Ygc/wnUdJn9+wQ1PWtNt9hcalTtaMcBZgXhyNcjLsl03uC+MWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41AE5339;
	Wed,  7 May 2025 06:12:31 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96DFB3F58B;
	Wed,  7 May 2025 06:12:39 -0700 (PDT)
Date: Wed, 7 May 2025 14:12:36 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	Mike Tipton <quic_mdtipton@quicinc.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, <arm-scmi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Peng Fan <peng.fan@oss.nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3] cpufreq: scmi: Skip SCMI devices that aren't used by
 the CPUs
Message-ID: <20250507-analytic-practical-carp-5cddaf@sudeepholla>
References: <20250428144728.871404-1-quic_mdtipton@quicinc.com>
 <aBtLMYqcnwacGJuy@pluto>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBtLMYqcnwacGJuy@pluto>

On Wed, May 07, 2025 at 12:59:45PM +0100, Cristian Marussi wrote:
> On Mon, Apr 28, 2025 at 07:47:28AM -0700, Mike Tipton wrote:
> > +static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
> > +{
> > +	struct device_node *scmi_np = dev_of_node(scmi_dev);
> > +	struct device_node *np;
> > +	struct device *cpu_dev;
> > +	int cpu, idx;
> > +
> > +	if (!scmi_np)
> > +		return false;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		cpu_dev = get_cpu_device(cpu);
> > +		if (!cpu_dev)
> > +			continue;
> > +
> > +		np = dev_of_node(cpu_dev);
> > +
> > +		if (of_parse_phandle(np, "clocks", 0) == scmi_np)
> 
> Shouldn't this, on Success, be released by an of_node_put() (or, BETTER,
> by some OF-related cleanup.h magic...)
> 

Good catch, I missed this.

With the above issue fixed, you can add and post new version:
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

I will drop this patch now that you need to fix and repost. Also Viresh
may be away, so better to route via his tree when he is back as I can't
take it without his ack. I was holding off my PR for this, but I will
send SCMI PR without this now.

-- 
Regards,
Sudeep

