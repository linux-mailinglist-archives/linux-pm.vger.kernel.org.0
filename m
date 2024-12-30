Return-Path: <linux-pm+bounces-19853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C93699FE907
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 17:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF081623FA
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778E11ACEAC;
	Mon, 30 Dec 2024 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR2PIpgg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E428A19ABA3;
	Mon, 30 Dec 2024 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735575856; cv=none; b=WvyhKdaKH4knSRcY253AfambDBST7P4uepRSii3IoOQ41UHLC4Sy3RiM8qVzQWblgMbxfhWF8ZSGJcImIava4MWbwdYi5t5p4t0jvpr3mnHsRFHVYcvfONVSZGdikHAkRUWLquMAMf0E4pZkdfkDFxRdmN0227rQDD7paDrEVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735575856; c=relaxed/simple;
	bh=WCDd1WFvb0By3z4kEVfAfGMFgCJKdxQTdHM6nF0i27U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShrlSpVWbNYq9ngxBYMqn3qbYgi428r+NNex6Scox6pi8REJ//PaBVkOSRqdrXncVqz78rhXjFPHV0vjsJKA8qA4m1bfa66Y3ivhxq273lZgoy7iJDWJo/W78KPAyOnOBBJteOO9sae0dTzFMLKc5vWmzHGYdrr12HOZn1Zw+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR2PIpgg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21680814d42so105578535ad.2;
        Mon, 30 Dec 2024 08:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735575854; x=1736180654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQYiqjijoXv8UNTxSWkMBDgGIXf88c4tiPOnipcOFPA=;
        b=CR2PIpggSqFMz0DMB8DtMP+dNWF50zc4pK1llZ7yaxyqXAFM2bA1xhp3LsQUebp3FE
         tGt50NY2FtCljOr5nseyLl71vO1QsS70okY1JSAfEddy3L3Z+kQ/YJzwLxQho0XeOM0K
         InX8eXT3veGItGLYie5cf+pCBl8S9a3jnuNZLCckwHK/eQtrqz0a5JVXOlEDf7nJWlQv
         lObsKGY9vDSAfPNJAXpODEDlxXDfoUm1UKLgO0rTnIx2OLxBvhkWISVEC9Ex56ZVWcnC
         A18CqcakU+P5r0VIp2XZ7bkMqD2qwsdeltNaczuiYdyPsyPZP7vYauyf2FZNQt/eLdBl
         ogmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735575854; x=1736180654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQYiqjijoXv8UNTxSWkMBDgGIXf88c4tiPOnipcOFPA=;
        b=JOQKrhPLaoijSn5016J9He0F2ivOxgwIVHfQFtUNR36ceRic8MPYMvviHwMf18v6Uj
         ILdF1ABwyobEthQj3ZHiOV/HUz058hxBsnX2UrHxJNywE9xQnpAY+yfv9mJv5zNXBJo9
         r1lDCSQwzTwb4T98/DztDZl+ffhyL+nans2DXUvwS3TlkW2XSzT/4/IiXDha2RHNOing
         dZUL1YiZUk+GJyA41aOmX6t4tmQUBrzdzK9RC432PlnOJCU14OgxBpupbIIRriSNTkmx
         tscucRIaKECmiIIM6mjZrEhlFxT/Ofw4TM0s0laczZzwkZABGDj+3zvXSubWp6ZsxaPd
         N53g==
X-Forwarded-Encrypted: i=1; AJvYcCUoJ1AWFcZvvnhO34up5l5/+jHZzzXMvbeJWRdXngzYg4VaLqXvlrxFznaOwM5tD+HllKX2hJpza1mw@vger.kernel.org, AJvYcCWg+MDCwQM3VgfcOKUBnkdehD8AM4hfLl6nv72eqS+PpYm+pHwjp5r+2nlACOg3CMHUKk5KSjxyhPfrxtiFlA16kIE9SQ==@vger.kernel.org, AJvYcCWnGFXW9IwY50d32KObJr2yVJqPfLl/biSZIPfMMawx+VydQLgZsigej4wbgKCpy5x24sfynF96UDCbAKBszA==@vger.kernel.org, AJvYcCXMGZzdTxjCxs3nzawktkP3MVc0NOeRFthfPH6wPCdhQvQYRtL6tly1dZgdO5XJO/SIRA2RCKYEY81phuSw@vger.kernel.org, AJvYcCXRsFk6ZHKnxTyzyawN8Q2kJSwWeEU/T8cS+Qk2S2ToHr20hBvTad5pi0HUqlBlKbJqY5Zuz7Xo7P0=@vger.kernel.org, AJvYcCXT+M/i44tzCjca6rA/GIxVF7TxoCr48+2vXcAim/5YMXyrPCFlTpKoDTU0rYFxS2hwyUgIF38vSYrM@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfEOfq1tKQRffiAJzFD1MFmgUwwMIo63dY7JpkP5t5+i+8Igl
	DyJdt13+cMzjydpicOJiKJIRncDThYAVLDLKiCPBoONCVnaf1SXa
