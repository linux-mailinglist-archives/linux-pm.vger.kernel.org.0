Return-Path: <linux-pm+bounces-30690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BE9B01DFD
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 15:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC0F1CC0B7D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC70B2D375D;
	Fri, 11 Jul 2025 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY1bE8Nv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10042C17A8;
	Fri, 11 Jul 2025 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241234; cv=none; b=N9gugotSaMoqOY5XaHMNFzu+VfcTxLViZz0RCl/FbvqtOde0Tg3sniSQ6mZRu7vY58JagD4C+WgfsdmlZhYJcgC+X6CahUuaqT+edYAaJ3rXsXOzV21iA5y7vDaD7JUABoXdaxyqVU30eDjOO8R+rUNa7GTCIwLnW3DOe3NXrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241234; c=relaxed/simple;
	bh=kHW409c2TBaU4M7cj18B4wU4/Ok8QufCBhSsllw1mk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxaFuTKlX4rU1BtNuZsls4+KksWuZ/eabuJD68C/7b63ncxYDkqVQq2oEyZ7Jl9EJmQXyFAkIINHW9hpbQT8CuX0yjA8G3Qp3McpGsgpym/JSO51i4OzsCsByVCmRyMdQIPpZl+myinc/mCjvQ5fY6R85HwEx2lkEFMvUk9v4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY1bE8Nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104D3C4CEED;
	Fri, 11 Jul 2025 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752241234;
	bh=kHW409c2TBaU4M7cj18B4wU4/Ok8QufCBhSsllw1mk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fY1bE8NvnLL5UtjPBZhAdg3r0S8sKIQ3rgm9YDUo6lG65fE8GoJJlTof54/LMPkj4
	 c1lebIDA1Ht2DL1JJgUC+A4xSa4jywU/nEDJKhTPAZsksWU2pymVqIberRWI9GzDL8
	 jFV8zraxRIOjY/J2YNANAhECfNEHOM1XtgBveXW4AUVpyIvEwbBOWBHc9ZyaMZpaMo
	 Pym38AUYs5UQgUI2MVEccpAz4ECI9i/MDhyhreSHwQnblzoBJl2mXf1acNbwqcftPI
	 eJi1Y8kNAwojyCi9QnJI2o4ytSPnZoXRhZjSa15oS+pA6P6RBlkvfp2j8pWsq77seP
	 w0jdvGrkGzHVA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61208b548e8so572580eaf.3;
        Fri, 11 Jul 2025 06:40:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHQJwKwPTeq4XL/ipJnMk6W2Gc5zc8VgGBZejt656SdNMxb73q49X75lROJbH4Ff2iGrbsw0luIWg=@vger.kernel.org, AJvYcCXFeLAG8j99EmF/Yu1zqXQpBTWUe+Yzos/Km/ZcZNc3o3hcBqKVugoaaO2LMa0mZEyCH+pV+VzoTBY=@vger.kernel.org, AJvYcCXp6TokOlTji9z/xUOenSueqfTv03nb9GC7B+YjabFdwAtfISRU+V0um1uR30CQoCdtFuYlixJnQYqtN9aI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi9m5TJcmTkbZLxJG1jevcwtfJxfchALGCc0F+eQqgfWZIhnyb
	XIaWgE8ADq3AaNbbS+VknB1SNqLvKKIKaYcp4HtZJZqj1R9OM0dOwr87vDLyuNc98eLKaxqkBvF
	yuedWnAY/9ztZIicL/6mU+22vceLUQGE=
X-Google-Smtp-Source: AGHT+IHYWUrT5/T8j5mPbE9LSBXdxoqRH1k/FXMiOLTMeg6kls7Rig+ps7//jB2hu/AhIcv3YM+yywrmdImt64YZ0L4=
X-Received: by 2002:a05:6820:2913:b0:613:cd27:2fe0 with SMTP id
 006d021491bc7-613e5efcb97mr2478213eaf.1.1752241233380; Fri, 11 Jul 2025
 06:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-pm-async-off-v3-1-cb69a6fc8d04@linaro.org> <b3de1e2b-973f-4b4a-83f3-6015808b3772@linaro.org>
