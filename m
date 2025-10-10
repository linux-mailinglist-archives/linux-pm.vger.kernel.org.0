Return-Path: <linux-pm+bounces-35921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7D8BCD910
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 16:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52971402A4E
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D483F2F60CB;
	Fri, 10 Oct 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eml6+LRK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77102F5327
	for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107210; cv=none; b=X/ZTQMGVSbFiQBLZdUlm/+KG3FY7cSd6LSaNSRPt9+qpkA+beKY5tdDdsch1dK+MhhupsvoiJP6zRpVeNRR0j/8+kvs4SAgNI3Zpzcd8EEi9h2rYxb8Ee/XSTyFi974x9EnNV2AUk8KO8fo9Qo0fay5up89lUlSoEllp02gs4IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107210; c=relaxed/simple;
	bh=WbeLzUgEV22dDeik0xafOaSUdi9R9dEvpfqnpGFwEAw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BuQ7+R+2VeYXNSPXcMKhP/5yT26c1BEdsC1IeY8OIBjm+h5+1TT1bdy4E3lO8xu4Eqmuyh2xkzmgq33z4QxqHJmgKvuWSzTLdqBZkz2DcOOvXmNEiGRXjwp42XpEh09c0C1kX1ierdE+IB1/kpOs5JDP5dHDgrU6SBrOZt40/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eml6+LRK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso1580656f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760107207; x=1760712007; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WbeLzUgEV22dDeik0xafOaSUdi9R9dEvpfqnpGFwEAw=;
        b=Eml6+LRK6dXTs8wDanPMG4/UBwafDNcsex+TU4XIv8H+YPlSSbdpmI6aQRtt9FS3MO
         XXiYJgUJDhugYOwVhPzBTa+Aj45j1dc0dtJhbRZGn9zcD3Wt7fjUsl9dkBVwihjUgMRH
         yXE9oxfYIlEu+13IwkAPfCIvtMRGCTsD1UHAgPB6eAeymExTGiViv2mER4eLHzO1oUnG
         roBlOJAHl9ZD/unr8xJ/5O2Z3aXbb+sysPP3ilMQDWsJTevMfEEpV1ZYnoWPKybXJ+RG
         Z32bDHCnjZrEw2xVdpt8/REaov7l7TSi2zD7od+92UAr04ChvEpep5yO79DrvOVb26aI
         fs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760107207; x=1760712007;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbeLzUgEV22dDeik0xafOaSUdi9R9dEvpfqnpGFwEAw=;
        b=KtQovdJnQcxi1R9kOOGXM9wqSUE4WVS4cJAdBOA43Z6ii24IXxjlKMayHOGEAkX2AV
         r+jPjI9YC9CtzcW9pbL9GeJzZWPb3dSt1znjX/ykr79kiRNgkI58D3sSMk/MM7+9o1JK
         N1vApkbNi7CvkYgM533cYCU/+17lZfmj6w8V3hsn0/fLbC+KGAoqNq9AiYToMZnet5Jx
         4zjWVZEHGVoL43kX1SqdFwPlRj6gr5oqunyh5UNImSE1lDp3sQf+CaDiIdpge3w1hF+Y
         eDtG8JHpywbs0cTLdMSDvbRVEQBDzGuyAx1dx7H1LQkCHYhlOqxKgPwJZ7JP6+2regCw
         ihCg==
X-Forwarded-Encrypted: i=1; AJvYcCXHV9hcUUhHIXwL3oiUPVAq6KvOyiEq9/j125aNRJsOKeLtQ+0QUJeLZm0PFW9NnPzwrSIpAFOvjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYgQ7vqGOSbAI+4cxH+xvcrSVz3IVbr76QaDDDc9rhtaMpBWmu
	Lbyz/RcqpU6/BDMeJqWAXvZZhycWuY3q4lyFL7ljEEitmscHwJ+Cfrvp
X-Gm-Gg: ASbGncuiXgdjxQCSxYNgCXdd9cdY8G8xJcXlGFkkwfMF7eOptPMLUwDoNjzlPYoJm2W
	8DePVvfZpnE6TxItmz+wNkK18BX5MMV2UCEiEMLVzmXUoeMGH3c1O5/yuc73mNRB1G05NUSTnPg
	wTmGjEdluv4P8+9j+auOC1ydfLFP5Ptbg4Kctqrsdd+bm4aJzrDP82xs8I3aI+vQJf5fYdxIJaR
	pvMn7Ot+HDCLt8dPfjUCxEF7ygGLnSlZdpqfhhWGoUB0R1dpCe5lICMk6uPloQG9y/DbFk2c38n
	9AC403dSofD3aR/5VTD/v1Ag+le1nJ1WvPwHvhZ1TeeRVBYSxJamAul9pZPL1ZtQfftbMsiVpA4
	oxYYPYs29u4DEqJTS1TbcEgqY+PegYOplq2tHvzFZrHkk5dPFLtcS6skEFnOw
X-Google-Smtp-Source: AGHT+IFnMF+6qNtBAMw+CyoQv3jiuQo/QSyCG7rCO6D+8KNfzJwrWSPS9T8beikQzgBhf5GvDE9Ang==
X-Received: by 2002:a05:6000:1867:b0:3eb:b80c:cea0 with SMTP id ffacd0b85a97d-42666abbbabmr6495344f8f.4.1760107206730;
        Fri, 10 Oct 2025 07:40:06 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5833dcsm4580320f8f.19.2025.10.10.07.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 07:40:06 -0700 (PDT)
