Return-Path: <linux-pm+bounces-42923-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLvLGBQwmGkzCQMAu9opvQ
	(envelope-from <linux-pm+bounces-42923-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 10:57:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2639E1668A5
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 10:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 400923028F73
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E5336ED1;
	Fri, 20 Feb 2026 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oAlLT1Zd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y0NABUPH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366E6335571
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581452; cv=none; b=EfsYVpCTbN//HIc8tvVbh+cYhHOaY+x6L8wiu1hZFj9xiSW0mayBtyJLYc5SFb0aHZLAQnQRqrfzZmMEKZ/ef/HTyFjiFW6tTmfZEKQ7GakBilFouza04Azjxwl0kRBhZQdyjcueMh2635iguOHXZtJ+BxIY43fkAsjus392T1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581452; c=relaxed/simple;
	bh=H0bxDrD7Q3iu1dnJy/oLm0o9F6Btp8a9WEHS1lwFwQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQxX+ahibHgjYv94rn9qMsI4Sok/RNOkVR/CNhJRqGNV4BoOxyKLc06KJhRWqc1Kdmr4quJm7wso8dZrqajmvLnSp3UUTueQurLcS6rFzWtykOMuOnkwvQCITj7rZK24rQUELY6X5q6M+d0Qi6qT37b98O0Rh8lLnwhvHX5xQXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oAlLT1Zd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y0NABUPH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K5SMPj2431847
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 09:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Td/GyC2H54TSnBsbZynZSNK0FkJDWvK5rVS04DwJxtU=; b=oAlLT1ZdkZc/HTEU
	P8EungoIUuX3fSBU95Vrnj3jBchh/utgHfR2UhfmGpuWq3X3PAuvPqTKky6E+qJn
	oGyiQFSiVMNG+ygP7xSnm31gYTH1U09aaLBAJ6oy5KHKQAbsg6t0GInyF7CasBOQ
	qMXTx0AXOW+tVMyPYVi/x4bQT1Tcnpn03tDT0j2q0lYGEYuzOac4Lm5gRZ72a8Dv
	rkNfXErAJcRNzqTYQH97k8P3ho2s1XWH/riNHYVtSEfgccmljtnUb3O6gX0pKw06
	3eQEKmyWyvk/1nEyJsTg4/STJ9oZ/ka5v2YVTRCjuh14Z1p7U46kP1x8FSxk3aFi
	KegcQQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ceh4j0num-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 09:57:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb38346fdbso182622285a.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 01:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771581450; x=1772186250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Td/GyC2H54TSnBsbZynZSNK0FkJDWvK5rVS04DwJxtU=;
        b=Y0NABUPHE/Cw7XsdpWYQCSHRni1tT7jLCUnSc8WGzfmjDm0groM4dz39SpMNf/iWF5
         nmvHHvlZjtOIrpdlBMdEkofDLTtR/qbTLCnvry4K9wj2PV5tv/p5YlPiI6Vd0Ca8lD0t
         X4UQoirv83PzDBGCo3cJ7l2mUX2yrEcTSyum5ujUZxDnixhhfwmGce3imcRGJiKN1GbG
         ObkqJEmwSg7vqqjFi1PxTxEaPsnIwrBNAi/Ykz3/IjWvMZiwIno8+ySwiIp3rue1yNNB
         Iz6QE69ReOO5MuuTlFhxcyrRbEW1oc2PF02N5/IIsLiS4bgKi7RFGqgGJmyy2yRsxXpf
         Pv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771581450; x=1772186250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Td/GyC2H54TSnBsbZynZSNK0FkJDWvK5rVS04DwJxtU=;
        b=ngLC9LesLbQO87iddtbeK+LeBRo+DX5YsTq0f8g8UTNzDwYb442A/hlUfcWTNEtGP0
         9vLtBIBnDnpTYv9rxhbpKcdTrrn2VgvO9hPTC2rAJFaa08g2sVRc7qO1qLQ6udwgjups
         Ms4Mtr59QWcYYct/2jXfyzCMm5dCHb3T1vN+q78CeC8k/jsiC3H7V31bX07jluhDGPJc
         S+Mzz6OxbJgsKge81zibwfxzIkeLrXngVD+4wu/2gnRiz4T2hb8UcKsY06yWq5qwYRVV
         L8WB8uRRtC60CxCinSfcYY63jTng6IjdhjIW24VSgeLzNUvz40Rc84nWzULlk0ZmyOFO
         rTUw==
X-Forwarded-Encrypted: i=1; AJvYcCX/D1U1wXDMOVqQeBaq0/ABo1iVtLtSPDUs9Iy0Q80IwseX7cAPUu/UB+nkifX4iWfspnGlwGekLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5Q/5A/EQNpqjinxnBzEOkNkYWHrjV4oqHX1KxwIKq5Xu6siS
	d6NSwSK9/CsN47wcUn0MxGZley8kvxwSiXrKC5TJr9gqv3ItLocEvIL5PVS3jj5T0DSePG07P0k
	2FfksQgSOSpZsvAYGomcXGLoCyOEEsC/6QcRUVzi0ObMQJyoCxGjnEmXcFbIauQ==
X-Gm-Gg: AZuq6aLGur9WWlGiJJoRyu+EHa+0hZ2Hma50OrNpUC+etaokrZoIH0SPrcC3qlQOzaJ
	WA3FmITLC/v3fZYaMXGsc/y/fdByCWfyV5wxpcSd1ngBkf4nDrTALHBlpXIW+BMX7hL1ZfTrS/i
	7/9I1EIBQbtsLn988E+PrhG+NiEpLdmn5wE7St6tRMkSzdb4EMe4Kq9sMW09qrd9pdBJR1aLsMu
	W1KknYrAQ5419ct+vfbGmmr5BBMVbgkEjsgEKdDS+x8fanFXEX0Ikqrjb7DriTG384BaX+Tzmev
	PRsIDjmVkR5EbEePwGz1tQF33H9a5d1nfWrYuFwcB6xOCZgU0rURFPotvbYs0OsKNmD3rkYjQDQ
	HtdPfw903z4Qo7/ffHGoPltgzomlydb3x1YnqfrcRTL/3Iug1e5desuTNcV2+U3Qt3Fob6dSBJv
	iQs78=
X-Received: by 2002:a05:620a:d8a:b0:8b2:e346:de7b with SMTP id af79cd13be357-8cb40820215mr2408610285a.1.1771581449647;
        Fri, 20 Feb 2026 01:57:29 -0800 (PST)
X-Received: by 2002:a05:620a:d8a:b0:8b2:e346:de7b with SMTP id af79cd13be357-8cb40820215mr2408606885a.1.1771581449214;
        Fri, 20 Feb 2026 01:57:29 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc735d95bsm661300166b.7.2026.02.20.01.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 01:57:28 -0800 (PST)
Message-ID: <cf9c3543-e3ff-4ce0-8fe2-942a478dee4d@oss.qualcomm.com>
Date: Fri, 20 Feb 2026 10:57:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: pm7250b: Define battery
 temperature ADC channels
To: Luca Weiss <luca.weiss@fairphone.com>,
        Jonathan Cameron
 <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Hans de Goede <hansg@kernel.org>, Jens Reidel <adrian@mainlining.org>,
        Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-4-fe34ed4ea851@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260220-bat-temp-adc-v2-4-fe34ed4ea851@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA4NiBTYWx0ZWRfX8evM6cnvwW0a
 n78fZWFcPh4HqR+hqNy/7NdhwAlC6tnwv7OJoVZZ4dTB69IQU03lyBurkGUTFyxLpmcFokS52l6
 13rwf8WpweZR1JwFanEMdhTHSERvosTenQRl3XYVo2MGg2SSxYvBE2BgU4C2hF0/RwyYGmi/H6n
 HJ0ysE7hyfuQaXahqVw6tXy4HaKTYSdwegSqr6yWGrX5GNSTyDpiU0acwBvspGcfk0fKUSWeJm/
 XxwG6U/9ZEgvmD1o8Uw2mXALx/h/x5vGtlyLs9OF+ylDcWQKz996LHUpGLAZL+At5zZXbuEvH1X
 p9gZXg+TRDubdLGU4xDlSfOEI/8vQ4VI9YMGQX0s3qEMUDN8p4jarRmIJZ3Sr9zvLqOeW2PhbGQ
 ywna31AjomzBDmDYJCbb9H/IG2XmrnE5FYXR1KP2r7xwED1/1q7d/bzspyeAeiVIf8XXutTVzcF
 D79MInFKgHG8r3Y+Lhg==
X-Authority-Analysis: v=2.4 cv=R/0O2NRX c=1 sm=1 tr=0 ts=6998300a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=ZSlsbEq598atbnW4AL0A:9 a=QEXdDO2ut3YA:10
 a=AYr37p2UDEkA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: y19H9CtrzqlY1KGxvT6cAoAp0gpbwlHj
X-Proofpoint-ORIG-GUID: y19H9CtrzqlY1KGxvT6cAoAp0gpbwlHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200086
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42923-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2639E1668A5
X-Rspamd-Action: no action

On 2/20/26 10:19 AM, Luca Weiss wrote:
> Add the definition for these ADC channels to the PM7250B definition.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

