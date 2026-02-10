Return-Path: <linux-pm+bounces-42465-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SISNI5Rwi2lhUQAAu9opvQ
	(envelope-from <linux-pm+bounces-42465-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 18:53:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF73811E222
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 18:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39884303A6F5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 17:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DB938A72E;
	Tue, 10 Feb 2026 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LI/5nS3u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E4326D46;
	Tue, 10 Feb 2026 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770746001; cv=none; b=V58cQOZrKKS9t+09TpOCgpjEXGJlJ1DKIicZfdhbfpCV2+gAhnqbu/9joh1IhPd8aeQumdalYSL9OUtoy34zokfrvNrW3NtMONLartA9XCOZOgOdEp5bviq66AeivDA/S1pwuK/LBU/P2L+avdabonNRE1mbfHWrm/L8Jz6zk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770746001; c=relaxed/simple;
	bh=wm0G/zTXeO7Fi58T0rdrAZcJO6SnbS5Dp2BsSwnb4OA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pPxxnOjysuByapHRRzH5/A98SSH9HiBMAq3yhb5s+mCSRSHgoVxhEXRIhe4nKNfJSN+ocyNTKHKYJ7boGL9Qh0GHZgpg8kAbdkLXkN75yKNwNmQLu/7ucrM0M7+CPWAzcQBYEGJcqvuA56lr2qSnL7nYPGUpTVYTWA2Ubj4Y3e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LI/5nS3u; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770746000; x=1802282000;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=wm0G/zTXeO7Fi58T0rdrAZcJO6SnbS5Dp2BsSwnb4OA=;
  b=LI/5nS3uVa+XPFk3RRVrPzdpj3DtPyYSwND2ZrBr/gWNvpmUyOXUNVRz
   pzKIrtBNObgwsoaU6W+wR44orrb044ek0lRzmNWrsm8ksvRe4HiIm5HNf
   1Pk2R1urlovkO6pdtxVdGWYrWsbAV+Vbhqo05+2VuTflJM/Tbn5VE9Wi+
   /DMYWEjn8gDT7Ngn0p9IMKnMTXRvC0cOrwevHHI5QGXUyVDP0UdJujAdA
   F+HGUZtWyIOCIeLWKdyIpWBZzA3QzfB0qbzSvBuLX+o6PykPFODDa2vW4
   CU8xYDCBxMkeGzxEccXc9dt3Ph62IWFBDkyjbk2AiCPg6XQ+anQNh5Qti
   g==;
X-CSE-ConnectionGUID: oNekvLGSR3SAG6gvkwGOjQ==
X-CSE-MsgGUID: X4SUFHstR/aVRbCzwxxmYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="82204468"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="82204468"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 09:53:20 -0800
X-CSE-ConnectionGUID: Eh1PLkTnSoKq5Y1A/xf5BQ==
X-CSE-MsgGUID: Vzz6dpnDQhec3XksDCaFzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="249630968"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 09:53:19 -0800
Message-ID: <62c8c3910e1becf49e96eddf892d7c37960c7c28.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/2] Fix RAPL PMU access from non-lead CPUs
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  "Rafael J . Wysocki"	 <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Feb 2026 09:53:19 -0800
In-Reply-To: <20260209234310.1440722-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: 
	<20260209234310.1440722-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42465-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: AF73811E222
X-Rspamd-Action: no action

On Mon, 2026-02-09 at 15:43 -0800, Kuppuswamy Sathyanarayanan wrote:
> This series fixes issues with RAPL PMU event access when using CPUs
> other than the package lead_cpu.
>=20
> The problem was discovered when turbostat reported zero power values
> when run on a non-lead CPU in the package.
>=20
> Investigation revealed two issues:
>=20
> 1. The RAPL MSR driver incorrectly validated that the current CPU
> must
> =C2=A0=C2=A0 match the lead CPU of the package when reading from PMU cont=
ext,
> even
> =C2=A0=C2=A0 though package-scoped MSRs are readable from any CPU in the
> package.
>=20
> 2. The RAPL PMU cpumask only exposed one CPU per package (the
> lead_cpu)
> =C2=A0=C2=A0 for both MSR and TPMI interfaces, forcing tools to use that
> specific
> =C2=A0=C2=A0 CPU even though package-scoped registers are readable from a=
ny CPU
> =C2=A0=C2=A0 in the package.
>=20
> The perf tool avoided issue #1 by checking the cpumask before opening
> events, but turbostat does not perform this validation. The
> restrictive
> cpumask in issue #2 was unnecessary since both MSR and TPMI
> interfaces
> support reads from any CPU in the package for package-scoped
> registers.
>=20
> These patches:
> - Remove the incorrect CPU validation check in PMU context
> - Expand the PMU cpumask to include all CPUs in each package for both
> =C2=A0 MSR and TPMI RAPL interfaces
> - Rename 'atomic' parameter to 'pmu_ctx' for clarity
>=20
> After these changes, tools can successfully read RAPL events from any
> CPU in the package, matching the architectural capability of the
> hardware for both MSR and TPMI based RAPL implementations.
>=20
> Testing (PTL & GNR platform):
> - Verified turbostat --no-msr --show power works on all CPUs
> - Verified perf stat -e power/energy-pkg/ works on all CPUs
> - Confirmed /sys/bus/event_source/devices/power/cpumask shows all
> =C2=A0 package CPUs instead of just lead_cpu
> - Tested on both MSR-based (PTL) and TPMI-based (GNR) RAPL system
>=20
> Kuppuswamy Sathyanarayanan (2):
> =C2=A0 powercap: intel_rapl: Remove incorrect CPU check in PMU context
> =C2=A0 powercap: intel_rapl: Expose all package CPUs in PMU cpumask
>=20

Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> =C2=A0drivers/powercap/intel_rapl_common.c | 21 ++++++++-------------
> =C2=A0drivers/powercap/intel_rapl_msr.c=C2=A0=C2=A0=C2=A0 | 12 +++++-----=
--
> =C2=A0include/linux/intel_rapl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A03 files changed, 14 insertions(+), 21 deletions(-)

