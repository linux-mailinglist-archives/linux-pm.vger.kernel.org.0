Return-Path: <linux-pm+bounces-20157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87229A08007
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 19:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9CD3A137A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 18:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83611198A32;
	Thu,  9 Jan 2025 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qc3IwZD2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002413B2B8
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448179; cv=none; b=HKNJJVOGCYO75wpLXvhFcdstyqg5mEsuPZ0KDfFhjsSbTEihNYn6QDojj8zo3P3pdgkFjCh1pKKoSsnHcjJlvEJPd5/BfN8mw9nxxaT3JFM3LVv6x521oyDy2NkVifJchIi80uWg8KLeDhE7R8ii/B1x0xYblOoSLDMeYyKAnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448179; c=relaxed/simple;
	bh=sTrATi7ahw33CEx7l9/LUPW/DbrfMMAukGZQwB1DkjA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kTgWPDiLbCU2Colj88RFH00eGJ/DNUC9Gm4XvLW4hqhOVuvblKnQ0unypRmypq4ItacaCLYW9xnKPu0BpE5PQpPbHTsniQftoL7ou/rjObyCLv0zaY9Hrez/D9dOIUXw5NjeqCZvOALJjICsTPq4Db9VP6MfTIIU835CxHTCMiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qc3IwZD2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736448177; x=1767984177;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=sTrATi7ahw33CEx7l9/LUPW/DbrfMMAukGZQwB1DkjA=;
  b=Qc3IwZD2z+8627ZkMfs/Y+8iyru4tm3VV1h6QCLr3TYNUmm+/VQQmN7l
   +YAsZ2TY3A/ZK29EnDA3nwP8TYUe+9RJuXrjPeWsEbBZEJR/+c7mTHWhr
   FMGlKw96fiWJx10afAPEDJjCbT1cK8PLhe0tIWxgEoNGH8beAdRmO3aij
   sL02jekkKW5Crw9skJ+FMddArGnxXSsUgeoacihC3xnqik7UmsJoXdZv6
   n2Nk2oW7yWB5tCbTKBIIqSRAXhWZQrdW5aiDukX1HAOSwp6eASAyqe1/3
   dXk5FuCpn3cf9gcCl+i0Mviyd51HMpxc/k+s6ck6VyKBahaH0KV7pF6av
   Q==;
