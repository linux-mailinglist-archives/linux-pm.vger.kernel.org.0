Return-Path: <linux-pm+bounces-19304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23C79F3170
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 14:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5865518879AB
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 13:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2D220550E;
	Mon, 16 Dec 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xe4bZQ4l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4F2054EE
	for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355492; cv=none; b=lP06DoltOezmOcJiNOij2agyyhRMjQ3lI5SpL4zHBK3Jm+RNoEAq/YhdafRt/ofKbXcJTUpvtoD6kyiKPnoOISv40JvcGIiwi+dZWmnOOL5HBWylRrGJ8zYYrBRvI0M7Jv7avq8Yd9sbykNEHmmhhaaTr+w9c+5caFY4adkkNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355492; c=relaxed/simple;
	bh=2KrBqpSB2RlPtMqWx0iCUQp1GTm67K2ZGNgYmIKgjRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsCMcau2622aEirD/FSP6zm5EG2hTEo9iRmXZbRp76AjAyHiyVVzWbNWbagFdp+n2Ud1FD3Vw7133S6l3mfMdc5PVTRnv6cmrK89wbTImHo+vbV34LLD4ixOyxVXnjPUxdDxkDeUYTJFZmeVF3DpKxMOC6Co+WPynJWjvUNHyv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xe4bZQ4l; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2164b1f05caso36945315ad.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 05:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734355489; x=1734960289; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qQ2PcWqmGEaXJGaCT9qDrihbcy/Fp9edeGdzGz/zoDw=;
        b=Xe4bZQ4lYjRuavqafhcIFJC1ZgBNxFll2vrFcACFGNvJiUyOEXsznokNk+iaKX58Iv
         2BiSWCG+BangmiashZaFQjFDw2Qd5zhlMEy/HwlGSRXxkuSZf4RA6We8KBUfht0ZNcq3
         1+M3seV4bwK2lQPVsjiWdHa/q6W419O0YUbOlBkebRd7VLx0BDm87ZDfCEeycj2aFYSv
         VfDAMbPRXN3dfIFqX0pAJvVVImn1ENL13jBW4JTkWOWVUt0v5K1ysWjmmCwdkOdL351o
         OLacCSpiGJz2iiE3DApMsRXGf3CPV3baSRV2NjbOmkXIRR6m/PRCx6lg+orNOSjRvUBj
         yAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734355489; x=1734960289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ2PcWqmGEaXJGaCT9qDrihbcy/Fp9edeGdzGz/zoDw=;
        b=XOTYBv5o/EBT8JAz+s75DbePIHAQncTGywD8qnf9GAncHqPBPCGzIHfFRglv7szsJC
         1NnhPhbE0FyvhcTCNMMZvEFRZpNcTftu/XwD9dkgh3BQ5D6WnpRMYKqRFNOgRZlan3uN
         V72x6uVl04yovwbJ8wkUcI8w2GjNqfmf8/t3gyCFuCIDg5CzNP8I17DGVDHGOdpngb+v
         RIEUH4nvOGKiOLxc5MNwae18D2NV8UG2q+0PpsVfpMX3k9GqFFXPKDiTOb0tj02RssJ5
         H6BVKzu2DhVuJs2PC8nYYD6qfskPrTNqnvdWbO8FX2UjqwpvhrV6k0MDgwCfO4b1BUEw
         qUxA==
X-Forwarded-Encrypted: i=1; AJvYcCVAg+wVGYoVAIBi+PWI4zNhk2b4ge5FhnLiG5+V4iIRkJmdiPAEL1MiQGwYPfE/Dbivf1cxK8KRsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzAgP8e75vu/1i68OrNj/fGORzrj7WKsT1G1RX09A20dxTZ9IZ
	BtLeiiKgAI8G4tyUGs/DpNPYnd6XhS9qieWlVRhObV9GUwPUDk897xyWooXzIw==
