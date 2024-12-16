Return-Path: <linux-pm+bounces-19298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2569F2E80
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 11:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F50A1885255
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 10:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E57E203D53;
	Mon, 16 Dec 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIbDmuA6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1F82AF03
	for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346229; cv=none; b=h88icSApA4S4YdWMN7htLivMze087JnLR8ZejLZL5icA2Rxly7cRXaywY0asXiz+g09WbN/Cr9JfQX5wq19P/OzrZ+vj/kySj1d4w95AoAZr7xERXrub/m7RYAtdfymIczbZljyEtJyXtgwUpLHoBokv6iki1wncQbQWJAVGpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346229; c=relaxed/simple;
	bh=pU9+RFIvvPtP4mmdfCgIU3Gp7wNrqZG+8HkcraOhF8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+u+gr48P/qa3Vayd/6lmbobkwqXgjCrufjQFB1F5YKH2T6SkD2gi02RMEh+k7v7qw1wTnw9Rh7sEDx4cn6J44FTEcege6hfVLo2uG6+5LsB248ZGkbDkS/cidOTXJdBbQh+3Abd2KCubEPk0nIOP7xO15eyILg9+Iin0y15qeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lIbDmuA6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso4845444a12.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 02:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734346225; x=1734951025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MqGC67fLkQNsDpcKJfvwCJwfrp98opCS1CMiZnUF5wI=;
        b=lIbDmuA6ZFZEwwD1s6FJ/oV+KSnfIfKIbzj3/wj4Qb2G9Yc78zClhfBbA1EWddxGVn
         mFBk+6EHooV00HA7hO8ma2tJDB1aZmi5hXgkWRY2T/8DMOXrIIZzxdMOnSoqU2GykRvu
         /gENWNJ1RbcF4Lr5F/am+augwCWoDfQYc7sdXI251hsAmcHiyX0IM9cK883+3ugY6xHa
         w19g35Jno4yQuTxwaOCerXMX5HgUL8I2414fH92a7KKj/bzz0nahlGN46XPNo7QEtjhw
         Y6Q932s9BR4URhnzZfZ/4G9ZXV6QI44WhPEElVmsZQFLNXVH5iWYswxYWGc8KYANtQ7h
         FNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734346225; x=1734951025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqGC67fLkQNsDpcKJfvwCJwfrp98opCS1CMiZnUF5wI=;
        b=OJBD25TwwY0OvO7HCYBJkHDdQpMBJTdjwBj2xrbbOBnA4Iquh8dh8VZO4Eeh6cQ0n3
         7zQECXmcJ0F2TPZcgXAt5zhWd2lAtSrr9PYi+7woT5OAGMG1W39aoMy/GkXRNz5Em54B
         yhFbKTOcEcZhNmZ4LX2ilDXjHqfilViim8bR/k1IiPsEEFDDqA8V7XGHWZA1WQaad4Wk
         zy0gApxQLuV0XKWmU2KKFvXX0mEDqUuW/PyOKmUiFxYiPMO/JomMkXPQrveEAZswccSx
         jDG2EFs5+VGeRtN8hzoGqXfEZ+0EhhPFVJ8rzKA600vkz3uKWMeQ3PbNj6UEfZtoqT8U
         SYWg==
X-Forwarded-Encrypted: i=1; AJvYcCXLcygo3HB1tMDg7zHdsBktxr9VpRuqUWHUr5l8JIrmHu273x3x1MmGaoktXEPZowYYV0UZmMMj4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyimRxvwHHKC/LAgb9NW0hu86V7qU8I389C4PrDTylFFd22eoGM
	IjS6wsMvZmBPkiQEDV3gZz3UE748rj3E+D1Cw9t9NFTs6jVbIOZxFxYjpayj2VQ=
