Return-Path: <linux-pm+bounces-8787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB49900886
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 17:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA171C2232A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 15:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48EE1946DC;
	Fri,  7 Jun 2024 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7v4NTKD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479411922FD;
	Fri,  7 Jun 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773511; cv=none; b=DyYAIRmcmTjoSI0v2iYX5yFpwHuqX3EiWhy4eCDvwt1WC/2vaxqpIEzkw5sua39YbQgKZiOTinTlvRxBxY+Etuj2p/Xtq5yzvYpLdeAdv1bi/tVpcT3y0h4vM2LGUf1zSZRM/7k0y29JoHitSbPJ01s801tkEXTiirTqfHJhsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773511; c=relaxed/simple;
	bh=mx+HUEjgAJNMiC9UnPN48IwI2aMt7Q4WkoEfs7332KA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ncqRUMeSYKRFqKBBXyVGAt9T/TNq/KWj09L8tfq3BQZbc+wKz/baxB8W3w+2geJnyKk48MulZFR9NavpWndCI3UxXysDHrhRz4lI2736h5ql1WjwrR6SwNzTQ22SG3evX2vUF6tqM0FYJvS/tgwinRSqWmmilI7yAw0GGwat5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7v4NTKD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717773511; x=1749309511;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mx+HUEjgAJNMiC9UnPN48IwI2aMt7Q4WkoEfs7332KA=;
  b=X7v4NTKDS6+VW7mTYImdN7IaNVh/UeqRIWWU+z0Slg30p4i3tZUpY0lQ
   Wi9T6blpyuzZ/PsR2CxJBrg4Rj1CDSInF7ZUKGSiqsV6GVLUY2zbQvX/C
   xJMDTk+k5b0QF/9JZa/Y2xj4iq29E5vh0moVmVTjbmocwoATO3ZGVul2l
   bwe/j9VuxIdrrCigP+g5WpsZI6yNRsZFxI2LMhs4ziE3MNKZZOkUm54mx
   5SGXOMbgydWjMaV/GRBJMVz5UVWLwmrYgHp4OzRH3Hr5Mv2lcncQElRJR
   z3YGhWZznyXGnF1H5SC0Uyz+hbbZYC1PihEUaBNU40oCtqGNRz93Ylb74
   w==;
X-CSE-ConnectionGUID: fet2cx53Q+K1irDaY+WkBA==
X-CSE-MsgGUID: 0pKbWhI7S2KWhPuFq4p5Qg==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="37028793"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="37028793"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 08:18:30 -0700
X-CSE-ConnectionGUID: sJPDrhkSQHC0MIwJ+Xr9Qw==
X-CSE-MsgGUID: gozCqHLWQa6HT+JxZPxvww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="43295641"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 08:18:30 -0700
Message-ID: <4fe39e45c117a976b60dfb37234551391050b199.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
  Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Date: Fri, 07 Jun 2024 08:18:29 -0700
In-Reply-To: <CAJZ5v0gvY6FGwhzTKrmNnKc48ixWAgTeT3Sw2tOUfshDwq3NcA@mail.gmail.com>
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
	 <101b903e58f2ebae60934edc374c7cda09f83de1.camel@linux.intel.com>
	 <CAJZ5v0jBBgjBny0Ps9bvHc7q1Un_6sdudpNL0==Z5HB+gHH0Hw@mail.gmail.com>
	 <651d11578646200cdb0a91c46ed09a22f29e94a0.camel@linux.intel.com>
	 <1031cc4e4b507628531d9115ce7e4bc588dbab1c.camel@xry111.site>
	 <a2f992adc034063de7f63e9065976f39f9929503.camel@linux.intel.com>
	 <CAJZ5v0gvY6FGwhzTKrmNnKc48ixWAgTeT3Sw2tOUfshDwq3NcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 17:04 +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 5, 2024 at 2:05=E2=80=AFPM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > On Wed, 2024-06-05 at 13:21 +0800, Xi Ruoyao wrote:
> > > On Tue, 2024-06-04 at 09:56 -0700, srinivas pandruvada wrote:
> > > > > > With such a delay, I am not sure how this even worked
> > > > > > before.
> > >=20
> > > It didn't work out of box but it worked after manually writing 0
> > > to
> > > no_turbo after 20 seconds, see
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D218702.
> >=20
> > That make sense. So it never worked out of box. The
> > store_no_turbo()
> > has additional read for turbo flag before, which is removed now. I
> > think adding that back will will restore old behavior.
> >=20
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 4b986c044741..0d5330e5b96b 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -1301,6 +1301,8 @@ static ssize_t store_no_turbo(struct kobject
> > *a,
> > struct kobj_attribute *b,
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no_turbo =3D !!clamp_t(int, =
input, 0, 1);
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 global.turbo_disabled =3D turbo_i=
s_disabled();
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (no_turbo =3D=3D global.n=
o_turbo)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto unlock_driver;
> >=20
> >=20
> > Need to adjust the mutex around it also.
>=20
> Anyhow, it can be made work.
>=20
> global.turbo_disabled can be updated right before it is checked in
> store_no_turbo(), so if 0 is written to no_turbo (and global.no_turbo
> is 1), it will succeed if global.turbo_disabled changes from 1 to 0.
>=20
> Something like the attached (untested) patch.

Should work.

Xi,
Please test so that we can close this issue.

Thanks,
Srinivas