X-Gm-Gg: ASbGncsBZpwx12QoLR28307Xs3sDApuZuHYHx6ZJZ3aqP+Vm3Lto0OZTl1WTQL92476
	SuxEYFGCgCRWfOyc0qjBTdBRZVtIch0SPpkL3GSelBPobbY+jKYX9MmjRAyEOs3rCDqQVqh3UlY
	L/52ejocNHChZMhqV7Yjxm8PRsPEmgqhRWAM6IX/HZ3i+pVRqZGUnRUMzfhnchXsb9NP9YlpO/A
	NcJzn8Xshn78yb9AEloBnfOt+FHZPKWwspngbSZA+0=
X-Google-Smtp-Source: AGHT+IFeDxGKcHWEYos+i3sMDCqEYmYUL6mMPgS2lHM+khPzP9xeYbBgtPQKszdQYLCZwH2Za6hUEg==
X-Received: by 2002:a05:6a00:ac2:b0:72a:ae66:3050 with SMTP id d2e1a72fcca58-72abde40466mr48099099b3a.1.1735575854114;
        Mon, 30 Dec 2024 08:24:14 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c182sm20055113b3a.189.2024.12.30.08.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 08:24:13 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: konrad.dybcio@oss.qualcomm.com
Cc: andersson@kernel.org,
	bryan.odonoghue@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mitltlatltl@gmail.com,
	nikita@trvn.ru,
	platform-driver-x86@vger.kernel.org,
	robh@kernel.org,
	sre@kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: gaokun3: Add Embedded Controller node
Date: Tue, 31 Dec 2024 00:22:56 +0800
Message-ID: <20241230162257.215401-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <233e7a35-0ec5-4746-b758-684a0befd005@oss.qualcomm.com>
References: <233e7a35-0ec5-4746-b758-684a0befd005@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Dec 30, 2024 at 10:53 PM Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
> On 27.12.2024 6:13 PM, Pengyu Luo wrote:
> > The Embedded Controller in the Huawei Matebook E Go (s8280xp)
> > is accessible on &i2c15 and provides battery and adapter status,
> > port orientation status, as well as HPD event notifications for
> > two USB Type-C port, etc.
> >
> > Add the EC to the device tree and describe the relationship among
> > the type-c ports, orientation switches and the QMP combo PHY.
> >
> > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > ---
> >  .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts | 139 ++++++++++++++++++
> >  1 file changed, 139 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
> > index 09b95f89e..09ca9a560 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
> > @@ -28,6 +28,7 @@ / {
> >
> >       aliases {
> >               i2c4 = &i2c4;
> > +             i2c15 = &i2c15;
> >               serial1 = &uart2;
> >       };
> >
> > @@ -216,6 +217,40 @@ map1 {
> >               };
> >       };
> >
> > +     usb0-sbu-mux {
> > +                     compatible = "pericom,pi3usb102", "gpio-sbu-mux";
> > +
> > +                     select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
> > +
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&usb0_sbu_default>;
>
> Please preserve this order:
>
> property-n
> property-names
>
> > +
> > +                     orientation-switch;
>
> This
>
> > +
> > +                     port {
> > +                             usb0_sbu_mux: endpoint {
> > +                                             remote-endpoint = <&ucsi0_sbu>;
>
> And this section have incorrect whitespacing (one tab too many, make
> sure you set your tab width to 8 spaces)
>
> Same for usb1-sbu-mux
>
> [...]
>
> > +     i2c15_default: i2c15-default-state {
> > +             pins = "gpio36", "gpio37";
> > +             function = "qup15";
> > +             drive-strength = <2>;
> > +             bias-pull-up;
> > +     };
> > +
> >       mode_pin_active: mode-pin-state {
> >               pins = "gpio26";
> >               function = "gpio";
> > @@ -1301,6 +1426,20 @@ tx-pins {
> >               };
> >       };
> >
> > +     usb0_sbu_default: usb0-sbu-state {
> > +             pins = "gpio164";
> > +             function = "gpio";
> > +             bias-disable;
> > +             drive-strength = <16>;
> > +     };
> > +
> > +     usb1_sbu_default: usb1-sbu-state {
> > +             pins = "gpio47";
> > +             function = "gpio";
> > +             bias-disable;
> > +             drive-strength = <16>;
> > +     };
>
> Similarly, please keep drive-strength above bias for consistency
>
> lgtm otherwise
>

Totaly agree, I was in a hurry, I will fix it in v2.

Best wishes,
Pengyu