X-Gm-Gg: ASbGncvnu8kA79yvQSqPIl3Qq8SmpKtOTLFUpQYmMNGtsqt27xit2JEhJvxVDf00hq5
	5aLd5vEcgkuJwVhh9deRsNY9a8F0GiG6Ublmzv5JD1CqD08gu61tY6nlP2vn5MWR+fNF00e2/yZ
	sR2o9EkvSGuet8it7tmCmiYDYDwsFRsDhYAjoNQUUKsMI5S4lrQNeheFGACs0HJU33HAd5HmFtk
	LB2XTCHhltoQ1DJiAYGnZia87BhTS6blom6A/fAP17vwLfJqIZ0dTIOp6hprCOB/qMi
X-Google-Smtp-Source: AGHT+IFWsdeBbOo/gehwDdAxH4dsAhxbK3jXs+6BV6q3JsoZI77/m4XtW3wgpgeXPo6fqHHqV7VINA==
X-Received: by 2002:a05:6402:34c7:b0:5d0:cfad:f71 with SMTP id 4fb4d7f45d1cf-5d63c407452mr27602457a12.32.1734346224811;
        Mon, 16 Dec 2024 02:50:24 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef80:45ce:f141:322e:8943])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963c54d2sm312557966b.190.2024.12.16.02.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 02:50:24 -0800 (PST)
Date: Mon, 16 Dec 2024 11:50:20 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH] Revert "power: sequencing: request the WLAN enable
 GPIO as-is"
Message-ID: <Z2AF56PDj1m1BS1S@linaro.org>
References: <20241203141251.11735-1-brgl@bgdev.pl>
 <Z1x6ti2KaMdKS1Hn@linaro.org>
 <20241216070554.ym54ozdw45zhveo7@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216070554.ym54ozdw45zhveo7@thinkpad>

On Mon, Dec 16, 2024 at 12:35:54PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Dec 13, 2024 at 07:19:34PM +0100, Stephan Gerhold wrote:
> > On Tue, Dec 03, 2024 at 03:12:51PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > 
> > > This reverts commit a9aaf1ff88a8cb99a1335c9eb76de637f0cf8c10.
> > > 
> > > With the changes recently merged into the PCI/pwrctrl/ we now have
> > > correct ordering between the pwrseq provider and the PCI-pwrctrl
> > > consumers. With that, the pwrseq WCN driver no longer needs to leave the
> > > GPIO state as-is and we can remove the workaround.
> > > 
> > 
> > Should probably revert commit d8b762070c3f ("power: sequencing:
> > qcom-wcn: set the wlan-enable GPIO to output") as well?
> > 
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > >  drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > > index 682a9beac69eb..bb8c47280b7bc 100644
> > > --- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > > +++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > > @@ -379,7 +379,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
> > >  				     "Failed to get the Bluetooth enable GPIO\n");
> > >  
> > >  	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
> > > -						 GPIOD_ASIS);
> > > +						 GPIOD_OUT_LOW);
> > >  	if (IS_ERR(ctx->wlan_gpio))
> > >  		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
> > >  				     "Failed to get the WLAN enable GPIO\n");
> > > -- 
> > > 2.30.2
> > > 
> > 
> > I'm not sure why but applying this patch brings back the error I had
> > before. It does seem like setting wlan-enable GPIO happens early enough,
> > but maybe some timing is still wrong.
> >
> 
> There should be no room for timing issue now :/
>  
> > [   17.132161] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
> > [   17.480619] ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with rc=134
> > [   17.491997] ath12k_pci 0004:01:00.0: pci device id mismatch: 0xffff 0x1107
> > [   17.492000] ath12k_pci 0004:01:00.0: failed to claim device: -5
> > [   17.492075] ath12k_pci 0004:01:00.0: probe with driver ath12k_pci failed with error -5
> > 
> 
> Are you sure that this is the same error that you noticed before?
> 

Yes, "pci device id mismatch: 0xffff 0x1107" is definitely the same
error I saw before.

> > Any ideas/suggestions?
> > 
> 
> Can you verify that the pwrctrl driver's probe is completed *before* ath12k
> driver starting to probe by adding the debug prints in both drivers?
> 

