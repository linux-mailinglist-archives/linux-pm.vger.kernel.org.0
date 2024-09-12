Return-Path: <linux-pm+bounces-14058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E434975F82
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 05:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2A91F28364
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 03:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2804F8BB;
	Thu, 12 Sep 2024 03:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FONhYAPW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BED26AC1
	for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 03:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726110060; cv=none; b=aNFe6J3ljRoky3spBnjSdc1CnLKIBnb/gLrUHQtScwh6YMdYkiGLgqqzApey14uaHXXpmmfknuMEWHP9zdPZLBU9wiH5H6BqWZFJ5zWWGLQD5f2mynX9vhKUwSWBlVK5A9t87wetQcdzbGdWGavMwPG4SG4x0BJwKpwTuKuM4jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726110060; c=relaxed/simple;
	bh=Vg0odeBMHpgtKhX8NR4LCSnyU5789G2srGCsELN6ZwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLv6TVCAn+CGNKM6HmTnfbZugd70XV3gSiAY1+R6pO4AOrOUlmBDSUHTPTvtO8of0m+yTYa8xEOdJBr63P3Yrvrl15uwuM5DG+LfUqKip5Rhv9Ip4nKaiCFxD8VFknzdG0SoQqGOlt2uBlHItPHrZYooeh3ly8i8cICv/PhFvSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FONhYAPW; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E00083F5E4
	for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2024 03:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726110056;
	bh=nxAKAHN4ulQFF60B5qp2xJnEkFmB45s9ou21KSZ6DT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=FONhYAPW4UeESlOgTmQ4IwRqyhSgjyFGyExsc6ySQrG6YFg4uBIQMdq/SGHonrGzD
	 /n8AoNOfW4erPH1btfOJo5EJ8klwRvD9kkF3U3iwSUC6Ibndvd3dXj5zqw/HMt9Z/B
	 VCwpkdes1wbKLAIrK1Y6Sl1KnXJWtvSOz2RzMQaTF8HF98/Yc8NEsVJzxlyWeZvN6u
	 KL6Khjl05isGydrwuSfrPt6Ej5dU0KCo9sTg8b9sL3tIgJSrlUl6QRBoRHEKy/4j2V
	 IkeQRLhowWK0UriEICz8gd5BD09lQv3n3yTEjY1ij52e82LACJMVsRbBGhrXq88hiL
	 hpNGbq/9uGChQ==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c23fffa44eso161876a12.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 20:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726110056; x=1726714856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxAKAHN4ulQFF60B5qp2xJnEkFmB45s9ou21KSZ6DT8=;
        b=Mn0Mu6jVHcOKQMHPw39D8Sv/HhXo+6xIOi4W2p7YyiIxWICMn3PzZTB+o4yCgPLAFV
         U5xxo3A66Fed7KXT4nyHPDy4Fe8YrkpxBPJu6wXoNnwoGEgxBa2kD+/RCU4suhP+eQYq
         IsqjQDsbUytSltU+KqizTIjeaES4qBkrSDzTfhU0BAxKqAl6ldL7/gR07Io9HndZ6Kt/
         ed39nm5P5UkpQ6DnDm8PaXM7lrwDE+KaSswgq47Tz3MhQlt3Ml/tqZJ5KR6nAC6Lbq1/
         Gl00QyyH+z0hh2Hk7xsKbfauPVIB2q8ONtpmcjmE4QUXhNgNuRFMEyVIXjQAagu9vUh7
         o24g==
X-Forwarded-Encrypted: i=1; AJvYcCVtpBhSHYAy5izA/VwDe2uQQ4nzNTDmt8vPOSHu3kMTJxagyu85E55H2EctucMGsr0msl32zn3ung==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHA8xl3QnSfLjvi2NaX6h8hl3VaKqaUQtiU8ZnXlXCAkK1Vb6
	zSj8/vAC+yFtKIDXzfmr/XEhaJwF2hw/YvG2B7lRgwpMUL/dRb7g74T19DFie+KxIreEGSAFw0V
	mBcmM0oB5Dnah9gL2OI5cofAksojesfLwihC9QDLb3fJZFiuRAGgag71zkvSnLkahUUuC86IM96
	LMST6m7ujoYzkTXe/YG8KLjtYd2ML1y4BPSDiXZoD0qMe1ixY=
