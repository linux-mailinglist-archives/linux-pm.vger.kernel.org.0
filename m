Return-Path: <linux-pm+bounces-11540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4573993F6B8
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 15:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D551C21DF1
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 13:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6281C152787;
	Mon, 29 Jul 2024 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIsfwdWt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3216145B27;
	Mon, 29 Jul 2024 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259875; cv=none; b=mYBiOjV3Z/rx0qTUVh7HiIUbpLw7K6hRurbITa04Ux35BKl/eziBV2bi94BvaML57HR1/wuXf7oKSRBq8iBWPm1yolQhZDLEZF9sAAquJneUG3UXb1jCY5+vgrjtjxayEaJQGs+laM2r/Vx7yhwreDCHYMqbNSFXRX+CT+DYMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259875; c=relaxed/simple;
	bh=dC4StydkvhN4D2FnulCowDb8t4nCXLe2HWtCaL9svbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxgDw684swh9a7zMdB3LmX3bAzUEvwegyQgLEGAqCXlCQmPsYedKQOu05JGb1cCWFclRqO1pkzBq67aGXKHupJVOnwJW/pxZEp+vdntzpwk8H4VaKMmDVu+GRjJxIczgAzyMkkCKw+m+tOLadt+IkP4g4JjaJqxh6ACV+cfoLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIsfwdWt; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f0271b0ae9so44472441fa.1;
        Mon, 29 Jul 2024 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259872; x=1722864672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOY+AlMeRwJs0YCYC6hzJCvRhv1dC+GmSx9gBu2yiuA=;
        b=eIsfwdWtksxaDwol+JBUEY3S1XHvPGcSGVyUMgOsgZJFrl3rN15ZC45ghAujJha5KB
         1iabPY7jskcKdleR4DdUaEOxy+pdybhQMqjA87Cxmeci07YlyPK+0nhmlI7xwWy+zOF0
         GWtsNpBTY6Ulb+Sq+UOh0PyazL8VkzIB1opFoxenvzzum9dN09xvFNEOPX3HdC709gL0
         hLXP7LK5y5+JjuMWRpWKr9ERc2nTk1Z/I5/akZJNFHSHMirjiXH2j420QhjsaFc9lfaq
         EHEoBgUR9myBjvM+X60PXYPWqKMtFdFqoPj7rSeU0IA2lw7esCNSbwk0/6liK7jwooHa
         Qh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259872; x=1722864672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOY+AlMeRwJs0YCYC6hzJCvRhv1dC+GmSx9gBu2yiuA=;
        b=RcOA5tiT4RQt3oZ1WsZZ/WDFoN1Jc5o3BQEaf4TIbZ96fWgeRH5YBNijqF3excTcZt
         /JOQH6TWZCRXG5Gf1Ur6zn0syPO615rhSgljeYqe+1Ik4XzBOVtPcVUR5jSugvGK5mQW
         RaIW6/0MbnGo+DpcwjfiGhcXSfPMbDtgJUGby2sEIMoU/jUxnD/TH6m51RXtflzN3K3f
         5T1v/tlzqn+XPDOPKeg8VlbcV5g546DWOXq5PyzOMJtt+R//sc59HiAn9QWGx9dxxrcx
         Q02ZMSw/vCqfGCih4Dtw2Oy678hBr/RNrI3KYDXPyMVRZ9jhxj65tKwK1whiYfCpn9gj
         i9dg==
X-Forwarded-Encrypted: i=1; AJvYcCWTn7UysmnOl14qiMu5eow3ItLw4M4zs19aci6C4/b/g4S3fU2dF/qmejXpdcdxeGyOVj5TMSisWy+DBPzTZIts7QR1edOT2AlZFGcMKhAh/whotGhCFLs/iBkjhrnsgHBBy+2HqaVZ5RzC7D/IFq+QhGYPttaWse5IbSoXpi6UsGl7D2KXmAaT
X-Gm-Message-State: AOJu0YzvP++cpCg708x1gcCFlcKCpUZ2YsOATE86Aeb9seNmTc57Gc8J
	XnuSn7j39EVJP0qgwQafOqjl4WAHXOEb8mWaivUdlVLE7CNYmz52lbv03yvdQNcHtYXTJaKpIKH
	YZap/1AUUEYCx2hvd4VaLoam8WwM=
