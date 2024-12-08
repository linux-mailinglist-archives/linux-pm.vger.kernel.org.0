Return-Path: <linux-pm+bounces-18761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6769E84F3
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79395164917
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 12:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794E3145A17;
	Sun,  8 Dec 2024 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HjadUx1o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7C313C9A4
	for <linux-pm@vger.kernel.org>; Sun,  8 Dec 2024 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733659564; cv=none; b=Uj4I4FvLAXOV3DlpUEUO0rncquGj0hL489qD4Za+bhNbtGLzi/DiEOxMsJNgjBIeKbokEobGI3jB1Nc87mjl3dSyv5PAuKgYY81mjKw4cFtk6/FgE7zywWAVW44wPB1VyBkUnwRh5bjtUOzsbJHUh22M1fAsTqdP/Y4G+yz475o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733659564; c=relaxed/simple;
	bh=7OLu/I3KbdAmUn3E2jNeRFtg91yq17Itmd5TAN+jdFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1otERVO1WwVxoObnFCmtxol5zsSWWO9FALIqKcERJjyASan8pLzwk6nLW8zx5nhQ4jhJhHj4zjfokFll06nkBxxm8Up+ylQkxTo+bVxGkZG4sbeiQNWtdWePxXR/2DlGOjoTeRlBavyLxYRtrrwDj2i0FSZvkm8Edsqf8I86H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HjadUx1o; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5401bd6cdb7so310264e87.2
        for <linux-pm@vger.kernel.org>; Sun, 08 Dec 2024 04:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733659560; x=1734264360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lx68hB7Zpl0dAySaNA/WYlqeVEbWVfGCTLK0VrOdlAY=;
        b=HjadUx1oRbUREzkeK2E4143dNrFG+BRiCMGdRFjk73bGv0xsYZt9pgPfMVQ2FApvAR
         AObJIr10VQe8aBv1vF1us3et8j07o5d19poJb/tFA3h2jAnXg9rpPmL1nCEtV011IJzU
         iJXw9kEfet9c/irdnTZYLInlWNo4OYWUmD2DzsqZxUu5RXUI90m3PGG4gNlVj5+v2XMX
         nek2VCUVVt/n1fSRPt7YLURN78GA5PJwwIP6/drgHA57ziYu9O0YGEg/wx3CZkjmfpPZ
         ivIjOblGvVk3J86mBnekohqNv8pf1/HTe1hN/22gmtFkfLy96TVkZP+rrMUWMl8i+Ijr
         jvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733659560; x=1734264360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx68hB7Zpl0dAySaNA/WYlqeVEbWVfGCTLK0VrOdlAY=;
        b=ir9PPIEwa83f5EeLVuP/uMzRhjYE6C4WVSEoKvWJsjMUzPVpBIKu/yNnEuMXDd3/82
         rrfTifujGFZULW2M7r4Ppoc996U7w05EIx0BXFKZhdf4QiGwN438kK7hFGKmOc1dDOOA
         Rcuk8dgo+cBrot/h1kOhqYCh8KHJs4bkmliwW4+VdUYy26yRl+Ey3I6qfJt7AJ/uCdER
         AKe1xx1F/jaVhqvIbuCSxhc+hG2Y3GMdW4qCEDceOHalGZvh1ZcbB10MkTxrz4onl7gm
         bh8jl+aKdp0PgpN3GZZKaDs9oDQy+cn0O/KDW5yDuZUmMS8Bh+SVAWyN6EXpwx7119Eq
         2CvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJX6D3yTMuc49zoYK5RKP2li8z5zdgPN70ojv+3ZdqaGygrcAi2IPi0gftX72DgjelyWQFw4/1Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/CC3OhPryO3u65cHLFDj2BPKLtR91HchIQwXt7ALWqhMXuL8
	jKlUtm0Pas7eTYG3rjrgzrZpmgU3ZaC22f5i/es0qUlC/c46yP189628liUGZwc=
