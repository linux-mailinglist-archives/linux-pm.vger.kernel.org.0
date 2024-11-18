Return-Path: <linux-pm+bounces-17728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62639D1491
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 16:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBD81F21E7E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BC61BD9EE;
	Mon, 18 Nov 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5Z0fNkR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BA11B6CFC;
	Mon, 18 Nov 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944209; cv=none; b=MLkVz3B2Ms0sYLZ5s+WmnYaCp98PwE1MNW7d1F00nbKZcMyhv6aChGJ/VdRz4kp2eV8zZWnFxhwfdTL0eaABZBnLVL8h0JOTBi6Ik7wQE43pxf9BVIfbKdCPh+8otBiWhQ1cU4g5T0nMpkjBMeGJPdlNymd6ViMN1+OD0pO1ejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944209; c=relaxed/simple;
	bh=Z1F/WWyh2Br9EzCFAJEMyj5kDOKy73YHKCPpES500bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIC0673t70US1qbmpBAaIP4D6jscvWDY5f1V2ojoWCC409lQeP4D3UF2xxk/g3Qw549SngGqas948O0smLGcAzIaByXJ3y74V2AOi8HaB3BkOCecx3xF+Ke5SHcZGWRz/XwzpXQGzHNgLrfNX91Hl4aLav2ixzuxaG+djhVREws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5Z0fNkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71055C4CED9;
	Mon, 18 Nov 2024 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731944209;
	bh=Z1F/WWyh2Br9EzCFAJEMyj5kDOKy73YHKCPpES500bI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z5Z0fNkRnjTm0IZXW2zvx37V1hMc1SiJyYJMC00zEObYgv1mbaRxWImHuHcBnm8R6
	 JmUzT8F+nnCVD0SEOxnnY8LOsvQblPKgQZZI/hWgRc8KUX/z0L2WsNOJ7R0nikOnnW
	 8bRJh83qn5mrr0APrsALEgS9Daz7o4YyEeLZqWZk7Jsv4HClspSf4cJ4a+lH5MhH+1
	 qWbuIQ+RtMk305B8I9Oolu9+KS7r44GtXNSCOfIPaPD0KVoV7kr5jwvI1EcwV4RS5v
	 W9yODhpt/CWQhjFsh0frkI5fbJMO8gbRocCxprparKAk7CpGzjMqQ0dv0csIPrRqQX
	 f3iGOJuzDkVHA==
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e38261653aaso1620912276.2;
        Mon, 18 Nov 2024 07:36:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZhOAaaANbCYWMBmjMEJ4xwKMP7Iy1Pxmuen2UZCALvm1LGqa7zOI6l2Jd0vbHnI96FsqV9zCWtgdzfG8=@vger.kernel.org, AJvYcCX85Sxc+BVMUyu82IfNsR3mtXT66iznpX6MW4Y+Ynv07lvI4DQTy6opkv3rGB94SzCwJBjEj8nIcNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsurqi23qG4SdmB7PbfOnKQvve4mswI1P8Sduri6ZWoUQ2xzJ5
	ASw22QiqOiIocNMFYvJR+bLVTHzgPZf80gtN6r6CDJhsOSeeohGXSh5zoDMnBZpiJI62Git1zz+
	aD1X0TEr+F2qp5yMENvQWRszarQ==
X-Google-Smtp-Source: AGHT+IEEIGFak9qKklcZsvCILXL3wsmYpRQVXReSreMGbi2y4CLvncVZuNk4Ue6AECvkVYWTyDD0MnYKDyXhx+DEKJg=
X-Received: by 2002:a05:6902:1701:b0:e38:8579:7e44 with SMTP id
 3f1490d57ef6-e3885797fb6mr6028789276.50.1731944208623; Mon, 18 Nov 2024
 07:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-13-masterr3c0rd@epochal.quest> <20241111041311.hleaz5fgipsyxigm@vireshk-i7>
 <CAGb2v646NHFAni=P+iC8OZsWMpg0PJc=kYbuWaY=C0-W-q6qAw@mail.gmail.com> <20241111055504.2f3szrd5ahudvtqm@vireshk-i7>
In-Reply-To: <20241111055504.2f3szrd5ahudvtqm@vireshk-i7>
From: Rob Herring <robh@kernel.org>
Date: Mon, 18 Nov 2024 09:36:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJJ5A+nYKg1aU5zqGZsmtNJxpS3Gw04pSH-3xOkQ9Vzew@mail.gmail.com>
Message-ID: <CAL_JsqJJ5A+nYKg1aU5zqGZsmtNJxpS3Gw04pSH-3xOkQ9Vzew@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] cpufreq: sun50i: add a100 cpufreq support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Cody Eksal <masterr3c0rd@epochal.quest>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Yangtao Li <tiny.windzz@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>, 
	Parthiban <parthiban@linumiz.com>, Andre Przywara <andre.przywara@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 11:55=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 11-11-24, 13:30, Chen-Yu Tsai wrote:
> > On Mon, Nov 11, 2024 at 12:13=E2=80=AFPM Viresh Kumar <viresh.kumar@lin=
aro.org> wrote:
> > >
> > > On 31-10-24, 04:02, Cody Eksal wrote:
> > > > From: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> > > >
> > > > Let's add cpufreq nvmem based for allwinner a100 soc. It's similar =
to h6,
> > > > let us use efuse_xlate to extract the differentiated part.
> > > >
> > > > Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> > > > [masterr3c0rd@epochal.quest: add A100 to opp_match_list]
> > > > Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> > > > ---
> > > > Changes in V2:
> > > >  - Add the A100 to the cpufreq-dt-platdev blacklist.
> > >
> > > Can this be applied to the cpufreq tree separately ?
> >
> > Yes.
> >
> > Acked-by: Chen-Yu Tsai <wens@csie.org>
>
> Applied. Thanks.

You missed the binding patch, so
"allwinner,sun50i-a100-operating-points" is undocumented. Can you pick
that up please.

Rob

