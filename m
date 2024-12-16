Return-Path: <linux-pm+bounces-19305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EB79F31A8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 14:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0F07A3055
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 13:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283612054F3;
	Mon, 16 Dec 2024 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="u9iOu5yD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8472054E6
	for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356200; cv=none; b=FNneXRdCixddKx89loUdLL/R8S1QNpqkgarC5Y97QDLRbJ0Y3jW+np0E5JO5PXaN1MaQKyqbtNqp6LpRld0tQ2C3X38Gz1AUiLuCT81Ib9j89XA/WRbzM8XqWfryEreCefoTaB2s6KNFQcpW9UXKBnL8t7inli/xgn6extt1/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356200; c=relaxed/simple;
	bh=n7Q0T0KMCPfp/HX0O5ykDIgJsILG2th39HppS/Qte0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RneO67YKTOkCPBXrBdL35gRSg1D4HoGet4Q9NlzbLK8h4cq+pChKit6V4VvbKPm6X3XLOHGE5rtbTWH0SiTvlfjR4kubfiAUABAJMfQbz4wiu7UgxF6KZP/XKiA4B4YdyrskmYGdeXn0KiheIZcpuYy+VFVmbH+MTnWMgQijLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=u9iOu5yD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30036310158so36239071fa.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 05:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1734356196; x=1734960996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPmTpcRMWad5Bttq2WNhuMIOuslXKz6l2KQBUY7vrew=;
        b=u9iOu5yDCmdCheFtYTE9dluUxp8p6d+QnOA5HsdZuqgzHZsHaIUyYlyaIbjbJHyy5a
         PPddxhedKFtHPzLJPy/keCOrTJNFCmZdry6C6hd4Z+K3bZFSIAtKk+7XVpGZtAoTwXAz
         2PTQ/22XpptgVA6sSVFRq3sLm6rkWIrUvweQuReHsa/toPplB2zAFKvGz5k+X0+sqED3
         l28isO88eIxd9jldRYXFimNmWwLW0rwCdBfzWmv53uiR1EpldANONCaIZI7XBZbaibLX
         UK3Lwj90zopyawSKBjr3LCGuWJk5VZpFCzd7LcA8GfsmmGKmTeGfSnmVTcA1kDGLTEZW
         2EIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734356196; x=1734960996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPmTpcRMWad5Bttq2WNhuMIOuslXKz6l2KQBUY7vrew=;
        b=axWZEp0jd4y4cgREAbYWgN3HlRGrje6YoK8AJafEb1sPUa/OMuxCiU8jP8p7FjhIAm
         F+9Cw8vm2Orlqp5aXer8HPfnEGmMGOdHJNfAMxoBST6uj+ifE4zHlfrHDRk3ZxD3BTfm
         rhVXcrkqi03yFulNXepKxwiU1VorAJJpywCvZRnOqHkoWMasachFKmBEp/gPfi+b8koI
         S6HJVhmgBzWIc7CkX6zK0SVa+xhx50YWhztkH4+KqLQCL/BgPKwqe7TbbaAb/k9kCewC
         +HDAc9+kV9XW785nxa7c0G/8i+gyKWx8w0LRwC1u8SaBGZNBZ2vz8kNHCHKLSgVPPPwk
         FyiA==
X-Forwarded-Encrypted: i=1; AJvYcCWqVzSvywsQE6Ey1YQIqu9a4E+Upd05c9CB6CeBMeUSC2qOnD+CHLUc9fLu20NXYR7iUULWfMkJZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytW2gEG07aMh8wMWGvV0V6crSRnR22J/B9NkFzRaITKadmL+CB
	KsrAEmEgMGjSiF0XcfGsYn+Z6V6lRQWv4pXHTA0VJAKXnhlZ5/Gw117WIW14gDN5J0kOkvEQ0Zr
	1Pbqrcfgdp9RXdwb1+DOgqrnF0Hs5Q8/nAGNGRA==
X-Gm-Gg: ASbGncscQiBTWX9HQwQmG/pKRtud2TR8XRLxfEjPr4w9ZTS3oqnzV+Y8dSpiSJxWaV6
	kcEOuUsL6Pqgkq0dkMDLVSD/H+QOyP1bIwrZYpOP4OFcqRAwwePJB3o11X5XkaD/SLSea7Q==
