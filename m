Return-Path: <linux-pm+bounces-34043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E87B469E7
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 09:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BAFD7BC148
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 07:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A8329D27E;
	Sat,  6 Sep 2025 07:22:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CED41E1C36;
	Sat,  6 Sep 2025 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757143364; cv=none; b=AzFFUFXsDQKXvo+3EBZh7TWz4zo5k3jXS1bwluz4NbXURDG9sdpymnyJZS/+fviH4VLfBTaywGKOKdP59nvbM9clOh5JAsxisiYx6voLofiP/0tk9vP8Dd+MCyAs8iYAPGyDgHlng0xZz6P2YqN3TFkvE3L734JwNRXa8wO39NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757143364; c=relaxed/simple;
	bh=z3wEUM6ZTGo7NsZBCM2TCyduncJiSvSfcxNC6uwKDNI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RC4hKjnDEPyRdby3LIDjkBAE4O6Zrl0NkCRgg19QsLwqs5W3KpgzXn2O4LNJZCoRd9CkTXEfv61bh6e1js23zaiNEyeHiAL0Yyq6T6uKnmoAhFo0PtEEuBANTF085iWBxbQQG7X3usP12DCL9osN1pSeDU8P6Jrrzv3WJdrbt1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 2A6CD119B08;
	Sat,  6 Sep 2025 07:13:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 152BA17;
	Sat,  6 Sep 2025 07:13:43 +0000 (UTC)
Message-ID: <99c1c03a9f7fe55b8f73e5574612dc3e1cd1af55.camel@perches.com>
Subject: Re: [PATCH] cpuidle: sysfs: Use sysfs_emit/sysfs_emit_at instead of
 sprintf/scnprintf
From: Joe Perches <joe@perches.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: vivek yadav <vivekyadav1207731111@gmail.com>, daniel.lezcano@linaro.org,
 	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date: Sat, 06 Sep 2025 00:13:41 -0700
In-Reply-To: <CAJZ5v0iAfgE4RkVXH7GaG9SqvGa0VfVuFi_cLd0utC8oPY0Fkg@mail.gmail.com>
References: <20250825185807.57668-1-vivekyadav1207731111@gmail.com>
	 <CAJZ5v0gfrTvLgs=PdmRbRRN05GE4Bk8Q7hJdtQfyk3VqaOz7FQ@mail.gmail.com>
	 <CABPSWR5cG=xTA72BHayYQTb=24VS3N+=dbsiMcU+gyqTKvNXAQ@mail.gmail.com>
	 <2fb11c0970da307cf8cf4f35d35c49f78f82ee72.camel@perches.com>
	 <CAJZ5v0iAfgE4RkVXH7GaG9SqvGa0VfVuFi_cLd0utC8oPY0Fkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: cqewjykworib1yix18r9kbwfax3r4xi5
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 152BA17
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19qMCdMmYR5ykQp5lznnzjF8qLBBYNDgAw=
X-HE-Tag: 1757142823-731849
X-HE-Meta: U2FsdGVkX198UeZyNXLpgOuzRAAH0fDsPr/Hfy8Z2vadC2koHcwD55z9vV+4CkRjdDu1z5VPlimwJHzgAgk+ASRkXxG52ouVvdcNR9thn6DMv1QxMA5E84ZXYY6M1MNvh6YK13Wz1tUfL/wMNN0vc/4AAbWbUyJKFUhpXRzX4y3GXU/lAFu98E03FobkN76NCZ0ydLwAFjcmx9+hfzcrZoHu+5WRbPAqIUxpd8DkJeP91rRnYhixZGvhT4dDN1yk9L1NW3uMQypq+ZtOj51AtOSZBn406XHhpKzVeLaNqhARKIGx6xOtDWIYE5uGvSOYqcdTMKQH6/FW/2bNOYrhNlexpHid9KnXhFwmSl3f06UoHq4OsFmgcNrfTsFwEjkOzLMWQH2+J59HwN878/aI/A==

On Fri, 2025-09-05 at 20:34 +0200, Rafael J. Wysocki wrote:
> On Fri, Sep 5, 2025 at 8:22=E2=80=AFPM Joe Perches <joe@perches.com> wrot=
e:
> >=20
> > On Fri, 2025-09-05 at 22:57 +0530, vivek yadav wrote:
> > > On Mon, Aug 25, 2025 at 8:58=E2=80=AFPM <vivekyadav1207731111@gmail.c=
om> wrote:
> > > > >=20
> > > > > From: Vivek Yadav <vivekyadav1207731111@gmail.com>
> > > > >=20
> > > > > The ->show() callbacks in sysfs should use sysfs_emit() or
> > > > > sysfs_emit_at()
> > []
> > > > > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> > []
> > > > > @@ -22,21 +22,21 @@ static ssize_t show_available_governors(struc=
t device *dev,
> > > > >                                         struct device_attribute *=
attr,
> > > > >                                         char *buf)
> > > > >  {
> > > > > -       ssize_t i =3D 0;
> > > > > +       ssize_t len =3D 0;
> > > >=20
> > > > The variable rename is not necessary or even useful AFAICS ->
> > >=20
> > > There is no harm if we leave the variable name as 'i' but it would be=
 better
> > > if we give it a suitable name like 'offset'. It will definitely impro=
ve
> > > readability.
> >=20
> > size and len are most commonly used.
> > I prefer len.
>=20
> Fine, in new code, use whatever you like, but what really is the
> reason for doing a rename in code that has been almost unchanged since
> 2.6.22?

If a sprintf -> sysfs_emit conversion is done, it's IMO better
style to be consistent with the typical sysfs_emit uses.