X-Received: by 2002:a05:6402:2551:b0:5c4:1372:c1ee with SMTP id 4fb4d7f45d1cf-5c413e085eamr1054655a12.4.1726110056258;
        Wed, 11 Sep 2024 20:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHObdhdH1kylUh+cnsfLE2FnMRLgHzmKi6VYXrNEML58hz+m9YTNmCXyQHMYbrGa2cNfNJrXGeH/I45eJ+lA6g=
X-Received: by 2002:a05:6402:2551:b0:5c4:1372:c1ee with SMTP id
 4fb4d7f45d1cf-5c413e085eamr1054640a12.4.1726110055775; Wed, 11 Sep 2024
 20:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712062411.35732-1-kai.heng.feng@canonical.com> <20240911190516.GA644336@bhelgaas>
In-Reply-To: <20240911190516.GA644336@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 12 Sep 2024 11:00:43 +0800
Message-ID: <CAAd53p7vP8TcPj=u5TTuPMXFaWW15hwpJdECCprvXGBhigKD6Q@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, mario.limonciello@amd.com, 
	mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kaihengfeng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Thu, Sep 12, 2024 at 3:05=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
> > Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> > connected.
> >
> > The following error message can be found during shutdown:
> > pcieport 0000:00:1d.0: AER: Correctable error message received from 000=
0:09:04.0
> > pcieport 0000:09:04.0: PCIe Bus Error: severity=3DCorrectable, type=3DD=
ata Link Layer, (Receiver ID)
> > pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=3D0000008=
0/00002000
> > pcieport 0000:09:04.0:    [ 7] BadDLLP
> >
> > Calling aer_remove() during shutdown can quiesce the error message,
> > however the spurious wakeup still happens.
> >
> > The issue won't happen if the device is in D3 before system shutdown, s=
o
> > putting device to low power state before shutdown to solve the issue.
> >
> > I don't have a sniffer so this is purely guesswork, however I believe
> > putting device to low power state it's the right thing to do.
>
> My objection here is that we don't have an explanation of why this
> should matter or a pointer to any spec language about this situation,
> so it feels a little bit random.

I have the same feeling too. The PCIe spec doesn't specify what's the
correct power state for shutdown.
So we can only "logically" think the software should put devices to
low power state during shutdown.

>
> I suppose the problem wouldn't happen if AER interrupts were disabled?
> We already do disable them in aer_suspend(), but maybe that's not used
> in the shutdown path?

That was my first thought, so I modified pcie_port_shutdown_service()
to disable AER interrupt.
That approach didn't work though.

>
> My understanding is that .shutdown() should turn off device interrupts
> and stop DMA.  So maybe we need an aer_shutdown() that disables
> interrupts?

Logically we should do that. However that approach doesn't solve this issue=
.

>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219036
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pci-driver.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index af2996d0d17f..4c6f66f3eb54 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev=
)
> >       if (drv && drv->shutdown)
> >               drv->shutdown(pci_dev);
> >
> > +     /*
> > +      * If driver already changed device's power state, it can mean th=
e
> > +      * wakeup setting is in place, or a workaround is used. Hence kee=
p it
> > +      * as is.
> > +      */
> > +     if (!kexec_in_progress && pci_dev->current_state =3D=3D PCI_D0)
> > +             pci_prepare_to_sleep(pci_dev);
> > +
> >       /*
> >        * If this is a kexec reboot, turn off Bus Master bit on the
> >        * device to tell it to not continue to do DMA. Don't touch
> > --
> > 2.43.0
> >

