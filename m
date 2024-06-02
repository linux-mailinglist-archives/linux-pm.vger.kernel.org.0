Return-Path: <linux-pm+bounces-8502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5239A8D75C3
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B373D1F2145D
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 13:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E363B7AC;
	Sun,  2 Jun 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMidcGMt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FBD3A1DC;
	Sun,  2 Jun 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717335634; cv=none; b=gGhi3FmtxZQNPDRMkglCnz7r+7inT+tOtOi9WYo2yRsvtrX4NiZDtwcj/iwcNeoUNsuf4KJYwpkReo8weAUDifSAISmZs/svuPzzc6RvBk3RMfA2z4GwOMpMUHfJ7PY//jzNF7yhMougkGUaH38RgsiHdGwPdvhg7pzfZ4AohkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717335634; c=relaxed/simple;
	bh=NugtBoo6HeoPWFobyp5Dqem7d2GcQeN/7XD7a5PIxwY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zj6I48yKbI8FvaQBcxbwoZI15qNqzU+7oHa/l6UgzDe62VHez3oHElqcEnDQBWys0kZjuagejnljKxE89GKaz69eaD7HFW6q3dxb33d0QKVrle5SLkOmwUjmKdqgOYRLUWBccehXVIcpxauPNeIv5AirFruEnN52KTqqYoLrTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMidcGMt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717335633; x=1748871633;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NugtBoo6HeoPWFobyp5Dqem7d2GcQeN/7XD7a5PIxwY=;
  b=ZMidcGMtGeZ0LGYUflk9rYPxT6aTnWWJ4SIk4XwDNrKiwKJ2laXsawwm
   grBzEe3UGwYk2L59eXd62s6ZNjKUNznL3+pPOclt/UTYIytdZARxJXQrP
   ehmqX4PoWbEdGwK/MI06M6AoroviRqf2F0BYZsZtEfJLOPvwNTagy3/rR
   6yNOkMqBG23/sMAVxQNwnjPm42IFzIU5pqP/trGavdCIZzryTURLGiIbC
   XPiXHaQ+zBSjtNB7pUUU68SjudjXh2nN2PIs07VGBp8mo4p6sopt0OSDq
   4r6Fjg1pn3fz95JC7Ig9PVEdkmSae0Ji5jdLv4+pWetI0EW0wMkmG1BM3
   Q==;
X-CSE-ConnectionGUID: lMHKWjjGQ8GVzXueetKhjA==
X-CSE-MsgGUID: yBhArZPgQ5iW6CNOuunuMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="14021895"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="14021895"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 06:40:32 -0700
X-CSE-ConnectionGUID: n126bJhYTfuM9l4t/0QEDg==
X-CSE-MsgGUID: xn0Des1vRDSpMh3bPjxRzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="37079604"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 06:40:32 -0700
Message-ID: <30a30c5107a47a2cc3fd39306728f70dd649d7fe.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Xi Ruoyao <xry111@xry111.site>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
  Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Sun, 02 Jun 2024 06:40:31 -0700
In-Reply-To: <6ebadacd8aaa307a5766cdb1b4d4a5c69acd87ac.camel@xry111.site>
References: <13494237.uLZWGnKmhe@kreacher> <8366982.T7Z3S40VBb@kreacher>
	 <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
	 <6d5ee74605bd9574baa5ed111cb54e959414437a.camel@linux.intel.com>
	 <6ebadacd8aaa307a5766cdb1b4d4a5c69acd87ac.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-06-02 at 12:25 +0800, Xi Ruoyao wrote:
> On Sat, 2024-06-01 at 21:03 -0700, srinivas pandruvada wrote:
> > Hi Xi,
> >=20
> > On Sun, 2024-06-02 at 11:21 +0800, Xi Ruoyao wrote:
> > > On Mon, 2024-03-25 at 18:02 +0100, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >=20
> > > > The global.turbo_disabled is updated quite often, especially in
> > > > the
> > > > passive mode in which case it is updated every time the
> > > > scheduler
> > > > calls
> > > > into the driver.=C2=A0 However, this is generally not necessary and
> > > > it
> > > > adds
> > > > MSR read overhead to scheduler code paths (and that particular
> > > > MSR
> > > > is
> > > > slow to read).
> > > >=20
> > > > For this reason, make the driver read
> > > > MSR_IA32_MISC_ENABLE_TURBO_DISABLE
> > > > just once at the cpufreq driver registration time and remove
> > > > all of
> > > > the
> > > > in-flight updates of global.turbo_disabled.
> > >=20
> > > Hi Rafael and Srinivas,
> > >=20
> > > Thanks for the clean up, but unfortunately on one of my laptops
> > > (based
> > > on i5-11300H) MSR_IA32_MISC_ENABLE_TURBO_DISABLE is mysteriously
> > > changing from 1 to 0 in about one minute after system boot.=C2=A0 I'v=
e
> > > no
> > > idea why this is happening (firmware is doing some stupid thing?)
> > >=20
> > > I've noticed the issue before and "hacked it around"
> > > (https://bugzilla.kernel.org/show_bug.cgi?id=3D218702). But after
> > > this
> > > change I can no longer hack it around and the system is much
> > > slower.
> > >=20
> > > Is it possible to hack it around again?
> > >=20
> > Please try the attached diff and build kernel and try.
> >=20
> > git apply update_max_freq.diff
> >=20
> > Then build kernel and install.
>=20
> Unfortunately it didn't work.=C2=A0 Then I tried:
>=20
> @@ -1304,6 +1310,10 @@ static ssize_t store_no_turbo(struct kobject
> *a, struct kobj_attribute *b,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (no_turbo =3D=3D globa=
l.no_turbo)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto unlock_driver;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0global.turbo_disabled =3D turb=
o_is_disabled();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0global.no_turbo =3D global.tur=
bo_disabled;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch_set_max_freq_ratio(global=
.turbo_disabled);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (global.turbo_disabled=
) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pr_notice_once("Turbo disabled by BIOS or unavailab=
le
> on processor\n");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0count =3D -EPERM;
>=20
> and my old hack worked again.=C2=A0 Curiously after I writing 0 to
> /sys/devices/system/cpu/intel_pstate/no_turbo successfully, your code
> is
> triggered.
>=20
> $ dmesg | grep intel_pstate
> [=C2=A0=C2=A0=C2=A0 0.554425] intel_pstate: Intel P-state driver initiali=
zing
> [=C2=A0=C2=A0=C2=A0 0.554877] intel_pstate: HWP enabled
> [=C2=A0=C2=A0=C2=A0 1.780021] intel_pstate: Turbo disabled by BIOS or una=
vailable on
> processor
> [=C2=A0=C2=A0 21.789044] intel_pstate: intel_pstate_update_limits cpu:0
> [=C2=A0=C2=A0 21.789053] intel_pstate: intel_pstate_update_limits cpu:1
> [=C2=A0=C2=A0 21.789060] intel_pstate: intel_pstate_update_limits cpu:2
> [=C2=A0=C2=A0 21.789189] intel_pstate: intel_pstate_update_limits cpu:3
> [=C2=A0=C2=A0 21.789198] intel_pstate: intel_pstate_update_limits cpu:4
> [=C2=A0=C2=A0 21.789203] intel_pstate: intel_pstate_update_limits cpu:5
> [=C2=A0=C2=A0 21.789209] intel_pstate: intel_pstate_update_limits cpu:6
> [=C2=A0=C2=A0 21.789276] intel_pstate: intel_pstate_update_limits cpu:7
>=20
> The message at [1.780021] is from the first attempt writing 0 to
> /sys/devices/system/cpu/intel_pstate/no_turbo when
> MSR_IA32_MISC_ENABLE_TURBO_DISABLE is still 1

This requires user action,
Please add a
pr_info() to
https://elixir.bootlin.com/linux/v6.10-rc1/C/ident/acpi_processor_notify

Check if you got any message

Also what is=20
cat /proc/cpuinfo
and
cpuid -1

Thanks,
Srinivas