Message-ID: <61b5a5f43d97f700ec7fc52110a1784ef699eeaa.camel@gmail.com>
Subject: Re: [PATCH RFC 0/6] Battery temperature ADC plumbing on Qualcomm
 platforms
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Luca Weiss <luca.weiss@fairphone.com>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko	
 <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano	
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba	
 <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan	
 <ldewangan@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, Konrad
 Dybcio	 <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, Jens
 Reidel	 <adrian@mainlining.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Fri, 10 Oct 2025 15:40:36 +0100
In-Reply-To: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
References: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 13:21 +0200, Luca Weiss wrote:
> This is an RFC which implements a potential solution to get battery
> temperature readings working on for example smartphones with Qualcomm
> SoCs.
>=20
> The solution chosen in downstream Qualcomm kernels is exposing
> ADC_BAT_THERM_PU* in the ADC driver as temperature channels with the
> lookup table ("struct vadc_map_pt") for the specific NTC found in a
> device's battery patched to adjust the lookup table.
>=20
> The high level solution proposed here:
> * ADC driver provides temperature channel in (milli)volt as IIO channel
> * generic-adc-thermal driver converts voltage to temperature based on
> =C2=A0 provided lookup table from DT (driver has one IIO channel input, o=
ne
> =C2=A0 IIO channel output)
> * The fuel gauge driver can use that temperature IIO channel to expose
> =C2=A0 battery temperature via the power supply device
>=20
> Variants/alternatives considered:
>=20
> 1. Do not implement IIO device in generic-adc-thermal
>=20
> Without an IIO channel and using thermal zone directly it becomes more
> difficult. You cannot get thermal zone by reference (e.g.
> thermal-sensors =3D <&foo>;). The function thermal_zone_get_zone_by_name(=
)
> exists but lookup by name is kinda clunky. Adding by-phandle support
> might be possible but is lots of work. It also doesn't really look like
> thermal-sensor is really meant to be used by other drivers. E.g.
> there's also no "thermal-sensor-names" property to designate passing
> multiple thermal sensors. So I believe IIO is a better fitting API for
> this.

The only thing that I dislike is that using IIO just feels like hacking aro=
und
the lack of an inkernel interface (as you pointed out and which IIO provide=
s)
for thermal devices. My main question is, what makes this device an IIO dev=
ice
despite the fact that we (you) want to use the IIO inkernel API (IIUC)? AFA=
IU,
the sensor is already being implemented as the ADC driver and this is just
convenience.

Anyways, that said, there's precedent (at least in 2 places) about register=
ing
IIO devices outside of the subsystem.

Maybe we need the concept of an IIO proxy for the IIO inkernel interface. L=
ike
consumers of IIO devices that can use some the measurements (channels), do
something with them and then be IIO providers. I guess I'm already rambling=
 :)
=20
>=20
> 2. Expose IIO channel as temperature in ADC driver
>=20
> This would require passing in the temperature lookup table somehow to
> the ADC driver via DT. I think this passes too many details about the
> hardware that's connected into the ADC driver. While possible, at least
> for Qcom ADC there's no precedent yet.

Not really familiar with the HW setup but (just for my understanding) why i=
t
would not make sense to pass that info to the IIO driver? I guess that tabl=
e is
just not part of the ADC?

>=20
> 3. Add temperature-lookup-table as property to simple-battery
>=20
> Since the NTC is a part of the battery pack, adding a
> temperature-lookup-table property to simple-battery would make sense
> instead of having this lookup table be standalone in the
> generic-adc-thermal node. However being able to re-use the existing code
> in generic-adc-thermal lead me to the current proposal.

What about turning it into a small lib module? No idea where to put it thou=
gh.
But while I was thinking about this, your option 3 looks the one that makes=
 more
sense to me.

My 2 cents!
- Nuno S=C3=A1


>=20
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Luca Weiss (6):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: qcom-spmi-adc5: Add battery ther=
mal channels
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: thermal: generic-adc: Documen=
t #io-channel-cells
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thermal/drivers/generic-adc: Register as I=
IO device
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thermal/drivers/generic-adc: Allow probe w=
ithout TZ registration
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm64: dts: qcom: pm7250b: Define battery =
temperature ADC channels
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm64: dts: qcom: sm7225-fairphone-fp4: Ad=
d battery temperature node
>=20
> =C2=A0.../bindings/thermal/generic-adc-thermal.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 4 ++
> =C2=A0arch/arm64/boot/dts/qcom/pm7250b.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 +++++++
> =C2=A0arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts=C2=A0 | 83
> ++++++++++++++++++++++
> =C2=A0drivers/iio/adc/qcom-spmi-adc5.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 6 ++
> =C2=A0drivers/iio/adc/qcom-vadc-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++++
> =C2=A0drivers/thermal/thermal-generic-adc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 68 ++++++++++++++++--
> =C2=A0include/linux/iio/adc/qcom-vadc-common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +
> =C2=A07 files changed, 198 insertions(+), 6 deletions(-)
> ---
> base-commit: 6063257da111c7639d020c5f15bfb37fb839d8b6
> change-id: 20251010-bat-temp-adc-8539bf0b85bc
>=20
> Best regards,

