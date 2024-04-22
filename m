Return-Path: <linux-pm+bounces-6820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517288AD17E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 18:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7D8287E1F
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B315153589;
	Mon, 22 Apr 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF69LuIA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC8153580
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801856; cv=none; b=XJa2FZS3/stuNAt9RehfNLZ677o2wJr8VfzjADBcYceRxwjsCqTOSko7+g2C4jIECaZuTLARGWPfrYxwBUyvsN/m6CnfJoEqmr+EsTObwJ61lnCdt0+lop9WAaYp2NIrZtYbTUW973/VRMmFGsqAwKIvY7ChnAVvn5Uxep7qctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801856; c=relaxed/simple;
	bh=kv1rDUKhFWJK/WnTyUTNRbq2aspxu1c+vFiiS6tbOQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ets6/7pkt9CWYPQBN8H48xqVGrnPuJXPiPgO+AzXaLgmRZ/YvBd7LpWAUo9IRDryJafhoNEq8QyqM3L3RJO0Sy5s8EK5V6zVdmZ7T2d1GDRyh2couKS8dtsZ1nR1+vAAW6ToFWCQgszbmYtSOWp5UNfDFslfoDh2owpshDIP3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF69LuIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE252C32786
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 16:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713801856;
	bh=kv1rDUKhFWJK/WnTyUTNRbq2aspxu1c+vFiiS6tbOQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cF69LuIAMO3J9W9YKkqCTf8pi6oiI0ASBSqIc3zF6v1pZKpwpd9r3Pih5n0cJxJji
	 YO69bbi1mpwWIDv7/fGKWwtRdAjVHdhRz66OCCiiQVA5Ida6rKuCdq/w5JNiDIrP/Z
	 EFBiOTz8uEQvz6MnqW5Fg9YL4xM6O7fXfY02cNaMmzsLz6ahyZrTDESm0FD22Znb9g
	 e3X4LVdfYhYwTKxtEUv0M1LS+YJneeC7xNT/ufB4mYeSpJjKgU3/tcl1Hd473gMfRm
	 UETe8Xsh2YkGTiuYs12PiOg74if916Bwh00mLPWZtf03Mk1FgyIqISKZ69+S7J+7he
	 1LbR/aB0hZYbA==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6eb7a4d64e8so1212932a34.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 09:04:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfiflwHORrFy/xa6OooSTq1vdVt4hD+iD7Fmb1MWBrMMNaunba7baosUiQjFg+AopZ83r5DB0I6zr1d7yuSWumOYhyM8Bo0YI=
X-Gm-Message-State: AOJu0YwVfbOf+WYlgOQ4ZxoMVCy86A1+NUEg9qujL2DypwrVgYU1x0R+
	8l2sQUM5WMYH56cfgE1Q3h9NOlWyghXBtfoFir5O2pfITsHS9P9ZbyQK/J/tFSon7aA/qfHCdcJ
	7bGOQn+j3YVkghaoNZ6QTZIJuSZE=
X-Google-Smtp-Source: AGHT+IGiS7/chjrczGmIoYQ5F9EW0YI+aEyPnTeRT71vYurnvkJhwOlZ1lAhxPnXxCapz0veNqY9V9viTCdzhTgtHXI=
X-Received: by 2002:a05:6820:26c3:b0:5aa:6a31:4f53 with SMTP id
 da3-20020a05682026c300b005aa6a314f53mr11403838oob.0.1713801855184; Mon, 22
 Apr 2024 09:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422093619.118278-1-xiongxin@kylinos.cn> <37847b26-1c1e-48d3-a74e-bd2bcc6e1fda@amd.com>
 <CAJZ5v0gmF0Lcy_nHSvTDnu4C3N0mipaeJqHff=00fgWdtwOzMw@mail.gmail.com>
 <2888cd41-65d9-4832-a913-399a074de7a9@amd.com> <CAJZ5v0ggFGSsPKWxowqn89WtLbmXVjUWZvc5KO-ab-UZHagR+Q@mail.gmail.com>
 <7b739eb8-573e-4479-9225-be3d2f4adbff@amd.com> <CAJZ5v0itOXsVCvU0kXgZA8v6OX5yy=RZn1d9FTe-fo1tqVy90w@mail.gmail.com>
 <cf3a8d4c-846e-4d7c-ba6e-b774dff420d8@amd.com>
