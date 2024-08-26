Return-Path: <linux-pm+bounces-12875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5028795F057
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 14:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F351B283023
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 12:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B1E16B385;
	Mon, 26 Aug 2024 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LOqaI10a"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A608715539F
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673814; cv=none; b=kL9PQe9CAoTQo8fwDfQddqFwbLUBsxeALpT3UdpF6PzAmNVZdobghRAZ+zMjMCfj0OAHI6robyJWxhifGXzo5pFYYV/qzaVtdVwCreanv3f9RB8NBId5qCFQ91AnOC+AihV07YsmsV3WHVecdHVcm4HPSPx+JdZIoOt1MUYkZS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673814; c=relaxed/simple;
	bh=snM5Rm0gMzlD08AvqsH0+c3YOt73h0syTAjhL8mg4zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgOkC/UepIMo6sWT62TRPzuCiN1/KQ7ex5PnhXkCS5XPE3m94Jiq2NlA/q2F3RS68Aall0lqCzoSFGuezBsvTSDZ02RI80iJcqruHlUOwYZAe4yj9+Iq+VgqxSrcjWPkx649uLlnIC2EarfLcL+UPnUqsBTsPUOsVNYUUZG1ffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=LOqaI10a; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D86A83F6B5
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 12:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724673810;
	bh=ajfaokdeZHRMyKn6mvHqNgguJUu0Q4E54DToJ/+4STQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=LOqaI10aEotQy1QRuaf7c20vHbkBW2mlzuqv9O5/Wzpcy1FgzV0KURM1oI2HGg+kV
	 s9YfZ6eD2j8G9Fy/W+bWkhI/aKzftg/ptie3cmDfJOiThO17N5/5/gjf2mgL6kTG9v
	 YDCdpN7mj/ABVDvbFECmP87V9kmqcztJ3xHlTi2zQ6li3bUSkV7RdvPO/sjyqKq1hB
	 WaD35XNFQ7/NInO9Six0JW/5xyBjIt+ZfOuKbf23C7OTA7lz9qhZ9DspGStfQnwjks
	 NVWSYjMG7c/rQnNmepoMgWBWnRWOO6T5v08wxaRaIwEKtoSqiLOeBoHf2LWdFySZ8K
	 hFW1kyblwgkCQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d5dafe951eso4742052a91.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 05:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724673809; x=1725278609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajfaokdeZHRMyKn6mvHqNgguJUu0Q4E54DToJ/+4STQ=;
        b=rv0IeBGo3guDVieF/zyTxu8jJjLA1zACQa/2nsI1K7zXYOvLOqeMm90YIoD+cP+r65
         U4u3GCj2VbMBI79c4MhNfbMs7iadbKWaFCN9yU1MtT6hTOng4/gi/Djwb+ZRmJnKtljN
         tLFohVr7ogPhgVS40KN48hDswR5dd2w8PZTivEZVuGNAX3FfIpXfu3Cy6Us0O7TFgIE/
         iswptj6vZDSGJQwBv7vgrFLOajupUYoLMzLOmJKJ7vXWqSfJPluTSmeBB8wS0lFFh0sX
         7ecWTZHnIMVznk8KfrpviDNVnQkRZ/khcJtnpCOi4jQAmkWy6dztcz6YoqlySFbhxO9U
         JYtA==
X-Forwarded-Encrypted: i=1; AJvYcCV1drTf3Z3YX7CQ32ED3liqeKmh94qz9DqgdXb+dRRqjbmnTB0Y5YfZRMEz/bIs69wTCWLZez4thw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9VeBexjjt2uPN9dyBgPrlEZ9aS4rH1suax11LtTPBJNvJAim
	BwixEgCpBlP6NaCzb8SomZIBpvWCqL0hE63mEvcPiuOoymeMcSIpmUsxTBoML43ZYxL7xAUTWH8
	HtNYIkugixYBqh/3myCeCXlajRmZaf4u6GlDfy4ONno7DjYQNN9xZowXpWcA/SCEftFgei4r2Ec
	4A7zCHH/f5/hyNr271KrNzA+npaBKolwwMdtEYG48lsRqzxBo=
X-Received: by 2002:a17:90b:3144:b0:2d3:c8ed:f0be with SMTP id 98e67ed59e1d1-2d646d0ae37mr8318609a91.28.1724673807973;
        Mon, 26 Aug 2024 05:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxdSvdFt9fVbKAhweGqLpVEbbex/kMjEPiDlJ1rpZiXNZAj2f5L37oaVUXyQSovQsgnz8J0WOkVwo6b700X+g=
X-Received: by 2002:a17:90b:3144:b0:2d3:c8ed:f0be with SMTP id
 98e67ed59e1d1-2d646d0ae37mr8318575a91.28.1724673807557; Mon, 26 Aug 2024
 05:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712062411.35732-1-kai.heng.feng@canonical.com> <6685e124-4a7d-44bb-80a9-fc5fa51269a9@amd.com>
In-Reply-To: <6685e124-4a7d-44bb-80a9-fc5fa51269a9@amd.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 26 Aug 2024 20:03:15 +0800
Message-ID: <CAAd53p5d6=m9MzC5pRS8HJSP54tiTxMBLR-Nd=fE2Tf2Sf+mpQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: bhelgaas@google.com, mika.westerberg@linux.intel.com, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 3:28=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 7/12/2024 01:24, Kai-Heng Feng wrote:
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
> KH,
>
> I did testing with your patch along with a few others, and found that it
> does the best job to put a majority of devices into a low power state
> properly.
>
> I have the details of what happens at S5 outlined on this Gist:
> https://gist.github.com/superm1/f8f81e52f5b1d55b64493fdaec38e31c
>
> * KH column is this patch.
> * ML column is
> https://lore.kernel.org/linux-usb/43594a1c-c0dd-4ae1-b2c4-f5198e3fe951@am=
d.com/T/#m03d0b36f86fb4722009b24a8ee547011128db80b
> * FS column is 0fab972eef49 being applied again
>
> I also have power testing data from an OEM's system that shows that it
> improves things well enough that a previously failing energy star
> certification is now passing.

Thanks a lot for the testing.

Bjorn, do you think this patch is in good form to get included in next -rc1=
?

Kai-Heng

>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219036
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >   drivers/pci/pci-driver.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
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
>

