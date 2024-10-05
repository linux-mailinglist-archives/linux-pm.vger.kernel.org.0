Return-Path: <linux-pm+bounces-15214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1269991877
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 18:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF3A1C21087
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 16:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B8156968;
	Sat,  5 Oct 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="MSRJKt/Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE868F70;
	Sat,  5 Oct 2024 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147049; cv=none; b=PUgrrSPOq6vw5pFOWuka5RZYAiMjskWB6rMnmIhDNUC6N9MXABWeT2HVLKo7XrmFVSWsOHQpX9mJ/GkC64n2tlgEl9lAXROAJsNmXTzPRK8T63UkoWwMlkOaXREbaXfXck1BFL9BEtOKzM5qGKHTX2VESpG8XhByszoUw2dUl3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147049; c=relaxed/simple;
	bh=YBV6mfTIKnepqgnaM+TIyychQPSBRJqk4KGM3GWeKg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KA6iSFI0F6otCJhxQc7C4fG1tPNFlcC7BMPlPZ0hrgxf2FG9mtBctlOvBnIHrT8FFkVzBoJiz+hPUOkAvaAtpUL7/rCXjxr7GykQ5XPAjL/OnQAIMtc5UJBkeDoaZMfGGXauuoPqk+kbgYHtkPhVz8P8FIgUUJFcAHKxhwdXbHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=MSRJKt/Y; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 787202E0A734;
	Sat,  5 Oct 2024 19:50:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1728147044;
	bh=YBV6mfTIKnepqgnaM+TIyychQPSBRJqk4KGM3GWeKg0=;
	h=Received:From:Subject:To;
	b=MSRJKt/YfKHt+QU2qr5qbMnGoGnuL9hkQPT2BS7S4Xk+ArYHk8McD5W1bt6H5zpJ4
	 CXvw/ErwfW9GZ2mlntqW67bWfkcYiAxVIgQ6O3GcwIFWsWOXn2tjVNJSmvpbqLBrBc
	 VSpnswN9L6hxWSgYzWtgaHXrxg2oBHBQw7qhwsYE=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-2facf481587so27326551fa.1;
        Sat, 05 Oct 2024 09:50:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWm3axgyVh+dc8Awx7aFk18k5A2yYWYDbO03zZpWFjc4sTIuVgqheBuCNRnmOAXmWEo5lY9fRnr+ymENrjbfBwraWno@vger.kernel.org
X-Gm-Message-State: AOJu0YxutsPgKRJYLngh0Wt5PfydFG8NfWqLK8RVGoYKK9X6tA6VC7rD
	LK4r3cbtCpxTNX6uDYhNvki7X5TOeN51zA5k9MTD6Purdo0O065lWDnSUtznByW+ApDAdDMbNrD
	5u+z4GGFDSqdodq6k+VRVsLQH6y0=
X-Google-Smtp-Source: 
 AGHT+IH0im5O/4KUAV9R6eTMaMuWIyNIVpGuh68pinQyJ6OCp2jbhrqDiN1f2OBJau+y5WUEvQT1GAwRfS1anFqP7oo=
X-Received: by 2002:a05:651c:150a:b0:2fa:c2c4:f9f5 with SMTP id
 38308e7fff4ca-2faf3d7128emr25068371fa.38.1728147042709; Sat, 05 Oct 2024
 09:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922172258.48435-1-lkml@antheas.dev>
 <134adbb7-06c5-4b6a-a8b9-abb973784f73@redhat.com>
 <CAGwozwG49xkWoFVybsVzpa=eG1U2YVCMdr8qc-HwRWSqEKCv0g@mail.gmail.com>
 <c19490b6-dc4b-47b3-b422-d244a6b87e5e@redhat.com>
 <f8042679-a469-4aaa-8671-a6dcaa894e8c@redhat.com>
In-Reply-To: <f8042679-a469-4aaa-8671-a6dcaa894e8c@redhat.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 5 Oct 2024 18:50:31 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFPb9JpbYd+P0M4Q2eQF8CmLhx_j15L_-WcuawizR26Tg@mail.gmail.com>
Message-ID: 
 <CAGwozwFPb9JpbYd+P0M4Q2eQF8CmLhx_j15L_-WcuawizR26Tg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>, luke@ljones.dev,
 me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172814704387.4750.12918478454761795579@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Sat, 5 Oct 2024 at 18:27, Hans de Goede <hdegoede@redhat.com> wrote:
>
> p.s.
>
> On 5-Oct-24 6:24 PM, Hans de Goede wrote:
> > Hi Antheas,
> >
> > On 5-Oct-24 5:10 PM, Antheas Kapenekakis wrote:
> >> Hi Hans,
> >>
>
> <snip>
>
> >>> IMHO it would be good to submit a v2 of just patches 1 - 3 run through
> >>> checkpatch. Also the commit message of patch 3 should point to the existing
> >>> quirk code in asus-wmi.c and mention that then is no longer necessary after
> >>> patch 3, then we can discuss what is the best place for these quirks.
> >>
> >> I did run it through before sending the patch. However, some of the
> >> warnings were a bit cryptic to me... I will run it again.
> >>
> >> I will add a note for asus-wmi on future patch series.
> >>
> >> First 3 patches of the series are designed to NOOP before patch 4. Did
> >> you mean patch 3 (which adds the delay) instead of 4?
> >
> > Ah I misread the series and failed to notice that patch 4 actually hooks
> > things up, I was under the impression that patch 4 hooks things up.
> >
> > But I did mean that patch 3 might lead to discussion not patch 4.
>
> Oh and upon re-reading the series I see that pathc 5 is just dropping
> the quirks from asus-wmi.c, which is fine.
>
> I somehow thought that the later patches where adding a way for userspace
> to already enter the LPS0 display off state earlier. No idea how that
> idea got in my head ...

Done this way to hopefully be easier to upstream and get this fix out
sooner. The plan here would be 3 series: 1) move Display On/Off +
quirk, 2) move Sleep Entry/Exit + Quirk, 3) RFC for exposing to
userspace, in which case if the kernel starts to suspend while in
standby it would skip those calls.

Antheas

