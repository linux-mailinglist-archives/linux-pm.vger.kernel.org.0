Return-Path: <linux-pm+bounces-34013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D681B46250
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 20:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDF01CC8163
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 18:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B952C249F9;
	Fri,  5 Sep 2025 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFhV98WZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9214A305947;
	Fri,  5 Sep 2025 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097275; cv=none; b=tWIDa9Gol88U5TIstX6orhv+oInKik6nmmZ8LScIlZf2Hd6xonxOaWlIBPDojP/pzb8ivi578qmq0gnXMZnFPWEOpFX16w/wOXE4x3IjZooWaYOLBs5/A24ExifNdWqvSws8BoAsJ86d0gF02ro/nXnJKQe/r4Xh8TR0EmynRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097275; c=relaxed/simple;
	bh=wuSIpbiYpwogPgiVrc3FHCRUTqDaQM6mxoYJcQcjKm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rme/0ULSFQonKJ4c9bHeN5zMhSbWPMubBxqe7+tYgjWGpKpYVl/Fgn1ZHA9AE+FcD0ngDrr3OOKUzV2Wqx4DhY9Wpozv6uAnNVVYPn6erPV5O2NzV1wDh5turXR4e+H2ecFzsp37dky1Qv3boRv8vrNxEg3o3wU1OTY5xEKvib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFhV98WZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBB4C4CEFC;
	Fri,  5 Sep 2025 18:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757097275;
	bh=wuSIpbiYpwogPgiVrc3FHCRUTqDaQM6mxoYJcQcjKm4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uFhV98WZttwk2YC6tQwc+TrK7mftGRLkuv2RZLVjsvgsQqzdChRiKVcghcrQIoLL1
	 qNU5aA3aYa3IXcoISjMCu2NLTiXLQs8v3ODCFxoVY6aSaXWTOzW9ED3Am94xpQKzDk
	 FP8hNcYhQ4rZ8a3IWREWQ3xfnYW3xAYotAfLpT3N/DwJyJny4XzvDBbtUov7T1GqiW
	 4gizyt9Co+VsBhbWJ/JMgo8yR3brEIJUFhD2BwQHIeo7ug5GULX2B/zJSac5MnTieH
	 DnBByfI77Wq8h7yzAGU3Vms8WCx8GuqBT5v8xDSkCniiCsV/YwCG2QuNXhIvYBVZWX
	 SWENt+QKGVP9Q==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74526ca79c2so1095692a34.3;
        Fri, 05 Sep 2025 11:34:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqJPyfUpY9LCBBwZ8ww4PuW+YGPhdVT/vHM0ef+0UvgYZHzc8RPylWD2KE2CMb8tiqpRgO06Mo9OA=@vger.kernel.org, AJvYcCXMet/+yS5CIlrFlcW0KkysQG8HX+uc+0ZW/Y5i+5Gx4dNe2zCoo1HXg7CjMFFmTJGJ+UIkDw2+2gx3VlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvasIxNkPjzzk/sW+83Q/V25pm+UMV67tGj60Rn/q0rtUmevyc
	83FVUoXyzz7fi/KGedmyEyHwq2tnQTyVUFnUNuVQGIgGAMM9ddjI+9x3DHFwXZG8c2+7Sk0cnwj
	Rvlk8gnEuOkpNHHuFiGCEuxl1sOMdlD0=
X-Google-Smtp-Source: AGHT+IEDJEP88wNRpReGztUGhqKLETt08FqHlfEKGOJT34bfUwqUxBXi/59yzSW50HRxaU3EV1r/smC4pokk0iX/a34=
X-Received: by 2002:a05:6830:650e:b0:746:dc05:8608 with SMTP id
 46e09a7af769-746dc058983mr2117830a34.34.1757097274380; Fri, 05 Sep 2025
 11:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825185807.57668-1-vivekyadav1207731111@gmail.com>
 <CAJZ5v0gfrTvLgs=PdmRbRRN05GE4Bk8Q7hJdtQfyk3VqaOz7FQ@mail.gmail.com>
 <CABPSWR5cG=xTA72BHayYQTb=24VS3N+=dbsiMcU+gyqTKvNXAQ@mail.gmail.com> <2fb11c0970da307cf8cf4f35d35c49f78f82ee72.camel@perches.com>
In-Reply-To: <2fb11c0970da307cf8cf4f35d35c49f78f82ee72.camel@perches.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 20:34:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iAfgE4RkVXH7GaG9SqvGa0VfVuFi_cLd0utC8oPY0Fkg@mail.gmail.com>
X-Gm-Features: Ac12FXwFaV57ByQOza5RjgJINg1kUBvl-S0wlTEa3Xmedc3ZsXtIATXwjIdJ5YM
Message-ID: <CAJZ5v0iAfgE4RkVXH7GaG9SqvGa0VfVuFi_cLd0utC8oPY0Fkg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: sysfs: Use sysfs_emit/sysfs_emit_at instead of sprintf/scnprintf
To: Joe Perches <joe@perches.com>
Cc: vivek yadav <vivekyadav1207731111@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 8:22=E2=80=AFPM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2025-09-05 at 22:57 +0530, vivek yadav wrote:
> > On Mon, Aug 25, 2025 at 8:58=E2=80=AFPM <vivekyadav1207731111@gmail.com=
> wrote:
> > > >
> > > > From: Vivek Yadav <vivekyadav1207731111@gmail.com>
> > > >
> > > > The ->show() callbacks in sysfs should use sysfs_emit() or
> > > > sysfs_emit_at()
> []
> > > > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> []
> > > > @@ -22,21 +22,21 @@ static ssize_t show_available_governors(struct =
device *dev,
> > > >                                         struct device_attribute *at=
tr,
> > > >                                         char *buf)
> > > >  {
> > > > -       ssize_t i =3D 0;
> > > > +       ssize_t len =3D 0;
> > >
> > > The variable rename is not necessary or even useful AFAICS ->
> >
> > There is no harm if we leave the variable name as 'i' but it would be b=
etter
> > if we give it a suitable name like 'offset'. It will definitely improve
> > readability.
>
> size and len are most commonly used.
> I prefer len.

Fine, in new code, use whatever you like, but what really is the
reason for doing a rename in code that has been almost unchanged since
2.6.22?

