Return-Path: <linux-pm+bounces-34011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E169B4622E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 20:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7381CC6BEA
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 18:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAAD33E7;
	Fri,  5 Sep 2025 18:22:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA8A305942;
	Fri,  5 Sep 2025 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096576; cv=none; b=rOG7mxWExmbVLP/iphjDnZGFlRMv19bWHjhXEzJQs1G2p+Rv0zCHshN8laXZQgbz4HgUta8OVU1pPuoLP2XfhFcOhrxssoiktGqdHOHR7zIE/kasc10lVaGEEEezeAQy4smYYYc66kQurbBsbC8AD5qNK+XmcgpOJRYFCPWCLUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096576; c=relaxed/simple;
	bh=YXugIXDvzgH0T8admNprqbqsP9NWY611ZTkKhOao8po=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0n7hzomi5mFgyEo8ObgLQESuhhs9ppAx7UUbLD/y8vgNzyE+wNdzZYznDiVTGp+GSgLTGg3jZ7VV/MOPwspzTnrR32deOI3vgNBH7W1Ou6+gl8wkJcninDUSk2l0vex87a2NqGppqLkcMZx+h/y8b+v93rfQTMD04W8PGSSMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 96D0D11681A;
	Fri,  5 Sep 2025 18:22:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id B88A42F;
	Fri,  5 Sep 2025 18:22:45 +0000 (UTC)
Message-ID: <2fb11c0970da307cf8cf4f35d35c49f78f82ee72.camel@perches.com>
Subject: Re: [PATCH] cpuidle: sysfs: Use sysfs_emit/sysfs_emit_at instead of
 sprintf/scnprintf
From: Joe Perches <joe@perches.com>
To: vivek yadav <vivekyadav1207731111@gmail.com>, "Rafael J. Wysocki"
	 <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Date: Fri, 05 Sep 2025 11:22:44 -0700
In-Reply-To: <CABPSWR5cG=xTA72BHayYQTb=24VS3N+=dbsiMcU+gyqTKvNXAQ@mail.gmail.com>
References: <20250825185807.57668-1-vivekyadav1207731111@gmail.com>
		 <CAJZ5v0gfrTvLgs=PdmRbRRN05GE4Bk8Q7hJdtQfyk3VqaOz7FQ@mail.gmail.com>
	 <CABPSWR5cG=xTA72BHayYQTb=24VS3N+=dbsiMcU+gyqTKvNXAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: B88A42F
X-Stat-Signature: wqf68ytbt8ke1b5usikkix3idkpwhjcb
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX190gCcJSH3CDUgVXfu7PWqUHuTQCA1oICA=
X-HE-Tag: 1757096565-205781
X-HE-Meta: U2FsdGVkX1+d8z0Ym18OmbD0TO1zVFKrX7IBhNNFwahH3KYF8Cf7fyvKTHMRLUadvsh7T3n5c82LK2Z+7N1LiHLU/NInTCXrgbbITaHWc9rnftWWHmksqcjGeMbflhN2S2OrOi1lvSPYIKjsOKJPz2wC0ESQuTZXZR+0XbKyfQUAN9vwR0dTSIxsRuVXSHjummzSGch3Ycj6L4yCbLvTsu6HMtGpDHsbC8tBqxjHyvxrVuivu2lURe2s4EWitruyi3tPk/VV1Fw20rwLDLQhsin6slU4p8gKPtU33m4bluFv/CzaXyH4Rvh1bE4Y/A1DsVm9fzZApU8Kp4sR5F5Vn0bsvXnp1zz7

On Fri, 2025-09-05 at 22:57 +0530, vivek yadav wrote:
> On Mon, Aug 25, 2025 at 8:58=E2=80=AFPM <vivekyadav1207731111@gmail.com> =
wrote:
> > >=20
> > > From: Vivek Yadav <vivekyadav1207731111@gmail.com>
> > >=20
> > > The ->show() callbacks in sysfs should use sysfs_emit() or
> > > sysfs_emit_at()=20
[]
> > > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
[]
> > > @@ -22,21 +22,21 @@ static ssize_t show_available_governors(struct de=
vice *dev,
> > >                                         struct device_attribute *attr=
,
> > >                                         char *buf)
> > >  {
> > > -       ssize_t i =3D 0;
> > > +       ssize_t len =3D 0;
> >=20
> > The variable rename is not necessary or even useful AFAICS ->
>=20
> There is no harm if we leave the variable name as 'i' but it would be bet=
ter
> if we give it a suitable name like 'offset'. It will definitely improve
> readability.

size and len are most commonly used.
I prefer len.

$ git grep -P -oh '\w+\s+\+=3D\s*sysfs_emit_at' | \
  sort | uniq -c | sort -rn
    361 size +=3D sysfs_emit_at
    187 len +=3D sysfs_emit_at
    144 n +=3D sysfs_emit_at
     69 count +=3D sysfs_emit_at
     60 rc +=3D sysfs_emit_at
     51 offset +=3D sysfs_emit_at
     43 ret +=3D sysfs_emit_at
     27 rb +=3D sysfs_emit_at
     16 res +=3D sysfs_emit_at
      7 pos +=3D sysfs_emit_at
      7 i +=3D sysfs_emit_at
      5 length +=3D sysfs_emit_at
      4 used +=3D sysfs_emit_at
      4 nchars +=3D sysfs_emit_at
      4 at +=3D sysfs_emit_at
      3 sz +=3D sysfs_emit_at
      3 l +=3D sysfs_emit_at
      3 buf_len +=3D sysfs_emit_at
      2 status +=3D sysfs_emit_at
      2 idx +=3D sysfs_emit_at
      1 n_written +=3D sysfs_emit_at
      1 cnt +=3D sysfs_emit_at