In-Reply-To: <cf3a8d4c-846e-4d7c-ba6e-b774dff420d8@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 18:04:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jp2ici368ebaHyBjhdsEPbgkdNg4FLCfS6kAfNZjd7mA@mail.gmail.com>
Message-ID: <CAJZ5v0jp2ici368ebaHyBjhdsEPbgkdNg4FLCfS6kAfNZjd7mA@mail.gmail.com>
Subject: Re: [PATCH] Revert "include/linux/suspend.h: Only show pm_pr_dbg
 messages at suspend/resume"
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, xiongxin <xiongxin@kylinos.cn>, len.brown@intel.com, 
	pavel@ucw.cz, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:54=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 4/22/2024 10:43, Rafael J. Wysocki wrote:
> > On Mon, Apr 22, 2024 at 5:25=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 4/22/2024 10:18, Rafael J. Wysocki wrote:
> >>> On Mon, Apr 22, 2024 at 5:02=E2=80=AFPM Mario Limonciello
> >>> <mario.limonciello@amd.com> wrote:
> >>>>
> >>>> On 4/22/2024 09:45, Rafael J. Wysocki wrote:
> >>>>> On Mon, Apr 22, 2024 at 4:33=E2=80=AFPM Mario Limonciello
> >>>>> <mario.limonciello@amd.com> wrote:
> >>>>>>
> >>>>>> On 4/22/2024 04:36, xiongxin wrote:
> >>>>>>> This reverts commit cdb8c100d8a4b4e31c829724e40b4fdf32977cce.
> >>>>>>>
> >>>>>>> In the suspend process, pm_pr_dbg() is called before setting
> >>>>>>> pm_suspend_target_state. As a result, this part of the log cannot=
 be
> >>>>>>> output.
> >>>>>>>
> >>>>>>> pm_pr_dbg() also outputs debug logs for hibernate, but
> >>>>>>> pm_suspend_target_state is not set, resulting in hibernate debug =
logs
> >>>>>>> can only be output through dynamic debug, which is very inconveni=
ent.
> >>>>>>
> >>>>>> As an alternative, how about exporting and renaming the variable
> >>>>>> in_suspend in kernel/power/hibernate.c and considering that to tel=
l if
> >>>>>> the hibernate process is going on?
> >>>>>>
> >>>>>> Then it should work just the same as it does at suspend.
> >>>>>
> >>>>> Well, this is not the only part that stopped working AFAICS.  I'll
> >>>>> queue up the revert.
> >>>>
> >>>> I just tested the revert to see what happens to other drivers but it=
's
> >>>> going to have more collateral damage.
> >>>>
> >>>> ERROR: modpost: "pm_debug_messages_on"
> >>>> [drivers/platform/x86/amd/pmc/amd-pmc.ko] undefined!
> >>>
> >>> What about removing the "pm_suspend_target_state !=3D PM_SUSPEND_ON"
> >>> part from pm_debug_messages_should_print()?
> >>>
> >>> This should be as good as the revert from the POV of restoring the
> >>> previous functionality.
> >>
> >> That would probably help this reported issue but it's going to be REAL=
LY
> >> noisy for the pinctrl-amd driver for anyone that sets
> >> /sys/power/pm_debug_messages.
> >>
> >> There is a message in that driver that is emitted whenever a GPIO is
> >> active and pm_debug_messages is set.
> >>
> >> It's a really useful message for tracking down which GPIO woke the
> >> system up as the IRQ that is active is the GPIO controller master IRQ
> >> not an IRQ for the GPIO.
> >>
> >> But if that change is made anyone who sets /sys/power/pm_debug_message=
s
> >> is going to see their kernel ring buffer flooded with every since
> >> interrupt associated with an I2C touchpad attention pin (for example).
> >>
> >> So if the desire really is to back all this out, I think we need to al=
so
> >> back out other users of pm_pr_dbg() too.
> >
> > OK, so it needs to check hibernate_atomic in addition to
> > pm_suspend_target_state.
>
> Yeah, that sounds great to me.

OK

> Tangentially related to the discussion; how would you feel about a
> /sys/power/pm_wakeup_gpio?  Or /sys/power/pm_wakeup_gpios?
>
> If we did the plural and used a comma separated list we could probably
> axe the message I mentioned above from pinctrl-amd all together.

That would be too specific IMV.

The whole idea with pm_debug_messages is to switch them all on or off in on=
e go.

