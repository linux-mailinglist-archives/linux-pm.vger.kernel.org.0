Return-Path: <linux-pm+bounces-13418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E3969DA7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 14:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB6A28480C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 12:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FB11C768F;
	Tue,  3 Sep 2024 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF6a7kUi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919151A0BE0;
	Tue,  3 Sep 2024 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366746; cv=none; b=I+7cdR4g3oOFapNbF2Kvw5W1Unf9Dj2Ea1LMh5NirkyESn1R5RT2fGOWZdMeLc3zJK1279H3WhXFcPeA25qHxY198H/5X3mRPbM8uJuqHIMPxS5m8o+WKSgEFOdA9RHNr4l1cLyeJgNHEALFXIlGR3s2bs2XUkKWNJ7z0/vhQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366746; c=relaxed/simple;
	bh=exDz0uG5y9CDYwIOlflGF/NQ6rDmCyP1kVsrGdRztkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qM/9Oc7o79SSt57NYE6Gz3Sjk5vzWUdWOTj6R0+Hsg3mE4eJ1hYRoRvbcDpE1cfFxoRIhgwvXCL6GA0lS6DVg7y9AriNnxZ7Upe4V4TFap9FtN79jHhTMlDVIsXK+MvE2p/krV6sVEqoflCODsU0jfAT/taF0+tzjFjFACxuu3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF6a7kUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B5CC4CEC4;
	Tue,  3 Sep 2024 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725366746;
	bh=exDz0uG5y9CDYwIOlflGF/NQ6rDmCyP1kVsrGdRztkA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SF6a7kUicW2eNwrYnz7FyYW3NPl+UGU3MnV+HTz2DSgoyp+u6iavyacTghcXnqhH0
	 bWudThlIBIx5uWPfObG5rcQYtqAGiksmJqms2uJh2eCaiHf7uIh0awHjkHLr2EbWc/
	 nH4Ta76XcwWGy230q7ZWAmQZZOyAZIOkw06bxgiYcpeQYAu0+/MY5jryR0OMI5nbFO
	 BeE5P/f1tQCvaE2mvv7J9xJ+xh9MmjoC/8aKoc99VkHStvfbVpNHJVE1oY/Nz43NYO
	 X4fcl2DM2n69M6GtKNcoecyCZiD9dNRlYJxXwwkq2RRrVbjpKi99HJt4TaLrniBrA5
	 O8zeACN1x0gCA==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-277fa3de06fso939623fac.0;
        Tue, 03 Sep 2024 05:32:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+8k9T+G3uVKoY3aoDvRtHmDjGbqQ/lVzA+UvwOktxMtma3hKOeMuGeiZzjfC1hoWrien9bSMhepYqfTU=@vger.kernel.org, AJvYcCVMapfln7afdCJ9lT/QRQvD99qdz/5WJS60+vDa9OYpeYAPC3F5hcT0OEUkG6+JSAHVsEBQDvMpTVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbn5JcW5XLe0HOw6cTu8SUr0+6xxucUm4Cq6pgHgiABa1Mrb7N
	HzErBR3UiC6vVTkktjQ7H+RTKP65uF9F1bX8ko7RgA1EX66Mf1gfbGRsGi+iANYU2n7/uPkbCYg
	euWN40GqMATp1vhCgV+AmQ9R64LQ=
X-Google-Smtp-Source: AGHT+IGdLE8YHyP6Qknn6MthooqA/9Y69zZ9Erc/NDSfI5VLEkIveGhPnqvOfeaFQtwHJrtbzxlN4IiRo0N4FN/VvRM=
X-Received: by 2002:a05:6870:164a:b0:25e:940:e934 with SMTP id
 586e51a60fabf-27810da7581mr2792857fac.47.1725366745587; Tue, 03 Sep 2024
 05:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902125933.5742-1-00107082@163.com> <2024090347-latter-collide-772a@gregkh>
In-Reply-To: <2024090347-latter-collide-772a@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Sep 2024 14:32:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ifKFXk=odx-dZZZg4G-2+O_8rXRb7++TzPMfN4fFuGVg@mail.gmail.com>
Message-ID: <CAJZ5v0ifKFXk=odx-dZZZg4G-2+O_8rXRb7++TzPMfN4fFuGVg@mail.gmail.com>
Subject: Re: [PATCH] pm: sleep: do not set is_prepared when no_pm_callbacks is set
To: Greg KH <gregkh@linuxfoundation.org>
Cc: David Wang <00107082@163.com>, rafael@kernel.org, pavel@ucw.cz, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 12:42=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Sep 02, 2024 at 08:59:33PM +0800, David Wang wrote:
> > When resume, a parent device with no pm callbacks
> > would have "is_prepared" and "direct_complete" bit
> > set, and skip the "fib" chance to unset "is_prepared"
> > in device_resume because of the direct_complete bit.
> > This will trigger a kernel warning when resume its child
> > For example, when suspend system with an USB webcam
> > opened, following warning would show up during resume:
> >
> >  >usb 3-1.1: reset high-speed USB device number 4 using xhci_hcd
> >  >..
> >  >ep_81: PM: parent 3-1.1:1.1 should not be sleeping
> >
> > The device parenting relationships are:
> > [usb 3-1.1] << [uvcvideo 3-1.1:1.1] << [ep_81].
> > When resume, since the virtual [uvcvideo 3-1.1:1.1] device
> > has no pm callbacks, it would not clear "is_prepared"
> > once set.  Then, when resume [ep_81], pm module would
> > yield a warn seeing [ep_81]'s parent [uvcvideo 3-1.1:1.1]
> > having "is_prepared".
> >
> > Do not set "is_prepared" for virtual devices having
> > no pm callbacks can clear those kernel warnings.
> >
> > Signed-off-by: David Wang <00107082@163.com>
> > ---
> >  drivers/base/power/main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> What commit id does this fix?

It doesn't fix anything, it is introducing a potential issue.