X-Gm-Gg: ASbGncvJjDxopCYAl61HMmFKU1XpJHRjvw2BJlC+eiL4k0FS5+POHzlneOtHTlxPV9Q
	ubGjp6NIttBJMZmXw73TjfTOnSbr2bPS6sOD6ogQSIlC+cWIc3FmjFx2p8sDbuO4TljffIeSFxb
	iRtSbpwqbdoxVmbzrgtC0AV8A2e2WXZz5NUyhMrfHV67CBZ0AMcA9G7vaUSazkz5CQnQvnBFemX
	V1OPfkIxtb9zEWKagXP5Y/uyN27A4ApS3+U14orn8AKY7iJhcMUTC/OvCtCtInIg6wi
X-Google-Smtp-Source: AGHT+IGbmUlVe8dk0ois4qkbR6zHbskbm9qvTKT+GOxinPVoLMRUvMrSVeO2Feozd+tQg8RZgRA83A==
X-Received: by 2002:a17:902:d509:b0:216:4499:b836 with SMTP id d9443c01a7336-218929d6b85mr182378955ad.26.1734355489546;
        Mon, 16 Dec 2024 05:24:49 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50340sm42302525ad.148.2024.12.16.05.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:24:49 -0800 (PST)
Date: Mon, 16 Dec 2024 18:54:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH] Revert "power: sequencing: request the WLAN enable
 GPIO as-is"
Message-ID: <20241216132445.vjkxxknvzaht2ltq@thinkpad>
References: <20241203141251.11735-1-brgl@bgdev.pl>
 <Z1x6ti2KaMdKS1Hn@linaro.org>
 <20241216070554.ym54ozdw45zhveo7@thinkpad>
 <Z2AF56PDj1m1BS1S@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2AF56PDj1m1BS1S@linaro.org>

On Mon, Dec 16, 2024 at 11:50:20AM +0100, Stephan Gerhold wrote:
> On Mon, Dec 16, 2024 at 12:35:54PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Dec 13, 2024 at 07:19:34PM +0100, Stephan Gerhold wrote:
> > > On Tue, Dec 03, 2024 at 03:12:51PM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > 
> > > > This reverts commit a9aaf1ff88a8cb99a1335c9eb76de637f0cf8c10.
> > > > 
> > > > With the changes recently merged into the PCI/pwrctrl/ we now have
> > > > correct ordering between the pwrseq provider and the PCI-pwrctrl
> > > > consumers. With that, the pwrseq WCN driver no longer needs to leave the
> > > > GPIO state as-is and we can remove the workaround.
> > > > 
> > > 
> > > Should probably revert commit d8b762070c3f ("power: sequencing:
> > > qcom-wcn: set the wlan-enable GPIO to output") as well?
> > > 
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > ---
> > > >  drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > > > index 682a9beac69eb..bb8c47280b7bc 100644
> > > > --- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > > > +++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > > > @@ -379,7 +379,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
> > > >  				     "Failed to get the Bluetooth enable GPIO\n");
> > > >  
> > > >  	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
> > > > -						 GPIOD_ASIS);
> > > > +						 GPIOD_OUT_LOW);
> > > >  	if (IS_ERR(ctx->wlan_gpio))
> > > >  		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
> > > >  				     "Failed to get the WLAN enable GPIO\n");
> > > > -- 
> > > > 2.30.2
> > > > 
> > > 
> > > I'm not sure why but applying this patch brings back the error I had
> > > before. It does seem like setting wlan-enable GPIO happens early enough,
> > > but maybe some timing is still wrong.
> > >
> > 
> > There should be no room for timing issue now :/
> >  
> > > [   17.132161] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
> > > [   17.480619] ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with rc=134
> > > [   17.491997] ath12k_pci 0004:01:00.0: pci device id mismatch: 0xffff 0x1107
> > > [   17.492000] ath12k_pci 0004:01:00.0: failed to claim device: -5
> > > [   17.492075] ath12k_pci 0004:01:00.0: probe with driver ath12k_pci failed with error -5
> > > 
> > 
> > Are you sure that this is the same error that you noticed before?
> > 
> 
> Yes, "pci device id mismatch: 0xffff 0x1107" is definitely the same
> error I saw before.
> 
> > > Any ideas/suggestions?
> > > 
> > 
> > Can you verify that the pwrctrl driver's probe is completed *before* ath12k
> > driver starting to probe by adding the debug prints in both drivers?
> > 
> 
> I tried booting with "modprobe.blacklist=ath12k" and manually loaded the
> module several seconds after the boot completed. Error is unchanged:
> 
> [   16.628165] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
> [   55.065794] ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with rc=134
> [   55.073354] ath12k_pci 0004:01:00.0: pci device id mismatch: 0xffff 0x1107
> [   55.080457] ath12k_pci 0004:01:00.0: failed to claim device: -5
> [   55.088977] ath12k_pci 0004:01:00.0: probe with driver ath12k_pci failed with error -5
> 
> I played around a bit more and it looks like the problem is that the PCI
> device is still being enumerated during startup, before the pwrseq
> driver is loaded. Not with the ath12k driver, but the internal PCI
> subsystem state. And then the PCI link dies briefly when the pwrseq
> driver loads.
> 