X-CSE-ConnectionGUID: d7SsAfXXTEmwp7fCYjjYiQ==
X-CSE-MsgGUID: ZW7NqMcRSGqltYTmyhhoyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36886265"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36886265"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 10:42:57 -0800
X-CSE-ConnectionGUID: JH0G53PPR2aZW3NIz/YVyg==
X-CSE-MsgGUID: XkhJLy8JRo2DXMnUgRxWwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134385195"
Received: from spandruv-desk2.amr.corp.intel.com (HELO [10.124.222.26]) ([10.124.222.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 10:42:56 -0800
Message-ID: <c33fda7bde0b7fed4d47a3d1fc46e448bf8f99ff.camel@linux.intel.com>
Subject: Re: [bug report] powercap: balance device refcount in
 powercap_register_control_type()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Joe Hattori
	 <joe@pf.is.s.u-tokyo.ac.jp>
Cc: linux-pm@vger.kernel.org
Date: Thu, 09 Jan 2025 13:42:55 -0500
In-Reply-To: <9d85c85f-c520-4e69-a412-22aaae7ba414@stanley.mountain>
References: <97c5c93d-e31e-483b-83c3-28b797b69e9a@stanley.mountain>
	 <68cdb73b-59cd-47be-9bc1-9affa606ba8f@pf.is.s.u-tokyo.ac.jp>
	 <9d85c85f-c520-4e69-a412-22aaae7ba414@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi All,

On Thu, 2025-01-09 at 11:31 +0300, Dan Carpenter wrote:
> On Thu, Jan 09, 2025 at 09:36:43AM +0900, Joe Hattori wrote:
> > Hi Dan,
> >=20
> > Thank you for the report.
> >=20
> > On 1/8/25 19:11, Dan Carpenter wrote:
> > > Hello Joe Hattori,
> > >=20
> > > Commit cae442480e40 ("powercap: balance device refcount in
> > > powercap_register_control_type()") from Dec 15, 2024 (linux-
> > > next),
> > > leads to the following Smatch static checker warning:
> > >=20
> > > 	drivers/powercap/powercap_sys.c:632
> > > powercap_register_control_type()
> > > 	warn: freeing device managed memory (UAF):
> > > 'control_type'
> > >=20
> > > drivers/powercap/powercap_sys.c
> > > =C2=A0=C2=A0=C2=A0=C2=A0 622=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0 623=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mutex_init(&control_type->lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0 624=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 control_type->ops =3D ops;
> > > =C2=A0=C2=A0=C2=A0=C2=A0 625=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 INIT_LIST_HEAD(&control_type->node);
> > > =C2=A0=C2=A0=C2=A0=C2=A0 626=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 control_type->dev.class =3D &powercap_class;
> > > =C2=A0=C2=A0=C2=A0=C2=A0 627=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 dev_set_name(&control_type->dev, "%s", name);
> > > =C2=A0=C2=A0=C2=A0=C2=A0 628=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 result =3D device_register(&control_type->dev);
> > > =C2=A0=C2=A0=C2=A0=C2=A0 629=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (result) {dev_release
> > > =C2=A0=C2=A0=C2=A0=C2=A0 630=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_device(&contr=
ol_type->dev);
> > >=20
> > > The patch adds this call to put_device() based on static analysis
> > > but
> > > I'm pretty sure that will lead to a double free so the patch
> > > should be
> > > reverted.
> > >=20
> > > We can see on line 626 that the class is powercap_class, so
> > > put_device() will call powercap_release().=C2=A0 The means that
> > > control_type
> > > will be freed.
> >=20
> > Indeed, I missed that.
> >=20
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 631=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (control_type-=
>allocated)
> > > --> 632=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 kfree(control_type);
> > >=20
> > > Use after free and double free.
> >=20
> > Instead of reverting the patch, How about removing these two lines
> > to avoid
> > the double free (so that mutex_destroy() is called in the cleanup
> > function
> > as well. Not that it makes that big of a difference though). If
> > that is ok
> > with you, I will work on a patch to fix it.
> >=20
>=20
> What you are suggesting *sounds* like the correct thing to do, but
> surely the original author thought of that too?=C2=A0 Except the original
> code was written 15 years ago and that was a completely different era
> so maybe that explains it?=C2=A0 We could CC Srinivas and see if he
> remembers this code that he wrote back when he was still a child.
>=20
Indeed, long time back during 3.14.
Looking at 3.14, callers of device_register(), on failure there was no
call to put_device().
So if device_register fails then this memory needs to be freed.
If I look at code now, put_device() is called.

Looking at the code of device_register(), the need of this free will be
only required if the call to get_device() fails. But get_device() can't
fail here.
After call to get_device() the put_device() should call dev_release(),
so we can remove code at line 631-632.


Thanks,
Srinivas

> I don't know this code well enough to be confident.
>=20
> regards,
> dan carpenter
>=20
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 633=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(re=
sult);
> > > =C2=A0=C2=A0=C2=A0=C2=A0 634=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0 635=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 idr_init(&control_type->idr);
> > > =C2=A0=C2=A0=C2=A0=C2=A0 636
> > > =C2=A0=C2=A0=C2=A0=C2=A0 637=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mutex_lock(&powercap_cntrl_list_lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0 638=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 list_add_tail(&control_type->node,
> > > &powercap_cntrl_list);
> > > =C2=A0=C2=A0=C2=A0=C2=A0 639=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mutex_unlock(&powercap_cntrl_list_lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0 640
> > > =C2=A0=C2=A0=C2=A0=C2=A0 641=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return control_type;
> > > =C2=A0=C2=A0=C2=A0=C2=A0 642 }
> > >=20
> > > regards,
> > > dan carpenter
> >=20
> > Best,
> > Joe
>=20