X-Google-Smtp-Source: AGHT+IHxVAdbtR4dYnHzvHK+CVlG/fuoHUNCRLPTcHwar41SB+rBNrcsKKmn40cVHo6A2sUwiHZOc7S529UuBn9F0ZA=
X-Received: by 2002:a05:651c:1545:b0:302:40ee:4c2e with SMTP id
 38308e7fff4ca-30254521f15mr39219871fa.2.1734356195419; Mon, 16 Dec 2024
 05:36:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203141251.11735-1-brgl@bgdev.pl> <Z1x6ti2KaMdKS1Hn@linaro.org>
 <20241216070554.ym54ozdw45zhveo7@thinkpad> <Z2AF56PDj1m1BS1S@linaro.org> <20241216132445.vjkxxknvzaht2ltq@thinkpad>
In-Reply-To: <20241216132445.vjkxxknvzaht2ltq@thinkpad>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 16 Dec 2024 14:36:24 +0100
Message-ID: <CAMRc=McmTUPqhF9uTdxBttm9RUxLgd68uanbxAVt-jbHe27h2A@mail.gmail.com>
Subject: Re: [RFT PATCH] Revert "power: sequencing: request the WLAN enable
 GPIO as-is"
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 2:24=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Dec 16, 2024 at 11:50:20AM +0100, Stephan Gerhold wrote:
> > On Mon, Dec 16, 2024 at 12:35:54PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Dec 13, 2024 at 07:19:34PM +0100, Stephan Gerhold wrote:
> > > > On Tue, Dec 03, 2024 at 03:12:51PM +0100, Bartosz Golaszewski wrote=
:
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >
> > > > > This reverts commit a9aaf1ff88a8cb99a1335c9eb76de637f0cf8c10.
> > > > >
> > > > > With the changes recently merged into the PCI/pwrctrl/ we now hav=
e
> > > > > correct ordering between the pwrseq provider and the PCI-pwrctrl
> > > > > consumers. With that, the pwrseq WCN driver no longer needs to le=
ave the
> > > > > GPIO state as-is and we can remove the workaround.
> > > > >
> > > >
> > > > Should probably revert commit d8b762070c3f ("power: sequencing:
> > > > qcom-wcn: set the wlan-enable GPIO to output") as well?
> > > >
> > > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.or=
g>
> > > > > ---
> > > > >  drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers=
/power/sequencing/pwrseq-qcom-wcn.c
> > > > > index 682a9beac69eb..bb8c47280b7bc 100644
> > > > > --- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > > > > +++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > > > > @@ -379,7 +379,7 @@ static int pwrseq_qcom_wcn_probe(struct platf=
orm_device *pdev)
> > > > >                                      "Failed to get the Bluetooth=
 enable GPIO\n");
> > > > >
> > > > >         ctx->wlan_gpio =3D devm_gpiod_get_optional(dev, "wlan-ena=
ble",
> > > > > -                                                GPIOD_ASIS);
> > > > > +                                                GPIOD_OUT_LOW);
> > > > >         if (IS_ERR(ctx->wlan_gpio))
> > > > >                 return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio)=
,
> > > > >                                      "Failed to get the WLAN enab=
le GPIO\n");
> > > > > --
> > > > > 2.30.2
> > > > >
> > > >
> > > > I'm not sure why but applying this patch brings back the error I ha=
d
> > > > before. It does seem like setting wlan-enable GPIO happens early en=
ough,
> > > > but maybe some timing is still wrong.
> > > >
> > >
> > > There should be no room for timing issue now :/
> > >
> > > > [   17.132161] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
> > > > [   17.480619] ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed wi=
th rc=3D134
> > > > [   17.491997] ath12k_pci 0004:01:00.0: pci device id mismatch: 0xf=
fff 0x1107
> > > > [   17.492000] ath12k_pci 0004:01:00.0: failed to claim device: -5
> > > > [   17.492075] ath12k_pci 0004:01:00.0: probe with driver ath12k_pc=
i failed with error -5
> > > >
> > >
> > > Are you sure that this is the same error that you noticed before?
> > >
> >
> > Yes, "pci device id mismatch: 0xffff 0x1107" is definitely the same
> > error I saw before.
> >
> > > > Any ideas/suggestions?
> > > >
> > >
> > > Can you verify that the pwrctrl driver's probe is completed *before* =
ath12k
> > > driver starting to probe by adding the debug prints in both drivers?
> > >
> >
> > I tried booting with "modprobe.blacklist=3Dath12k" and manually loaded =
the
> > module several seconds after the boot completed. Error is unchanged:
> >
> > [   16.628165] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
> > [   55.065794] ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with r=
c=3D134
> > [   55.073354] ath12k_pci 0004:01:00.0: pci device id mismatch: 0xffff =
0x1107
> > [   55.080457] ath12k_pci 0004:01:00.0: failed to claim device: -5
> > [   55.088977] ath12k_pci 0004:01:00.0: probe with driver ath12k_pci fa=
iled with error -5
> >
> > I played around a bit more and it looks like the problem is that the PC=
I
> > device is still being enumerated during startup, before the pwrseq
> > driver is loaded. Not with the ath12k driver, but the internal PCI
> > subsystem state. And then the PCI link dies briefly when the pwrseq
> > driver loads.
> >
>
> Ok, this seems to be the cause. There is a known issue with Qcom PCIe
> controllers where if the device is powered off abrubtly (without controll=
er
> driver noticing) the PCIe link moves to link down state. Then we need to
> bring the link back by reinitializing the controller. I have it in my tod=
o list
> but no one noticed this issue unless they tried powering down and powerin=
g up
> the device (which is rare except on hot pluggable slots).
>
> > If I add some hacks to the DT to force the wlan-enable GPIO low before
> > the entire PCI _controller_ is probed, then it works correctly:
> >
> > [   16.607359] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
> > [   16.668533] pci 0004:01:00.0: [17cb:1107] type 00 class 0x028000 PCI=
e Endpoint
> > [   16.668606] pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit=
]
> > [   16.669055] pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
> > [   16.675546] pcieport 0004:00:00.0: bridge window [mem 0x7c400000-0x7=
c5fffff]: assigned
> > [   16.675555] pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5fffff 64bit=
]: assigned
> > [   16.862083] ath12k_pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5ffff=
f 64bit]: assigned
> > [   16.870358] ath12k_pci 0004:01:00.0: enabling device (0000 -> 0002)
> > [   16.888792] ath12k_pci 0004:01:00.0: MSI vectors: 16
> > [   16.893954] ath12k_pci 0004:01:00.0: Hardware name: wcn7850 hw2.0
> >
> > Note the pci messages after enabling the GPIO, before the first
> > ath12k_pci messages. Without the hack, those appear already before the
> > pwrseq driver is being loaded (during initramfs).
> >
> > [    5.888688] pci 0004:01:00.0: [17cb:1107] type 00 class 0x028000 PCI=
e Endpoint
> > [    5.888758] pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit=
]
> > [    5.889207] pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
> > [    5.902692] pci 0004:00:00.0: bridge window [mem 0x7c400000-0x7c5fff=
ff]: assigned
> > [    5.910311] pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5fffff 64bit=
]: assigned
> > ...
> > [   21.227565] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
> > [   21.305496] ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with r=
c=3D134
> > [   21.318382] ath12k_pci 0004:01:00.0: pci device id mismatch: 0xffff =
0x1107
> > [   21.338489] ath12k_pci 0004:01:00.0: failed to claim device: -5
> > [   21.338555] ath12k_pci 0004:01:00.0: probe with driver ath12k_pci fa=
iled with error -5
> >
> > Can we skip scanning the PCI bus until the power sequencing is done?
> >
>
> This won't help (but a good idea anyway that I'll implement). See below..=
.
>
> > The hack I used (see below) works, but is a bit odd since it requires
> > assigning the wcn7850-pmu pinctrl to the PCI bus in the DT. Otherwise
> > the GPIO is not forced low early enough.
> >
>
> Your hack is making sure that the default state of the GPIO is not change=
d at
> all after initializing the controller. So even if the pwrctrl driver prob=
es
> later, it will try to enable the module by doing,
> 'gpiod_set_value_cansleep(ctx->wlan_gpio, 1)', which would do nothing to =
the
> device state.
>
> So the issue is not with the pwrctrl driver but with the controller
> implementation. Ideally, once the device is removed, the PCIe link should=
 move
> to Detect state and then to Polling state once the receiver is detected o=
n the
> lanes. But the DWC and Qcom glue has other logics that prevents the contr=
oller
> from doing so.
>
> So until the link down handling is implemented in the controller driver, =
we need
> to carry this hack that preserves the GPIO state.
>

Thanks for the explanation Mani. Regarding this patch: I suggest we
keep it for now but maybe I'll add a comment saying why it's still
necessary?

Bart