In-Reply-To: <b3de1e2b-973f-4b4a-83f3-6015808b3772@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Jul 2025 15:40:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hJjbp0qBZh1Jj3hVHrZV1CLeCgrOVseSGS+7=1r7onYA@mail.gmail.com>
X-Gm-Features: Ac12FXzDgl_lWOpU6WHqno1wGO4QZHusIJZc9tKNWFd40y80OKUoGkHCmJLRyUA
Message-ID: <CAJZ5v0hJjbp0qBZh1Jj3hVHrZV1CLeCgrOVseSGS+7=1r7onYA@mail.gmail.com>
Subject: Re: [PATCH v3] PM: add kernel parameter to disable asynchronous suspend/resume
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	peter.griffin@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
	kernel-team@android.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 3:21=E2=80=AFPM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
>
>
> On 7/9/25 1:31 PM, Tudor Ambarus wrote:
> > On some platforms, device dependencies are not properly represented by
> > device links, which can cause issues when asynchronous power management
> > is enabled. While it is possible to disable this via sysfs, doing so
> > at runtime can race with the first system suspend event.
> >
> > This patch introduces a kernel command-line parameter, "pm_async", whic=
h
> > can be set to "off" to globally disable asynchronous suspend and resume
> > operations from early boot. It effectively provides a way to set the
> > initial value of the existing pm_async sysfs knob at boot time. This
> > offers a robust method to fall back to synchronous (sequential) operati=
on,
> > which can stabilize platforms with problematic dependencies and also
> > serve as a useful debugging tool.
> >
> > The default behavior remains unchanged (asynchronous enabled). To disab=
le
> > it, boot the kernel with the "pm_async=3Doff" parameter.
> >
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> > ---
> > Dealing with the pixel6 downstream drivers to cope with the changes fro=
m
> > https://lore.kernel.org/linux-pm/10629535.nUPlyArG6x@rjwysocki.net/.
> >
> > Similar to what people already reported it seems pixel6 lacks proper
> > device links dependencies downstream causing i2c and spi client drivers
> > to fail to suspend. Add kernel param to disable async suspend/resume.
> > ---
> > Changes in v3:
> > - update documentation with "pm_async=3D" and "Format: off" (Randy)
> > - reword documentation to make it clear "on" isn't a selectable option
> >   for pm_async because it's the default behavior.
> > - Link to v2: https://lore.kernel.org/r/20250708-pm-async-off-v2-1-7fad=
a54f01c0@linaro.org
> >
> > Changes in v2:
> > - update the documentation and the commit message to describe that the
> >   "pm_async" kernel parameter provides a way to change the initial valu=
e
> >   of the existing /sys/power/pm_async sysfs knob.
> > - Link to v1: https://lore.kernel.org/r/20250708-pm-async-off-v1-1-1b20=
0cc03d9c@linaro.org
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
> >  kernel/power/main.c                             |  9 +++++++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index f1f2c0874da9ddfc95058c464fdf5dabaf0de713..06beacf208de3242a3b4bb2=
413ab6cd3e0083f15 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5000,6 +5000,18 @@
> >                       that number, otherwise (e.g., 'pmu_override=3Don'=
), MMCR1
> >                       remains 0.
> >
> > +     pm_async=3D       [PM]
> > +                     Format: off
> > +                     This parameter sets the initial value of the
> > +                     /sys/power/pm_async sysfs knob at boot time.
> > +                     If set to "off", disables asynchronous suspend an=
d
> > +                     resume of devices during system-wide power transi=
tions.
> > +                     This can be useful on platforms where device
> > +                     dependencies are not well-defined, or for debuggi=
ng
> > +                     power management issues. Asynchronous operations =
are
> > +                     enabled by default.
> > +
> > +
>
> I just noticed an extra new line here, that checkpatch didn't catch.
> Please let me know if I have to resubmit, or it can be amended
> when/if applied.

No worries, I've already applied the patch.

The extra new line can be removed separately.

Thanks!