Ok, this seems to be the cause. There is a known issue with Qcom PCIe
controllers where if the device is powered off abrubtly (without controller
driver noticing) the PCIe link moves to link down state. Then we need to
bring the link back by reinitializing the controller. I have it in my todo list
but no one noticed this issue unless they tried powering down and powering up
the device (which is rare except on hot pluggable slots).

> If I add some hacks to the DT to force the wlan-enable GPIO low before
> the entire PCI _controller_ is probed, then it works correctly:
> 
> [   16.607359] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
> [   16.668533] pci 0004:01:00.0: [17cb:1107] type 00 class 0x028000 PCIe Endpoint
> [   16.668606] pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
> [   16.669055] pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
> [   16.675546] pcieport 0004:00:00.0: bridge window [mem 0x7c400000-0x7c5fffff]: assigned
> [   16.675555] pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5fffff 64bit]: assigned
> [   16.862083] ath12k_pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5fffff 64bit]: assigned
> [   16.870358] ath12k_pci 0004:01:00.0: enabling device (0000 -> 0002)
> [   16.888792] ath12k_pci 0004:01:00.0: MSI vectors: 16
> [   16.893954] ath12k_pci 0004:01:00.0: Hardware name: wcn7850 hw2.0
> 
> Note the pci messages after enabling the GPIO, before the first
> ath12k_pci messages. Without the hack, those appear already before the
> pwrseq driver is being loaded (during initramfs).
> 
> [    5.888688] pci 0004:01:00.0: [17cb:1107] type 00 class 0x028000 PCIe Endpoint
> [    5.888758] pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
> [    5.889207] pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
> [    5.902692] pci 0004:00:00.0: bridge window [mem 0x7c400000-0x7c5fffff]: assigned
> [    5.910311] pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5fffff 64bit]: assigned
> ...
> [   21.227565] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
> [   21.305496] ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with rc=134
> [   21.318382] ath12k_pci 0004:01:00.0: pci device id mismatch: 0xffff 0x1107
> [   21.338489] ath12k_pci 0004:01:00.0: failed to claim device: -5
> [   21.338555] ath12k_pci 0004:01:00.0: probe with driver ath12k_pci failed with error -5
> 
> Can we skip scanning the PCI bus until the power sequencing is done?
>

This won't help (but a good idea anyway that I'll implement). See below...
 
> The hack I used (see below) works, but is a bit odd since it requires
> assigning the wcn7850-pmu pinctrl to the PCI bus in the DT. Otherwise
> the GPIO is not forced low early enough.
> 

Your hack is making sure that the default state of the GPIO is not changed at
all after initializing the controller. So even if the pwrctrl driver probes
later, it will try to enable the module by doing,
'gpiod_set_value_cansleep(ctx->wlan_gpio, 1)', which would do nothing to the
device state.

So the issue is not with the pwrctrl driver but with the controller
implementation. Ideally, once the device is removed, the PCIe link should move
to Detect state and then to Polling state once the receiver is detected on the
lanes. But the DWC and Qcom glue has other logics that prevents the controller
from doing so.

So until the link down handling is implemented in the controller driver, we need
to carry this hack that preserves the GPIO state.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

