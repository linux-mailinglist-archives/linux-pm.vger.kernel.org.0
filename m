Return-Path: <linux-pm+bounces-43066-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGooBgilnGkYJwQAu9opvQ
	(envelope-from <linux-pm+bounces-43066-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 20:05:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0E117BFD6
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 20:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70A633062FB9
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D634A36A01A;
	Mon, 23 Feb 2026 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IuqL9frT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GNH3VALr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D736A002
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873510; cv=none; b=qOl454uRcOEx0LazIssuMAW0ZZBEsk5Kw6UXtl4PppZ4kVoHs+b0zHqPf3hUqtvJkee/kdA6cIZbyvTpjKgkJ1SQpoDsOZCZ4FTJ/t6PHf3ChyNwLOmE5PgbSpeYm/AHOkrN4vUFfOEuq0VmbtaCdBaNJk5cM55oVdvpPhYmRsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873510; c=relaxed/simple;
	bh=+c1bZBQs/guNz7fjEph0UAOI1LMhure7eyCMtUj6mL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii/xssBR3R6623aSfdFucFxefroC+CjdasQLX0MST8SmLb/Uv1TvAfeCG+Qsr5m58CgSgDJGgsi+Kpbhb6bvd0DSuy48t/BraFHwQsx3wK7Kh3wJGRL2gdAv+1/MU1+A0o2F7xI9k97mak3oDknDy2Ts0MktOVuaJodysblxOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IuqL9frT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GNH3VALr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NDsV2d185750
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 19:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZzRDmU+V1N4Y2c/BrLaePKh3e2DWyeiVEC2s5+FnDg0=; b=IuqL9frT3eYrhIIB
	NuxvfBGQwC26oEc6lOpSKdaTr3dKtYr9sLzCX+vvkDYAu28/klWz5qjEI8bztiSK
	l3rDltBto6ORydt1gp38//DIVORhGYpBDWPm9+8CXU9r3GLw6jDSLLGQVtFD0qHa
	yIzhV8TchJGZW4YIMFEMgGDh80hv9H/x8jw4UuTGuWJ4SM6clqRNT26VyH+vJ8fV
	SJQOT8kv3K1vKqi0h3JR7KDxVrcEMNIZkQTPfUGxaOUSkpfY/Exi2dJ8ZDDAD/N1
	anHlcbk2wVz3+1tDU0yct5fW8mrLlxziJiFhO8SENs4EhfD/Kf4o5PFMbQ1CSxZe
	dM16ZA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgr69h0qe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 19:05:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c70ef98116so4968005285a.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 11:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771873507; x=1772478307; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZzRDmU+V1N4Y2c/BrLaePKh3e2DWyeiVEC2s5+FnDg0=;
        b=GNH3VALrJrhrVRHyfEFG6+M2vg2JhkSDXb4J1CzKsnOkrymwUzpx2feX7dlOEu4TcT
         B5sBQ9yPcNmVEwmFMTMn+FSTq9jm/HMItsewTTFX400/mphde//tM5VgXf78ZrISR6fZ
         qVmVNxzQvgBLUtiZW23cI8X0ntyVr1i69Gr58A5FQL+exq9BvvZWWUTyrLT604ma7/sJ
         NUnwBa0jBgtk5gK4b/VnR6XDc7lYsVgBzLpXDPOKvGSGYfmxJroFEHu4wxa4+BDUHI8j
         zUuJ5kmhlKESBoxLPi3CuYU9li07PEyWwJfzxre+Qst+h0p/0xrKhs6gqvdW8cKXi6zP
         Ghdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873507; x=1772478307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzRDmU+V1N4Y2c/BrLaePKh3e2DWyeiVEC2s5+FnDg0=;
        b=Qky+zqAlEwMttbs3BFqN6s1DlQZjOIrjFBAQyBk3KQpLP7iQMed+UQpPEJh5cC021G
         zQR9f6KzRMHm9L2hBdkaurmlvtq3pvmo44MOMuYqwFFBetw0I4qUY9PuhEe59Qb4XbCo
         B19RVnQUFi/wVbI4lMAp33eFOFfSf5qnmmgGpBP1bSCc7IdMqTgL2GwF0fz4T3GR/ZWw
         wFyFxO7uRuGoK4DOY8bHhELzFWNrheKldN9yzI3RYrCyQm+yHRaLJU+YESaxuA5M313K
         xGjiNXnioL54BRWFOu5J5uQk8/HomwK7cJTIeajjdmAKFHfSSaoYoZKaQyNykX7Jzupa
         JYMA==
X-Forwarded-Encrypted: i=1; AJvYcCU4FUa9KY/yVcs80YjOgr+m2bXq2eKVEhYDR/IAifQsTjIM9fhyHc5epTL/Gjaq+V1Yar75hJm6+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHnNlnsYxiyWIQXFgPkJxgJP4pgipiKPgfkcbIrw3OP0bB8vzO
	nuIMsNxo+PQ2K0Sl2jN/NUjWMCRaGqyYqiCDL28Qp1MTtzbcQJyK3v6lFg8KLL1dONcKXhZJRMR
	B49oFfMptYR12DViJymxOhtzyIY5nYn+d14DXgAzF6XY1jjr+uEKET+DF0UFY1g==
X-Gm-Gg: AZuq6aJwR1y3HJLD9CECaKVDAz44iTNMRues460BiPgKdBJb7fHyLjpAU3pBDMyaKbU
	FbPzL2fn5U1sAevMfT1jKgqR/5j3gtPmQtfvFULrzUHqXR6OVDk2j9qshnmtChpyw2mc06SWv3P
	+v+LvbBlQubLo42ak5B8BXKAfYJ30VlwBr9A6qMSpZtbzEzgrcnAlCILiHIGuX+ebOqx7rvnGbk
	9qiY5cGRiaChHREicbmI9DjIYTZ/gy+cflCP22P+yv5khLw0yAfbD1vhO63qMQjekJZ9DChdXEv
	nqH8pDj3KcWdZ40WE0/P/UWx1iZ2G2Tsj/2u1GAhs4C0DiUqjkH4fSKcRJHhoU5qk/X+2bvB0f1
	w355AQrzvHfbGSCfPCj2SlahD04y7JeToWTLjHVmu14BI1QjCgy1r6y8WzTza7xWyzXItecsfG8
	9oSnNswfRtvf1NGGQM8d3qVXW3mwwqvqR0kDI=
X-Received: by 2002:a05:620a:1aa9:b0:8b2:d56a:f2f1 with SMTP id af79cd13be357-8cb8c9e6647mr1251512985a.12.1771873507006;
        Mon, 23 Feb 2026 11:05:07 -0800 (PST)
X-Received: by 2002:a05:620a:1aa9:b0:8b2:d56a:f2f1 with SMTP id af79cd13be357-8cb8c9e6647mr1251505785a.12.1771873506405;
        Mon, 23 Feb 2026 11:05:06 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a7a207a1sm16902281fa.21.2026.02.23.11.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:05:05 -0800 (PST)
Date: Mon, 23 Feb 2026 21:05:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Hans de Goede <hansg@kernel.org>, Jens Reidel <adrian@mainlining.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sm7225-fairphone-fp4: Add
 battery temperature node
Message-ID: <uivc6k5luetg6dfih5bmkkywdtxkg3jxk7zpem53jwcaetfb7l@i7v37nvm2tku>
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-5-fe34ed4ea851@fairphone.com>
 <85ce1f2c-f5cf-4e97-9611-4aed03f69cd7@oss.qualcomm.com>
 <DGJQ4WLIML3H.GAO7T4L3MCJM@fairphone.com>
 <a422e087-a91c-4bb2-9d95-e1cefc9a91bf@oss.qualcomm.com>
 <DGJR40B5R6MB.1V4ZK5SW1PXAV@fairphone.com>
 <yikwygc5gasmr3cdyv5emfr2flaoraxcz7ap3j55wn4ib6wfqx@4yxoly5zrucx>
 <DGM6EAN8EJU0.2JLEY3CA0R5G9@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DGM6EAN8EJU0.2JLEY3CA0R5G9@fairphone.com>
X-Authority-Analysis: v=2.4 cv=O6A0fR9W c=1 sm=1 tr=0 ts=699ca4e4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=6H0WHjuAAAAA:8
 a=gvbEHs2N2TqGYGsSA-IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: KccErrtb9ckJYlejiffK1sd03WRPkKCk
X-Proofpoint-GUID: KccErrtb9ckJYlejiffK1sd03WRPkKCk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2NSBTYWx0ZWRfX3+efdQUa92fH
 PiUXDQ5BPlgs+3PV9yjeIe5VzPCn0yRXPvvuYuF97zy4iXYrGjtiNUTEy7LN/xhODU4PxOyYCYJ
 yUEjtH2yFFHZN+SblOffH3TCcCHJx9xexCIlBfiwWtbLoDtU1wqQO7kgYS0tTNt8GMPSbCxug8c
 gQ9ynZRYX42+z3v1dY/rt09N1c5qeQaoRxWm/6ataxAPmJ0N+1YD0WFuM1MD08FZOc7yPE8cs2Y
 2yyC8CaKy3zUhuSJbjiYjaWlaY+u9PQs+UesbdttXwIHhnnLSdReXUN1lhqy9iWj3xj8KDvQlJv
 Y/NMnVlulUXyoi0hOf5q2o4TqoNAXrhs0twZu8trVm2FU0cAyx0BBl7ABJ1ZyGMbSkobd52QaT2
 dE6wD7TUM5T2JKNXEF+1MyoaK2TkRpnkDt9doES/D75VJNYZWdcWxw8qMudaLvnCyFbCUGrzpOO
 5JA6EomEjtoyp/iWY1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43066-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,fairphone.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5F0E117BFD6
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 08:50:50AM +0100, Luca Weiss wrote:
> On Sat Feb 21, 2026 at 3:49 AM CET, Dmitry Baryshkov wrote:
> > On Fri, Feb 20, 2026 at 12:26:48PM +0100, Luca Weiss wrote:
> >> On Fri Feb 20, 2026 at 11:51 AM CET, Konrad Dybcio wrote:
> >> > On 2/20/26 11:40 AM, Luca Weiss wrote:
> >> >> On Fri Feb 20, 2026 at 11:00 AM CET, Konrad Dybcio wrote:
> >> >>> On 2/20/26 10:19 AM, Luca Weiss wrote:
> >> >>>> Add a generic-adc-thermal node to convert the voltage read by the
> >> >>>> battery temperature ADC into degree Celsius using the provided lookup
> >> >>>> table.
> >> >>>>
> >> >>>> This will later be used as input for the fuel gauge node (QGauge on the
> >> >>>> PM7250B).
> >> >>>>
> >> >>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >> >>>> ---
> >> >>>>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 83 +++++++++++++++++++++++
> >> >>>>  1 file changed, 83 insertions(+)
> >> >>>>
> >> >>>> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> >> >>>> index b697051a0aaa..7857003099a6 100644
> >> >>>> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> >> >>>> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> >> >>>> @@ -108,6 +108,89 @@ rear_cam_sensor: thermal-sensor-rear-cam {
> >> >>>>  		io-channel-names = "sensor-channel";
> >> >>>>  	};
> >> >>>>  
> >> >>>> +	bat_therm_sensor: thermal-sensor-bat-therm {
> >> >>>
> >> >>> nit: this should be a little higher
> >> >> 
> >> >> meh, it's surprisingly easy to miss this sorting stuff. Will fix in v3.
> >> >> 
> >> >>>
> >> >>>> +		compatible = "generic-adc-thermal";
> >> >>>> +		#thermal-sensor-cells = <0>;
> >> >>>> +		#io-channel-cells = <0>;
> >> >>>> +		io-channels = <&pm7250b_adc ADC5_BAT_THERM_30K_PU>;
> >> >>>> +		io-channel-names = "sensor-channel";
> >> >>>> +		/*
> >> >>>> +		 * Voltage to temperature table for 10kΩ (B=3435K) NTC with a
> >> >>>> +		 * 1.875V reference and 30kΩ pull-up.
> >> >>>> +		 */
> >> >>>
> >> >>> I think this looks good. Is this data going to be correct for all/most
> >> >>> devices (i.e. is there a single battery sku)?
> >> >> 
> >> >> Yes, from my info there's just a single battery SKU, so that makes it
> >> >> easy here.
> >> >> 
> >> >> For Fairphone 3 there's two battery SKUs:
> >> >> 
> >> >> * (Fuji) F3AC with NTC 100kOhm B=4100, ID resistor 10kOhm
> >> >> * (Kayo) F3AC1 with NTC 100kOhm B=4050, ID resistor 49.9kOhm
> >> >> 
> >> >> In reality, one can probably ignore the difference between the LUT for
> >> >> either B value since it only differs by a marginal amount, but
> >> >> conceptually I'm not sure how this should really be resolved.
> >> >> 
> >> >> We could have both battery definitions in the dtb, and then the charging
> >> >> driver could determine the battery that's actually present in the
> >> >> system (based on the BATT_ID measurement), but given the design here
> >> >> now, I'm not sure how this temperature lookup table would be propagated
> >> >> to the rest of the system...
> >> >
> >> > The path of least resistance (pun intended) would probably be to make
> >> > generic-adc-thermal consume an ID channel and accept a number of LUTs..
> >> 
> >> Not the worst idea ;)
> >> 
> >> >
> >> > That sounds sensible since most battery ID mechanisms are probably also
> >> > ADC-based and one would hope (tm) that the values output by these ADC channels
> >> > would then be distinct enough for the driver to have an easy time confidently
> >> > selecting one of the options (or a fallback)
> >> 
> >> Charger / fuel guage and everything else battery-related would also need
> >> to get the correct battery properties for the actual one present, not
> >> just this generic-adc-thermal driver.
> >> 
> >> But I feel like soon DT maintainers will say that Linux shouldn't
> >> dynamically detect hardware that's present and the DT should be the
> >> absolute source of truth. That works fine in simple cases, but in case
> >> of interchangeable batteries, display panels, camera sensors, this won't
> >> work. *Something* needs to determine what's actually there.
> >
> > How is it handled for the Android boots? I assume there are (at least)
> > two DTBOs and the correct one is being selected somehow (via the msm-id
> > / board-id?). Or does ABL pass some kind of battery identifier to the
> > kernel?
> 
> On downstream the Linux driver will do the selection, there you have two
> batterydata nodes in the dtb with each their qcom,batt-id-kohm property
> and the driver will choose the correct one at runtime.
> 
> Similar with multiple display panels, but I think there usually the
> 'detection' happens via what's passed on cmdline from the bootloader.
> But not with two dtbs, the driver is selecting the correct panel from
> one dtb.

I remembered that all panels are a part of a single DTB, I didn't
remember about the batteries. If there is a bootparam, in theory we can
use it to identify the battery. Or we can find how it is being
identified in the first place and use the same logic in the kernel /
userspace.

> 
> For cameras, the camera stack is 95% in user space, so it's not quite
> comparable but also there usually I think there it's trying probe camera
> #1, if it fails try probing camera #2.
> 
> Regards
> Luca
> 
> >
> >> 
> >> And for most of the ways to detect which of those are present in the
> >> device that is booting, you need half a kernel to power up the various
> >> hardware and do some basic communication to figure out what's there. Of
> >> course you could say that's U-Boot's job for example but not sure you
> >> want to add a CCI (I2C), ADC driver and much more...
> 

-- 
With best wishes
Dmitry

