Return-Path: <linux-pm+bounces-18788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 012049E86FA
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 18:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97D11883F26
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2678E18A93E;
	Sun,  8 Dec 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vyzlni3H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307CF189BB0
	for <linux-pm@vger.kernel.org>; Sun,  8 Dec 2024 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733678105; cv=none; b=fel8pBXPjH0qH3EcLu7xbA3+zXoc+3O5AzFUj+pXd6ujU9QcerIb3cFHvRepN+NdA1jP/bY19E4GfC+kJRsGlp255MDcAikAE+KF28MADr6P89AlrVsHDhbiFl8DJFpO5r2be9UIgiTVCzrghvBpCyLOzSsw8uXTwEf7QhadEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733678105; c=relaxed/simple;
	bh=CNbRGW8g8fcfrwiNfo+C/cJDf1YMo9RhfdZTo8iq2f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZshP6rv6hyLd1um5+Um3CGIzjKJJ6ZjxnQuoOTxxOYtA/fDs2vzFXX0JJmNCQSUyZkGNA0Sm4R3G6YcUqmhYBTAUsbSPlfrJ9nJU8JZgvfgAlAOxGZcn4AMRRSZa/qRWdMjsFr+T+YmEzbjrsIwQMXM1dLUuyFX8xU+4f/knkXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vyzlni3H; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e399e3310so1646412e87.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Dec 2024 09:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733678101; x=1734282901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dqFplj0uMB8EInw65XscKncVTRnpYupnLVJWyaDnZYI=;
        b=Vyzlni3HuXPl2eCGwnRBEuKwFbjlFI/vrgF8eNTCVYJycVrd/JUVoSEGQsTSi0yAlD
         ylFdN/AiR1Q2ZVnQkypXxYeKcuvDkhfnwC9koj1IxOTUxB9J9/JaHGBaTqwkrpDL7PyZ
         3qweteucYvi5cFNWRHrF0hE8fJPgz65MpcuYk84oSordFKr8/lvUG4BItSY/CBAxljOk
         lnnw2NF/jwlgthtfz3RQnR/PUo2Oz7zT56988HtuvaR4dzkhwdXlIROEcma1MhvLc2vP
         +mE0p9FirEA5nwu5RzhluLVxArLjDvW/R2XXrhGlLkphq8G20P8mqbN2wVEM+heHK1m1
         jxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733678101; x=1734282901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqFplj0uMB8EInw65XscKncVTRnpYupnLVJWyaDnZYI=;
        b=DLcbyx3Tyo0yUwR1kE6QbUJ9NpyUE2S+5Edny1ea8kVuViq2Ei6eNyipB25ISSrno0
         nAUn6wekFc4k5HmAXvVt4ylJEroAMzzPITQR5pUK09RMR9qtf3owNdOerAAn915SKwO1
         O9CFNzFH7zUH0a4mIJJzaNfHvacCvtqqVYTY0TaWrMM/kOlonvavbQLn63SCcG1OpWfH
         FM213F0uHfDhCA/VspoXYV/3GVwu4qvLRCOcw0UB4DfsTSiEzM5ZaqhmsgvZWS3NlOGQ
         w3RC3zo1sbPktBiT0KhQwa1ivm8Jcos5KRZATJpCmsM9PD6HU1i0TYKtNHs5Iz77V65T
         WjuA==
X-Forwarded-Encrypted: i=1; AJvYcCVcD3SPIYtiJP77GWS9mw7dqSPQyJri0DaqvqHxFHdVfScz9IKhijbqzAqpGVlVrt8WPvxx0cbGBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+vfCT9GMefrhRTrQ5sWz1cSXwXlJ8TnFQr1KCbtJlgKQANRfo
	HpmbiQC5EzL3o3UxqyFsMw1n3rDbP+hxbjYebS5phJ09PEkWQV72Gi3rjml2i1KnV1YKUhmUTin
	e+E2tzw==
X-Gm-Gg: ASbGncvvfCPnODn6GnesgCvxBLWfYKKIrqu4+BvDyVyRO2vyMGolymhqD9CjTZ/L/6G
	wqFjTDW7NjcOmemM6maLXySiJ9pd3BZkFsj2C/1WmnhwKcNKzRviLNiUrRBalZbThs4ldHWPSNP
	YL9xuTNvXPODcihvB3yxr7Agg44U2DDxQtRSLA2GQMHzXJ2iYOG0oiyUYQGp72NmDq5WQhc8/UN
	8KOvQD/lwPcPEXtLYBRrevwoVlZsjm/x0tK8CLahmrbMCs3HGHNDlEZCL85WwQD1Z0Riji43CdJ
	9p4md88+ouazq8RnXNqioXleM2jA7A==
