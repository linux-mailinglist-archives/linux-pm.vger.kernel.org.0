Return-Path: <linux-pm+bounces-8808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5AF901123
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 11:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C631F22B97
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2024 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48261411E6;
	Sat,  8 Jun 2024 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="WKj8JVl6"
X-Original-To: linux-pm@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9281B10A1A;
	Sat,  8 Jun 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717839066; cv=none; b=eFEAgFxlXzuUaGoiS9qbD8S7ozrHcEHd/cfXrRwA06LgR6EVsIerF0HKDlFNhPzGnSa0FrmdlR/b9myrfQawSgPuWaH2d5FIJyFjH7BHQ++P+1TpNuefKa4BzJTg7/jRXuaigFEwkIjYcc4anH/ssGR1O6aCTmlx9jur96Hu8EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717839066; c=relaxed/simple;
	bh=xsEQ4RbKUCCvCOLijKx+rrLpk6s3nFjLGIQkMHpDzro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HG1LWZsbms751pQKovMU6V20FWzt1fJKFu+JVV4+eTD657n5/W3ifBJ9DcOORk9sD1Mfv6+bF3EVE/X4QT8OQrVrC1VGvPB6DCVo9f1ohyudozQ/L1MsDMnmL1KyleuHelwWRcic8O5XInLLUpXfgugUC6XbrUMTslTKyU7LwC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=WKj8JVl6; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717839057;
	bh=xsEQ4RbKUCCvCOLijKx+rrLpk6s3nFjLGIQkMHpDzro=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WKj8JVl64i+29XvnAOfZLe0+B7Pb6ZuHx2kNBskgqIcineM5NslulL7aZX43FJUnA
	 sXox9Hy152zqbomhx/C84077XN4L5rGiZRAMryW3cvutV8WGJPK+1//V10VIx8sw2o
	 rYKkbAkRWbcBJJKjQjEYMmWNhD4FZZb+UO2t2XpQ=
Received: from [IPv6:240e:358:1149:1500:dc73:854d:832e:6] (unknown [IPv6:240e:358:1149:1500:dc73:854d:832e:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D896A6709E;
	Sat,  8 Jun 2024 05:30:54 -0400 (EDT)
Message-ID: <4179689cade0b26bb412d6aef2f695664d16a6eb.camel@xry111.site>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: Xi Ruoyao <xry111@xry111.site>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Date: Sat, 08 Jun 2024 17:30:50 +0800
In-Reply-To: <4fe39e45c117a976b60dfb37234551391050b199.camel@linux.intel.com>
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
	 <4fe39e45c117a976b60dfb37234551391050b199.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 08:18 -0700, srinivas pandruvada wrote:
> On Fri, 2024-06-07 at 17:04 +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 5, 2024 at 2:05=E2=80=AFPM srinivas pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >=20
> > > On Wed, 2024-06-05 at 13:21 +0800, Xi Ruoyao wrote:
> > > > On Tue, 2024-06-04 at 09:56 -0700, srinivas pandruvada wrote:
> > > > > > > With such a delay, I am not sure how this even worked
> > > > > > > before.
> > > >=20
> > > > It didn't work out of box but it worked after manually writing 0
> > > > to
> > > > no_turbo after 20 seconds, see
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D218702.
> > >=20
> > > That make sense. So it never worked out of box. The
> > > store_no_turbo()
> > > has additional read for turbo flag before, which is removed now. I
> > > think adding that back will will restore old behavior.
> > >=20
> > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > b/drivers/cpufreq/intel_pstate.c
> > > index 4b986c044741..0d5330e5b96b 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -1301,6 +1301,8 @@ static ssize_t store_no_turbo(struct kobject
> > > *a,
> > > struct kobj_attribute *b,
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no_turbo =3D !!clamp_t(int=
, input, 0, 1);
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 global.turbo_disabled =3D turbo=
_is_disabled();
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (no_turbo =3D=3D global=
.no_turbo)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto unlock_driver;
> > >=20
> > >=20
> > > Need to adjust the mutex around it also.
> >=20
> > Anyhow, it can be made work.
> >=20
> > global.turbo_disabled can be updated right before it is checked in
> > store_no_turbo(), so if 0 is written to no_turbo (and global.no_turbo
> > is 1), it will succeed if global.turbo_disabled changes from 1 to 0.
> >=20
> > Something like the attached (untested) patch.
>=20
> Should work.
>=20
> Xi,
> Please test so that we can close this issue.

Yes it restores the old behavior for me.

Tested-by: Xi Ruoyao <xry111@xry111.site>

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