I tried booting with "modprobe.blacklist=ath12k" and manually loaded the
module several seconds after the boot completed. Error is unchanged:

[   16.628165] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
[   55.065794] ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with rc=134
[   55.073354] ath12k_pci 0004:01:00.0: pci device id mismatch: 0xffff 0x1107
[   55.080457] ath12k_pci 0004:01:00.0: failed to claim device: -5
[   55.088977] ath12k_pci 0004:01:00.0: probe with driver ath12k_pci failed with error -5

I played around a bit more and it looks like the problem is that the PCI
device is still being enumerated during startup, before the pwrseq
driver is loaded. Not with the ath12k driver, but the internal PCI
subsystem state. And then the PCI link dies briefly when the pwrseq
driver loads.

If I add some hacks to the DT to force the wlan-enable GPIO low before
the entire PCI _controller_ is probed, then it works correctly:

[   16.607359] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
[   16.668533] pci 0004:01:00.0: [17cb:1107] type 00 class 0x028000 PCIe Endpoint
[   16.668606] pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
[   16.669055] pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
[   16.675546] pcieport 0004:00:00.0: bridge window [mem 0x7c400000-0x7c5fffff]: assigned
[   16.675555] pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5fffff 64bit]: assigned
[   16.862083] ath12k_pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5fffff 64bit]: assigned
[   16.870358] ath12k_pci 0004:01:00.0: enabling device (0000 -> 0002)
[   16.888792] ath12k_pci 0004:01:00.0: MSI vectors: 16
[   16.893954] ath12k_pci 0004:01:00.0: Hardware name: wcn7850 hw2.0

Note the pci messages after enabling the GPIO, before the first
ath12k_pci messages. Without the hack, those appear already before the
pwrseq driver is being loaded (during initramfs).

[    5.888688] pci 0004:01:00.0: [17cb:1107] type 00 class 0x028000 PCIe Endpoint
[    5.888758] pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
[    5.889207] pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
[    5.902692] pci 0004:00:00.0: bridge window [mem 0x7c400000-0x7c5fffff]: assigned
[    5.910311] pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5fffff 64bit]: assigned
...
[   21.227565] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
[   21.305496] ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with rc=134
[   21.318382] ath12k_pci 0004:01:00.0: pci device id mismatch: 0xffff 0x1107
[   21.338489] ath12k_pci 0004:01:00.0: failed to claim device: -5
[   21.338555] ath12k_pci 0004:01:00.0: probe with driver ath12k_pci failed with error -5

Can we skip scanning the PCI bus until the power sequencing is done?

The hack I used (see below) works, but is a bit odd since it requires
assigning the wcn7850-pmu pinctrl to the PCI bus in the DT. Otherwise
the GPIO is not forced low early enough.

Thanks,
Stephan

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 054ae260218e..8b658d15f185 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -562,8 +562,8 @@ wcn7850-pmu {
 		wlan-enable-gpios = <&tlmm 117 GPIO_ACTIVE_HIGH>;
 		bt-enable-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;
 
-		pinctrl-0 = <&wcn_wlan_bt_en>;
-		pinctrl-names = "default";
+		//pinctrl-0 = <&wcn_wlan_bt_en>;
+		//pinctrl-names = "default";
 
 		regulators {
 			vreg_pmu_rfa_cmn: ldo0 {
@@ -1298,7 +1298,7 @@ &pcie4 {
 	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
 
-	pinctrl-0 = <&pcie4_default>;
+	pinctrl-0 = <&pcie4_default>, <&wcn_wlan_bt_en>;
 	pinctrl-names = "default";
 
 	status = "okay";
@@ -1757,6 +1757,7 @@ wcn_wlan_bt_en: wcn-wlan-bt-en-state {
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
+		output-low;
 	};
 
 	wwan_sw_en: wwan-sw-en-state {

