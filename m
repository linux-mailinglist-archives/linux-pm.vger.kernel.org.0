Return-Path: <linux-pm+bounces-38269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC592C72739
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 07:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 34F2A29C05
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 06:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBF12EFD92;
	Thu, 20 Nov 2025 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=it-loops.com header.i=@it-loops.com header.b="e7zx6hOD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC012DA767
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621625; cv=none; b=P836kuiii17YCOo/dhg/ZygBVxmKpFm/t/PEVqP6RIGwjjUbbUsesFh7KWp413oDz7MCckG6FDMGMb1DlnTckkhxuB891hwylKhdoXK/K5c3SFDH2B9NhAzEilGZR4r4tb1bvBDcjlIEjVEin69mn9OBiGMlHojrdbd/e2uFMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621625; c=relaxed/simple;
	bh=zr0CBJGyuyaXtn/TDsv2TcK75UaPiBC/TUNcJrIzhaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9qZI1sW+Hg2GssKs9ngCqOn0NBB7SI42cZEXbnzwbYeSPxPUUFVOYxeh/N2q+LTtD3FNjlkyGXnSd0RbFlbhg15HUpNyLd4OIPGSlO0BhIxIxbTWXMApqnQrITM2tMlt4NpImnixTWbLM03qMFaCrSq3oaNRlDRleVOSiM+K20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-loops.com; spf=pass smtp.mailfrom=it-loops.com; dkim=fail (0-bit key) header.d=it-loops.com header.i=@it-loops.com header.b=e7zx6hOD reason="key not found in DNS"; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-loops.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-loops.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso822275a12.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 22:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=it-loops.com; s=google; t=1763621621; x=1764226421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zr0CBJGyuyaXtn/TDsv2TcK75UaPiBC/TUNcJrIzhaA=;
        b=e7zx6hODWljWhx/NDBltup3ltE4DNr1r/s4M5Fge58+invrWrJkIEaULzPAHDFtNiC
         FCicKPLb/qJzL4l7fcKbb7+cfbtSLJdLOOZOTe2/hNccfXdtU749Pi0nWfb67QT/4WiR
         DreKx56YERb/k/23RJwTCWko7i9RZ55ZPxSjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763621621; x=1764226421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zr0CBJGyuyaXtn/TDsv2TcK75UaPiBC/TUNcJrIzhaA=;
        b=URy6ppcfksQOOWO6Jt6XfZVIWUxVAHHNMHOUQNiMRVH8TPDYc3ktBBVviYxYUwILIX
         ss7pZzstzw1IOLOR5LnCE8oFs2k9NLXMJiZfEoA63mTmVoy4vCLKe8TRWTeeWfFtLMQU
         mgyn5+DXwiOOScbd1SnSIn7qHjg17M37py5IthIXqsOJp5vuVA9+JJdkyOB0WbLhXZBA
         WCPiZ3NqCLgilno2ok6tTGlEIxRLsIkLQJSc4Q3Gj3oh00KhlmOrDanYzzA9KJcg1tcG
         RdL7bq/JQcmXU/QTr7EhQAL4IaAJ+MCapehmBhWAYGvFA9S0ojVoZZzHRTwb9vRJL+ot
         Kl5g==
X-Forwarded-Encrypted: i=1; AJvYcCWKy97m1HdPqD8Bu+yn9OW8O3GVbo/fFgqv/k2dOSO6tuHnVX3WN08XI+Ax1ZCXtpI0vPWlUsqo/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo2g9sBSVJKf5FFvFzsiMojiIqh7O6546DBJEhVtkJp8FAIupS
	gCOmsgcMdZfwFEGL5q2PLuLkCofYI0GdxLO7t+kelzUu1n0e90w2vlpXCBlgBdugjRt8hhey1Ft
	wCRcEJXKHIl+bGdeuUshcxnoHJsELB1DaujeVLuYQab+0O9KXLoLsvuM=
X-Gm-Gg: ASbGnctgPdtn+9iYs86nGheZlmGD2IAuwJXUoRsQqxJK9RJFjYUDBgiYqGRv+KNb8QS
	ulRLiWNPQV3j7mgtqaNBdHlpsTO1sW9t/rLL2GV4S1oMHFGmZsm0cy23e2cAZj7WZgoT9Kc8W2x
	YvZSKaw2WqXNiWIH4+1RmpS4jnBD97oQiQ5ouiHs+CD1UosCXR3Jyf2TzJctqlwHMdtNhyAmfxq
	HCvEwRdrl7WW3SevdzNo8g/OIqrJKhLcTuelOFv+SPt6TyizRJkiflCevP7xAdQai2atRvbKTEk
	kbfvh+yg
X-Google-Smtp-Source: AGHT+IFDju7a6nSoanq8XycIM948k+1jT0tC4aFj2fiQdYIiPZGI+Boci8DqkHzsZeXu1mypd7pa22Z8g2CdRD7G7c4=
X-Received: by 2002:a05:6402:2345:b0:643:d1b:41d9 with SMTP id
 4fb4d7f45d1cf-6453821354cmr1475503a12.17.1763621621322; Wed, 19 Nov 2025
 22:53:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALG0vJuaU_5REU55Hg170LipPLj7Tt0V3icn7XzxLY-8+jsx-A@mail.gmail.com>
 <20251120055748.GM2912318@black.igk.intel.com>
In-Reply-To: <20251120055748.GM2912318@black.igk.intel.com>
From: Michael Guntsche <michael.guntsche@it-loops.com>
Date: Thu, 20 Nov 2025 07:53:30 +0100
X-Gm-Features: AWmQ_bk3JB7Og3Frs0hJzyS1Q8xlvPf9E9GnCyeC0LqfMilOvaT7FhHYRLzDcME
Message-ID: <CALG0vJtYLE3mz5EfyRVjW8-kgXvB+j3dYcXVbpYUb+4QNemzmg@mail.gmail.com>
Subject: Re: Oops when returning from hibernation with changed thunderbolt status
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 6:57=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Wed, Nov 19, 2025 at 06:43:16PM +0100, Michael Guntsche wrote:
> > Hello,
> >
> > I started seeing this issue with kernel v6.15, it worked fine up to 6.1=
4.
> > If my notebook went into hibernation with the docking station plugged
> > in and I then started it up again with the docking station unplugged
> > it would panic. Some times but not always it would also panic if the
> > dock was still connected.
> > With a lot of support from Mika (thanks again) I tried to debug this
> > issue for weeks but was not able to get any meaningful debug output.
> > Now finally with 6.18rc6 and freeze_filesystems set to 1 I managed to
> > get at least "something" showing up on my screen with a backtrace.
> >
> > Hibernating and waking up again works fine with no thunderbolt device c=
onnected.
> >
> > The device in question is a
> > Lenovo ThinkPad X1 Carbon Gen 11 with a 13th Gen Intel=C2=AE Core=E2=84=
=A2 i7-1355U
> >
> > Please tell me if you require more information or want me to try
> > something different.
>
> Did you try to disable RTC_DRV_EFI? At least from the backtrace that's
> where it crashes.
>
I tried this with all drivers removed also this one.

> Also I think I asked you to check with the distro kernel because I rememb=
er
> that you did some changes to get the crashdump working (please correct me
> if I'm wrong) so this could be related to that. For instance it is jumpin=
g
> to the crash kernel (through kexec) and tries to run EFI services related
> to RTC but they are not there anymore due to kexec.
The issue is reproducible with the current ubuntu and debian distro
kernels as well. After I tried it with the vendor version I switched
to the rc version to make sure it was not fixed in the meantime.