X-Gm-Gg: ASbGncs/vdRZItSTrqM/L5AWi/Ba1JEiH7YmvnHXC2P608R7qSVLtoXNFT/weR7Bh3i
	2yzStLpq+ZwPaskN7QJZOk+swL3SbNz7l4+DgVEuSh9K+5uO8aXGdSJ2lA6thKKl8qd6Qw+Bq09
	CAGk/SR4o+Bclfh0H0teqLSVva20TSA8w3gh7qvqYN9eERdulLFzCfrPnDCeNhswOlIRabx7d+O
	pUndiLiKBYjh+Gqj/h7SzgokK1dsk1h5WQb6F32f+mN4OCV5rBd5vctd6/dF46E2Jpe052Ns3DV
	z6LIrmyouNJ2VYvGyvUwgd1YFnSIYQ==
X-Google-Smtp-Source: AGHT+IGvsRQ2B7XobCDNbx1+tDzWDsM8MW8qgWQNqGXtl3/Y/aZoodCtsatud1RQBz8SZrVJpchqVg==
X-Received: by 2002:a05:6512:3988:b0:53e:df2b:df25 with SMTP id 2adb3069b0e04-53edf2be017mr1390532e87.16.1733659559586;
        Sun, 08 Dec 2024 04:05:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401a26babesm304562e87.11.2024.12.08.04.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 04:05:57 -0800 (PST)
Date: Sun, 8 Dec 2024 14:05:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: qcs6490-rb3gen: add and enable
 BT node
Message-ID: <hjui7cn4iuo4id2q4mmqx2i7c3eyu6ae43fcft6psflypb3aya@ia5i5s4ya45e>
References: <20241204131706.20791-1-quic_janathot@quicinc.com>
 <20241204131706.20791-3-quic_janathot@quicinc.com>
 <pzkijkdswskaq6232uldapz3b6v6zplif7uah24iwq3ymlezft@skbcy2vod3c5>
 <53d44689-798e-4b5f-a0f1-8a39bea2f19b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53d44689-798e-4b5f-a0f1-8a39bea2f19b@quicinc.com>

On Fri, Dec 06, 2024 at 08:15:35PM +0530, Janaki Ramaiah Thota wrote:
> 
> 
> On 12/5/2024 4:29 AM, Dmitry Baryshkov wrote:
> > On Wed, Dec 04, 2024 at 06:47:04PM +0530, Janaki Ramaiah Thota wrote:
> > > Add a node for the PMU module of the WCN6750 present on the
> > > qcs6490-rb3gen board and assign its power outputs to the Bluetooth
> > > module.
> > > 
> > > Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 165 ++++++++++++++++++-
> > >   1 file changed, 164 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > index 27695bd54220..07650648214e 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > @@ -1,6 +1,6 @@
> > >   // SPDX-License-Identifier: BSD-3-Clause
> > >   /*
> > > - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> > > + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> > >    */
> > >   /dts-v1/;
> > > @@ -33,6 +33,7 @@
> > >   	aliases {
> > >   		serial0 = &uart5;
> > > +		serial1 = &uart7;
> > >   	};
> > >   	chosen {
> > > @@ -217,6 +218,63 @@
> > >   		regulator-min-microvolt = <3700000>;
> > >   		regulator-max-microvolt = <3700000>;
> > >   	};
> > > +
> > > +	wcn6750-pmu {
> > > +		compatible = "qcom,wcn6750-pmu";
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&bt_en>;
> > > +		vddaon-supply = <&vreg_s7b_0p972>;
> > > +		vddasd-supply = <&vreg_l11c_2p8>;
> > > +		vddpmu-supply = <&vreg_s7b_0p972>;
> > > +		vddrfa0p8-supply = <&vreg_s7b_0p972>;
> > > +		vddrfa1p2-supply = <&vreg_s8b_1p272>;
> > > +		vddrfa1p7-supply = <&vreg_s1b_1p872>;
> > > +		vddrfa2p2-supply = <&vreg_s1c_2p19>;
> > > +
> > > +		bt-enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
> > 
> > Doesn't WCN6750 also have SW_CTRL and wifi-enable pins?
> > 
> 
> For Bluetooth, these pins are not needed. We have verified Bluetooth
> functionality, and it is working fine.

You are describing the hardware (PMU), not "a part of the PMU for the
BT". Please check if there should be a wifi enable pin and adjust
accordingly.

-- 
With best wishes
Dmitry

