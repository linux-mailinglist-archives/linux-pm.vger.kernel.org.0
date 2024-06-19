Return-Path: <linux-pm+bounces-9563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F9190E860
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 12:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2AA1C21AB9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 10:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6031B86255;
	Wed, 19 Jun 2024 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwmLBZ/H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3862D78C91;
	Wed, 19 Jun 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793307; cv=none; b=ZfgfRLZ1E25/jWjReKG6RVwACb9VBXDqTeutwt8KwPJWDGfvO0aBndWXyRxSJN2yg7XgY61KOWMpsOMx1dYPyQSCq4kL30zfY7H2DY1bdAsC63kWuJVMqt+vBdfDb+Xnp0rDTRb9/MgpSSrCRfoC8E9s/bay+vvtc1diF43nK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793307; c=relaxed/simple;
	bh=rAkZoulyRqoWcGhfxv3cdCzwzCQF6KLQPe1hqhtmVBQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QG14v0lWeLtGBU0QwUAKsSKQ+WRvd3jggRebdRwD85ACGj05GWd/vfnO+oueinW8NWbH1MhCsHO7Z1vw48zgFvJMHdYGq1Dzxqardl+3at2lz9wGhbkMm8zNHB99FbPKScRhy++kW0pdjQ0qR6fZxxBII0acTIS37Em68Nxk+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwmLBZ/H; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718793305; x=1750329305;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=rAkZoulyRqoWcGhfxv3cdCzwzCQF6KLQPe1hqhtmVBQ=;
  b=LwmLBZ/HEG9lGlSclIZO8jMiiiWYz93rs4LcgDjNiryfzciSu8vq3Wl3
   SuCtXbX/YwjyI8qQ8LFUPPVyQiCZFjxiIaivkkSpRa5mZImkGroNRkHux
   RTEBRWeuygOxxcfjrc6UYYPwaV/hFzYN3HRkhFiYVsXdMvOpBE0eOo/3A
   7L7g3mBnjxWjxvvlGZRsvkxPmbE/0644wnX798zBAkZU8dsfr1aTUpMO8
   HSCPFMcGA/2a8SoF+Wx+c8R3IhODWsJ9aZyP7p4bp8Tf4ZHy4BkvilSdR
   xGtaQ5HVYNdfRMdIOSBJNdr1Qt/ELLv0P0OGHUD0/Ntje7UfHrOGmTqOp
   g==;
X-CSE-ConnectionGUID: cK4+lQJPRzOFUFxuu7z+Zg==
X-CSE-MsgGUID: 6EnvEt65QY6ERkurd+lspg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="19596813"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="19596813"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 03:35:04 -0700
X-CSE-ConnectionGUID: UjQFZ2qzTJ6GiLj/nm1kiA==
X-CSE-MsgGUID: oN9ZG3u6TViQwpUipDLVZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="41987288"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 03:34:47 -0700
Message-ID: <bc75ff55161671e4470849ed51baa547f619889d.camel@linux.intel.com>
Subject: Re: [PATCH 0/9] Add CPU-type to topology
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Brice Goglin
	 <brice.goglin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,  daniel.sneddon@linux.intel.com, tony.luck@intel.com, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>,  "Liang, Kan"
 <kan.liang@linux.intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>
Date: Wed, 19 Jun 2024 03:34:46 -0700
In-Reply-To: <20240619015315.3ei5f6rovzdnxovo@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
	 <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
	 <20240619015315.3ei5f6rovzdnxovo@desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 18:53 -0700, Pawan Gupta wrote:
> On Tue, Jun 18, 2024 at 02:49:10PM +0200, Brice Goglin wrote:
> > Le 17/06/2024 =C3=A0 11:11, Pawan Gupta a =C3=A9crit=C2=A0:
> > > Hi,
> > >=20
> > > This series adds support for CPU-type (CPUID.1A.EAX[31-24] on
> > > Intel) to
> > > differentiate between hybrid variants P+E, P-only, E-only that
> > > share the
> > > same Family/Model/Stepping. One of the use case for CPU-type is
> > > the
> > > affected CPU table for CPU vulnerabilities, which can now use the
> > > CPU-type
> > > to filter the unaffected variants.
> > >=20
> > > * Patch 1 adds cpu-type to CPU topology structure and introduces
> > > =C2=A0=C2=A0 topology_cpu_type() to get the CPU-type.
> > >=20
> > > * Patch 2-4 replaces usages of get_this_hybrid_cpu_type() with
> > > =C2=A0=C2=A0 topology_cpu_type().
> > >=20
> > > * Patch 5-7 Updates CPU-matching infrastructure to use CPU-type.
> > >=20
> > > * Patch 8 cleans up the affected CPU list.
> > >=20
> > > * Patch 9 uses the CPU-type to exclude P-only parts from the RFDS
> > > affected
> > > =C2=A0=C2=A0 list.
> >=20
> >=20
> > Hello
> >=20
> > Is there still a plan to expose this info in sysfs?
>=20
> Sure, if it helps userspace.
>=20
> > Userspace currently uses frequencies to guess which cores are E or
> > P.
> > Intel sent some patches several years ago [1], but they got
> > abandoned
> > nowhere as far as I know. There was also some discussion about
> > using a
> > "capacity" field like ARM does, but IIRC Intel didn't like the idea
> > in
> > the end.
>=20
> There can be many ways to expose this information in sysfs. Like this
> ...
>=20
> > [1] https://lkml.org/lkml/2020/10/2/1208
>=20
> ... exposes /sys/devices/system/cpu/types which, in hybrid parts,
> creates a
> subdirectory for each type of CPU. Each subdirectory contains a CPU
> list
> and a CPU map that user space can query.
>=20
> The other way is to expose the CPU-type in a file:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/sys/devices/system/cpu/c=
puN/type
>=20
> that could return the CPU-type of the CPU N. Is there a preference?

But you still have to look at frequency or caches as there are Low
power E-cores which will have same type but different capabilities.

Thanks,
Srinivas




