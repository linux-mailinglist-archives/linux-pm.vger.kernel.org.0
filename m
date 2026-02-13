Return-Path: <linux-pm+bounces-42621-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIbjJbKpj2mZSQEAu9opvQ
	(envelope-from <linux-pm+bounces-42621-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 23:46:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A08139D87
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 23:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B20930066B7
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 22:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F342D061B;
	Fri, 13 Feb 2026 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VXJBaBWE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GqPgINdd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A15214204
	for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771022766; cv=none; b=o0d3nO3m8Q+XETLUL0FT6vunRxXIXm6kjdJ1yZTGJBq8fdxQt3lmC8WhB0xQa1P9AvddM+2GlpF9n/pumlgLShFnZ+dnrzRFUbyfSk3RGWMnd5flw8AuToBDFWa0XpgsWsIc2+82gE6m9RYkSApwenv47HslAGGe73GfnCeivDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771022766; c=relaxed/simple;
	bh=knJBdqPjVtEV62c0/GHhHaUpxoq6PevP9pwkwQcrQXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/yMbGtenmfWyBK90SAQkYdxICC8DXl/KBr3CPHwHEdwq3uYX/Dl+rAv0pxyWr7AzHyaNHbJ3y/2k4FSXD143sJB7y3J8oYCDXVx0Byuvvp3zMHZoDzIxeIHrc3nLip+oWJH/2m7i1kAcUzzotwZ6BJrNghpPVHzIP5iEz4VjsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VXJBaBWE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GqPgINdd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DEOQLn3272967
	for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 22:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3SsDYUO/omo5M8jNjG2gaAOl
	NQh7/M+BuNJyGGLsXeE=; b=VXJBaBWEJSeBXk2+pKZW/Dyj5r9h7dypGiqmo5iA
	mrISmWKXpPCs/3B4fsYgD8lWfOD3EMNXfIed9ZDL5vTONpT3TBuYkvfyR9PX8M1b
	hz7OGbS4Si/VPQXMTF4rMjDexggRKqjoWti+D4yIdfU75OunRBTrH1KsXzDaAnAE
	LIyNgdg+cLAeo04d7Wl9eJAZGQBCCxkno/u7w94i+5TcBNxjrGmybXwa38Xu4N4b
	gKe1A/ASiHVw/aR2g5Zv5NO61mz7Q9g6O55BiF5hW12ijl2xPBVr+YBRRAGfpDaU
	p0ez7ErsXgDASxeQYGypHxSf42/C4o6fz0+R6MjD62r8Tw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ca5pd9pe0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 22:46:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c7166a4643so520402185a.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 14:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771022762; x=1771627562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3SsDYUO/omo5M8jNjG2gaAOlNQh7/M+BuNJyGGLsXeE=;
        b=GqPgINddxVkAiDmNlsMEaLzg6YGHj2FEkrrpvB5RiBl4hJYjc2v7z5S649BAG60iF9
         oOm/vUETC3aY3NOYCJTRmS938694Ul5Tf/HlUXh8fFbtIB0Oo1SbQF1Sf/MCjIJOjVzE
         Js577xiNeaeDWTPRkdNn3h5dT98wrca9NQKlnFKsUFJSQcy12T0hdrjCJrniu477YguN
         jfRHM/6O5wjUAtLSeYJgxO2KeoeUhyorr4TBgh8MIlD8pRpC3pvCNsTxGw4VafCK6kMn
         o833aJ6zwwr+XQvAXuDnddw+R4W7QGGpFeWF/LZso8ln4mogRkmibiTjwDpFMjsQS+9k
         ipow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771022763; x=1771627563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SsDYUO/omo5M8jNjG2gaAOlNQh7/M+BuNJyGGLsXeE=;
        b=KEY4OIgFs68Cv43dIHEd1Qkilis4XwZbmwmWMmQ3QMeg34Nt+fsZ/F4F4Q+QrqZrpc
         pkWObSEzt/raUfrz4+9Emgej1eVuo+hFU2OwyDpTup35V4hj/48QiJ+QWlhXixiQ3Kes
         PZCQnBTUrXofLXLhJwanGDKO+eiQGGEyegDVm1xjHEixG3nBExPdwf/Nj263YlVIduqw
         bUl/MKn9ZwTKTY913DyPTaS0OKutJwvA4F/UnWObeq9XlzRrwpIlxG/W7jL04nNEARu0
         5Vf/Y4tvwrm5sfxSZ0rzYGwW+J/R00jqPVI5lanNJx7zXx5zQw4M4YxgImG9IZLVKBAo
         6dJg==
X-Forwarded-Encrypted: i=1; AJvYcCXqzJ5/DQkc8h5+ibfySk/LtM82ImJguSKaVLlkEQC3ydodYpgpWiMXQxeSXxIT+Wh+32GON50Y5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5R5HXSQ0u0eoYJZo/imzvvF2HwpF3Yu0zUwfvu1DF9b3TMyf+
	4ny59ick5FHVHW+0ItBJT+KiPY/D0zXsr9K2O8XKYjY8wTtsj0lahu2oYYeih3dapZVbcg+0EXC
	Ai3xx2XqRKf0bf9mN54qpKUIBCdn5wWIV7QEFS3mq4trK89y77w+/yrbNyCPubA==
X-Gm-Gg: AZuq6aJ1jQNWxB7+0GaGzobNgOsXbswKzrt+9V0Rd0RzDAGAAiDdAMR3sQmgnkx6+CH
	AngU2cCyWLjLocKXJcNgmSFaOk2gcFflG8G6H1h3UCi2MSZc1fq4foiXvATOMn56+Yd8FIqPz73
	KnVEdHrwxfiZRojsZIjdeKLBeOBHrkdOhBYXr7W6RMmQ3qYMi+UdBp8YG02Vq32iE7jetUZgkxj
	BlthpoWvYCSgXjBQXyCDmG0voZjteRKvAvvr+MNp0jMnq5Q7AgbBUuzHm2bf7ZmojzQnubi8Jq7
	OGhVojG6OssMQMxP5P5tmHvQWoPzmVj+q70ht3xq6yfNsWaythLStHaxj++tL4JO4LWs6lv2NCh
	//a3igWtLnEh69hNOhUdLuFHbZPNnCv/tlk6B6RnN/8sSnaxoDPTrohf9mI3wNiAE5ZSfPxtXIM
	7kIQ+IzrvQRTo21+4kZ/2+zqVPYK9YhhXbeqo=
X-Received: by 2002:a05:620a:460b:b0:8b1:728f:952e with SMTP id af79cd13be357-8cb42269571mr428793285a.31.1771022762592;
        Fri, 13 Feb 2026 14:46:02 -0800 (PST)
X-Received: by 2002:a05:620a:460b:b0:8b1:728f:952e with SMTP id af79cd13be357-8cb42269571mr428790285a.31.1771022762117;
        Fri, 13 Feb 2026 14:46:02 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-387068925besm15182931fa.4.2026.02.13.14.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 14:46:00 -0800 (PST)
Date: Sat, 14 Feb 2026 00:45:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sdm670: add thermal zones
Message-ID: <3ekefztyorudtf4xcdcamoyxjrgylaszemb52qmqgoxflyp3jb@6gi2levlz3qt>
References: <20260210021607.12576-1-mailingradian@gmail.com>
 <20260210021607.12576-3-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210021607.12576-3-mailingradian@gmail.com>
X-Authority-Analysis: v=2.4 cv=Rp7I7SmK c=1 sm=1 tr=0 ts=698fa9ab cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=fwIEsm_0hnujN-Tp9KwA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: NWabcfSObjnoTJupTVFpRR9C7TuZqEQK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDE3NiBTYWx0ZWRfX8NnGoPSXQ6wX
 Tv6zDnniuJZGcXa+b4hF80eUYGZ9+e5aDyXwiAAOtARc3kK1nybDeeTEc3zpZ1sNR7Myt2UFpKa
 JQ+k9s8/m79xZYDs2KKhVHVRh+JGD+XOyIMvp1odlZa4lLIWHcO801Oo2kXwA53XZ7UiUmsBawL
 kuxqKR1i5mfjfWIeZxWFFWdfEQNxQoHw8q0/VxjKA0W3cSxhVrNs7YVBnyS4k8ATk8KnmiSWaeh
 8uDWFqz4yG57BsS9pr0EukiDCHkzS74EtswvQvevBujzWKF7xr+pmyY/7PMcFZICp6zSWWdUMjs
 CktPU9fpo///RNw+jwRX236tRSIavWiRRYsCuTVwFU1/dIq42Qd5oaIv7MahnVr0pNP/FkQMFoz
 /Z2ZtNimBf7H3i58aNKn0cvyTa514g6Vr+eARTEuDVLEjZRz0gO0D5s1/HoVNx3HN/QZr+EzMpQ
 25T0cBguSfkXriItNZA==
X-Proofpoint-ORIG-GUID: NWabcfSObjnoTJupTVFpRR9C7TuZqEQK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_05,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130176
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42621-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,intel.com,arm.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 40A08139D87
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:16:07PM -0500, Richard Acayan wrote:
> Add thermal zones to safeguard from overheating to high temperatures.
> The temperatures are very high, but should still be safeguard for
> devices that do not specify their own thermal zones.
> 
> For some zones, do not include untested cooling devices (although the
> GPU is untested).
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm670.dtsi | 558 +++++++++++++++++++++++++++
>  1 file changed, 558 insertions(+)
> 
> +
> +		cpu0-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 1>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu0_alert0>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;

Note, use of the CPUs as the cooling devices was removed for SDM845 in
favour of using the LMh. Please consider switching to the LMh device
instead.

> +				};
> +			};
> +
> +			trips {
> +				cpu0_alert0: trip-point0 {
> +					temperature = <95000>;
> +					hysteresis = <1000>;
> +					type = "passive";
> +				};
> +
> +				cpu0_crit: trip-point1 {
> +					temperature = <125000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu1-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 2>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu1_alert0>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +

-- 
With best wishes
Dmitry

