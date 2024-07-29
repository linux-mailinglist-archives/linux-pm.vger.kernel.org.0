Return-Path: <linux-pm+bounces-11542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B109393F769
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 16:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5097F28295A
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 14:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F4814D2A7;
	Mon, 29 Jul 2024 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fHa2MtOR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D959914AD19
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262678; cv=none; b=I6cgcyWwdeiFuwYLMIRbXHZpHJfxfCp5Hom3TY7MvIk3bSKzuU+gjUQCFrq0hcWKToXagUOCGPwt5VgB3VPCl6l9EdxGYk6tpEYh9xQwKccTqzzIr+D/lN0mPnXmB2qNasHStAtfuBouhPfX066o9TzqFRzjeMq7clIjrH7yNng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262678; c=relaxed/simple;
	bh=0ONHSl1kWF9vFR/oI4GzjWnZhfcyq1XMYf1zZBjG4M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuihEG6TJ1VjhxBwayqPutP/5DzAmB7EOhDT62/juGA3oCoC9BO5WSNSgaOE3SySNaKAiEU5w50/jkGT37b40c/wBNFu1BTNdvDZjmCkWEPbOKHYeJthX+oGA25o+s1Qsiyp2x1+bMGvCRT1UpAKRUhFYfHYW/SNnwyUjJqpbP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fHa2MtOR; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f01afa11cso5329893e87.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 07:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722262674; x=1722867474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVgLB3bObd2N9Ezn9AyPIe4vo8ORxAD3AgXO6pdpfDo=;
        b=fHa2MtORn1dZpz0RVvXXDBKAEZchM53/nRFxbdpKaSogSAjXsc0J9HSeIiegUPKDRa
         pMmYq+JSmbPpwToYANS2KI0kTBqRFcuPnkV9lIGiyMWZJxp9Ijess6SJNfozGMJTkYCj
         mKuFf/eFMq4+bkkU8oCUcN7E500dfE+1OnjYbclrRVI9zz1c6CbbUNDqd3gAZ0f6hLjR
         EsME4xiqzkJ4qCyywmKHyUH/bT7u4tzBFR4vMH1ZlRiCJW/1lC5UubKRyyrtBKsf9tpv
         Yfhtnc4ryepqATbmpqPS6Vs1Uie00HRxeHTC6lPjHd0E8Hrtu6BxyAxT9elKooSVJoeV
         C0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722262674; x=1722867474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVgLB3bObd2N9Ezn9AyPIe4vo8ORxAD3AgXO6pdpfDo=;
        b=w1PRDYoBoTRjyASTo5irhjwVVFdbcvhiJssNpvCzr5ssKMXpLuCCMbeNgqUCYsAGUx
         lku7pFso2ARyf0alNjB4dHfuBuKc0wie8/bHtZk18Q8gS2+T9W0Ev9f3lgy4MS20dsWi
         gwtscu8M6nGREmRF1L7IAQTnwJVgesPgiwrMaDdqc/zSUj0dmPmdviUePfkbReHpWiUq
         BoT6aP5W2cj/urmYVYw6MrRSiKMmv3gzfllVi5UIzMHSLR4o/UJ7FLBzJlBtsDZTrDZV
         qcesf+M6NhAqQjECkV8JCrrVmNJyEpxT5AV8TtK/K9nly0SHTkUO/uW8rSUc4X5jA3cz
         /lcg==
X-Forwarded-Encrypted: i=1; AJvYcCV3Ff00u4YZSv1FVQH8rxNYNG34Ed9HXX1I2ZslvubCXEu7zkBbxIFET0qF9NOSQdrDoVw2nTGlhjkIW3NQklmfdRH9fTgVaAc=
X-Gm-Message-State: AOJu0Yz3Cja4VnpcVba78U2QkoZcXpRCAqEfR8OI0DTcOMbQkYV18Gqm
	Abaf22NShnlXKDleThSVxlR8oAzYQTnn615kDqISsD5SocZS/dRi9dqMEJuC4D3vzCBsjKkFWgh
	7dAMj5GXiYHlRHK0LAgqFLL3cmHCBmnGA6Gnpfw==