X-Google-Smtp-Source: AGHT+IFkgC4CY00uHOEhGCDb+lElZAAae4ogeFkb0UE5GLOs3gylH/vk0xRefOvLftIPM6MTtA/XpQ==
X-Received: by 2002:a05:6512:138f:b0:53e:1b94:7279 with SMTP id 2adb3069b0e04-53e2c2b9319mr3748035e87.23.1733678100986;
        Sun, 08 Dec 2024 09:15:00 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e33ac12fesm787746e87.108.2024.12.08.09.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 09:15:00 -0800 (PST)
Date: Sun, 8 Dec 2024 19:14:58 +0200
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
Message-ID: <7y6mu2mtujloctxwi5voszmeo4ctheceiypbnbslyxv34jknm4@ewkooz5fi4w6>
References: <20241204131706.20791-1-quic_janathot@quicinc.com>
 <20241204131706.20791-3-quic_janathot@quicinc.com>
 <pzkijkdswskaq6232uldapz3b6v6zplif7uah24iwq3ymlezft@skbcy2vod3c5>
 <53d44689-798e-4b5f-a0f1-8a39bea2f19b@quicinc.com>
 <hjui7cn4iuo4id2q4mmqx2i7c3eyu6ae43fcft6psflypb3aya@ia5i5s4ya45e>
 <d68907f0-15e4-486a-9077-31e8a8659e02@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d68907f0-15e4-486a-9077-31e8a8659e02@quicinc.com>

On Sun, Dec 08, 2024 at 09:42:21PM +0530, Janaki Ramaiah Thota wrote:
> 
> 
> On 12/8/2024 5:35 PM, Dmitry Baryshkov wrote:
> > On Fri, Dec 06, 2024 at 08:15:35PM +0530, Janaki Ramaiah Thota wrote:
> > > 
> > > 
> > > On 12/5/2024 4:29 AM, Dmitry Baryshkov wrote:
> > > > On Wed, Dec 04, 2024 at 06:47:04PM +0530, Janaki Ramaiah Thota wrote:
> > > > > Add a node for the PMU module of the WCN6750 present on the
> > > > > qcs6490-rb3gen board and assign its power outputs to the Bluetooth
> > > > > module.
> > > > > 
> > > > > Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> > > > > ---
> > > > >    arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 165 ++++++++++++++++++-
> > > > >    1 file changed, 164 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > index 27695bd54220..07650648214e 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > @@ -1,6 +1,6 @@
> > > > >    // SPDX-License-Identifier: BSD-3-Clause
> > > > >    /*
> > > > > - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> > > > > + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> > > > >     */
> > > > >    /dts-v1/;
> > > > > @@ -33,6 +33,7 @@
> > > > >    	aliases {
> > > > >    		serial0 = &uart5;
> > > > > +		serial1 = &uart7;
> > > > >    	};
> > > > >    	chosen {
> > > > > @@ -217,6 +218,63 @@
> > > > >    		regulator-min-microvolt = <3700000>;
> > > > >    		regulator-max-microvolt = <3700000>;
> > > > >    	};
> > > > > +
> > > > > +	wcn6750-pmu {
> > > > > +		compatible = "qcom,wcn6750-pmu";
> > > > > +		pinctrl-names = "default";
> > > > > +		pinctrl-0 = <&bt_en>;
> > > > > +		vddaon-supply = <&vreg_s7b_0p972>;
> > > > > +		vddasd-supply = <&vreg_l11c_2p8>;
> > > > > +		vddpmu-supply = <&vreg_s7b_0p972>;
> > > > > +		vddrfa0p8-supply = <&vreg_s7b_0p972>;
> > > > > +		vddrfa1p2-supply = <&vreg_s8b_1p272>;
> > > > > +		vddrfa1p7-supply = <&vreg_s1b_1p872>;
> > > > > +		vddrfa2p2-supply = <&vreg_s1c_2p19>;
> > > > > +
> > > > > +		bt-enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
> > > > 
> > > > Doesn't WCN6750 also have SW_CTRL and wifi-enable pins?
> > > > 
> > > 
> > > For Bluetooth, these pins are not needed. We have verified Bluetooth
> > > functionality, and it is working fine.
> > 
> > You are describing the hardware (PMU), not "a part of the PMU for the
> > BT". Please check if there should be a wifi enable pin and adjust
> > accordingly.
> > 
> 
> We further checked with WiFi team. For wcn6750, sw_ctrl and wifi-enable pins
> handled from WiFi firmware/controller. So it is not needed to handle in PMU.

Please mention that in the commit message and add a brief comment in the
PMU node.

-- 
With best wishes
Dmitry

