Return-Path: <linux-pm+bounces-14064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB5D97620D
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 09:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F271C22AF9
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 07:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CF9189B8F;
	Thu, 12 Sep 2024 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KlIInfdY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3192B1885AD
	for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124547; cv=none; b=sxhR1IUHi6g5N6rVQDVZR1ZgRzCgfgnWxAh+r0e68EJjmbVsrhaYf3TXWQjreKInX/EsSTGRDH6kIdwpvSJGuh8HAh/XCmYjE5YYApgNNqYgQ781QoVSR6fTfqiBKh8JQHNMfFAlF3h084Z0HssoX0c+XXaMldlBVXLx9sRrILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124547; c=relaxed/simple;
	bh=lDzL+/bkYxaNRuuGM0blmhB5eknPwvACk7Gzegus+NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7Ys/xJw/bGSNDqB3YrcXZgNCe8URuaG9gmysWVvWPtgjxIkPk4nznw9Y6R+wUQFJ5vI0gjthRbZ5ku8LalcPizUWaRscuhQoWFtBBzMUdjOdqkzAVyKIGNYp5YpsmEbWAopTFoRu9KqBXZ5KsoT/SFPzSHtMC+gyo78OB6BLhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=KlIInfdY; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 064D23F1BD
	for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 07:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726124543;
	bh=1CKMTCTTm7jqXVJcpUxDxIfDKzM8XfvNoAgn0SaBro4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=KlIInfdYocxaSNQQq5/ctVcVAT8fUjJXDlXF2JuJNp3wpjsV+I7lMAq5hjWUPRp5a
	 STWrxzgFArT3leI8GKRSaikEHIU95ZCmISr6uGu3L/w5U/IC22KKhCrQdu9pB/6LBh
	 EK5Cp+MNxFUIL+KmB2+KQ+HekkTsmpymEo9EHuDiH98EQAwvAxfxsqnzvzk3y9EB+i
	 48A4SPNb9UXoFZXjLQNBpTWg1vGe32kiYSc/HPqh+M1rILQZAtRFJAihdj5TdpTIOi
	 lADCEtSZHCRZ0oxsVPV15TfHPLvOtbVnMFyu/crtYgf1SLDq+1XVZ/YeIT47s4vF6X
	 5v5pdzJnwqn0w==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-535681e6f8eso468883e87.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 00:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726124542; x=1726729342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CKMTCTTm7jqXVJcpUxDxIfDKzM8XfvNoAgn0SaBro4=;
        b=KRO8DPbQsr9xF9rkDNSypRMB0Ew7eGNl6xxwrGQiyX5HFrtIfvixor2cOIMzLwppzj
         hLVgvJvTtyaX9w8brqlMigj1p63HRVkjPFS3x4ESdRd6cFObhD1mwTe1hzHDn9vAo6HC
         l1N/8/egnWb5z/ZnQb2hpo7zn0X0sIu6cAaggkr3xWF+UlVD4DRi29zBcmWOTRyESUIv
         9q8jCrkoV+GR0D8RhvGfm2087hMYjdVVTB+Gz7ZY9BjTHhG8b4jXDX6r6YsGKu4y7UxK
         RG6938AxHKPc/iiO5unKTQ9xj9Iap+Fpzjf6waEuIJwl4BqB0ugl0fmUnaqf0Jsvtysh
         pbag==
X-Forwarded-Encrypted: i=1; AJvYcCVhFTja+mIJT5mIzK/lmnJThMt/gFCq+4bJPYwKVkmJTtYs6kXV24PsWg+3hPT0/7PU2w3cwsblrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXc5VTLxD3Ff3LF4D6oeuXwd05Z/R//Uz366h2orr803d0huCq
	n7TNCamC0vF+iHQlKNOOvP/Y5LO8avNP/WR0KWJRBANlGfxtyBe8CB9aU2V9vFGEF8zE1MTAVOs
	11mYTXBc6N2jGtTMVsmbtG5RIgZFevxT9csr2f4B6n7AzpLi6Ym8lrW9XpgzbIP7J6wKK7ALZv5
	z3CQB5jz5Mwf5Xv71Slort8p0NOEYex5tBC0CrT8VbQ6idh9M=
X-Received: by 2002:a05:6512:334d:b0:536:7a24:8e82 with SMTP id 2adb3069b0e04-5367a24908emr533434e87.13.1726124541974;
        Thu, 12 Sep 2024 00:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuwOtWwPuErUCydeoa2yBkKx7aUuc0DgfJKxXEK5w5XG0mdKRr+ESyjKNT9pgNj/ndfRUhOjPcEeAtHU54puA=
