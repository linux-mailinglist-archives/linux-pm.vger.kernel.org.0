Return-Path: <linux-pm+bounces-40051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 127CACEA270
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 17:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B22413027A68
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 16:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC59D3191A7;
	Tue, 30 Dec 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8nxJGH5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E0223D291
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111532; cv=none; b=HDw++FG/0KproufgFfrUU/A5I/hj22dmzYyAi/KaYgQWJPf33vaoJ6FBbehlCFASZJQFP3T3AW6kppvNb0pKA4PBt24X9DyPK01Zs2HjhwU3H/9Ghy8iKKUAm/A+AIHpyZDQ/MPdzHbuhtcbwPUXpIifs16CrabGpfAU+0WVH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111532; c=relaxed/simple;
	bh=k11I6TH4hh1xItjM+8O3XlYwQ4cJNtO+7rbbpZauB74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZSAKvG9YKJxjjRHPEST+11zfyT87EY7yKlQIGqGBdto/z6tGdWPGIAPS85D+8lyIxY2uoDVInNpgjTqoADEp8aXNtDFFEnTM+R32nqx95v92Q+oTlAHTjk6ER4240O9oz1dXiJ19oWpRUuppOiAVUbusn5SUAT7BhZlZx8UGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8nxJGH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3B1C19422
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767111532;
	bh=k11I6TH4hh1xItjM+8O3XlYwQ4cJNtO+7rbbpZauB74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n8nxJGH5q7jhlaFgPryuP586CmNAv8tk95aj6+sljIHt25uDvGHkUoe+vt+V9hnKu
	 uFSaSHPybV4DUX1aknNxbb5/mrqU4jksImRixX2UahCGEcuQlkos6ONNw4YJu34zMJ
	 sPnGgamLNOWJ9ahDAEDz4/+isZBWpn8QNIJ4w37U9TOAeMx/8B/RHrID7Zud819s15
	 JO04Pa6A4h54CoZyFXqFLbs+fccPf8703xsXbMBRosX8dj7nCuCMVQStVS+2t86TVb
	 o9vmt2AUsFk809NcF0KfO7kjO4dF5Zf/m/PmTRgMaQMj7/patzl40yd9di+TfKknEd
	 X8pE7I6YC0h3w==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3f9ebb269c3so3653944fac.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 08:18:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+uRypZHKXjVFPmHjQyBuIh1P8DPXf04mrzAR+nKEBLq4wbYFXD6oZkwe0TI9pJtCCoO5gqBrz5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5wmt3j4pkfFlb5P7ZkPW1937idjiq6Fo6PFY8gRQ/wiZelw5g
	qOYe20sdfB2ouc/fqQitBsGF3lBOIscNIX56IoWjlmjwK9alQ+5jq2OBh2ht1n466V2CKk1rf2n
	TZQv3TVKqOGDAVC3cgqbHISCK0nd/DA4=
X-Google-Smtp-Source: AGHT+IEdabLLxZ0XTEgZlfk9fnVlkw8+txCIs0Un/B8yOfm3X38+PZiV6Uu339Qlt8g6YBaV8b/gqN8TBz47Ppq0Tlc=
X-Received: by 2002:a4a:dcd6:0:b0:65d:163:3e5 with SMTP id 006d021491bc7-65d0ea694a3mr9520016eaf.47.1767111531525;
 Tue, 30 Dec 2025 08:18:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <2556645.jE0xQCEvom@rafael.j.wysocki>
 <CAMuHMdVMFQebA43FJ53PBnd67C8fxWAC21cr4jWTGDwg-HV53w@mail.gmail.com>
 <CAMuHMdWshJOjzD5DGzyRUG66jvPC6PPVBgaT=UdWy+XOk_T5Pw@mail.gmail.com> <CAMuHMdVeHY7+9Jz60OX521iaEorGOcrxuGC8iuzDRUA-tkEvLQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVeHY7+9Jz60OX521iaEorGOcrxuGC8iuzDRUA-tkEvLQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Dec 2025 17:18:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hFBF_jKUV8DeWvxYpb8=s3F_4vwQ8kiYnOCBZEff4ZYQ@mail.gmail.com>
X-Gm-Features: AQt7F2rCs_r1PtPfO7YpKtu0zWadoNeeETCRVLW5w_39U6CvaW6J7q_HTWb9v0o
Message-ID: <CAJZ5v0hFBF_jKUV8DeWvxYpb8=s3F_4vwQ8kiYnOCBZEff4ZYQ@mail.gmail.com>
Subject: Re: [PATCH v1 15/23] phy: core: Discard pm_runtime_put() return values
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Brian Norris <briannorris@chromium.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-phy@lists.infradead.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 4:05=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> On Tue, 30 Dec 2025 at 11:54, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> > On Tue, 30 Dec 2025 at 11:34, Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
> > > On Mon, 22 Dec 2025 at 21:40, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > The PHY core defines phy_pm_runtime_put() to return an int, but tha=
t
> > > > return value is never used.  It also passes the return value of
> > > > pm_runtime_put() to the caller which is not very useful.
> > > >
> > > > Returning an error code from pm_runtime_put() merely means that it =
has
> > > > not queued up a work item to check whether or not the device can be
> > > > suspended and there are many perfectly valid situations in which th=
at
> > > > can happen, like after writing "on" to the devices' runtime PM "con=
trol"
> > > > attribute in sysfs for one example.
> > > >
> > > > Modify phy_pm_runtime_put() to discard the pm_runtime_put() return
> > > > value and change its return type to void.  Also drop the redundant
> > > > pm_runtime_enabled() call from there.
> > > >
> > > > No intentional functional impact.
> > > >
> > > > This will facilitate a planned change of the pm_runtime_put() retur=
n
> > > > type to void in the future.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Thanks for your patch, which is now commit caad07ae07e3fb17 ("phy:
> > > core: Discard pm_runtime_put() return values") in phy/next.
> > >
> > > This is causing several messages like
> > >
> > >     phy phy-e6590100.usb-phy-controller.2: Runtime PM usage count und=
erflow!
> > >
> > > during boot, and s2ram on Koelsch (R-Car M2-W).
> >
> > On R-Car Gen3, there are no such messages, as e.g.
> > drivers/phy/renesas/phy-rcar-gen3-usb2.c does support Runtime PM.
> > R-Car Gen2 uses drivers/phy/renesas/phy-rcar-gen2.c, which does not
> > use Runtime PM yet, but still relies on explicit clock management.
> >
> > > > --- a/drivers/phy/phy-core.c
> > > > +++ b/drivers/phy/phy-core.c
> > > > @@ -190,15 +190,12 @@ int phy_pm_runtime_get_sync(struct phy *
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(phy_pm_runtime_get_sync);
> > > >
> > > > -int phy_pm_runtime_put(struct phy *phy)
> > > > +void phy_pm_runtime_put(struct phy *phy)
> > > >  {
> > > >         if (!phy)
> > > > -               return 0;
> > > > +               return;
> > > >
> > > > -       if (!pm_runtime_enabled(&phy->dev))
> > > > -               return -ENOTSUPP;
> > >
> > > Adding some instrumentation shows that this branch was taken before,
> > > thus skipping the call to pm_runtime_put().
> > >
> > > Can I just put the check back, or is there an underlying problem that
> > > should be fixed instead?
> >
> > I assume the PHY core should support both drivers that do and do not
> > support Runtime PM.
>
> I have sent a patch:
> https://lore.kernel.org/3ca9f8166d21685bfbf97535da30172f74822130.17671070=
14.git.geert+renesas@glider.be

LGTM

