Return-Path: <linux-pm+bounces-8537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FA68D88DA
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 20:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D201F2286B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 18:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1119A1369A3;
	Mon,  3 Jun 2024 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfoT1fGQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881D8F9E9;
	Mon,  3 Jun 2024 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440477; cv=none; b=Casls81XtGBb2GiiJxvP10twvlsCNI6H8WQe88kkHIxa7lzYhXvtIJnicNZuMBNBUUIEx5XEEb3hwPzXN9YjzSTgXRq2P5JzWfWvifSkY3MMDiGSq1bC5rrcN7wUgZzQcLasfAuzJ93rl2uBk0zkXO1eRSquzydrD8iGJoa/jOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440477; c=relaxed/simple;
	bh=15edaRo3ICbpvaIs7c6VEpdb48R0PeutvnP1BJysCiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IR0fgi0kgrsLF840WLPEJhF1x4/LZ6JGKfvczq7WPPycHGaMaN3CEQr+2godfUW2y1rTiop/mIjcVnsjW2ow5ACb4l38uhS3JxDa5pTs4fdUP3p6I9+F9RmOOsiFdHyYl+PDITjWbnZZmpqLA8yxtSSDFO7598unKId2cCSZb4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfoT1fGQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717440476; x=1748976476;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=15edaRo3ICbpvaIs7c6VEpdb48R0PeutvnP1BJysCiA=;
  b=RfoT1fGQCBdovUie90RhU2fUD8e9JUebxacGbpvN1K/ff66y86d5sxal
   4fAEBY4YWewdpqetz/onlHZBH2A5XPnS9BO2pX1+ILr0d0Vov7StNm0Vn
   5Gf9PhVZMLd75kQiwt6TyeokHTdImXOlLaGUkTPXxxLo/LgWl3Weo7KP1
   2CZGgWDJqiBXhOKwap7eOJsgiEdI95/EJ1svnIhf4C8yQ9539WqChz3+n
   nbcSlOotLQ0ox+Q2kN6tF6siNH3sduOgvJBHuEndAKLlo9L7BNeplgQ/n
   64n2xt3UhfXg9LultZJOngj6lElyXgxRrUFqVOf6c/Q7XcVWK41CV6O5k
   A==;
X-CSE-ConnectionGUID: 7ybUBxOBRN2pX5XG4t/xmw==
X-CSE-MsgGUID: EtfynT4kRoiAY9qcutCcEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13760284"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="13760284"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 11:47:55 -0700
X-CSE-ConnectionGUID: k4gcVFlcRN6rDfDYOVQJCg==
X-CSE-MsgGUID: 5TjGErkLRrOhpKmSenUGNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="74452120"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 11:47:55 -0700
Message-ID: <f34c20ae3feac0e3570125f124e440d51c5e4d9b.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Xi Ruoyao <xry111@xry111.site>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Date: Mon, 03 Jun 2024 11:47:54 -0700
In-Reply-To: <CAJZ5v0jjLgG3VY_kBYc4mTrL2ybD2LfBTk2_H7xY0+Aq5g827A@mail.gmail.com>
References: <13494237.uLZWGnKmhe@kreacher> <8366982.T7Z3S40VBb@kreacher>
	 <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
	 <6d5ee74605bd9574baa5ed111cb54e959414437a.camel@linux.intel.com>
	 <6ebadacd8aaa307a5766cdb1b4d4a5c69acd87ac.camel@xry111.site>
	 <30a30c5107a47a2cc3fd39306728f70dd649d7fe.camel@linux.intel.com>
	 <f382e06635b3b52841d1e0c11dcf639d225edae0.camel@xry111.site>
	 <29d69252dcdc398f147c9139a8666d09e7bd831d.camel@linux.intel.com>
	 <0324bc3a88654855719cd48a5ed69a34eea31037.camel@xry111.site>
	 <c3526e7a0e80ec1a3a011259c38ab4b772040ea4.camel@linux.intel.com>
	 <48eba83030e155f703b4248e9c1ae65aa44b1a83.camel@xry111.site>
	 <CAJZ5v0jjLgG3VY_kBYc4mTrL2ybD2LfBTk2_H7xY0+Aq5g827A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-03 at 20:32 +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 3, 2024 at 7:44=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wro=