X-Received: by 2002:a05:6512:334d:b0:536:7a24:8e82 with SMTP id
 2adb3069b0e04-5367a24908emr533415e87.13.1726124541340; Thu, 12 Sep 2024
 00:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911190516.GA644336@bhelgaas> <319e5419-3b12-4672-9f51-f90c5e142e29@amd.com>
 <fa504022-acb3-4930-b6b8-87a8dcb912c3@amd.com>
In-Reply-To: <fa504022-acb3-4930-b6b8-87a8dcb912c3@amd.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 12 Sep 2024 15:02:08 +0800
Message-ID: <CAAd53p4ZpCF0GpGhzUx_7V8M2+YCsxgMz8CePPGG_fBTG0JzZA@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, 
	mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kaihengfeng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 3:38=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 9/11/2024 14:16, Mario Limonciello wrote:
> > On 9/11/2024 14:05, Bjorn Helgaas wrote:
> >> On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
> >>> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> >>> connected.
> >>>
> >>> The following error message can be found during shutdown:
> >>> pcieport 0000:00:1d.0: AER: Correctable error message received from
> >>> 0000:09:04.0
> >>> pcieport 0000:09:04.0: PCIe Bus Error: severity=3DCorrectable,
> >>> type=3DData Link Layer, (Receiver ID)
> >>> pcieport 0000:09:04.0:   device [8086:0b26] error
> >>> status/mask=3D00000080/00002000
> >>> pcieport 0000:09:04.0:    [ 7] BadDLLP
> >>>
> >>> Calling aer_remove() during shutdown can quiesce the error message,
> >>> however the spurious wakeup still happens.
> >>>
> >>> The issue won't happen if the device is in D3 before system shutdown,=
 so
> >>> putting device to low power state before shutdown to solve the issue.
> >>>
> >>> I don't have a sniffer so this is purely guesswork, however I believe
> >>> putting device to low power state it's the right thing to do.
> >>
> >> My objection here is that we don't have an explanation of why this
> >> should matter or a pointer to any spec language about this situation,
> >> so it feels a little bit random.
> >>
> >> I suppose the problem wouldn't happen if AER interrupts were disabled?
> >> We already do disable them in aer_suspend(), but maybe that's not used
> >> in the shutdown path?
> >>
> >> My understanding is that .shutdown() should turn off device interrupts
> >> and stop DMA.  So maybe we need an aer_shutdown() that disables
> >> interrupts?
> >>
> >
> > IMO I see this commit as two problems with the same solution.
> >
> > I don't doubt that cleaning up AER interrupts in the shutdown path woul=
d
> > help AER messages, but you really don't "want" devices to be in D0 when
> > the system is "off" because even if the system is off some rails are
> > still active and the device might still be powered.
> >
> > A powered device could cause interrupts (IE a spurious wakeup).
>
> It's a bit of a stretch, but ACPI 7.4.2.5 and 7.4.2.6 are the closest
> corollary to a spec I can find.
>
> "Devices states are compatible with the current Power Resource states.
> In other words, all devices are in the D3 state when the system state is
> S4."

In addition to that, vendor collected the wave form from the device,
Windows put the device to D3 while Linux kept the device in D0, and
that asserted one of the PCIe interrupt line to cause system wakeup.

Kai-Heng

>
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mg=
mt/oem-supplied-system-level-control-methods.html
>
> >
> >>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219036
> >>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>> ---
> >>>   drivers/pci/pci-driver.c | 8 ++++++++
> >>>   1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> >>> index af2996d0d17f..4c6f66f3eb54 100644
> >>> --- a/drivers/pci/pci-driver.c
> >>> +++ b/drivers/pci/pci-driver.c
> >>> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *d=
ev)
> >>>       if (drv && drv->shutdown)
> >>>           drv->shutdown(pci_dev);
> >>> +    /*
> >>> +     * If driver already changed device's power state, it can mean t=
he
> >>> +     * wakeup setting is in place, or a workaround is used. Hence
> >>> keep it
> >>> +     * as is.
> >>> +     */
> >>> +    if (!kexec_in_progress && pci_dev->current_state =3D=3D PCI_D0)
> >>> +        pci_prepare_to_sleep(pci_dev);
> >>> +
> >>>       /*
> >>>        * If this is a kexec reboot, turn off Bus Master bit on the
> >>>        * device to tell it to not continue to do DMA. Don't touch
> >>> --
> >>> 2.43.0
> >>>
> >
>

