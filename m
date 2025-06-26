Return-Path: <linux-pm+bounces-29584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7632AE9B17
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 12:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3784A2290
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BD8221FA8;
	Thu, 26 Jun 2025 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0Ry1Z2r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E01891A9
	for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933268; cv=none; b=i3bh3xvls6C72RaDxbuDmS6YYuvSWspiGgETYka6D2C5qRIks6HuxQJP1MdyZ6wNNSALmXXRvaH0jq6lA/CMJVxnHDJ2sWyIgJh/+9D4I0nnMnC86K6jx6wVDyle5RqhHs117XSxhOwQN0Z5DETkrrKeKsJrlq35Iy+2GieyYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933268; c=relaxed/simple;
	bh=c08UXPYZtjpEMhL4kGvfOaWGJO+poU22yY2ilFqSmcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjB2Ht5+yaILX4bPGMPmpMErdWT6zO1tlqjXZUYqgLdxnLVnnK/BLqJVEaHjIeR8RyIN6tWdyHSZ9wJWpNCEApEh2jxdSqGOO0Asq7m7b9qvvpicu3WQnY0rORMfkGJkXeovY6A0pttW7HjiK4OUbJrutiHlDKUvA8yxwCOMUbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j0Ry1Z2r; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8600c87293so584617276.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 03:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750933265; x=1751538065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgWe1yEUe01r1E8Tw1sTfxB+GfHH0ZziUvZh1CX89D4=;
        b=j0Ry1Z2rbrHJ+ZMvicemzIgGcSDadTcbHP3hHnFupm7bwKB+1XyO2EgBX32uMDgBOG
         2mbz9ms0z3BUkx6d2Dt4mfp60k9dTQyO5Ft4WV6ZOioSbXFbLittcGKI83+08NqhM9gp
         +pyBuETk9YzhYzlEEyqRB5Lok9YIoMMN8a9t0OoEf6HsS5pIBqvTJGF3ZHaBFNaNIggW
         cH/eoY85HSVulwaAjccdTn+0il4MRKcNKKHNbQssidnyJM/kcNjpHwvIje+dhdTwXZ5e
         sF1Pnasi/hgGsqMMyrvct6YbCM14/wGAfbULuJPQJabimZjQzyz7yfWtxy6M1aysRcTf
         HGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750933265; x=1751538065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgWe1yEUe01r1E8Tw1sTfxB+GfHH0ZziUvZh1CX89D4=;
        b=vpf5R0BTvMusOsehtEWSI+tZQJGAnKWGPkiFwU1wGZMQMqyy6S8X2XDlwy31SWc3mi
         /wjhqAsmMqRANHrjImikkEOk69cyOSlzROoxzbH5DqZmISjL0k3Taq3wVnsM6A/vmOSD
         kllLnzWHQ4jU1HhkOExh7UnW2S3wmOalnrtweQBfVAz+fnGzmiayEpFQNq88MKb2UCxZ
         Yx0uB4q3HE/5AI3IL0+EVK+xYS/A6rKbHqyXxl40R7mdxbCgaBLp9a0Xn2gM6AxSrL5N
         RPZ1HfW1kUfjZ1bA4vXtQjuD/56TntD9F7kdPAPzj4sHTDTKXbIJHqiqIEEJAiyju5Vc
         +XKg==
X-Forwarded-Encrypted: i=1; AJvYcCXW1ifaQoNolX35+h1mbRQWFY+fONoQjuAoyovLaRCDm3h2Cqz3UkfIVukrcEsc5co9U6ifYjK/GA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2XkySs4H+3f6BI79dQg1fnkNeoFBH/QyM0zllN3eNOaV4DrI8
	qlitqqGX96EAySEoBNEJBdI5wVRYU0QJEjC7BD2S5EWG9HS3bYTBnsIlGk6dWJfxhKD8E3WYhzW
	2D4DXupETbh1aD6Ur/+iD3I2E1UgE0UKfbwh1LNa60g==
