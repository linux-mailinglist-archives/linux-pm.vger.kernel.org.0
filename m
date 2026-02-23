Return-Path: <linux-pm+bounces-43004-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAQZJ+sGnGmO/AMAu9opvQ
	(envelope-from <linux-pm+bounces-43004-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:51:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE55172D2B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B8CE301E229
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D967B34A76B;
	Mon, 23 Feb 2026 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Vfj1Mg1J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BDC1917F0
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833055; cv=none; b=VAvY5Y8C8kN5gTl/qZYzMaB6+y6pMHG6+QShPkYb8gQ4e+diY/SZGvuBVc0MqPoA9lmtGOYcYSLXJYbXslQoxnErs4SWkh1OtxGTttJz0O6gddsvyJgtxYvC2sM0rBdGubUbxbWy4O+bKsprzM7yP1GcxyGUWNS/omyo85RBcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833055; c=relaxed/simple;
	bh=myrYEPr/R1pVr+HcXiT9MOTW/An54yWrX6KWA186BlE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=SfyhUsl537WdZNrN+4PDjfnrUZ4I+3idR6u7QK0WrMmHcTSEXhtmNg76x6d2s1XQn/d/2PL0M5q3IPrV7ILrblnYnI9r9o8wZ9vFKNPJyjjMIU02afwt6ArG6OFsAi4ZjTti4DUmPfCSF08lfkza4400EMuy5aCkNNCtMxOdJbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Vfj1Mg1J; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b884a84e622so603047966b.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 23:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771833052; x=1772437852; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERYQol69KzvMZw4jEOTjkJFG/z3wRah/VmniZQD/41w=;
        b=Vfj1Mg1Jtj3zNWPsyWcoDtm2oFvl+48/lxpC6XCUaeYoAjjLFjglwV1CPlX00jL+is
         mFquk3O73OI9NlWw+W/CJ6zEQzJdDF5UNdrzdWYrwnW7fuQDLVVGB9Mylg6FpeGJqbMa
         3OWyVeEfJtysaGOQw9ntC8EbUfOG3IjMe4apFhDi2YGDzzVs4yj0KVIpqzoxnA93OLu0
         lSqnCwHaP+weWaEfwXd4e6MiNGK4Y1ol0bwZXgJu81QfA55aIBC9zUD2yw2V1n83v1Id
         Q/OSayAy7fj3isTKCXbikkwT0y1s81U2QT5ObyWyk2QXg4UcHxVlZbamdRUI3aSER76x
         E1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771833052; x=1772437852;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERYQol69KzvMZw4jEOTjkJFG/z3wRah/VmniZQD/41w=;
        b=wL6y87INqhwEnIdKxl58FGBl14qc0QAtm0yMMNYkkkHAhYIgxOVBp80W9r6ecXhmyz
         wx+EE9lyw2UkUt/oZz2BMHmNpFe/lHm8P+j63GviTkhUlhNTYGJ9ECmDGKoIWDua/MaF
         lN8lBk8k2p0FA6b/2kV0/AVyn0/Qc5GGN2qh45a9NQ26arEstftQlHL7cM2cNVzCtM5k
         3r6+ecFiPPt/7l09/rlINngPR/2puPn7q6mc44cQ2uOvVDnpBDKabIoSJJU8q1HWYld/
         JR+zpkjoQCJ2Fw/v1IJ21ayopV0hNFGeJFPQJuYPUxgxZtpt62HJiPgNCueMsJlrVBse
         Sgsw==
X-Forwarded-Encrypted: i=1; AJvYcCUozyn6HK7VqswCQWWM3mWpIi0xoi6d8gCwvi/G++wnjx3AH1J0BZ5nac6pDl+fGVZOr8jcIx9k2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwFTuvLHwOfYSf2bmPsX2ZfMVJeG3lm4x+lioUa07S0h2Jd/8
	7UYMl/nSVmD9IA8nb/DLuojiTZiksBQxj1xuxh2NaWtmUk4ED99i6MWoRlNmAtw/XUA=
X-Gm-Gg: AZuq6aI+em6bYN+sZRvYFweN+NL/JAuAJcObn15pyijzK2oMzsU/cKW3hrWhNih72nd
	aDOmvuBSf82osW/sMD8GWsJ+hBPFQ+3nTIyGmCDu9qBECiknjZpmI+pla7zri9+XUfBiexvp9Ox
	H/whb2SqE1t8sn641DjLWN9A8hTMCOE5z0hOCRmLuWYRgDPNn84fl783pxDv48JsUyBPx3oLI64
	/o33iR1N6+kw1RkZCtXPBSK0AtqJAhc29bcq8v2erTRXU2yS1uT+rsjO2cUg4w5BT1BdywLjfUY
	O170rKWCOh5AuV3FeoKpin0RipfnwPLfrAkYTeEwDMyVhCaIrcERprdJ8PZfwkD7lUZ8lrPKaaU
	o/Nv4NphTSSyBMgIOLj3ttF8ziTv55KvEGp+4o9oAGeqI8MrkNQ/F3mDcy/yjF1sdpPhl2YmaeA
	EawUy9xkiptjb1igjJoSDch1t0YH6QuqZjS3x4E5TGE8drSFWeRF20zpYEJsQG95jTw1BrlPcOv
	yvIYZ4=
X-Received: by 2002:a17:906:9fd2:b0:b90:3436:9f71 with SMTP id a640c23a62f3a-b9081bbf557mr536112366b.47.1771833051868;
        Sun, 22 Feb 2026 23:50:51 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084e8d0d9sm297348066b.50.2026.02.22.23.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 23:50:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 08:50:50 +0100
Message-Id: <DGM6EAN8EJU0.2JLEY3CA0R5G9@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
Cc: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Daniel
 Lezcano" <daniel.lezcano@linaro.org>, "Zhang Rui" <rui.zhang@intel.com>,
 "Lukasz Luba" <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Laxman Dewangan" <ldewangan@nvidia.com>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Hans de Goede" <hansg@kernel.org>, "Jens Reidel"
 <adrian@mainlining.org>, "Casey Connolly" <casey.connolly@linaro.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sm7225-fairphone-fp4: Add
 battery temperature node
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-5-fe34ed4ea851@fairphone.com>
 <85ce1f2c-f5cf-4e97-9611-4aed03f69cd7@oss.qualcomm.com>
 <DGJQ4WLIML3H.GAO7T4L3MCJM@fairphone.com>
 <a422e087-a91c-4bb2-9d95-e1cefc9a91bf@oss.qualcomm.com>
 <DGJR40B5R6MB.1V4ZK5SW1PXAV@fairphone.com>
 <yikwygc5gasmr3cdyv5emfr2flaoraxcz7ap3j55wn4ib6wfqx@4yxoly5zrucx>
In-Reply-To: <yikwygc5gasmr3cdyv5emfr2flaoraxcz7ap3j55wn4ib6wfqx@4yxoly5zrucx>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43004-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[fairphone.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BE55172D2B
X-Rspamd-Action: no action

On Sat Feb 21, 2026 at 3:49 AM CET, Dmitry Baryshkov wrote:
> On Fri, Feb 20, 2026 at 12:26:48PM +0100, Luca Weiss wrote:
>> On Fri Feb 20, 2026 at 11:51 AM CET, Konrad Dybcio wrote:
>> > On 2/20/26 11:40 AM, Luca Weiss wrote:
>> >> On Fri Feb 20, 2026 at 11:00 AM CET, Konrad Dybcio wrote:
>> >>> On 2/20/26 10:19 AM, Luca Weiss wrote:
>> >>>> Add a generic-adc-thermal node to convert the voltage read by the
>> >>>> battery temperature ADC into degree Celsius using the provided look=
up
>> >>>> table.
>> >>>>
>> >>>> This will later be used as input for the fuel gauge node (QGauge on=
 the
>> >>>> PM7250B).
>> >>>>
>> >>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> >>>> ---
>> >>>>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 83 +++++++++++=
++++++++++++
>> >>>>  1 file changed, 83 insertions(+)
>> >>>>
>> >>>> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/ar=
ch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> >>>> index b697051a0aaa..7857003099a6 100644
>> >>>> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> >>>> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> >>>> @@ -108,6 +108,89 @@ rear_cam_sensor: thermal-sensor-rear-cam {
>> >>>>  		io-channel-names =3D "sensor-channel";
>> >>>>  	};
>> >>>> =20
>> >>>> +	bat_therm_sensor: thermal-sensor-bat-therm {
>> >>>
>> >>> nit: this should be a little higher
>> >>=20
>> >> meh, it's surprisingly easy to miss this sorting stuff. Will fix in v=
3.
>> >>=20
>> >>>
>> >>>> +		compatible =3D "generic-adc-thermal";
>> >>>> +		#thermal-sensor-cells =3D <0>;
>> >>>> +		#io-channel-cells =3D <0>;
>> >>>> +		io-channels =3D <&pm7250b_adc ADC5_BAT_THERM_30K_PU>;
>> >>>> +		io-channel-names =3D "sensor-channel";
>> >>>> +		/*
>> >>>> +		 * Voltage to temperature table for 10k=CE=A9 (B=3D3435K) NTC wi=
th a
>> >>>> +		 * 1.875V reference and 30k=CE=A9 pull-up.
>> >>>> +		 */
>> >>>
>> >>> I think this looks good. Is this data going to be correct for all/mo=
st
>> >>> devices (i.e. is there a single battery sku)?
>> >>=20
>> >> Yes, from my info there's just a single battery SKU, so that makes it
>> >> easy here.
>> >>=20
>> >> For Fairphone 3 there's two battery SKUs:
>> >>=20
>> >> * (Fuji) F3AC with NTC 100kOhm B=3D4100, ID resistor 10kOhm
>> >> * (Kayo) F3AC1 with NTC 100kOhm B=3D4050, ID resistor 49.9kOhm
>> >>=20
>> >> In reality, one can probably ignore the difference between the LUT fo=
r
>> >> either B value since it only differs by a marginal amount, but
>> >> conceptually I'm not sure how this should really be resolved.
>> >>=20
>> >> We could have both battery definitions in the dtb, and then the charg=
ing
>> >> driver could determine the battery that's actually present in the
>> >> system (based on the BATT_ID measurement), but given the design here
>> >> now, I'm not sure how this temperature lookup table would be propagat=
ed
>> >> to the rest of the system...
>> >
>> > The path of least resistance (pun intended) would probably be to make
>> > generic-adc-thermal consume an ID channel and accept a number of LUTs.=
.
>>=20
>> Not the worst idea ;)
>>=20
>> >
>> > That sounds sensible since most battery ID mechanisms are probably als=
o
>> > ADC-based and one would hope (tm) that the values output by these ADC =
channels
>> > would then be distinct enough for the driver to have an easy time conf=
idently
>> > selecting one of the options (or a fallback)
>>=20
>> Charger / fuel guage and everything else battery-related would also need
>> to get the correct battery properties for the actual one present, not
>> just this generic-adc-thermal driver.
>>=20
>> But I feel like soon DT maintainers will say that Linux shouldn't
>> dynamically detect hardware that's present and the DT should be the
>> absolute source of truth. That works fine in simple cases, but in case
>> of interchangeable batteries, display panels, camera sensors, this won't
>> work. *Something* needs to determine what's actually there.
>
> How is it handled for the Android boots? I assume there are (at least)
> two DTBOs and the correct one is being selected somehow (via the msm-id
> / board-id?). Or does ABL pass some kind of battery identifier to the
> kernel?

On downstream the Linux driver will do the selection, there you have two
batterydata nodes in the dtb with each their qcom,batt-id-kohm property
and the driver will choose the correct one at runtime.

Similar with multiple display panels, but I think there usually the
'detection' happens via what's passed on cmdline from the bootloader.
But not with two dtbs, the driver is selecting the correct panel from
one dtb.

For cameras, the camera stack is 95% in user space, so it's not quite
comparable but also there usually I think there it's trying probe camera
#1, if it fails try probing camera #2.

Regards
Luca

>
>>=20
>> And for most of the ways to detect which of those are present in the
>> device that is booting, you need half a kernel to power up the various
>> hardware and do some basic communication to figure out what's there. Of
>> course you could say that's U-Boot's job for example but not sure you
>> want to add a CCI (I2C), ADC driver and much more...


