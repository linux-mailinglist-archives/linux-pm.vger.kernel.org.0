Return-Path: <linux-pm+bounces-43537-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHVAHxmRp2l7iQAAu9opvQ
	(envelope-from <linux-pm+bounces-43537-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 02:55:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2927A1F9BBF
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 02:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5D89304B585
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 01:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917A3327BEC;
	Wed,  4 Mar 2026 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhgK5UDN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iJN1mqF3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872693242B0
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 01:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589334; cv=none; b=FFtg/eBfLn19oypAysIDeoXah0QwdQK+zz3531R/jlKJZjcrvk1DrZQbcjQIDVgtNXN39irXABVApCwv1M5yxCRuSKS5nfT5ThKMU8FfYB2g1rTgv+HFG/lYirt74SYFfKVzOwJcYc+zi6kqa08/HjVtkxT9GIIQBLEVP6RNgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589334; c=relaxed/simple;
	bh=UFg+j/Y8ZucMypkuZJF7sEz4IZAIuHIRmFuQhsOzIpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OI17i28xyyObqXosZZ8Gm1cJlr5/IDa59r3kdWJSXaD4RjYQNPBUQF915lZeTQQM2f3AFGSR192KJsJx/If7IXnGW+9xmKL+lWtoOktxu3L56/iKhR3ODs5BqrwxqmLWd37lUSWlMk53w1pexfmlth5i0z+vl4VFXdfu42wifSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hhgK5UDN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iJN1mqF3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H0T0Q3670005
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 01:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OHbm5naIkR5F0mYCp+/Z0mxA
	zTgo5cKKpME6H9yKg1g=; b=hhgK5UDNlWdv659lFXkAByI2YHxtScYeLL0QduTT
	MhOkzDFl2lw7ys+cgdz+JX+lpdlezAFPIKsrrwpophIMphyj7RGN59FwcAiiLGDR
	CMIdIjcSRuBxypSoxiC42cig5Q9N6hOQq9oTeypHKkGfej8YX/DxTG3xT7o0Nla3
	RyyrE5XI9D7vR9Bbye19bDImp/HoDoNb3rwHtWJ4op+P9APmu1QWPZ4kltY8kalv
	nDSnNKIsQ19kDBHcvd46p4epmz/pLSSieOFkSlqVEm1S3K5RehQKc8NHK5wJgfmU
	e+YxvF8UMn0Wflykc0p0xB9nBeE1qG628LTl2Ls6n/A4Lw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnswe3ta9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 01:55:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb4d191ef1so799933185a.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 17:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772589325; x=1773194125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHbm5naIkR5F0mYCp+/Z0mxAzTgo5cKKpME6H9yKg1g=;
        b=iJN1mqF3UeFAqM3CIR/Ts6MNMRvFapnG5Fihqn8MtbU8ddGq+zxI+c09upqRAT7hVB
         /7VaJJW1QkkX9PsWVLeAqCEecSpUCozNw8x3vV5F9gJmiPEnT5KefZpmQALdJK9Ftl3A
         LrTzkE+h6Ps6TJyo/cUhxhemsENmX029W5ZgkOnW26LtFbA+obavn1S+glamgo45tfqB
         Vco2103j12eIGZeyE040vQFUBbodI62p1TXHKalKYFmRCI/1eUtdG4MKq7uYVaIj2571
         DU2bPukmUTKooJBzZP0S7MTGkW1qGwWm5/yWDWlAmQbqr+VIrN9X5xd6QJfbuNVQNQVp
         VJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772589325; x=1773194125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHbm5naIkR5F0mYCp+/Z0mxAzTgo5cKKpME6H9yKg1g=;
        b=pqwKxYiRadCYpuEpdeJqx5AcXZme64LSW1lC2Yig6HuaRgw9SWjouzL1rRpbxRywlP
         WTKIpjhUnsj3mAN1CYprNpQJNvmIg4mLyeJpCQU9fBCJAMIoGky+OaNanPpwM8bdkkNj
         /Uuf7bVi+sWGPXh1ibxkB9g5grHBwu6/bPVx87NwQGkZFVUGNq7Ax/vcZt4jaRodMbZ3
         duxTXXRASsOLMhRnZIehCOW95YF2Th9LIxsTBQLeTW/rGuZkcnH/EXNTtWQwJdRu4X0F
         Un6u1LB3z9KUrRG6MFmcdvryTr1a9JakpnHLAHpB2lvSbPIFzRCq4v3yWrPgOmDa/jHs
         VjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1jIwuONC9rGDxGbLHf4ad0NyGbCkgowwt/l1LRr7nIqGvgR7oP75EGRurjKX2OswFTvymfg0ubg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOC+359L4YYRmoSTidmN8fgzIX3LR/xN8THYjyNVajZNeiSLM1
	SEfqSjHVzA8iW9+a523bkvPbK75rS7c4NwdKabZEYvbUQ2FL67MgBXyUJiPQqZTMpwF9Lm76gSX
	C9Si219nHlDZsMHyzh548NGOpZ30QSwdPcH6IZ92EFLNXDCdOCbJM6msaVnOPTw==
X-Gm-Gg: ATEYQzwTO36K6Xpq50G0ZSBanV44IJjtpCHnrvCGsp8mmeLj6JG4sz821IVxx4RH7pk
	tfwzIJ8DAaFriuYrSsHCFxNkBP5wTxv6tLEE6zWizlw1INof+fmusGN8cRhH0wrE//53cIOzdTv
	y1ewGJQD8famOt0KGeCkL85fC1jBgQ1QJiJpQukOxyWw0XkZS3IYBfzMRIVPH0GqxFqIvCNC59r
	Xq3rCN1R5hFCdHT+6pH8prqN+e6eo2LxAXKFRqCa1Ec9CScga6eXsuxDKQBt37Z4gMZwrpCq1OF
	oO9MqgQq1SCwxMciUlPnkNW44kvzPKGEhEeN4YtB+8IP8xDmATh+8x4Yzc9IhjdaVwGu+jVp5o6
	hruSlDc3XCB3URnV9nbYj6TrDcVHojBvkLzO1YjrUMPkB1oZkaskS1/wEP6beLbyX0kO/BNLYxq
	zF+hN+OoSrVPRhc1+A5BIbNF404sGt39WVZ74=
X-Received: by 2002:a05:620a:2944:b0:8c7:9e6:3a72 with SMTP id af79cd13be357-8cd5aec377amr64463785a.6.1772589325361;
        Tue, 03 Mar 2026 17:55:25 -0800 (PST)
X-Received: by 2002:a05:620a:2944:b0:8c7:9e6:3a72 with SMTP id af79cd13be357-8cd5aec377amr64459485a.6.1772589324780;
        Tue, 03 Mar 2026 17:55:24 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a123583e48sm909623e87.18.2026.03.03.17.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 17:55:24 -0800 (PST)
Date: Wed, 4 Mar 2026 03:55:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Richard Acayan <mailingradian@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm670: add thermal zones and
 thermal devices
Message-ID: <55s2gczljwgtk5rihaq6iu6a2osotruyostrhjawwz7xywlumy@7vjt6vb2kkwt>
References: <20260304014530.27775-1-mailingradian@gmail.com>
 <20260304014530.27775-4-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304014530.27775-4-mailingradian@gmail.com>
X-Proofpoint-ORIG-GUID: Zzdot_e5F1K9xWmdAw1R3trMrVgu6OKv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAxNSBTYWx0ZWRfX2pbYi8evGLtj
 oL7aYg1fw5/61vob1nj5JYOhssl4oGRza2Mo2cKkbCLnilIOeI7TFo4IoVVADpNCSzDuAzQkJQ0
 Et3Tsl/E3IsQ3amOPN9ASXXeIYPlAS7J6ZaRbu30nXTU6qtVvqTqeo7hhz5SEyumUtKjU4Fn2Ek
 8wVYitnzVRI8z7IWh7R9BKaqRsIM4WgPGbf8mXnOZyeWtFO3GzhPPiLtu4la3xDfQ+jKTZbtSvh
 L++evvsNpeiZJao0+kw/P6hi/gOXn3Ql6/sLw4wbMLiA9TykHr5fOeu4l85i6hSNNnuUjRZO5F1
 /4GHB+Zf0igllbAWOsZwH0g81PfTzl7tbJ9w1+CZW0wZOwh1MRO5tOQkF2WIpmNvTsWDBsVQpH0
 Mhdein1pQjFqbJiC2svPKWQVRUuRLbJ5i6FjzM4MhKrMNudSvhRC0kbZUkGmFJn+p8NI+dDGlul
 I561Oyb/UbbvZO1AovQ==
X-Authority-Analysis: v=2.4 cv=TtHrRTXh c=1 sm=1 tr=0 ts=69a7910e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=M8YKDcNaA03c_0jmb2cA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Zzdot_e5F1K9xWmdAw1R3trMrVgu6OKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040015
X-Rspamd-Queue-Id: 2927A1F9BBF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43537-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,arm.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 08:45:30PM -0500, Richard Acayan wrote:
> Add thermal zones to safeguard from overheating to high temperatures,
> along with the thermal sensors (TSENS) and CPU frequency limits (LMh).
> The temperatures are very high, but should still be safeguard for
> devices that do not specify their own thermal zones.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm670.dtsi | 474 +++++++++++++++++++++++++++
>  1 file changed, 474 insertions(+)
> 
> +
> +		mem-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 2>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&mem_alert0>;
> +					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;

Why is it only cpu6 & 7? Note, SDM845 doesn't have any cooling maps for
mem-thermal.

> +				};
> +			};
> +

-- 
With best wishes
Dmitry