X-Gm-Gg: ASbGncvzc4nyvpZ1rui91jkgiUjDaMDzjNQKy56IFuwuTr1YoM47wmOpVhLf+8C4wtV
	fRdyl8evsJAllvpYkvOAHS89Br1WnA+bv4YzfTzzW2rwy2AIf622T1WuYIdjd1dk9VY3BFNqqtt
	EkZXQpZzk2oC/HfoFM8pOpFBbCtpDCUT8XZuaPmvcaU08X
X-Google-Smtp-Source: AGHT+IEyk3mms1+5t/8MuCL0xllpmb6YLFcWeRD/hQ0f5nW0B1ALuSQjWxbP5EYpCLmojQnL9hQoN2Or3EhNmCkqm78=
X-Received: by 2002:a05:6902:2b90:b0:e84:2adb:2548 with SMTP id
 3f1490d57ef6-e86017a744amr8247814276.24.1750933265396; Thu, 26 Jun 2025
 03:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <2045419.usQuhbGJ8B@rjwysocki.net>
 <CAPDyKFq8ea+YogkAExUOBc2TEqi1z9WZswqgP29bLbursFUApg@mail.gmail.com>
 <CAJZ5v0h-9UnvhrQ7YaaYPG5CktwV-i+ZeqAri8OhJQb4TVp82w@mail.gmail.com>
 <CAPDyKFoW5ag69LBnxvP5oGH1VAErBn17CAOzh=MX2toxAHwLxA@mail.gmail.com> <CAJZ5v0jx643Os_hvAwoOvYbP3VPhAhgWBqQJk+Rp8zn=w49w9Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jx643Os_hvAwoOvYbP3VPhAhgWBqQJk+Rp8zn=w49w9Q@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Jun 2025 12:20:29 +0200
X-Gm-Features: Ac12FXxpBZ3tZsz4pEVg98bpJK1QwSul4p2Gdnai6PYvcQNw3Uyzytb7ot0tbss
Message-ID: <CAPDyKFpnvg3w9B_R7F-xrhXU+upFSJv5c=buVR5FyFnqoach_g@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] PM: Move pm_runtime_force_suspend/resume() under CONFIG_PM_SLEEP
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Jun 2025 at 12:13, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jun 26, 2025 at 12:05=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >
> > On Thu, 26 Jun 2025 at 11:41, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Thu, Jun 26, 2025 at 11:38=E2=80=AFAM Ulf Hansson <ulf.hansson@lin=
aro.org> wrote:
> > > >
> > > > On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net>=
 wrote:
> > > > >
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Since pm_runtime_force_suspend/resume() and pm_runtime_need_not_r=
esume()
> > > > > are only used during system-wide PM transitions, there is no reas=
on to
> > > > > compile them in if CONFIG_PM_SLEEP is unset.
> > > > >
> > > > > Accordingly, move them all under CONFIG_PM_SLEEP and make the sta=
tic
> > > > > inline stubs for pm_runtime_force_suspend/resume() return an erro=
r
> > > > > to indicate that they should not be used outside CONFIG_PM_SLEEP.
> > > > >
> > > >
> > > > Just realized that there seems to be some drivers that actually mak=
e
> > > > use of pm_runtime_force_suspend() from their ->remove() callbacks.
> > > >
> > > > To not break them, we probably need to leave this code to stay unde=
r CONFIG_PM.
> > >
> > > OK, pm_runtime_force_suspend() need not be under CONFIG_PM_SLEEP.
> > > That's not the case for the other two functions though AFAICS.
> >
> > Right, but maybe better to keep them to avoid confusion?
>
> There really is no point holding pm_runtime_need_not_resume() outside
> CONFIG_PM_SLEEP and pm_runtime_force_resume() really should not be
> used anywhere outside system resume flows.

Right, I am fine moving it if you insist.

>
> > At least the corresponding flag is needed.
>
> What flag do you mean?  If pm_runtime_force_suspend() does not go
> under CONFIG_PM_SLEEP, needs_force_resume will not go under it either
> (so I'll drop the next patch altogether).

Yes, that's my point. needs_force_resume needs to stay within CONFIG_PM.

Kind regards
Uffe

