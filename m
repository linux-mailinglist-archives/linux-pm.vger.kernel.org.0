Return-Path: <linux-pm+bounces-8586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5763F8FB93D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 18:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887661C21659
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A10146D6E;
	Tue,  4 Jun 2024 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RC6DyZRf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7333F6;
	Tue,  4 Jun 2024 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519310; cv=none; b=lNozvpfKf7uO5wL7zmOyckDXW8oz+ODfE5xBn9/y/gv+cdVW3FKmqhB0GLFAK5Tljsr6fQ5DkRYjLMG5e9AwPgre9iUdYS4y5YzJbZeJTswTGHEaD34+YOjjxfnn4wnVWpUPVj5zXF/6u5hXOCLeGEEwwdje+rw0JXYRs7JwEWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519310; c=relaxed/simple;
	bh=UFRy4idr9VBlMzfDzcTaalAaxI9DLLr/dtiBncZuzjY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O6a22JrzQ1z+h6Rj6eMIxPSMXANFGt8Ke3pYWwIuK5/GEXQThODBZRBsKjY10KBwhXH4kto1ydFzVPdK0yXu/En8b2MZEXPTXb2f4lqbjaokODDr9q7lqK/vJOAle6DrKa8m9U1ekpGUPTBAgF3xiNfqB7HIg4Byl7HCT5RGf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RC6DyZRf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717519309; x=1749055309;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UFRy4idr9VBlMzfDzcTaalAaxI9DLLr/dtiBncZuzjY=;
  b=RC6DyZRfX64t5Azaf/AwHVmlW58TVipXugrY8NZmDBroGauGucYaF2jC
   0lbMYfjRDuIHuoOqCSuA7uT2Ik+ri/SEmcHkYJqjblNk37wrvVenCIkYT
   5RPFqRcYvGRMsFfxF22i14stq1q8J4LSWHr1a5o2KFb4VgNuQBQntjxrb
   pGvkzgV8IRde5AUH+DyRENTM//aezj8lscReAE8LgfTR+6Ew2HVJHnus6
   UGGlVdVgmvCHFR6n8s9Daf/i2fPEjY8bAt2m6EvP3XVWpM/3w3hEXVQUz
   ZRlMuQtbn28C6X9rg8wSoTEn3Cwjpw0XFOOop0L+rP+pIfXMCx/OiwUXX
   A==;
X-CSE-ConnectionGUID: 3okxuEibQcK9kLJyPG0d1w==
X-CSE-MsgGUID: 0mAhODuBQmmLDD2XKeamPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25482604"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="25482604"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:41:48 -0700
X-CSE-ConnectionGUID: s1U2IinjTmuhbHbx2wVhbA==
X-CSE-MsgGUID: Rm0SavGrS6C0aKqWdEjzng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37937684"
Received: from rbhongad-mobl.gar.corp.intel.com ([10.213.90.152])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:41:45 -0700
Message-ID: <101b903e58f2ebae60934edc374c7cda09f83de1.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Xi Ruoyao <xry111@xry111.site>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Date: Tue, 04 Jun 2024 09:41:40 -0700
In-Reply-To: <258ce61c155c28937620f6abe57a39f2b4b0ff56.camel@xry111.site>
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
	 <f34c20ae3feac0e3570125f124e440d51c5e4d9b.camel@linux.intel.com>
	 <1da736da33a61de92314934ecf7fa0420d6d6b81.camel@linux.intel.com>
	 <aa643910265b9d92a397d5148b31d37b2c421b8b.camel@xry111.site>
	 <63e98f2151ef64de92cf7e3da796937755ea5552.camel@linux.intel.com>
	 <258ce61c155c28937620f6abe57a39f2b4b0ff56.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 18:32 +0800, Xi Ruoyao wrote:
> On Tue, 2024-06-04 at 03:29 -0700, srinivas pandruvada wrote:
> > On Tue, 2024-06-04 at 17:30 +0800, Xi Ruoyao wrote:
> > > On Mon, 2024-06-03 at 21:31 -0700, srinivas pandruvada wrote:
> > >=20
> > > > > > Second, a delayed work can be added to check the MSR long
> > > > > > enough
> > > > > > after
> > > > > > initialization and update global.turbo_disabled if it is 1.
> > > > > > However,
> > > > > > that would require some code surgery.
> > > > >=20
> > > > Something like the attached which does same way as user space
> > > > no_turbo
> > > > update.
> > >=20
> > > > =C2=A0static int intel_pstate_register_driver(struct cpufreq_driver
> > > > *driver)
> > > > =C2=A0{
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > > @@ -3114,6 +3137,9 @@ static int
> > > > intel_pstate_register_driver(struct cpufreq_driver *driver)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0global.turbo_disabl=
ed =3D turbo_is_disabled();
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0global.no_turbo =3D=
 global.turbo_disabled;
> > > > =C2=A0
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (global.turbo_disable=
d)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0schedule_delayed_work(&turbo_work, HZ);
> > > > +
> > >=20
> > > I have to change it to 20 * HZ to make it work for me.=C2=A0 15 * HZ
> > > does
> > > not
> > > work.
> >=20
> > Is there any consistency or it is changing every time?
>=20
> It seems consistent.
With such a delay, I am not sure how this even worked before.
Can you revert the patch in question and use kernel dynamic debug
dyndbg=3D"file intel_pstate.c +p" kernel command line and collect log for
30 seconds?

Thanks,
Srinivas

>=20
>=20


