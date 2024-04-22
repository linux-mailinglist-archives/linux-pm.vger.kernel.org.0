Return-Path: <linux-pm+bounces-6816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694738AD122
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2153D285BCF
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB181534E2;
	Mon, 22 Apr 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIIx+VNM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07066152509
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800627; cv=none; b=oiCNjtgj/0rd79U4DXWBj7l23UBDbzQzH3iyncqEwImX7ClPdj9CMCKkiJMY5bxQjvWXZ1Lb6WSCvLCrpm0RO1wI/dCuPB3rvyGrX+J3oMma8YIebH0ou+BMtgIP9F4LF1dKF/POyQa9Cn0fKXmEI+Rqa3wtRPAN1TuKAHcqRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800627; c=relaxed/simple;
	bh=UaAJ/hOmEQZg76kGABsoFNnEM9N9D3xtnOnnILvvFf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2/YhsiRoWNb2HBG1d6bMZ9nJbUojlbs7eWDdFGVceqHvA/Z+vdFFY3wpxvxC/L6FbACfIS39oTHeU/HZpDnOQhJogHvNV26sG/GuCzpL1KTO279UKi5h/PKyLlb34EWjq6OszxJA2ouVUKQS3/Cg8yPvzUSxc/uk1G8lh4+W0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIIx+VNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79E6C113CC
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713800626;
	bh=UaAJ/hOmEQZg76kGABsoFNnEM9N9D3xtnOnnILvvFf8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bIIx+VNMsbvMbHC3C9H7eeQ/FyDe/USEv4/fkejbmzhEELfY2E22PMSCcwwcNEylz
	 NzS/BQTKhriLnIrYcaDUNARfr5MgRdQprYapcJncQsjo0WPAJAVkVEV0K0XPRpsw+Q
	 T1kr6mRgjMg3OWqHSLsVS0uA5hc2OOFX85MT/voCDDJeVb/L207uyJdhah0FlkEMja
	 g0/iU3uBqfcJ/p3cwb6P62LNnmLKvO7ntceS0lCytoTqMX08c+2b/xI3dg//1L0HPi
	 tZzKL/5UF8MYiBmwJ/Nc/3YAW3ptDaltek/K+2Pak8TPeQ17ofkyodRAO2g+bII2Un
	 5SBa9c+MjgvMw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5acdbfa6e94so1208173eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 08:43:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXtopTqPuW3LEi/HB95/+MMlMjZNg9rDVxhI+qyGK3iZelKNVxNHTTs2J3Jn4RkPVYPQ0YVluha65jAswarstFNgJWROz8Sh0=
X-Gm-Message-State: AOJu0YzRehBIkIof0m2v+UJUgWyW23Gy/PCeQL80CJYf/wf2gKND+tWt
	lp8SvsvCR5qUXk9qBepovLc16YWZsk40+uFLBFOSvll6DgBtUpVLDXlhwBCSasNSTce2yxRQk/3
	LU+pXiDSW4uFFzW75rsfs1gwtQgs=
X-Google-Smtp-Source: AGHT+IFNsdJYYVFb1Nqtru6criaZ3HoK7/PE0/Nb9taHcgkBQQJNcI2j4shX13jnbSM635WvRETu4D8Wdif9Qdklqdk=
X-Received: by 2002:a4a:de19:0:b0:5a7:db56:915c with SMTP id
 y25-20020a4ade19000000b005a7db56915cmr11703753oot.1.1713800625948; Mon, 22
 Apr 2024 08:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422093619.118278-1-xiongxin@kylinos.cn> <37847b26-1c1e-48d3-a74e-bd2bcc6e1fda@amd.com>
 <CAJZ5v0gmF0Lcy_nHSvTDnu4C3N0mipaeJqHff=00fgWdtwOzMw@mail.gmail.com>
 <2888cd41-65d9-4832-a913-399a074de7a9@amd.com> <CAJZ5v0ggFGSsPKWxowqn89WtLbmXVjUWZvc5KO-ab-UZHagR+Q@mail.gmail.com>
 <7b739eb8-573e-4479-9225-be3d2f4adbff@amd.com>
In-Reply-To: <7b739eb8-573e-4479-9225-be3d2f4adbff@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 17:43:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0itOXsVCvU0kXgZA8v6OX5yy=RZn1d9FTe-fo1tqVy90w@mail.gmail.com>
Message-ID: <CAJZ5v0itOXsVCvU0kXgZA8v6OX5yy=RZn1d9FTe-fo1tqVy90w@mail.gmail.com>
Subject: Re: [PATCH] Revert "include/linux/suspend.h: Only show pm_pr_dbg
 messages at suspend/resume"
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, xiongxin <xiongxin@kylinos.cn>, len.brown@intel.com, 
	pavel@ucw.cz, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:25=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 4/22/2024 10:18, Rafael J. Wysocki wrote:
> > On Mon, Apr 22, 2024 at 5:02=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 4/22/2024 09:45, Rafael J. Wysocki wrote:
> >>> On Mon, Apr 22, 2024 at 4:33=E2=80=AFPM Mario Limonciello
> >>> <mario.limonciello@amd.com> wrote:
> >>>>
> >>>> On 4/22/2024 04:36, xiongxin wrote:
> >>>>> This reverts commit cdb8c100d8a4b4e31c829724e40b4fdf32977cce.
> >>>>>
> >>>>> In the suspend process, pm_pr_dbg() is called before setting
> >>>>> pm_suspend_target_state. As a result, this part of the log cannot b=
e
> >>>>> output.
> >>>>>
> >>>>> pm_pr_dbg() also outputs debug logs for hibernate, but
> >>>>> pm_suspend_target_state is not set, resulting in hibernate debug lo=
gs
> >>>>> can only be output through dynamic debug, which is very inconvenien=
t.
> >>>>
> >>>> As an alternative, how about exporting and renaming the variable
> >>>> in_suspend in kernel/power/hibernate.c and considering that to tell =
if
> >>>> the hibernate process is going on?
> >>>>
> >>>> Then it should work just the same as it does at suspend.
> >>>
> >>> Well, this is not the only part that stopped working AFAICS.  I'll
> >>> queue up the revert.
> >>
> >> I just tested the revert to see what happens to other drivers but it's
> >> going to have more collateral damage.
> >>
> >> ERROR: modpost: "pm_debug_messages_on"
> >> [drivers/platform/x86/amd/pmc/amd-pmc.ko] undefined!
> >
> > What about removing the "pm_suspend_target_state !=3D PM_SUSPEND_ON"
> > part from pm_debug_messages_should_print()?
> >
> > This should be as good as the revert from the POV of restoring the
> > previous functionality.
>
> That would probably help this reported issue but it's going to be REALLY
> noisy for the pinctrl-amd driver for anyone that sets
> /sys/power/pm_debug_messages.
>
> There is a message in that driver that is emitted whenever a GPIO is
> active and pm_debug_messages is set.
>
> It's a really useful message for tracking down which GPIO woke the
> system up as the IRQ that is active is the GPIO controller master IRQ
> not an IRQ for the GPIO.
>
> But if that change is made anyone who sets /sys/power/pm_debug_messages
> is going to see their kernel ring buffer flooded with every since
> interrupt associated with an I2C touchpad attention pin (for example).
>
> So if the desire really is to back all this out, I think we need to also
> back out other users of pm_pr_dbg() too.

OK, so it needs to check hibernate_atomic in addition to
pm_suspend_target_state.

