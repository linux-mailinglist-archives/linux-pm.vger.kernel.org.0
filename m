Return-Path: <linux-pm+bounces-16320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118629AD454
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 20:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF1B2828DF
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 18:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9DB1D0DE9;
	Wed, 23 Oct 2024 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2P9ux1v"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989883CDA
	for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709901; cv=none; b=AYZD5/8C+XGtNHO/B/mBM5c/HyfFokYrASOHguF7zzItZnVwEsaaGSlG8mh1uvwIV3ZGI8Sigu6Na0qydh9WzRYA3uihHOf0pucLChEaw/gthxI/Er4hbQLiTIg0KevvofMp5VyXzHxVnqjD4tR9xK1txgv1P8TpuS20+Q/x5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709901; c=relaxed/simple;
	bh=V0QCXFcnMZdAOdZbqjcNhbz4kbwQ0T4aqZAafjCtJnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKvXg6OPucvwwMEcg18MM1BSBGndzrh7o+X/EZavwcD0jlrKUrwzVe7VYM2KIOS6eiDHTDbcHjg64CiNLbtdDEo04h2Mj5w/tiJ+eUdw9y7yD72Cn3KcRWv1LBkKDNETqPWYe5+VgGkhPz8LaRpb/JjaEv7A01/O90qbU27QZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2P9ux1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B160BC4CEE5
	for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 18:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729709900;
	bh=V0QCXFcnMZdAOdZbqjcNhbz4kbwQ0T4aqZAafjCtJnI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i2P9ux1v0WU5QDDs5VXl+Ay6VP+PL4oOS+yB+0QtBCsyzKLx34zFqt41aF8Nzwrj2
	 YPlqgjPRFCA5NveN4SsMtORz+UDsQKwv0tuUvFGbATulokoegxKBu4dEFUNdi/2QsS
	 nA3zILg5Somfja/rfQw+R5ZN/eUgT8pYhbvpRww1oAqXUB7WgXrZl9eTM4ZHSlR1qF
	 XJ66kc3+uUHcD9mdxvXXYpSTLYuPDlZwfxAHlo4uA6o2aGV0fBmQyrDWztGj+1ixQF
	 ldcnjqbqS0+YIf/AoPphMrcORy1OW+HhLLe8MPocEvgTm4rgPo/0Lu4aelO8QEc+Za
	 IJHvFK7ecGVYQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-28896d9d9deso118011fac.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 11:58:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YxHZyE2RJs6EFpbSQGsTJAbFTEuyaa1NJc+jogB8ei8p+rmVosM
	6gsvLL+/DUmSjPTyYiNX2uyBH4YDU9OsdiJYvBYE6yQBijbsr9H+eFFdBSMc7pGGqoGok8Gwzwj
	wI7ISnku5S7sKj4WcXYkcHaxkvog=
X-Google-Smtp-Source: AGHT+IGciat9lHqlF2KMeKlhllpbf8ODHX0TxNfcCdc7huv0sYULJ6xAGL0SLlHWdF8Q5FkWMOz8tIN7STaTeVeefPQ=
X-Received: by 2002:a05:6871:721:b0:288:4823:fe1b with SMTP id
 586e51a60fabf-28ccb4bbc76mr3764266fac.17.1729709899981; Wed, 23 Oct 2024
 11:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020153910.324096-2-u.kleine-koenig@baylibre.com>
 <CAJZ5v0jAMr=bmZ5PexVTS0SqrXP4EytZ+RH5X8p1Nep2wMg-kQ@mail.gmail.com> <20241021102207.ujbprtc3gecxlyu3@vireshk-i7>
In-Reply-To: <20241021102207.ujbprtc3gecxlyu3@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Oct 2024 20:58:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gBejHfbOje+yNBf59MNTqfjLWXH5JPU=DbaJ=3KPcQ4w@mail.gmail.com>
Message-ID: <CAJZ5v0gBejHfbOje+yNBf59MNTqfjLWXH5JPU=DbaJ=3KPcQ4w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Switch back to struct platform_driver::remove()
To: Viresh Kumar <viresh.kumar@linaro.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:22=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 21-10-24, 12:20, Rafael J. Wysocki wrote:
> > On Sun, Oct 20, 2024 at 5:39=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > >
> > > After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> > > return void") .remove() is (again) the right callback to implement fo=
r
> > > platform drivers.
> > >
> > > Convert all platform drivers below drivers/cpufreq to use .remove(),
> > > with the eventual goal to drop struct platform_driver::remove_new(). =
As
> > > .remove() and .remove_new() have the same prototypes, conversion is d=
one
> > > by just changing the structure member name in the driver initializer.
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > > ---
> > > Hello,
> > >
> > > given the simplicity of the individual changes I do this all in a sin=
gle
> > > patch. I you don't agree, please tell and I will happily split it.
> > >
> > > It's based on Friday's next. Feel free to drop changes that result in
> > > a conflict when you come around to apply this. I'll care for the fall=
out
> > > at a later time then. (Having said that, if you use b4 am -3 and git =
am
> > > -3, there should be hardly any conflict.)
> > >
> > > Note I didn't Cc: all the individual driver maintainers to not trigge=
r
> > > sending limits and spam filters.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> > Viresh,
> >
> > I'll pick this up unless you'd prefer to apply it, so please let me kno=
w.

Applied as 6.13 material, thanks!

