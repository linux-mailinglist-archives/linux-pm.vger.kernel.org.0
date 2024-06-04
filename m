Return-Path: <linux-pm+bounces-8567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D03FB8FAFDD
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 12:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A78A283782
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 10:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74BC144D3B;
	Tue,  4 Jun 2024 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbs4N7Zk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1B029401;
	Tue,  4 Jun 2024 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496987; cv=none; b=n0a5AMqRmYw8Zqgp750JdoYOSV3/0BgwPfwTcUiVKfOIEAoN7WStvk7URariV6bMsPiPnR8cy3NS54RvGLXAn3GT6mOg5w+mi2ySioymjKxuaqtlmh3M1dIQBLeqSdPlrXnD+qBik2GN5/4S8NltTgxmaYs0OCFUWNjO/8bPKds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496987; c=relaxed/simple;
	bh=YnGXqvFYemOK4oAa8u+jvIolcn9ttr1HWGnsulGYRQw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IGvtDARW7hiEYp0jIDHzKEr7ntsBhIB4OMa3OEJqn2NilyILfW0gZGRFZCGTYfcNWL4/GXjOWshpVYTewaJR88owLWoeo6+Stvpri+i+5pefoxysTkLIZy2selgzEscTKrSMODkMpA/eP6X7T5HOUKjHHyuAv4F91V7ctVp2WyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbs4N7Zk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717496986; x=1749032986;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YnGXqvFYemOK4oAa8u+jvIolcn9ttr1HWGnsulGYRQw=;
  b=lbs4N7Zk5R0Bw1CdoHPNqqw9mUyXxY9qEHoOd8E6bj7KSci06H9sP17u
   gagjqcChxpfTaImnDCPqEqVuu2WEpmu6L/N7hkSdbJIeAOelZMHkbmS1f
   sUr8TNa0L6I3L+laJHf+3ubAEmStTW7Z88t2b6mM3jKFtgjKpJD0j77aq
   uQ6PbgRYttuW4Ru2ter5/Bd2ktITq1KuLZIkb4Iu+wHXm/d9bIbaehSqW
   sh7UDJgQQaCxqQzv3FN9J1v75ZwKlziUrQ51LDEDC9FC2UTaHW5rwhs2+
   Ib6gauv15MfChznK/yrlMGuw0FYbFE1xybazV9hfT8MQutemBCGJAFK2D
   A==;
X-CSE-ConnectionGUID: A23+fNJrQfCA4WwN/NHDJQ==
X-CSE-MsgGUID: 2YCpqckRS3mxfypKwEZYyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13874763"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="13874763"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 03:29:45 -0700
X-CSE-ConnectionGUID: bQeZwrfRQTqQ7akfNCvZdQ==
X-CSE-MsgGUID: CzaMVoSjToGuY7h0sNMbrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37788938"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 03:29:45 -0700
Message-ID: <63e98f2151ef64de92cf7e3da796937755ea5552.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Xi Ruoyao <xry111@xry111.site>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Date: Tue, 04 Jun 2024 03:29:45 -0700
In-Reply-To: <aa643910265b9d92a397d5148b31d37b2c421b8b.camel@xry111.site>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 17:30 +0800, Xi Ruoyao wrote:
> On Mon, 2024-06-03 at 21:31 -0700, srinivas pandruvada wrote:
>=20
> > > > Second, a delayed work can be added to check the MSR long
> > > > enough
> > > > after
> > > > initialization and update global.turbo_disabled if it is 1.=20
> > > > However,
> > > > that would require some code surgery.
> > >=20
> > Something like the attached which does same way as user space
> > no_turbo
> > update.
>=20
> > =C2=A0static int intel_pstate_register_driver(struct cpufreq_driver
> > *driver)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > @@ -3114,6 +3137,9 @@ static int
> > intel_pstate_register_driver(struct cpufreq_driver *driver)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0global.turbo_disabled =
=3D turbo_is_disabled();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0global.no_turbo =3D glo=
bal.turbo_disabled;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (global.turbo_disabled)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0schedule_delayed_work(&turbo_work, HZ);
> > +
>=20
> I have to change it to 20 * HZ to make it work for me.=C2=A0 15 * HZ does
> not
> work.

Is there any consistency or it is changing every time?

Thanks,
Srinivas

>=20