X-Google-Smtp-Source: AGHT+IH6v3cbZSE3rm+5BNiemiv6fzg/nnWS8axNAdReC0d6vqRCKNfgEwUa8tZIiNkQ1VJr6XJwRuzUL1OcINftSVg=
X-Received: by 2002:ac2:465a:0:b0:52c:e050:452a with SMTP id
 2adb3069b0e04-5309b2c2e98mr4761880e87.37.1722262673620; Mon, 29 Jul 2024
 07:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-pwrseq-wcn-config-v1-1-021dce9f2513@redhat.com>
 <CAMRc=Mcop3+00G3kZo+dazpemuj0PjXNc_3+EiyFukLevBGd_A@mail.gmail.com> <bgev74hvkl7q5cbxuako6ljlesf256kz7kmolornhrczkwgsjv@tkfclj66d5rm>
In-Reply-To: <bgev74hvkl7q5cbxuako6ljlesf256kz7kmolornhrczkwgsjv@tkfclj66d5rm>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 29 Jul 2024 16:17:42 +0200
Message-ID: <CAMRc=MfOOkbgMN6nT1LzZzXbPop-5BPDjk+5QYtiY9O7x=K7DQ@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: pwrseq-qcom-wcn: Depend on WCN36XX
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 3:20=E2=80=AFPM Andrew Halaney <ahalaney@redhat.com=
> wrote:
>
> On Mon, Jul 29, 2024 at 10:12:27AM GMT, Bartosz Golaszewski wrote:
> > On Thu, Jul 25, 2024 at 6:28=E2=80=AFPM Andrew Halaney <ahalaney@redhat=
.com> wrote:
> > >
> > > This driver does sequencing for the hardware driven by WCN36XX, let's
> > > make it depend on that. Without WCN36XX, we're sequencing power for
> > > nothing.
> > >
> > > Fixes: 2f1630f437df ("power: pwrseq: add a driver for the PMU module =
on the QCom WCN chipsets")
> > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > ---
> > > I *think* this makes sense, but if you disagree please let me know. I
> > > was sorting out configs in fedora and noticed this was being asked fo=
r
> > > builds that didn't have WCN36XX enabled, which seems odd to me at lea=
st.
> > > ---
> > >  drivers/power/sequencing/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequenc=
ing/Kconfig
> > > index c9f1cdb665248..a4765cb33a80e 100644
> > > --- a/drivers/power/sequencing/Kconfig
> > > +++ b/drivers/power/sequencing/Kconfig
> > > @@ -16,6 +16,7 @@ if POWER_SEQUENCING
> > >  config POWER_SEQUENCING_QCOM_WCN
> > >         tristate "Qualcomm WCN family PMU driver"
> > >         default m if ARCH_QCOM
> > > +       depends on WCN36XX
> > >         help
> > >           Say Y here to enable the power sequencing driver for Qualco=
mm
> > >           WCN Bluetooth/WLAN chipsets.
> > >
> > > ---
> > > base-commit: 2347b4c79f5e6cd3f4996e80c2d3c15f53006bf5
> > > change-id: 20240725-pwrseq-wcn-config-0b6668b5c620
> > >
> > > Best regards,
> > > --
> > > Andrew Halaney <ahalaney@redhat.com>
> > >
> >
> > What if we want to disable the WLAN driver but keep the Bluetooth
> > driver enabled?
> >
>
> Should we:
>
>     depends on WCN36XX || UKNOWN_TO_ANDREW_BLUETOOTH_CONFIG
>
> or, would you rather base it on something else, or nothing at all? I
> don't have any hill to die on here, but I wasn't really sure what to
> set this config option to for arches outside of aarch64 and was hoping
> some Kconfig dependencies could make that more clear.
>
> I'm a little unsure about what the WCN family of hardware is, so I don't
> know if that's something we could gate behind a different config more
> intelligently (say just ARCH_QCOM if it only makes sense as part of a
> Qualcomm SoC itself... not sure how this hardware is sold).
>
> Please let me know your thoughts!
>
> Thanks,
> Andrew
>

I wouldn't base it on anything.This is a driver for the PMU and it's
the other way around: the PCI pwrctl driver for WLAN and the hci_qca
BT drivers depend on it to power up the HW that uses the sequencer.

Bart

