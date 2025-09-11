Return-Path: <linux-pm+bounces-34517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCBAB53CF5
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 22:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C5017BF7E
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 20:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A423257444;
	Thu, 11 Sep 2025 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdcRJ+pl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C53255F31
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621466; cv=none; b=I/s2bqBV7wTaNECsFdDwUN/QIcsyLc7XQZ0sc2tjgIFehUkR6bBhlKYfO5dZE8/x/r9AhqxT4j+ShR3gKhfYH2NgCjRge2qHRgcQJ5FVFyGNxfPnDbULv8w2HysxSBjSnzVUnUzVAYsapn/tlvTXDGGEYbCGEaa7goBxEbddYpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621466; c=relaxed/simple;
	bh=nNg7292elzca9JdxdiZwE6FkcEtXNTz1g9rUEUlMSQs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PmydhjL7LbsAfLgg+/taLuzAyNGwB73Q65iOoxJFpIA4MWoFgiikJhJzXbhGu4E/uUGUGUa7ayWTxyNAVJwYtPqGJshe2NBXxjohQN5IrblPKIph0OXeUvIjrSl2pwGr4ekWRvGpINg8Q7phqOu9nQHomLyoHL7ynWCUIGeE2rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdcRJ+pl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757621461; x=1789157461;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=nNg7292elzca9JdxdiZwE6FkcEtXNTz1g9rUEUlMSQs=;
  b=gdcRJ+plgvpVHsIkf+uYAuUeTUwSsGRXqL5Yu+U1e0UtBpdj8Nu/6R0D
   jMTqNOeLQTYBPDU+CnXbizni4Np2arzIdMCy1sY25l3z0HKgpYyJVvxhB
   GruwZHmyyXDUKHm/uVpnfMqNSvjuvHmXt1/IeNciQaDUheOGbDYW+Sngl
   DL2P1au/qLgLn6folC3vC1gcE0TIPs+1asroNoI/94tSvcHR7rztFDsrk
   UCueLRh7Xnwz8HIWiKkruuYZSYFV4VLTbEM+jsE/4Rz6weGsXHGt8LfCj
   8jnPJ0RhnRc6rihEqm2lmgwC4uTwWSvwVVIBA2DpdAb4Ys7HxEHYqKpuD
   g==;
X-CSE-ConnectionGUID: OXoYah2rTJmIreHEl+T7tA==
X-CSE-MsgGUID: lBLF09APS32FUvXzl7mpaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="47535436"
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="47535436"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 13:11:01 -0700
X-CSE-ConnectionGUID: BrSFeOFdTZSoYhzxvPWiGQ==
X-CSE-MsgGUID: jJx7NuPbTRmW4SLOCtlJJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="173852236"
Received: from spandruv-desk2.jf.intel.com (HELO [10.88.27.176]) ([10.88.27.176])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 13:11:01 -0700
Message-ID: <6d90dda6140b8000acb9d74bd888d70e3014f128.camel@linux.intel.com>
Subject: Re: Sometimes I only see 3 RAPL (out of 4) Counters
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Kenneth Crudup <kenny@panix.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date: Thu, 11 Sep 2025 13:11:00 -0700
In-Reply-To: <474555e3-dc46-49aa-8e1e-0afbd1dee9ad@panix.com>
References: <8ce4578e-6913-4dbe-9573-433e69925bc1@panix.com>
	 <CAJZ5v0i4gNcir8sDunPbpSP367tN=PvrsrP61puv954XEtMBKQ@mail.gmail.com>
	 <b88dc0fc6604bd18d1658c0d16aa10a2f43eb054.camel@linux.intel.com>
	 <474555e3-dc46-49aa-8e1e-0afbd1dee9ad@panix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-11 at 11:40 -0700, Kenneth Crudup wrote:
>=20
>=20
> On 9/11/25 11:37, srinivas pandruvada wrote:
> > On Thu, 2025-09-11 at 11:42 +0200, Rafael J. Wysocki wrote:
> > > +Srinivas & Rui
> > >=20
> > > On Thu, Sep 11, 2025 at 2:20=E2=80=AFAM Kenneth Crudup <kenny@panix.c=
om>
> > > wrote:
> > > >=20
> > > > I have a Dell XPS-9320, with a i7-1280P (family: 0x6, model:
> > > > 0x9a,
> > > > stepping: 0x3) CPU. Sometimes I'll only see 3 RAPL counters
> > > > instead
> > > > of
> > > > the normal 4. (It used to happen a lot more often, BTW):
> > > >=20
> >=20
> > That is because sometimes the counter for PP1 (GFX ..) is 0 during
> > boot
> > and then the PMU code will ignore that. This happens when the
> > counter
> > is sampled before GPU is not even started. So this is a race
> > condition.
>=20
> Is there anything that should/could be done about it?
>=20
Not an easy solution at this time without ignoring 0s.


> What's the effect of not having a GPU RAPL available?
>=20
The package level counter already includes this. So unless looking for
only GPU counter, not much effect.

Thanks,
Srinivas


> > Thanks,
> > Srinivas
> >=20
> >=20
> > > > ----
> > > > gunzip --force --stdout /var/log/syslog* | fgrep -i rapl |
> > > > fgrep
> > > > fixed
> > > > 2025-09-08T12:09:05.915989-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> > > > 2025-09-09T08:52:19.098522-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-09-09T17:25:24.377784-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-09-09T17:50:09.334140-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-09-10T16:42:13.259270-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> > > > 2025-09-10T16:46:36.322016-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-09-02T13:05:02.632218-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-09-02T14:07:19.683466-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-09-02T14:20:43.602483-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-09-04T13:13:38.636326-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-09-05T09:21:50.147180-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-08-29T10:57:14.419740-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-08-17T11:52:55.733943-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-08-19T07:52:30.696326-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-08-19T07:55:49.083600-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-08-20T10:53:54.601680-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-08-20T11:00:09.560496-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > 2025-08-20T11:12:30.580414-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=
=A0 T1] RAPL
> > > > PMU: API
> > > > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > > > ----
> > > >=20
> > > > ... and it's always(?) the GPU RAPL:
> > > >=20
> > > > ----
> > > > gunzip --force --stdout /var/log/syslog* | fgrep -i rapl | cut
> > > > -d\]
> > > > -f2-
> > > > > sort -f | uniq -c
> > > > grep: (standard input): binary file matches
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0 intel_rapl_common: Fo=
und RAPL domain core
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 36=C2=A0 intel_rapl_common: Fo=
und RAPL domain package
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0 intel_rapl_common: Fo=
und RAPL domain psys
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=C2=A0 intel_rapl_common: Fo=
und RAPL domain uncore
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0 intel_rapl_msr: PL4 s=
upport detected.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=C2=A0 RAPL PMU: API un=
it is 2^-32 Joules, 3 fixed
> > > > counters,
> > > > 655360
> > > > ms ovfl timer
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=C2=A0 RAPL PMU: API unit is=
 2^-32 Joules, 4 fixed
> > > > counters,
> > > > 655360
> > > > ms ovfl timer
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0 RAPL PMU: hw unit of =
domain package 2^-14 Joules
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0 RAPL PMU: hw unit of =
domain pp0-core 2^-14 Joules
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=C2=A0 RAPL PMU: hw unit of =
domain pp1-gpu 2^-14 Joules
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0 RAPL PMU: hw unit of =
domain psys 2^-14 Joules
> > > > ----
> > > >=20
> > > > A reboot fixes it up again (and that's if I even notice), but
> > > > what
> > > > would
> > > > cause this to happen? What's the effect of it missing the RAPL
> > > > counter, BTW?
> > > >=20
> > > > LMK if you need more info,
> > > >=20
> > > > -Kenny
> > > >=20
> > > > --
> > > > Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting,
> > > > Orange
> > > > County CA
> > > >=20
> > > >=20
> >=20

