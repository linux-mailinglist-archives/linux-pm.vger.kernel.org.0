Return-Path: <linux-pm+bounces-25046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C0EA83031
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 21:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA590189FD7D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B409B1DF980;
	Wed,  9 Apr 2025 19:16:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF418143748;
	Wed,  9 Apr 2025 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226176; cv=none; b=VHcek6+rk9h6J5vPTiEbqQ0tVjK4tWT8P3xjvSoswL2Rzw1p9qJPonjyRp88uPRWc/wm6fTZbTW85T0ZYrhgVqcT2jomPl2o6Zt3SqGAmFrf3Cd7ybqn5QkZcbh6H4ZlSMijRfGGbXWcP2ryFTNnI2rVFRRTEa9NQ886M2c6zt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226176; c=relaxed/simple;
	bh=XDGMYzHDpuAgaJDxOpUvh0E3YpfSvQ1q3XeyDVOLxgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym6CaXDk40/CPCI3vdPnlcnGjvv87MtgV+NKMOpAagJKu9kRbKaU6o8JsauNKL2kESNoJsXbCzl1FvoNKfqy2+pmjgBznOW+TSPwgHb4VfUFiXPurU+vwzlhA8+3FpFA72EFEr1BNKw3PuEzWiy0+bGmiQfDbQMx/2o+SVfi5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8141C15A1;
	Wed,  9 Apr 2025 12:16:14 -0700 (PDT)
Received: from bogus (unknown [10.57.41.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 889B13F694;
	Wed,  9 Apr 2025 12:16:12 -0700 (PDT)
Date: Wed, 9 Apr 2025 20:16:09 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1 00/10] cpufreq: cpufreq_update_limits() fix and some
 cleanups
Message-ID: <20250409-chirpy-gerbil-of-drizzle-a948dd@sudeepholla>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4651448.LvFx2qVVIh@rjwysocki.net>

On Fri, Mar 28, 2025 at 09:36:05PM +0100, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This series of patches consists of a fix for a possible (and actually happening
> in some cases) NULL pointer dereference in cpufreq_update_limits() (patch
> [01/10]) and a bunch of tangentially related fixes inspired by it, mostly about
> using __free() for cleanup and locking guards.
> 
> The first patch is definitely for 6.15, but the rest is rather 6.16 material.
> 
> Please refer to the individual patch changelogs for more information.
> 

For all the generic changes(i.e. except x86 specific changes)

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

I also gave it a quick test using scmi-cpufreq on my Juno platform.

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

