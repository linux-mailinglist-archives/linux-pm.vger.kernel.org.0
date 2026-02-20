Return-Path: <linux-pm+bounces-42934-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LYgFNwBFmGmMEwMAu9opvQ
	(envelope-from <linux-pm+bounces-42934-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 12:26:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34755167477
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 12:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D7143013797
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ADF330647;
	Fri, 20 Feb 2026 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="WlDvS1KO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5473D33031F
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586812; cv=none; b=bEuMBni5nA4sFHGtE7iaqm4r3qSap4UV5CxaOv4j+0TdLSK/5J98jLL+ylENoPlwzxHOY6Zu74FNMn3SneRXpnOqJHXosCp40MedCa4/AhNnm8EcmoVsGE/fgMJ8p8XpxtQYn/UMrKpI/JVMUDaW4DeKWYZWavyDESQlLqmoTLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586812; c=relaxed/simple;
	bh=m91/Pj6i562vC9RgSAKF0lAmXFt7YMj8wOrD5dUjLts=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dpcv4x+rU1k4TToleAy5n574zsbXnbdVytei9WDr/IRRtqZtqXHT56sP6aLBVQEpa/mtvSJrkVRX21LQopUMtwLrWWm/Y5pV5h73DaLT5cnqPnk14jhiWNwnPaozmRiWJcF7kfh8iFh7fKynHaEjlmCJr0fDQ8n6ocRG6i75I5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=WlDvS1KO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65c5a778923so2822364a12.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 03:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771586809; x=1772191609; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83zz9Fx5gsW9BIv6c8ksqWZjM7IcWR5idqwhbUOB91Y=;
        b=WlDvS1KOyibyFVCCqJYzkavPTQYwMCrJrR1gCfkhpkNF23AFSKSY+Up0Iv6MUlmgxE
         PXDuz1A/97WtcAr0YtYUGl7rJ68Bh/eE6CONVuBcbcodcwMl5QgtPKDX6VNHyDzCpc8u
         H0dkeiQYKV24KqYmXnT/GjGoGJKHYR/a+a6k9xkGUjFaZq+sB99hUzVrr5ot7LbV/s1L
         vVXJF3vftRivB5EREc9uShQmwh35W8/9GtfzeRuISyBK/3U3D/wZpWRDstRzvYY2PVxs
         hKVSH4Q5Tz605zqKfqa5PSxa4Oi/KgW4IFVmuEPejgHiNP1bbBvnI4Ozo7FsnIsjpQZq
         fO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771586809; x=1772191609;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83zz9Fx5gsW9BIv6c8ksqWZjM7IcWR5idqwhbUOB91Y=;
        b=tJ9QHYF9/5Zg7jPcCXWGblo7uA9GX/8Oxc1w71RYQkcdeiHpFLCsWkZyaApyOeTj1Z
         3Hgnk4UJ0JCQPZiSxzbtOWnsIvewXsjtfj4FO51h9fOaXSFlQosJNZdDXk+eVPaTHKUT
         NrNLju7gAamLBbqj0PfEkDBH4/4d8Gxpx1qqjRmYP8rvERcVJGEFWwEi7+XtSXFDFClE
         H664qKzQeaJX264nVdY7XvV5FnNX0+J4WxG07TgeIRkszND3lZDygzY9RxJRR5MMv4ep
         UW6UECM4G0fR78EjL/6qNfHU0SeZMpngNcZ1qNfxJgcsOAJBz32gobdUbYrDFy2GKvK2
         ZH7g==
X-Forwarded-Encrypted: i=1; AJvYcCVOhIuzsNogMG1tarX9gekk2c7kyRKDF18+JKEzz3+gIr5W3dqcihkbCMrud7fCaHtF93yRqIHVWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKb7FFomgXw26+3ejZ8M3uST2U/i+MEv2Jk3aeubyyjqUBxskI
	8oVF9R9taHSp7QxMHZYWzoDaVvxl2ql+Mh6qP9AF6j6y7OSsqhDuUn2MqkXPRp7AvYQ=
X-Gm-Gg: AZuq6aKlFLY87OVhOmn5cuAQgq3MBdWaFcEdhZ4HQE3EXC/O5TNt14Ma8bg4whTPOyo
	7twHUbo+ZoNQczyOxVAMWErJ1BFm9j2S6eousAyrv0rM2PSh53BfUcMCNn1NHZDFREYY24mEGQx
	o6yXC4EvD2Wy24HpP7X5egwnq8rbfrsUxbU2frCoXZc8N4nVUeR+BMKuuarBAbT29vuMa1aQOai
	GXiVIOqclkWZKNxQZA8qyo0nBFiMYXTs6SQMpaQ/pHXwdgLO3ffHxBDLbAm2nO6NKRzQnliphRL
	+1QmgFunDSUgKY3kTcYNIlDTGS+CeiCdOjkWj6OyWRD+ylwaEfse5hVuFe53HESYdWrOq4ENmXK
	wybjfV2ug4ys85pnznqN3oW+WXUUNt4AH8vaVHI2d9k/lNKDXokJjx3a9jqeQsFHvxaboBuFRWS
	kkLqLU7qKCWZ8R/+uGYW/an4E3ttWHwG3DLhMPVvVwTNyH070kRH9BHwqisoELfrXpQ8O2J2n8l
	fR6Gfs=
X-Received: by 2002:a05:6402:5186:b0:659:454b:7167 with SMTP id 4fb4d7f45d1cf-65bc7a751a0mr10415695a12.23.1771586809215;
        Fri, 20 Feb 2026 03:26:49 -0800 (PST)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad29d295sm4987701a12.8.2026.02.20.03.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 03:26:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 12:26:48 +0100
Message-Id: <DGJR40B5R6MB.1V4ZK5SW1PXAV@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sm7225-fairphone-fp4: Add
 battery temperature node
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Jonathan Cameron" <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Laxman
 Dewangan" <ldewangan@nvidia.com>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Hans de Goede"
 <hansg@kernel.org>, "Jens Reidel" <adrian@mainlining.org>, "Casey Connolly"
 <casey.connolly@linaro.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-5-fe34ed4ea851@fairphone.com>
 <85ce1f2c-f5cf-4e97-9611-4aed03f69cd7@oss.qualcomm.com>
 <DGJQ4WLIML3H.GAO7T4L3MCJM@fairphone.com>
 <a422e087-a91c-4bb2-9d95-e1cefc9a91bf@oss.qualcomm.com>
In-Reply-To: <a422e087-a91c-4bb2-9d95-e1cefc9a91bf@oss.qualcomm.com>
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
	RCPT_COUNT_TWELVE(0.00)[26];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42934-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:mid,fairphone.com:dkim,fairphone.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34755167477
X-Rspamd-Action: no action

On Fri Feb 20, 2026 at 11:51 AM CET, Konrad Dybcio wrote:
> On 2/20/26 11:40 AM, Luca Weiss wrote:
>> On Fri Feb 20, 2026 at 11:00 AM CET, Konrad Dybcio wrote:
>>> On 2/20/26 10:19 AM, Luca Weiss wrote:
>>>> Add a generic-adc-thermal node to convert the voltage read by the
>>>> battery temperature ADC into degree Celsius using the provided lookup
>>>> table.
>>>>
>>>> This will later be used as input for the fuel gauge node (QGauge on th=
e
>>>> PM7250B).
>>>>
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 83 ++++++++++++++=
+++++++++
>>>>  1 file changed, 83 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/=
arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>>>> index b697051a0aaa..7857003099a6 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>>>> @@ -108,6 +108,89 @@ rear_cam_sensor: thermal-sensor-rear-cam {
>>>>  		io-channel-names =3D "sensor-channel";
>>>>  	};
>>>> =20
>>>> +	bat_therm_sensor: thermal-sensor-bat-therm {
>>>
>>> nit: this should be a little higher
>>=20
>> meh, it's surprisingly easy to miss this sorting stuff. Will fix in v3.
>>=20
>>>
>>>> +		compatible =3D "generic-adc-thermal";
>>>> +		#thermal-sensor-cells =3D <0>;
>>>> +		#io-channel-cells =3D <0>;
>>>> +		io-channels =3D <&pm7250b_adc ADC5_BAT_THERM_30K_PU>;
>>>> +		io-channel-names =3D "sensor-channel";
>>>> +		/*
>>>> +		 * Voltage to temperature table for 10k=CE=A9 (B=3D3435K) NTC with =
a
>>>> +		 * 1.875V reference and 30k=CE=A9 pull-up.
>>>> +		 */
>>>
>>> I think this looks good. Is this data going to be correct for all/most
>>> devices (i.e. is there a single battery sku)?
>>=20
>> Yes, from my info there's just a single battery SKU, so that makes it
>> easy here.
>>=20
>> For Fairphone 3 there's two battery SKUs:
>>=20
>> * (Fuji) F3AC with NTC 100kOhm B=3D4100, ID resistor 10kOhm
>> * (Kayo) F3AC1 with NTC 100kOhm B=3D4050, ID resistor 49.9kOhm
>>=20
>> In reality, one can probably ignore the difference between the LUT for
>> either B value since it only differs by a marginal amount, but
>> conceptually I'm not sure how this should really be resolved.
>>=20
>> We could have both battery definitions in the dtb, and then the charging
>> driver could determine the battery that's actually present in the
>> system (based on the BATT_ID measurement), but given the design here
>> now, I'm not sure how this temperature lookup table would be propagated
>> to the rest of the system...
>
> The path of least resistance (pun intended) would probably be to make
> generic-adc-thermal consume an ID channel and accept a number of LUTs..

Not the worst idea ;)

>
> That sounds sensible since most battery ID mechanisms are probably also
> ADC-based and one would hope (tm) that the values output by these ADC cha=
nnels
> would then be distinct enough for the driver to have an easy time confide=
ntly
> selecting one of the options (or a fallback)

Charger / fuel guage and everything else battery-related would also need
to get the correct battery properties for the actual one present, not
just this generic-adc-thermal driver.

But I feel like soon DT maintainers will say that Linux shouldn't
dynamically detect hardware that's present and the DT should be the
absolute source of truth. That works fine in simple cases, but in case
of interchangeable batteries, display panels, camera sensors, this won't
work. *Something* needs to determine what's actually there.

And for most of the ways to detect which of those are present in the
device that is booting, you need half a kernel to power up the various
hardware and do some basic communication to figure out what's there. Of
course you could say that's U-Boot's job for example but not sure you
want to add a CCI (I2C), ADC driver and much more...

Regards
Luca

> That said, this is just my guesstimates and perhaps the IIO folks could c=
omment
> on that
>
> Konrad


