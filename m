Return-Path: <linux-pm+bounces-25027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9800DA82E12
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77AB88505C
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71011270EC2;
	Wed,  9 Apr 2025 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt6RI8WY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343B1CF8B;
	Wed,  9 Apr 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744221332; cv=none; b=t4f3tdd+TVRSStjWbPsiMkshLr+fvXW/8uCLDVwf8OFlTtIH8Cg8dIxSsFwqPfp2Wk8N3/q3+/K1fxQIPTPOYUUxOiiHM7ExAzRPMeRioLcWBXzbY2MJuLMx1nPCzhtZ4/wM/h46ng1ppPBai6WU9Ll1eSr/lqmtZOUBiaQmFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744221332; c=relaxed/simple;
	bh=9r66Wfrha929p07ng1Y/KZsuo0v815X+zoxiuQrI03o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIS5an8wpY6lzO50cUFbz2cVxv77fMXAod8PXhPguIigkmgDBKZ+Bl5I+8rv8IDKh26DzxTuGV/DUrmmlIcVO2wrGawvdkTfZ4KGjQpKOz97k2wWa4Qh0uQ3+j4E3+gkmBDBqTA+EDul71HZI2xdb/0B0QHuDW8OAkbCoUeTVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt6RI8WY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B872AC4CEEB;
	Wed,  9 Apr 2025 17:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744221331;
	bh=9r66Wfrha929p07ng1Y/KZsuo0v815X+zoxiuQrI03o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mt6RI8WYF1RIawWkad3srN7T8VU/vt/myELopiUs0eBBUmkcBoOq90TTHhnROJ8lH
	 t8uWG3zKo2cWM1uYWdKLs/LOFrEN8Va5WMiR4Ua7CYlfhClmCxdF9nwATag4hcW/Rl
	 9oABDKiZK663k62mzvJGZ7u0CxB2/ZVoU6askowRpALcrW6DEO348AShabngMRBbx1
	 UvdIBTGYTzt5QGWbZigQ0Lb6+vPMRuhNNub7hnpQgaGrjlyqthPQSUwnflKtWwIOec
	 oKQGJepLDN9F0Zm4FfaHb2r+gLxjEjGlsBml0HfQ3MSesypjLgYq8M5xxKjX5BIMJ8
	 ZVQOUJnqzpMSw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c12b7af278so5789fac.0;
        Wed, 09 Apr 2025 10:55:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5Ed2DQOWL/SFoMbRWXspLmER/jTa0adbycK30xOTjUuuIK1LawZnmlCYzqV5MRtVy/OTP7sdxmP8=@vger.kernel.org, AJvYcCXQD1hrxUCjWoDbFerHJgVKeeUWzBdAVuWKCwafZyR9D7KDIE2B5lbUSqplCA3gKB5eUc4HSx8qcBNdnM8t@vger.kernel.org, AJvYcCXhQPwRVLg2t8+iTUzcw61bklgpOTTJgQHyWiyLYfGIsELjYoh63itoFsESSLSm8fbzz4Vm/f+UIGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGBcCCRPZfSmubVNF39deAfa5+tdmMIzUKR2Qp+4EgGNmmI6R
	NfF6twzQ9I6p+QuE4o9Ag8ysiD7BONqNk+W+xhg77LoVgcY8APxOM2c+jFEa04fZePG3KguSe2p
	qNlRwacUUESDlBqD04MUeCdG03qc=
X-Google-Smtp-Source: AGHT+IGO+jjqHSBXWjTWnVsJIN7eK1oOONxiSCBMknxBMzVZk3syrHLRphRe2sQeYc6PCuzK/Vi72uVzOo1BrkBsC1Q=
X-Received: by 2002:a05:6871:a594:b0:2b8:41ef:2ca with SMTP id
 586e51a60fabf-2d0ad053dddmr312843fac.6.1744221331026; Wed, 09 Apr 2025
 10:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
 <20250326-cross-lock-dep-v1-1-3199e49e8652@bootlin.com> <CAJZ5v0gFER-nbWpZK6FMDJCXA+iPQUm5DZDAiRY3ahugR2MM=g@mail.gmail.com>
 <874izdlblm.fsf@bootlin.com>
