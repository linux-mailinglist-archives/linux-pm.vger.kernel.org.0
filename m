Return-Path: <linux-pm+bounces-8464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00BF8D6110
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 13:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DECF1F24AD7
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A34C1581E6;
	Fri, 31 May 2024 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fF/ezA/Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B9157E94
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717156575; cv=none; b=SKvpUFGT+6h0KQdFxo9O4VDUKhvv8Mx5bZ1X2AN3OQxZjz/EKFjFzuhVYsyy6EEPnsnstxlcPIy1/aen2aqrEcqim09hQufaC2bXtiDL7VIaopwYcKwXFtzr+X8ccbzTABx+PYaYSbPrIHdlSndzxDYpXgZZ07TA9F3pX6oZ/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717156575; c=relaxed/simple;
	bh=WP2wcu9fIkfw5GVoOI318p+TgEgZ2trqV9TmKhr2udI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=miMpReHuilSn+Q7dWLu9Z2Voa0KPg6smV+EcbyGTY1784w9mZw4Se0NXuq722Mb3j/1FiojKzVhbQ9KfYycA4ruGqb6ksjDZlmsKZe0C9K4B22GUCM4rsUz7PIBQba6u9At2M6LXUxPwm0pLtQb0/HcwWLgdmUoPb7aPt2Bmri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fF/ezA/Z; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717156573; x=1748692573;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WP2wcu9fIkfw5GVoOI318p+TgEgZ2trqV9TmKhr2udI=;
  b=fF/ezA/ZAG6q97IbQA9x0gLyArvZSFS95GNMkYJ/Gm4jeL2BEyP6qCTr
   YLtO/uFFFMUzCQyGYJGmmIRFwV4SRqSIl+ax+8wfP/rof/G8gEvP2K6Ik
   F+fRAF0lSorFuv0oi6QFQebBvRweLe8i68L8ISPXsJDKAi8bCu3WjEoKF
   0dX3F+6ngChMUqJVZS9dZLGcffrQY8Nx3Bz2ZPlc9wss1B9tvnLXXW61x
   lOdfMBSAmAdxYzcAXzR/7GbbqkpqzHmPkfjUCHVUMWkAmw6zhhxXsM6EE
   1gWxJBPhEADr/OIdIqbLjWh7syBpdDKnwOCE+VnY2JPQl96Ycil9MK0Zv
   Q==;
X-CSE-ConnectionGUID: m5Hlhg3wQIu3w/ozKXLBWA==
X-CSE-MsgGUID: E84MHN8fTyO9J3ui6l/5aQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25099902"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="25099902"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 04:56:13 -0700
X-CSE-ConnectionGUID: W1iYWgaASBGXyY3QiUCGFw==
X-CSE-MsgGUID: VHyLh77bR5yrhX4fJu35rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="40578909"
Received: from dmishra-mobl.gar.corp.intel.com ([10.213.74.200])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 04:56:09 -0700
Message-ID: <3eaf90b63edccb3317968101040510c91b5b2f4e.camel@linux.intel.com>
Subject: Re: intel_pstate_get_hwp_cap on wrong CPU
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Len
	Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Viresh Kumar
	 <viresh.kumar@linaro.org>
Date: Fri, 31 May 2024 04:56:04 -0700
In-Reply-To: <20240531110200.CtBSN_p4@linutronix.de>
References: <20240529155740.Hq2Hw7be@linutronix.de>
	 <ca47b6f812175ea60f6ad615274223aa7fee295d.camel@linux.intel.com>
	 <20240531110200.CtBSN_p4@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,
On Fri, 2024-05-31 at 13:02 +0200, Sebastian Andrzej Siewior wrote:
> On 2024-05-29 16:08:19 [-0700], srinivas pandruvada wrote:
> > Hi Sebastian,
> Hi,
>=20
> > On Wed, 2024-05-29 at 17:57 +0200, Sebastian Andrzej Siewior wrote:
> > > Hi,
> > >=20
> > > this just popped up:
> > > > [ 6538.614568] unchecked MSR access error: RDMSR from 0x771 at
> > > > rIP:
> >=20
> > Please check if the attached change fixes?
>=20
> it should based on the callchain. Let me test it in a few=E2=80=A6
>=20
> Would you mind letting
> =C2=A0 /sys/devices/system/cpu/intel_pstate/num_pstates
>=20
> reporting something sane? Not 4294967285 but 0 for instance? Would
> that
> make sense?
>=20
It should be some good value, usually less than 50. Do you see this
high number without even triggering condition, which caused warning?

In your system, firmware changed performance notifying via ACPI. That
method is deprecated for a while. You are using Haswell, which has this
support. But deprecated from Skylake.

> =E2=80=A6
> > From f85a83508ef029bceaf9192cb648d66f32b61d02 Mon Sep 17 00:00:00
> > 2001
> > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Date: Wed, 29 May 2024 15:30:49 -0700
> > Subject: [PATCH] cpufreq: intel_pstate: Fix unchecked HWP MSR
> > access
> >=20
> > HWP MSR 0x771 can be only read on a CPU which supports HWP and
> > enabled.
> > Hence intel_pstate_get_hwp_cap() can only be called when hwp_active
> > is
> > true.
> >=20
> > Reported-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Did Sebastian _Reichel_ report it, too?
My mistake. I picked up wrong Sebastian. Sorry.

Thanks,
Srinivas

>=20
> > Closes:
> > https://lore.kernel.org/linux-pm/20240529155740.Hq2Hw7be@linutronix.de/
>=20
> Because this my report ;)
>=20
> > Fixes: e8217b4bece3 ("cpufreq: intel_pstate: Update the maximum CPU
> > frequency consistently")
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
>=20
> Sebastian


