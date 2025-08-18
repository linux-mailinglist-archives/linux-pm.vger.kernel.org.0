Return-Path: <linux-pm+bounces-32527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6661BB29EF7
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 12:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB7D1894CFF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF85315770;
	Mon, 18 Aug 2025 10:21:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EED230E836;
	Mon, 18 Aug 2025 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512492; cv=none; b=HFvzoMd3uZqbNWQl/vg/v/bED/dULucgb27XUZ70T4sd0gQAWisP1+BQzP2fLMyGAvBFZuJi+GRAtdjHRJkLhWcOSXwi0HlScCO2POGynSrzLEpeSq3nr15bueP46vQslxYKMvrh9uzFC7UBGC9R0/TOkgxVa6rAZ6KaVlb9f0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512492; c=relaxed/simple;
	bh=RYV3iIchdWXA7wyjnN2Jx4NW7e9oYNjCFQtNXtWC/OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhay3JYCI/By96cGT/FHRBOnmRQK43tynaSXbr9qej+hMQj3zbJGLBwI3oQvIMgnrwdfNoizSlvdfnggwdpM980qAsZQSgsqwJAdYD2XKiVyLZk22mcm4BCeVGqwpuVhvE0Vguw79by0rdbmQOaXDB8yPva05A9fVEFWn4FfZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5864B1596;
	Mon, 18 Aug 2025 03:21:21 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E4E53F63F;
	Mon, 18 Aug 2025 03:21:27 -0700 (PDT)
Date: Mon, 18 Aug 2025 11:21:24 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, james.quinlan@broadcom.com,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Mike Tipton <quic_mdtipton@quicinc.com>,
	Peng Fan <peng.fan@nxp.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: scmi: Account for malformed DT in
 scmi_dev_used_by_cpus()
Message-ID: <20250818-imposing-salamander-from-pluto-0f0eac@sudeepholla>
References: <20250815205714.1545571-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815205714.1545571-1-florian.fainelli@broadcom.com>

On Fri, Aug 15, 2025 at 01:57:14PM -0700, Florian Fainelli wrote:
> Broadcom STB platforms were early adopters of the SCMI framework and as
> a result, not all deployed systems have a Device Tree entry where SCMI
> protocol 0x13 (PERFORMANCE) is declared as a clock provider, nor are the
> CPU Device Tree node(s) referencing protocol 0x13 as their clock
> provider.
> 
> For those platforms, we allow the checks done by scmi_dev_used_by_cpus()
> to continue, and in the event of not having done an early return, we key
> off the documented compatible string and give them a pass to continue to
> use scmi-cpufreq.
> 

With the multi-line comment fixed as suggested by Viresh.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

