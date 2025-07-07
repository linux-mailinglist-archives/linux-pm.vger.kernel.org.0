Return-Path: <linux-pm+bounces-30309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603DFAFBBA3
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 21:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521BE7A7EA3
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 19:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F33262FE5;
	Mon,  7 Jul 2025 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk9jQMZR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31D242D7E;
	Mon,  7 Jul 2025 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915865; cv=none; b=dV418/rptGCVE1EtTkLVWhO0GyB6ushn5ZfVN+xHzWLm99LF5Wr4BvsvogLGeWf8LjbeYisI5SPaPIVvuWq1In+P+EopTABud+JMTo8ab5apjJ4lYuanwhVvJNxKTcDaFzkD/r21558UHhc25t0Toxj1kJIsXLDDaGi6LK60jV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915865; c=relaxed/simple;
	bh=X58se4pufgFYDvpX4RDVuu3hHsO7uUWKHZToESh/FC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJC+JfSUWjnqcZiUP4e0gRULMieHdTMd7w+N0IOObRVklHbC0+85rRIdfNlJXYSq1Qp7HvLNcM58kAn0DgnPSKuKRbVDZvcNWAneC6V/HkunKxjI8iDPgrV8nD27wlEFz4cVdQ5nTmxrPYFHJwwGJl8492KI98QSkVdRZT6IKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk9jQMZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D785AC4CEF9;
	Mon,  7 Jul 2025 19:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751915864;
	bh=X58se4pufgFYDvpX4RDVuu3hHsO7uUWKHZToESh/FC0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kk9jQMZRKG2PlUf9xk+DjlJCYb6Z1Rue5IrSXQuoPOvCmE+GfB/OS/yZ6kugg8GOS
	 fwz8iBbQpv0pCaFtfyyQCur4AAOtD23NFyylB55KYw6Bpi/c3k9v0z8eUutp7l1kvd
	 K6IVV9QUIXvfropr19eM+gHliN13MC8o4L//VMUr2b+lab4uCWUWC8TneTKfJSOLc8
	 gEhC1cC7Iw2joC8Ek8NSALgRkl2BDrSF4krThfqQnihmycYY6pc/8S6TlQP6/GWudx
	 h6kQ6GsJjRP1+3dWVP7w7+fML73pu6tEPdqlHOyoKqx+Wp3977eWH5ooXWQwt19sIs
	 n/BlpFgN7eurg==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6113e68da82so1736391eaf.1;
        Mon, 07 Jul 2025 12:17:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFIOj/kjUv0vrLgtu9skwFck1KpwBZpPzDPemXuCVHCSFdhb76xW+k0NIH5c/5SryAIldTkRvsSq0vPWA=@vger.kernel.org, AJvYcCXr6Xsqgsu556qJPHUUkV0+fsT5P6oqEpqpEvd4VLPyYG9QmGJMGTrUXDzqinkf6zVBe2jl8IgBd2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFw6piUwTTlusIz5O1IIqhfXOSqpgtapLm1yBljdDjOQMdhTx8
	lfmu0z/7DVlylNsrpK4Uq43aDx3vPZ05dFrtFLZzuxe1K/fmsJeru2om3MBZC5yHuY2WfzDESn1
	jKoYZPF4kPb71/Am1LCYtYvC/FxZha5Q=
X-Google-Smtp-Source: AGHT+IFvvGre2qKtisDKi84+JIJG0BNJKCNho0uAzGYlxwaCn2fgCOqGP0+8tfw2ciOjUepnmH58MZ/QJmKYTv+DXoE=
X-Received: by 2002:a05:6820:4b07:b0:611:7385:77a0 with SMTP id
 006d021491bc7-613c10ca61dmr86938eaf.4.1751915864050; Mon, 07 Jul 2025
 12:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704101233.347506-1-guoqing.zhang@amd.com>
 <20250704101233.347506-5-guoqing.zhang@amd.com> <2c609512-ebe8-4a61-a666-44b308975d72@amd.com>
In-Reply-To: <2c609512-ebe8-4a61-a666-44b308975d72@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Jul 2025 21:17:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0in0Qj5QR5GLNB+1JjOh3rbOR3YB91kr40OSy0ygOWLGg@mail.gmail.com>
X-Gm-Features: Ac12FXyry_ZMX4wIeZua_zevr27j-iIjf-OututexrSMWXUO4cFW0hY8Xsxad8c
Message-ID: <CAJZ5v0in0Qj5QR5GLNB+1JjOh3rbOR3YB91kr40OSy0ygOWLGg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] PM: hibernate: export variable pm_transition
To: Mario Limonciello <mario.limonciello@amd.com>, Samuel Zhang <guoqing.zhang@amd.com>
Cc: lijo.lazar@amd.com, victor.zhao@amd.com, haijun.chang@amd.com, 
	Qing.Ma@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	alexander.deucher@amd.com, christian.koenig@amd.com, len.brown@intel.com, 
	pavel@kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org, 
	airlied@gmail.com, simona@ffwll.ch, ray.huang@amd.com, matthew.auld@intel.com, 
	matthew.brost@intel.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 10:40=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 7/4/2025 6:12 AM, Samuel Zhang wrote:
> > https://github.com/torvalds/linux/blob/v6.14/Documentation/power/pci.rs=
t?plain=3D1#L588
> > Per this kernel doc, dev_pm_ops.thaw() is called mainly for resume
>
> Proper way to do this is to put the URL in a 'Link' tag above your SoB.
> That being said I don't think we need to reference the rst file.  Just
> reference the html file.
>
> Something like this:
>
> Per the PCI power management documentation [1] dev_pm_ops.thaw() is
> called mainly for resume.
>
> .
> .
> .
>
> Link: https://docs.kernel.org/power/pci.html [1]
> S-o-b: Foo bar <foo@bar.com>
>
> > storage devices for saving the hibernation image. Other devices that no=
t
>
> that are not
>
> > involved in the image saving do not need to resume the device.
> >
> > But dev_pm_ops.thaw() is also called to restore devices when hibernatio=
n
> > is aborted due to some error in hibernation image creation stage.

This isn't factually correct.

dev_pm_ops.thaw() can be called in an error path in two cases: (1) the
"freeze" transition before the creation of a memory snapshot image
fails and (2) the "freeze" transition during restore (before jumping
back to the image kernel) fails.

> > So there need to be a way to query in thaw() to know if hibernation is
> > aborted or not and conditionally resume devices. Exported pm_transition
> > is such a way. When thaw() is called, the value is:
> > - PM_EVENT_THAW: normal hibernate, no need to resume non-storage device=
s.
> > - PM_EVENT_RECOVER: cancelled hibernation, need to resume devices.
>
> If these events are being exported out for driver use I think that we
> also need matching kernel doc exported too.
>
> That is the comments in include/linux/pm.h need to be converted into
> kernel doc.
>
> Before you make any changes like that though let's see what Rafael
> thinks of this approach.
>
> He might not want to export this symbol out and would prefer a new
> helper for drivers to use like:
>
> inline bool pm_aborted_hibernate();
>
> If that's the direction he prefers you'll need to make kernel doc for
> that instead.

I would prefer a wrapper around pm_transition returning pm_transition.event=
.

It can be called pm_transition_event() even as far as I'm concerned.

Thanks!