In-Reply-To: <874izdlblm.fsf@bootlin.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 19:55:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0irZj7ttvUqb-iENQS6BX+KTGuTqyVh0DxgKmsoKrBcbA@mail.gmail.com>
X-Gm-Features: ATxdqUEhvTKg_Dm0U4wlDBZsG6FgRkNszoP9ogCJEM3XAr3NbaLY303rrxWg228
Message-ID: <CAJZ5v0irZj7ttvUqb-iENQS6BX+KTGuTqyVh0DxgKmsoKrBcbA@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] PM: runtime: Add helpers to resume consumers
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>, Lucas Stach <l.stach@pengutronix.de>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Vasut <marex@denx.de>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, 
	Fabio Estevam <festevam@denx.de>, Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, linux-imx@nxp.com, 
	Ian Ray <ian.ray@gehealthcare.com>, =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 28, 2025 at 10:59=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hello Rafael,
>
> >> The runtime PM core currently allows to runtime resume/suspend a devic=
e,
> >> or its suppliers.
> >>
> >> Let's make it also possible to runtime resume/suspend consumers.
> >>
> >> Consumers and suppliers are seen here through the description made by
> >> device_links.
> >
> > It would be good to explain why all of this is needed.
> >
> > I gather that it is used for resolving some synchronization issues in
> > the clk framework, but neither the cover letter nor this changelog
> > explains how it is used.
>
> The explanation is quite long, there have been already 3 full threads
> from people attempting to fix a problem that resides in the clock
> subsystem (but that may also be probably problematic in others, just
> uncovered so far). I don't know if you took the time to read the cover
> letter:
> https://lore.kernel.org/linux-clk/20250326-cross-lock-dep-v1-0-3199e49e86=
52@bootlin.com/
> It tries to explain the problem and the approach to fix this problem,
> but let me try to give a runtime PM focused view of it here.
>
> [Problem]
>
> We do have an ABBA locking situation between clk and any other subsystem
> that might be in use during runtime_resume() operations, provided that
> these subsystems also make clk calls at some point. The usual suspect
> here are power domains.
>
> There are different approaches that can be taken but the one that felt
> the most promising when we discussed it during last LPC (and also the
> one that was partially implemented in the clk subsystem already for a
> tiny portion of it) is the rule that "subsystem locks should not be kept
> acquired while calling in some other subsystems".
>
> Typically in the clk subsystem the logic is:
>
> func() {
>         mutex_lock(clk);
>         runtime_resume(clk);
>         ...
> }
>
> Whereas what would definitely work without locking issues is the
> opposite:
>
> func() {
>         runtime_resume(clk);
>         mutex_lock(clk);
>         ...
> }
>
> Of course life is not so simple, and the clock core is highly
> recursive, which means inverting the two calls like I hinted above
> simply does not work as we go deeper in the subcalls. As a result, we
> need to runtime resume *all* the relevant clocks in advance, before
> calling functions recursively (the lock itself is allowed to re-enter
> and is not blocking in this case).
>
> I followed all possible paths in the clock subsystem and identified 3
> main categories. The list of clocks we need to runtime resume in advance
> can either be:
> 1- the parent clocks
> 2- the child clocks
> 3- the parent and child clocks
> 4- all the clocks (typically for debugfs/sysfs purposes).
>
> [Solution 1: discarded]
>
> The first approach to do that was do to some guessing based on the clock
> tree topology. Unfortunately this approach does not stand because it is
> virtually unbounded. In order to know the clock topology we must acquire
> the clock main lock. In order to runtime resume we must release it. As a
> result, this logic is virtually unbounded (even though in practice we
> would converge at some point). So this approach was discarded by Steven.
>
> [Solution 2: this proposal]
>
> After the LPC discussion with Steven, I also discussed with Saravana
> about this and he pointed that since we were using fw_devlink=3Drpm by
> default now, all providers -including clock controllers of course- would
> already be runtime resumed the first time we would make a
> runtime_resume(clk), and thus all the nested calls were no longer
> needed. This native solution was already addressing point #1 above (and
> partially point #3) and all I had to do was to make a similar function
> for point #2.

So this depends on DT being used and fw_devlink=3Drpm being used, doesn't i=
t?

You cannot really assume in general that there will be device links
between parents and children.

