Return-Path: <linux-pm+bounces-20141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F179A074E2
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 12:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7402B16858D
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 11:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470A216E10;
	Thu,  9 Jan 2025 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHKnm668"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFF4216E01
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422755; cv=none; b=TyGcWDNQuxyZNxEOCzfylLkTcKNihE1jodEf4cTMNc2RXbfJgQwEO9VRQwKkoJ4zE2tKGYlkFMTfmiyYLZq9r/nUhYjNJcou0t8UeZSi0b51e/yycERvSohEU0FDHvRkRFqt6KLNigD8kJ7uuNvoUl7QbrTlgFRVH+ymexmcyTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422755; c=relaxed/simple;
	bh=DXE2So2Py5XRjf84OhnQg7rvzaZdP9MRRVPhI7d2j1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8JrIusFPXrrWBMwcb77hPs7H5lTt7Sx4ycUU+FeUpydau42ueZ+CiOg23urECPP5fo8cpxcMSwi1UtKNZxnOf7r4PpBryZA5z8D9ts7brVmd8lTvfo7qzWQzPM+lqoiNWwnwsnemOmt0eatahWepQkuTLkeOd9PY472bFUre/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHKnm668; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EF3C4CED2
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 11:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736422754;
	bh=DXE2So2Py5XRjf84OhnQg7rvzaZdP9MRRVPhI7d2j1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DHKnm668LZloOjr8HB9l3i3Ph2SMcYlqctSL9SdPzBdCU9G/22CyW6CkuhFpS3Zlf
	 k4NCRmuNXW7BUkq7bSET9aN4SBmMNbkikjc+MXH47tVnzau06w1JjtAR1l0ggoOAyg
	 T9FolIIeEsk399LUOBWFouYuwIzUAG226Om305ELudWbDR/Xwd1NeS7yLE6O1CjgUm
	 jYSmZTGTC0QIAJ9Uxk+NM/KfemE9k2VeONXy3ueE0OOP3rpVBWHE8yoUmENw+P8qeu
	 n+sssuRTaqsBDDCHrWCG5UOUowob6oesqdM8ht/xc+B8ZnCbRnbiBBQeM86+II8VfQ
	 BIjlatDyIj3tA==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3eb7edfa42dso375810b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 03:39:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVYYt8CkoRjgx/8q5kq6qQvTGAEigGQuKRNQVSy6bUfvhAV7iUuAA19MXhye4tgLuDJG+ElJ6yjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmrmgzxcUcbAdrHI9NygvsI5iCA9mabUdQ2ab7rprALcTbyliF
	+NRmoV6JiIyhxmxswZVsMtzI6pPDeP9Zz7meDKQRgNbO/qJZ/g8z2GJyrvvl4wr/wMtnCftcoPc
	eseUvLJt7B0a+0YOAbr3tzDl9Bgg=
X-Google-Smtp-Source: AGHT+IGMqUrt2FKou5An29S/lwto4lru3NIbCF5jBqSGOlkndBoIjeSLEXcUR95IHzzENRb3gc+NTbmPsc2MCz+VH5s=
X-Received: by 2002:a05:6808:1446:b0:3e6:63b5:f248 with SMTP id
 5614622812f47-3ef2ebcb8e4mr3897067b6e.7.1736422753938; Thu, 09 Jan 2025
 03:39:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97c5c93d-e31e-483b-83c3-28b797b69e9a@stanley.mountain> <68cdb73b-59cd-47be-9bc1-9affa606ba8f@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <68cdb73b-59cd-47be-9bc1-9affa606ba8f@pf.is.s.u-tokyo.ac.jp>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 9 Jan 2025 12:39:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h4TUvGKKD51U+RUWv0sCbRjon6PF3ycVaTHMoA=1VEVQ@mail.gmail.com>
X-Gm-Features: AbW1kvbbH0I-CJj2f6-yB5QpUedzTyqnz7rgG_4MRC9lfYMeaRVEBir3AFTkCyA
Message-ID: <CAJZ5v0h4TUvGKKD51U+RUWv0sCbRjon6PF3ycVaTHMoA=1VEVQ@mail.gmail.com>
Subject: Re: [bug report] powercap: balance device refcount in powercap_register_control_type()
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 1:36=E2=80=AFAM Joe Hattori <joe@pf.is.s.u-tokyo.ac.=
jp> wrote:
>
> Hi Dan,
>
> Thank you for the report.
>
> On 1/8/25 19:11, Dan Carpenter wrote:
> > Hello Joe Hattori,
> >
> > Commit cae442480e40 ("powercap: balance device refcount in
> > powercap_register_control_type()") from Dec 15, 2024 (linux-next),
> > leads to the following Smatch static checker warning:
> >
> >       drivers/powercap/powercap_sys.c:632 powercap_register_control_typ=
e()
> >       warn: freeing device managed memory (UAF): 'control_type'
> >
> > drivers/powercap/powercap_sys.c
> >      622         }
> >      623         mutex_init(&control_type->lock);
> >      624         control_type->ops =3D ops;
> >      625         INIT_LIST_HEAD(&control_type->node);
> >      626         control_type->dev.class =3D &powercap_class;
> >      627         dev_set_name(&control_type->dev, "%s", name);
> >      628         result =3D device_register(&control_type->dev);
> >      629         if (result) {
> >      630                 put_device(&control_type->dev);
> >
> > The patch adds this call to put_device() based on static analysis but
> > I'm pretty sure that will lead to a double free so the patch should be
> > reverted.
> >
> > We can see on line 626 that the class is powercap_class, so
> > put_device() will call powercap_release().  The means that control_type
> > will be freed.
>
> Indeed, I missed that.
>
> >
> >      631                 if (control_type->allocated)
> > --> 632                         kfree(control_type);
> >
> > Use after free and double free.
>
> Instead of reverting the patch, How about removing these two lines to
> avoid the double free (so that mutex_destroy() is called in the cleanup
> function as well. Not that it makes that big of a difference though). If
> that is ok with you, I will work on a patch to fix it.

I'd rather drop the commit in question and feel free to submit a
correct patch for the device refcount balancing.

Thanks!

