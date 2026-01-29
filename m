Return-Path: <linux-pm+bounces-41720-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IC2EASze2nNHwIAu9opvQ
	(envelope-from <linux-pm+bounces-41720-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:20:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EABB3DF9
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC8893004054
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560B12F8BD0;
	Thu, 29 Jan 2026 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdVnHNAN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F32280CF6;
	Thu, 29 Jan 2026 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714431; cv=none; b=RIKJMUg74107JrnOFrec0OenQvTLfFdYyBaxqw0N1fRF/SGPeLgVlfi/A5PCneWFxWp12fw//SD4nZ2Nnua7Y/U8nE7RbBIInuQRthBkCFvWxANZm+0oRWVr9WFv7qFvTnQFXS0R11RdSnJDnEV3mxPYVJnxhi2cOZOee9S3kdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714431; c=relaxed/simple;
	bh=PalrbpRYpRj0TLYoVkWb03NC3bogZJ6bYnLkSLN1CTU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A6u3joyzv8z4LAHFp9LoNf8PcbO89AODuSkw5xJIDwSOyOR1mrruKV4RY3/Ho5K09BpZjRdlLklrCxUQnivF4HV5ECDA8vbPg0bjKPWnIK+VSszcVkMqLG+C0OfB1HrRsxoY7A2GiNihUxyhsVyFI0TX8IOoR/P3ZdP2KcqiED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdVnHNAN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769714429; x=1801250429;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PalrbpRYpRj0TLYoVkWb03NC3bogZJ6bYnLkSLN1CTU=;
  b=gdVnHNANWnTlrErXay19fdpY47I8rzPIQ/cMDJ7ppSHNqPKoK62LfNzX
   IKWrq4VwKWkAEkdD8Ag32q4XCUOHh3zxC/YM5wdcfyBX3EOZj+vJySyNE
   Wkeo6rirG2d8hC+SDKB+BFUlXaQYMiStvtJxoPq5cNBu8R4Ze/n6/1L7q
   RD78fOcy9QQMdEnM/5LVJLQeFWcoAhmkg8SMgJEgiI1Fe6jqqc51Xfdwg
   6qCVQ2Av6bViSRJJE68QYI9Lr0rr9OoNVmPoRwOl9HASc+xExSlJQcbFS
   kPJiZrBISLnqtFatV2CYkYhTCSFPz6gVZvU0/ldJPtCStGlKQWFILZZKl
   g==;
X-CSE-ConnectionGUID: U3aBcmu9SSW+aMbg2WATBw==
X-CSE-MsgGUID: DkjNIeHhRjmiNgg7eIuKdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="58544986"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="58544986"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 11:20:29 -0800
X-CSE-ConnectionGUID: 7S1UvuM9Qmyv/sbwin4Jlg==
X-CSE-MsgGUID: /2Qw7YeuToW98aQVp6s+7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="246287156"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 11:20:29 -0800
Message-ID: <ed7cd1ea051f07bb59fea83f359aedaaab4cf423.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/9] Move RAPL defaults to interface drivers
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  "Rafael J . Wysocki"	 <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 29 Jan 2026 11:20:28 -0800
In-Reply-To: <20260129183646.558866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: 
	<20260129183646.558866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41720-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31EABB3DF9
X-Rspamd-Action: no action

On Thu, 2026-01-29 at 10:36 -0800, Kuppuswamy Sathyanarayanan wrote:
> Hi All,
>=20
> The Intel RAPL common driver has accumulated a significant amount of
> interface-specific logic over time. There is very little common code
> shared across the MSR, TPMI, and MMIO interface-specific defaults.
> Keeping these interface-specific defaults in the common layer
> therefore
> provides no real benefit and instead increases complexity and
> maintenance burden.
>=20
> As a first step toward cleaning this up, this series moves
> rapl_defaults ownership from the common driver into the individual
> interface drivers and allows each interface to provide its own
> defaults
> directly. Additional interface-specific cleanups in the RAPL common
> driver will be addressed in follow-up work. This series is a
> continuation of the earlier cleanup and refactoring effort initiated
> by Zhang Rui.
>=20

For the series:

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> Patch Summary:
>=20
> Patch 1-4/9: Preparatory patches that do code cleanups in
> intel_rapl_common
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
driver.
> Patch 5/9: Preparatory patch that renames/declares the common
> functions.
> Patch 6/9: Move TPMI default settings from the common driver into the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPMI interfa=
ce driver.
>=20
> Patch 7/9: Move MMIO default settings from the common driver into the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MMIO interfa=
ce driver.
>=20
> Patch 8/9: Register the PM notifier only when a RAPL package exists.
>=20
> Patch 9/9: Move MSR default settings from the common driver into the
> MSR
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interface dr=
iver.
>=20
> No functional changes are intended across the series. This is
> strictly a
> structural refactoring to simplify the common RAPL code and prepare
> it
> for further cleanups.
>=20
> Kuppuswamy Sathyanarayanan (9):
> =C2=A0 powercap: intel_rapl: Add a symbol namespace for intel_rapl export=
s
> =C2=A0 powercap: intel_rapl: Cleanup coding style
> =C2=A0 powercap: intel_rapl: Use GENMASK() and BIT() macros
> =C2=A0 powercap: intel_rapl: Use unit conversion macros from units.h
> =C2=A0 powercap: intel_rapl: Allow interface drivers to configure
> =C2=A0=C2=A0=C2=A0 rapl_defaults
> =C2=A0 powercap: intel_rapl: Move TPMI default settings into TPMI
> interface
> =C2=A0=C2=A0=C2=A0 driver
> =C2=A0 thermal: intel: int340x: processor: Move RAPL defaults to MMIO
> driver
> =C2=A0 powercap: intel_rapl: Register PM notifier only when RAPL package
> =C2=A0=C2=A0=C2=A0 exists
> =C2=A0 powercap: intel_rapl: Move MSR default settings into MSR interface
> =C2=A0=C2=A0=C2=A0 driver
>=20
> =C2=A0drivers/powercap/intel_rapl_common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 755 ++++++----------
> --
> =C2=A0drivers/powercap/intel_rapl_msr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 251 +++++-
> =C2=A0drivers/powercap/intel_rapl_tpmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 48 ++
> =C2=A0.../int340x_thermal/processor_thermal_rapl.c=C2=A0 |=C2=A0=C2=A0 9 =
+
> =C2=A0include/linux/intel_rapl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 17 +-
> =C2=A0include/linux/units.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A06 files changed, 561 insertions(+), 522 deletions(-)