te:
> >=20
> > On Mon, 2024-06-03 at 10:11 -0700, srinivas pandruvada wrote:
> > > On Mon, 2024-06-03 at 21:12 +0800, Xi Ruoyao wrote:
> > > > On Sun, 2024-06-02 at 16:11 -0700, srinivas pandruvada wrote:
> > > >=20
> > > > /* snip */
> > > >=20
> > > > > What is the output of:
> > > > > grep . /sys/devices/system/cpu/intel_pstate/*
> > > > >=20
> > > > > Also
> > > > > rdmsr 0x771
> > > > > rdmsr 0x774
> > > > >=20
> > > > >=20
> > > > > Try these three patches. Don't worry about the commit
> > > > > description
> > > > > for
> > > > > this issue.
> > > >=20
> > > > Unfortunately they still do not fix the issue for me.
> > > >=20
> > > > The outputs of grep and rdmsr commands are initially:
> > > >=20
> > > > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost:0
> > > > /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> > > > /sys/devices/system/cpu/intel_pstate/min_perf_pct:9
> > > > /sys/devices/system/cpu/intel_pstate/no_turbo:1
> > > > /sys/devices/system/cpu/intel_pstate/num_pstates:41
> > > > /sys/devices/system/cpu/intel_pstate/status:active
> > > > /sys/devices/system/cpu/intel_pstate/turbo_pct:33
> > > > rdmsr 0x771: 10d1f2c
> > > > rdmsr 0x774: 1f04
> > > >=20
> > > > But it then changes to:
> > > >=20
> > > > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost:0
> > > > /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> > > > /sys/devices/system/cpu/intel_pstate/min_perf_pct:9
> > > > /sys/devices/system/cpu/intel_pstate/no_turbo:1
> > > > /sys/devices/system/cpu/intel_pstate/num_pstates:41
> > > > /sys/devices/system/cpu/intel_pstate/status:active
> > > > /sys/devices/system/cpu/intel_pstate/turbo_pct:33
> > > > rdmsr 0x771: 10c1f2c
> > > > rdmsr 0x774: 1f04
> > > >=20
> > > > It seems only the output of rdmsr 0x771 has changed.=C2=A0 And if I
> > > > read
> > > > the
> > > > SDM correctly it's a "Most_Efficient_Performance" change.
> > > That is fine.
> > >=20
> > > We don't have any notifications either via ACPI or via HWP
> > > interrupt.
> > > I think it was working by chance before this change as by the
> > > cpufreq
> > > core is trying to set policy, the turbo is enabled by the
> > > firmware.
> > >=20
> > > What is this laptop make and model?
> >=20
> > It's a Hasee X5-2021S5H.
> >=20
> > Hasee is known for producing some laptops very cheap but often
> > having
> > "minor" issues.=C2=A0 So I guess the firmware is doing some stupid
> > thing.
> >=20
> > But turbo works just fine on Windows 11 so it'd be better if we
> > could
> > make it work for Linux too.
>=20
> In principle, there are two things that can be done about this.
>=20
> First, MSR_IA32_MISC_ENABLE_TURBO_DISABLE on this system can be
> ignored altogether, but that would require adding a quirk.
>=20
> Second, a delayed work can be added to check the MSR long enough
> after
> initialization and update global.turbo_disabled if it is 1.=C2=A0 However=
,
> that would require some code surgery.

I was about to send this suggestion.

For the first one we can always program the HWP_REQ.max to HWP_CAP.max
and  let hardware do the clipping. But this is not friendly to passive
mode. But display of scalig_max_freq still should reflect the reality.


Thanks,
Srinivas

>=20


