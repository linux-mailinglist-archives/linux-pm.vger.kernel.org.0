Return-Path: <linux-pm+bounces-42702-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOOfDIwvk2ke2QEAu9opvQ
	(envelope-from <linux-pm+bounces-42702-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 15:54:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4361B144DA8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 15:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B4A23002913
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092C6313526;
	Mon, 16 Feb 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MOfAdO3i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JqRI4ML1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7EB3128C6
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253620; cv=none; b=m8ZAzi9ndd+ygBaLwVk17MvIbQsytY2zWZxawKP8apQQM8u1XXHS3aJitzFiLJzq0GctYw8BgSBA4FfDRr6FNeX+AyW/Hu1Os/quMh3DC9oekavZOJIcj7TkcAoEN/Zi5J0u0rWl+6kMByYpPsWAFnFPP3kfgiWYoH1pLIoMXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253620; c=relaxed/simple;
	bh=2rxaVjGu4XpdOg33udkiiQxYeZq0jcqJlk+U72irDE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLiFw5Ym7tcchxjqpUiikU2eoam0AB7wzD6bJW2sMFoZK1JZ/b2kRAJYcqY2/tFZfyndkc/2EgSiA2XrLHTDOMhsuS/Um92TB1KplFy0CmtCbZxxwdlQeEZ0meS0i0DO7jGWaCUIyWkUhjCE88AabaLJU8X+Z4pTHjHbHc8aOPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MOfAdO3i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JqRI4ML1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G8fwQj2802092
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 14:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kovETaFhNl90oBKEgZpok7n0YsCTyTL0lxrKHwRVzWQ=; b=MOfAdO3iTzIx2mDH
	NIv5rt8qhAwITi7+7nzuLhpcXzEfJRSOYTRlOPe2zQU0+TiAeAcAva7eZb7qhtD+
	RDf/UXiNvxhvYUl7DjnvDGjrdwhVIlJVqRxlEJZ/yx3YfklozdNyFUydUqL2xayK
	qqGh/0Z+Cf0klQ3y/UGJ18uWG9X9ri9F0yd3zGFtxal4SBa5yjbNr2vpQWwy2fyy
	XutEly/1f0Eg9MRrHfvkPItVCbbiTCe5P3J8/f8Q8GX8hKmPE+9SYoauFJp7StWi
	aDhdPQQUUZXY3w9wQsqLRSnv+r6hJynLq9oSHfj05pt8byl3QXQ8vFK64RBkwkXT
	42ORqA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cbyxugw6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 14:53:38 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8954b9b5da7so22423936d6.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 06:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771253618; x=1771858418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kovETaFhNl90oBKEgZpok7n0YsCTyTL0lxrKHwRVzWQ=;
        b=JqRI4ML1KaCDRE6kObv7RiNqq187QTfOye26MBuUrZlHtBC8KCD1/dGx2aMpSPEz3y
         2OVUjeW5Uq1bynctwJzoK7yw/HNcKfWqWTib+fHrsHltNdrSw9kic/C8F1Qh+skVCCMv
         ux0C8J0pfszIkuTPq605ZB/jyS7OWyXM6m6DB0mHKCLL2x6Lnt9OgW5EwWJPVftpuDup
         SF2i+IyFDelmIr3Tk3TM5+xFJHQBzY5vMygH8I5rQVyNHxlWvi6gPZQ9FRWDyDp2rcuL
         X3iwohJC2Vf/16Yc9wVXeOEXbejw1DaMq2quWsmODNUNh5KgsURwtVLW9WliTZ+3axpc
         jGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771253618; x=1771858418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kovETaFhNl90oBKEgZpok7n0YsCTyTL0lxrKHwRVzWQ=;
        b=rgaDLkPamrFLxSwnODDpJvRb2143hT4EFjEklahMpPbWMJLprFaoRvejfUzxZIm/sn
         lYSxm36HaNCefbudJICpLnU1d+SB8aT+5lXuz+xQ3IeCRs6H531M6azImSWhY1tM+7jL
         JK+SCvdjjWoeK7X9p9SEiQqx5xf0DVcHOk/LnMfa1Qwv3xs5N4SptQBVLtjXorqCRjTv
         FwH+VLUj7VzZyoqE9LgcjzU0vHzQzSw2xbHpxXFJ3Zc+5Ey6kAB6BVqN204D92jd7QeT
         MQ+Lxn/vtNs5HpVAza03KgVFfvt4PVQualO2l6GaMli8/kZ7NDX9kp5YOufXcCzRB8jL
         GjSA==
X-Forwarded-Encrypted: i=1; AJvYcCU1K0RxaprBdakw9U7kdyvsFqC0E2TGolFqLJqfdUMYhaIccKOMa6z6yIUok+rAWERiz6DhcdnEWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTHcyK0vyaekJETyheNnf8fAgWJV/9tEtoMj1HwG6z0GWndoMO
	FkOpMJS7iUi2+VqAaWKphD0zdtdB1+gcoYsLBsJfZ57so84l9ucJzV47hvmbmGHSUisDuZ5Pdg3
	ysN+dJ7dRuK2T+XL0Wi+rDf8RNEpHpqIgkalM+7hDunUf+r8g5/sjMLwJuInnJA==
X-Gm-Gg: AZuq6aJVlOFDAnZjn6DzRCJcLKVlcHpokJERvLmuc44UMiVGFcL66BqrqSCwncB9vNH
	lrrAsXQXdhdbmDQqZxZhTKEHcHNt4fX6ewW37S8+9DR2zbA87hs9k4RiB3PydGap6CALNV2lRzr
	rX/FbdrXKKJ0dV7Seyked6UPS2ouETYS4/C708LqjByh1z01H73bGDjrtfQCZFmj5TLqw2SMymW
	yUS68nUou7cDt8RoKwhqrXtQFkoyR9oD8TMdutjvaTz3kNrttQT7qRmqEs8DytYaD5je/14oNE+
	m8t+Nq6j2PvQoiertftJATu35xSItyAPUDvA8wMRzjh5gV+VO1ZbLHr6Okyc1f0UY4J5M3EqkLx
	+zUL/lPRNefWYdnQByiTwi5UHkl7/TKi/zladG/In8B7r8UzirAAL+H2weHY/uLipcWhXGmwe8t
	GWDWk=
X-Received: by 2002:a05:6214:8004:b0:895:4afd:5dea with SMTP id 6a1803df08f44-89734625af4mr114524706d6.0.1771253618255;
        Mon, 16 Feb 2026 06:53:38 -0800 (PST)
X-Received: by 2002:a05:6214:8004:b0:895:4afd:5dea with SMTP id 6a1803df08f44-89734625af4mr114524436d6.0.1771253617732;
        Mon, 16 Feb 2026 06:53:37 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc766579asm259615066b.54.2026.02.16.06.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 06:53:37 -0800 (PST)
Message-ID: <ba6a9ce1-6ef0-4921-83dc-751b037d0e7f@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 15:53:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pmdomain: qcom: rpmhpd: Add Eliza RPMh Power Domains
To: Abel Vesa <abel.vesa@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260216-eliza-pmdomain-v1-0-c51260a47d6d@oss.qualcomm.com>
 <20260216-eliza-pmdomain-v1-2-c51260a47d6d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260216-eliza-pmdomain-v1-2-c51260a47d6d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2P-IeFKvx-XtZ-0j9lUx7-XhF4KtSxHN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyNyBTYWx0ZWRfX0LDrfERcs4Nd
 dmx387GhcPltfBtF3938jsyyMzctdRfRayMqYs7eQuyljzWhqUX63BUbRuCYUKlKecWUeWCJvNP
 vIbw3SWCha1McaMaT8iraxy09JlQbmEpBgQI3bg4p2zwtvTOblj0VqqPkjsmPrcxLOpdRV9l4mm
 8b8PKNHRKr9qVQuVEkkGXlKfmCjtfBI/TRgEcNBmb/1eB4+XN8MyacTwx2D7ccQ8zCxQosrPvP+
 3b+yWxvHusOiuslPoRQfP9vEyANQDs3HE0pGmFx5wXOnRlK5aJ7Et+SIoyz9sp2CvnxjUhLfA5i
 BOn5jfsESaBXahkTx5/PDuwkbxpygyqiDPXmQfzj5NRXsKE6aLgXNBp3osYMiGbeUWyLdtpBKGv
 lT0znO/N1NLnA18G/o4mYJLi0iF6JdRRy5+bXw0043hvRj/q/nlKW8RBdcOB/Mmybr8eXWMLbCH
 vTbmvkC46NdkKyyQQiA==
X-Authority-Analysis: v=2.4 cv=BpuQAIX5 c=1 sm=1 tr=0 ts=69932f72 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=T3cQ91Bvcxg1os4lQNMA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: 2P-IeFKvx-XtZ-0j9lUx7-XhF4KtSxHN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160127
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42702-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4361B144DA8
X-Rspamd-Action: no action

On 2/16/26 3:23 PM, Abel Vesa wrote:
> Add RPMh Power Domains support for the Eliza platform.
> 
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

