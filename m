Return-Path: <linux-pm+bounces-18764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C88D9E851B
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B552815E6
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068B146D6E;
	Sun,  8 Dec 2024 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+oQBo/a"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5A545BEC;
	Sun,  8 Dec 2024 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662412; cv=none; b=q+fSnc9Blo4WyJkV9t0ALb/lsipP4BWDDB7WZ4lVd/KGFauV5+l+dj0oAQj8n+AsB/ygbxLD4RF335/alipVnPHLwW3uVwr9b2X4r2BE9dtrLjYWLNQHhBvslAQYI05pNnUSMMpL9ttAAKoOmkNJUTa2HwL/SazRVXOMfZjDwkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662412; c=relaxed/simple;
	bh=Yx900HJVTUyYPR7FkyIH9aTbaonayusFBDIiHQD6H48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKFZJS3OP3RAKPEjdjDPmGN+iw2DyaNjtXc6SbQtL5Rx9ku1QEWnzkTCknbnribwPfUZ1mJAVnBKTuG+vn2TADV0JM7quM4Ao2LawkbTuSgjUNQbdjhyYDnj0pfp7JDjQLJtrwYxp4+vzyjjYFAkBw2qZkxJlSscI3Z3DRMF+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+oQBo/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501FEC4CEE1;
	Sun,  8 Dec 2024 12:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733662412;
	bh=Yx900HJVTUyYPR7FkyIH9aTbaonayusFBDIiHQD6H48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V+oQBo/avRNunACKzvOLpD9MGxZt6gf4A4w129BuF7nKnhrt5kUIqFyD9CHuYgf0O
	 LBx0OO62mUzoOtmtRul/CQZCWiGEBZtdONURXbXFrhQKzNhnIs5DA3bM8dHHitOctV
	 4VrGCwUbJSQQiHv2tbo0eULB29PNdtWFkUALoZtj4/yLQ+F5eteIO4JPEVFO6g9wiM
	 +oKMiBTAT9SUGU0CmnGopZmj1fY4DdFTcYwTbxi0ERUUBSCqNaE2GLaTVu8mrb2zt6
	 6pTfH4pPJgWb6Qztb81qM2vdMzZy0G6umauv1vBkVONZgyM4ckFF+QUVKHZAk0NV08
	 eWKUJhYDWLFuQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so4290707a12.1;
        Sun, 08 Dec 2024 04:53:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0qg9/8VwZZw2SPDVjt09IhDYKkF7OspHEEC+fy0cq/t3cCTqAcbJOK29xEmZs2srwKQQd2DbidrE=@vger.kernel.org, AJvYcCVkDIbyf4EEUPuskCZJRUgKG6GRNGtoGxX5zGBEixdPp4HD3Rtgj80bDz8tazd/ic0S4eE4YRR7Qts=@vger.kernel.org, AJvYcCW7iAPSGcAIdHpQoCS/NK/YWS1/a5GjRZy89ibA2n85KRmqz6vvXsdnmzCn1tsBHo2g9AXi5Gw2gB1HA5j2@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoDj8XLimZC/81Qi9gfsf07mbtRvvMfoaJikcUTNLeJLCB6Yo
	oKZ8acY7VJ4YF1cgKKQBe5Y7K9tyYcAFj7QF+mQNqbuThLgedrKEx3b+/s35Clj3pyzSXQOD5WE
	umr/LcNzDIdZ5xXU9efdjtXCr6Cw=
X-Google-Smtp-Source: AGHT+IGwo7Cy4yY8H60EoHZMYS7t82Hdhwwmgp/hd1/GR1huLk0AH+TGZqGgIYbuBP00Q1axVqFfkmsD6Ysrxn1jt0A=
X-Received: by 2002:a17:906:1ba1:b0:aa6:4a5b:b72d with SMTP id
 a640c23a62f3a-aa64a5bb77emr500626766b.23.1733662411114; Sun, 08 Dec 2024
 04:53:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0iWPCzjv9YQ4kO_@gallifrey> <20241028021344.477984-1-linux@treblig.org>
 <CGME20241128161146epcas1p46768d7685092deaa817119db30fd12f2@epcms1p4>
 <20241207052209epcms1p45818db425ba84821003b6d735bc0e957@epcms1p4> <Z1RD3Ec1IJ2jY5TZ@gallifrey>
In-Reply-To: <Z1RD3Ec1IJ2jY5TZ@gallifrey>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sun, 8 Dec 2024 21:52:44 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3YkBOruDcqj8gAy0jVzdsESJo0ntL4SF9ooR_QiFjgVA@mail.gmail.com>
Message-ID: <CAGTfZH3YkBOruDcqj8gAy0jVzdsESJo0ntL4SF9ooR_QiFjgVA@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Remove unused devm_devfreq_(un)register_notifier
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 9:47=E2=80=AFPM Dr. David Alan Gilbert <linux@trebli=
g.org> wrote:
>
> * MyungJoo Ham (myungjoo.ham@samsung.com) wrote:
> > >* linux@treblig.org (linux@treblig.org) wrote:
> > >> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > >>
> > >> devm_devfreq_register_notifier() and devm_devfreq_unregister_notifie=
r()
> > >> have been unused since 2019's
> > >> commit 0ef7c7cce43f ("PM / devfreq: passive: Use non-devm notifiers"=
)
> > >>
> > >> Remove them, and the helpers they used.
> > >>
> > >> Note, devm_devfreq_register_notifier() is still used as an example
> > >> in Documentation/doc-guide/contributing.rst but that's just
> > >> an example of an old doc bug rather than anything about the function
> > >> itself.
> > >>
> > >> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > >
> > >Ping.
> > >
> > >Thanks,
> > >
> > >Dave
> >
> > When I search github, it appears that vendors are using this API.
>
> Hmm OK.
> Of course there's a lot of random junk on github, so it can be tricky
> to know what's current/real/relevant.
>
> > NVIDIA:
> > https://github.com/NX-Development/android_kernel_nvidia_nvidia/blob/c9a=
de3b5e32a12b8cf6f33a632dc39209194e4e8/drivers/devfreq/governor_wmark_active=
.c#L624
> >
> > Samsung:
> > https://github.com/Vaz15k/android_kernel_samsung_a54x/blob/8ac517c37c60=
6746213064857dc240e99eba80d2/drivers/soc/samsung/exynos-llcgov.c#L107
> >
> > Realtek:
> > https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/25f5b88ec4ba34029f96469=
3dc34028b26e6c67c/linux-rtk/drivers/devfreq/realtek/governor_rtk_ltl.c#L114
> >
> >
> >
> > Please don't remove ABIs used by vendors even if
> > they didn't upstream their drivers.
>
> Hmm OK.
> Do you think they should be using this ABI or do they have the same bug a=
s
> is fixed in 0ef7c7cce43f ?
> I guess they don't care.


According to Myungjoo's comment, I'll keep this code.


Thanks,


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

