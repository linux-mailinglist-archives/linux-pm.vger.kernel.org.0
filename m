Return-Path: <linux-pm+bounces-26808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C96AAE0B6
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 15:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69B2467DFC
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D2626D4FC;
	Wed,  7 May 2025 13:27:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9321FFC74;
	Wed,  7 May 2025 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624460; cv=none; b=SpYKYGxvDm87Ca8aG6wUK4QD8eLZGRE/bHCrKjt1tUCRUqGICNYdjN8qc3Jnb33qVWP4hrPzkO70CXSXBJAh58+bDIjXvOwkVD6D4gyd8RHfmJvF8fTjzluzK2ggrZYEnt/cDzovBcehzZpMHcrzEhpJbRz2ctAltTaavV8waTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624460; c=relaxed/simple;
	bh=K8pIwt+OaZxn8fT7e46XkSa7PQIQUHl0YN7/6eVDis4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMpFDxtkR4JcaXNuUJSxuKwLxVeHQ45WxI9wKZrP8yZT3dSIyu7JcvQzWP81H+zOlZ8H+jYLuQebqT3oIIE4EQsK0XOk6nHLe6+iy3IMXrWmtxn0wjEaFAQhPKJmKCHh3FgLXYNx5tpmC4YmEFnSnV1CiaNwBmCcDSbnhwI80Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D093339;
	Wed,  7 May 2025 06:27:27 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A83EF3F58B;
	Wed,  7 May 2025 06:27:35 -0700 (PDT)
Date: Wed, 7 May 2025 14:27:26 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Mike Tipton <quic_mdtipton@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@oss.nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3] cpufreq: scmi: Skip SCMI devices that aren't used by
 the CPUs
Message-ID: <aBtfvuzO54XK6KOd@pluto>
References: <20250428144728.871404-1-quic_mdtipton@quicinc.com>
 <aBtLMYqcnwacGJuy@pluto>
 <aBtdqvyT4Ded8Lht@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBtdqvyT4Ded8Lht@stanley.mountain>

On Wed, May 07, 2025 at 04:18:34PM +0300, Dan Carpenter wrote:
> On Wed, May 07, 2025 at 12:59:45PM +0100, Cristian Marussi wrote:
> > > +static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
> > > +{
> > > +	struct device_node *scmi_np = dev_of_node(scmi_dev);
> > > +	struct device_node *np;
> > > +	struct device *cpu_dev;
> > > +	int cpu, idx;
> > > +
> > > +	if (!scmi_np)
> > > +		return false;
> > > +
> > > +	for_each_possible_cpu(cpu) {
> > > +		cpu_dev = get_cpu_device(cpu);
> > > +		if (!cpu_dev)
> > > +			continue;
> > > +
> > > +		np = dev_of_node(cpu_dev);
> > > +
> > > +		if (of_parse_phandle(np, "clocks", 0) == scmi_np)
> > 
> > Shouldn't this, on Success, be released by an of_node_put() (or, BETTER,
> > by some OF-related cleanup.h magic...)
> > 
> 
> The cleanup.h magic is __free(of_node_put) but dev_of_node() doesn't
> take a reference so I don't think it's required.
> 
 
I was referrring to the 2 (possibly) successfull of_parse_phandle() needs an
of_put() before returning. (at least looking at of_parse_phandle() comments)

Thanks,
Cristian

