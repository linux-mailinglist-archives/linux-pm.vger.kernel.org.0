Return-Path: <linux-pm+bounces-42928-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ8JMEA6mGmFDQMAu9opvQ
	(envelope-from <linux-pm+bounces-42928-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:41:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BA7166E7C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 313203027DA0
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 10:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA2D33E377;
	Fri, 20 Feb 2026 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Cx5MsgJk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58C33DEE9
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584061; cv=none; b=ORDSsfEL8/DImFUalEOzBhATWYvfn2m17JxdZMOpiUI54jO7iWVlde1pnz1sA67WEdYjgsxHFPkWCL6GoCM7XF3FQO3ogGiUuhs7J4EwPW5FRgVmKmtVezOR716IIwttbe00Llxpp5c4k1q/myp/dH+s8bbNoiN6ZF/GTc9ffoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584061; c=relaxed/simple;
	bh=lCfjiFCpKJoa+6uB16bTXpWJQyvUj3mvFlbxKEOoSYE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Tp1ZyTXSw/i1YgeObuhzIiSWRkEVXBjKkD+NkF1ANMe83zS9BmSFuU/ecF5LLNNhAgOK3C90h96gZFMLP8hWH/Qz2jCeLpTODZ8YEpvMtvWBEWdg2kBuQ4Vhjf2Z/kRUQolVHXkYg1jUv2fASvF7SPQ2e8+ffmgoO15HV+dCS7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Cx5MsgJk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8850aa5b56so354228466b.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 02:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771584058; x=1772188858; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4tgaqGFqrzVKKPOb+iFZ3JERZen8Ej1v/LIDxYhK+0=;
        b=Cx5MsgJkG9oj7APqKUjH43BrcK93sBkvrR9uvqcW3+WgQxYIby7Z70/GQmH/9sMPTB
         iTFvlnLZUsfREVfIT8h9JEn6ageY55GZFmOSxcGM5gQVDgvZ34b36TuowJfG9vX9O5Th
         EW9fx1ICNQfmxW94+axh4GugWhJTNY3YcAKmjfRfsokim005XjhelAP3uBdEAD0eGpRo
         AEAyVVAQW3/TrSGMrt0zQRSkVRrqLeHWs2+XtTHmgUoG3bKEEJi1X1En0Lo3mZenj6lZ
         XxUABx770Ns1ng8jGfWFnHL0O/Gyan1LIgouu1BMaBxikef9eopFUuQysP3OwuWzM7Bb
         yxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584058; x=1772188858;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o4tgaqGFqrzVKKPOb+iFZ3JERZen8Ej1v/LIDxYhK+0=;
        b=oVavs0lU/akukhR5Psswy6OaKpDq4bN/F+ILJMTK8j+Bm/4j0eUfRNhnI55SMDLnoU
         cUYdgjFzHPnIjG4F9lYo6ahF8m+A63I1bApyYnlJgMjmNT4a7KVI9fnA3ox7jHwsoTtL
         TeDBzdHGQmOubOwDNMUwN5lJQVJcB9DIrJnkwTPaPhSaCVtyTz37zo808vuMVAYk+lnf
         T4xvvuyhr8aeTotoWOOI9cj0wRna1i4chmBUiwLzFrjEZP7I2H48HnftlPrxa6NqW3ei
         FcNZcTJPDNjvVWssQOOMaTqE/PM11etxGOf1jQx4fpB416wBEZJEb/ImxXklyFFqtP8d
         xMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQQBFQKxShrskC2qwW5M7X2BFuCpMFh99g6+Qx3bCk1tj6J1HasqSDkjZJ3YptQB0MKEJGoMjLYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOYhtc70v1bdeGx2+g+SO83e4j4nyxsyMpqsoSmUEqTq+Pl+sA
	dqBK59uH5R9KgVln6c8q7rDADOVnQpIw/G3BgL/DGRq7YzNPg561d/8DgyTlmlcn7ik=
X-Gm-Gg: AZuq6aJJMtK2O4wuEOY8R9/3140nyARtYypyFLvP1A0PWfl6CdqGLVL1GLoX4p6gmoZ
	nZtGqwd7g2PTyYLTctuATMTODkhBCyzkUfXIk6Oukp6vws+J32pK/Q4nBBQS/iDDo/pQK3OpW1r
	rd5hkijXkMLoUFnvVAM69GLUgCShymBO6ELpmLgZUtLq0Gdug5xFO8Fh4Yb8jBlNrldKmVsbBte
	9xNLfVt0roaHWmllGlCExgcHT6ZIfcbn8BtBxufelhVthdECsAqE4/ozn9tPh9ajqCl6by5AjW+
	DIngk6K4AHefc5B2uytJFJeAjqTSYVHYil/q7DY96e2g3FAin2O7T/z0bFqX/s+XehVhPMob4ap
	BPguSDZyUsClDEEQC9ZIErXAvHiFvLnwQNBPx5hg/VDRgMtvqBEGhkc2oLHe+DT/MyQZ/t5wvy/
	06QPxOoW9Icmy0GsxiehZ/5cVTKDc/1VQ6Iryrr3yp5e7FZF2z+yV6UhcilCLlByeQ9eSH
X-Received: by 2002:a17:907:98d:b0:b90:3436:9f71 with SMTP id a640c23a62f3a-b90731fef13mr72589166b.47.1771584058260;
        Fri, 20 Feb 2026 02:40:58 -0800 (PST)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7385e60sm661232566b.19.2026.02.20.02.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 02:40:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 11:40:57 +0100
Message-Id: <DGJQ4WLIML3H.GAO7T4L3MCJM@fairphone.com>
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
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-5-fe34ed4ea851@fairphone.com>
 <85ce1f2c-f5cf-4e97-9611-4aed03f69cd7@oss.qualcomm.com>
In-Reply-To: <85ce1f2c-f5cf-4e97-9611-4aed03f69cd7@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42928-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[fairphone.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fairphone.com:mid,fairphone.com:dkim,fairphone.com:email]
X-Rspamd-Queue-Id: 36BA7166E7C
X-Rspamd-Action: no action

On Fri Feb 20, 2026 at 11:00 AM CET, Konrad Dybcio wrote:
> On 2/20/26 10:19 AM, Luca Weiss wrote:
>> Add a generic-adc-thermal node to convert the voltage read by the
>> battery temperature ADC into degree Celsius using the provided lookup
>> table.
>>=20
>> This will later be used as input for the fuel gauge node (QGauge on the
>> PM7250B).
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 83 ++++++++++++++++=
+++++++
>>  1 file changed, 83 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/ar=
m64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> index b697051a0aaa..7857003099a6 100644
>> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>> @@ -108,6 +108,89 @@ rear_cam_sensor: thermal-sensor-rear-cam {
>>  		io-channel-names =3D "sensor-channel";
>>  	};
>> =20
>> +	bat_therm_sensor: thermal-sensor-bat-therm {
>
> nit: this should be a little higher

meh, it's surprisingly easy to miss this sorting stuff. Will fix in v3.

>
>> +		compatible =3D "generic-adc-thermal";
>> +		#thermal-sensor-cells =3D <0>;
>> +		#io-channel-cells =3D <0>;
>> +		io-channels =3D <&pm7250b_adc ADC5_BAT_THERM_30K_PU>;
>> +		io-channel-names =3D "sensor-channel";
>> +		/*
>> +		 * Voltage to temperature table for 10k=CE=A9 (B=3D3435K) NTC with a
>> +		 * 1.875V reference and 30k=CE=A9 pull-up.
>> +		 */
>
> I think this looks good. Is this data going to be correct for all/most
> devices (i.e. is there a single battery sku)?

Yes, from my info there's just a single battery SKU, so that makes it
easy here.

For Fairphone 3 there's two battery SKUs:

* (Fuji) F3AC with NTC 100kOhm B=3D4100, ID resistor 10kOhm
* (Kayo) F3AC1 with NTC 100kOhm B=3D4050, ID resistor 49.9kOhm

In reality, one can probably ignore the difference between the LUT for
either B value since it only differs by a marginal amount, but
conceptually I'm not sure how this should really be resolved.

We could have both battery definitions in the dtb, and then the charging
driver could determine the battery that's actually present in the
system (based on the BATT_ID measurement), but given the design here
now, I'm not sure how this temperature lookup table would be propagated
to the rest of the system...

Regards
Luca