X-Google-Smtp-Source: AGHT+IEkj8gJtt7Xa/PRg0sMhXYsUI0z5cB0Kqpuw44BH7fbPSlxtdi/VtkbDXSJ+OEuJ4+ru7ds3EoONnjafiZrjfk=
X-Received: by 2002:a2e:8710:0:b0:2ef:2f60:1950 with SMTP id
 38308e7fff4ca-2f12ee1bdf2mr47796711fa.30.1722259871270; Mon, 29 Jul 2024
 06:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <su3wp6s44hrxf4ijvsdfzbvv4unu4ycb7kkvwbx6ltdafkldir@4g7ydqm2ap5j>
 <aa9d6aec-ef94-4137-b2ff-0c86d9a92d42@molgen.mpg.de> <CAA8EJpqGXe0A0yDpEP==60k-bPEbDORpLUtsiPvGSi+b_XphAg@mail.gmail.com>
 <CABBYNZJP2c4L-nFHtug0isqnKPR+Q0CE09o_ACsPLobjLpHtcg@mail.gmail.com> <CAMRc=McB1hY+Lad-gBj9-_Ve2OeW+rXaRqHL2xO4zDPMRD41jw@mail.gmail.com>
In-Reply-To: <CAMRc=McB1hY+Lad-gBj9-_Ve2OeW+rXaRqHL2xO4zDPMRD41jw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Jul 2024 14:30:57 +0100
Message-ID: <CABBYNZJXgJmfe=o2bgj_Gs1wsD=OQRokEkzVRc_OhBs5-_+Dww@mail.gmail.com>
Subject: Re: btqca: crash with linux-next on bt power down
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Paul Menzel <pmenzel@molgen.mpg.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, regressions@lists.linux.dev, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

On Mon, Jul 29, 2024 at 12:58=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> On Mon, Jul 29, 2024 at 1:56=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Dmitry,
> >
> > On Mon, Jul 29, 2024 at 12:01=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > #regzbot: introduced:
> > > 973dd9c4db4746200f88fe46e30eada7054fdbea..84f9288208dfcd955446060a53a=
dd15b9e01af4e
> > >
> > > On Mon, 29 Jul 2024 at 13:21, Paul Menzel <pmenzel@molgen.mpg.de> wro=
te:
> > > > Am 29.07.24 um 04:11 schrieb Dmitry Baryshkov:
> > > >
> > > > > On Qualcomm Dragonboard 820c (APQ8096, QCA6174) soon after the bo=
ot I
> > > > > observe the following crash:
> > > > >
> > > > > Unable to handle kernel NULL pointer dereference at virtual addre=
ss 0000000000000018
> > > > > Mem abort info:
> > > > >    ESR =3D 0x0000000096000006
> > > > >    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > > >    SET =3D 0, FnV =3D 0
> > > > >    EA =3D 0, S1PTW =3D 0
> > > > >    FSC =3D 0x06: level 2 translation fault
> > > > > Data abort info:
> > > > >    ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000
> > > > >    CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > > > >    GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > > > > user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000010da63000
> > > > > [0000000000000018] pgd=3D080000010da62003, p4d=3D080000010da62003=
, pud=3D080000010da61003, pmd=3D0000000000000000
> > > > > Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> > > > > Modules linked in: hci_uart btqca
> > > > > CPU: 2 UID: 0 PID: 66 Comm: kworker/u19:0 Not tainted 6.10.0-next=
-20240726-13923-gd3ce7ebd61f9-dirty #2722
> > > >
> > > > I am unable to find the commit. Your tree also seems dirty. What is=
 the
> > > > last working commit?
> > >
> > > Checked the commit range on the linux-bluetooth branch, hope this hel=
ps.
> >
> > Im currently traveling so it would take some time for me to
> > investigate this but I suspect it could be some of the changes
> > introduced by Bartosz with power sequence, @Bartosz Golaszewski
> > perhaps you can help?
> >
>
> Hi!
>
> I just came back from last week's vacation to a bunch of different
> regressions. I will get to it but it may be later this week.

Thanks, looks like there were other reports saying QCA driver is not
working which perhaps is related.

> Bart



--=20
Luiz Augusto von Dentz

