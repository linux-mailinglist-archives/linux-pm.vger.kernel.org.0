Return-Path: <linux-pm+bounces-41222-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGkPDtuwcGmKZAAAu9opvQ
	(envelope-from <linux-pm+bounces-41222-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 11:56:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6C055960
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 11:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07AD58E6DB5
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 10:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E39413255;
	Wed, 21 Jan 2026 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YsSrXDig";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A0Z1u0Pc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658C724679F
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991840; cv=none; b=pXzQZdJkd/uyQohhthqrxn1XmSuC5+2B5SDYosnIPGQxQjZFLWJRX4xGDPNpAngxzzr292oQTcs9NLpki2mD9Lc98Mfu3CMlwVSN7hoKO+64UlMWtdcTBB6jHvmuGMR3xd0M6plmFEseYtJipoI+ccPscbx3eWsaoVHoG4rnvRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991840; c=relaxed/simple;
	bh=aLmqcGbfiLbQu3OURTEMClnX+EcS58GjLNdezEN/Jr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owdkv2tB7Du9D6Cie2LjwgmoyDWeEuILBb17hfGooTaGnkd1uQrEESWWQ4jhFw+I68RUOqOjED8f+ZhKkbTbJhHolcY9nDbgDZJG7sFBat4QOJT7IIB6vlVrxBct1cPnY6VYALVR34rd0Ay0BDaQgy/vudT2d8ras1jpPXK40iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YsSrXDig; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A0Z1u0Pc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L9fSYf824387
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 10:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	00HJ2WKg5ks04XLuIgWAT3HUKXOTWnnXf74hpRf4Dtg=; b=YsSrXDign4zqSWD2
	XeJuv6bbNmzbZDHjL1d+SQTfLhYj6yz1l3ABwLobW4fRlNm6YcaU1grVcUoqDw04
	p32XZNf2+mDRa1h3PBHwBQNCLILPVvGcXfXc5jIeVeS9la5eks1ELLwfFyVCRUBj
	5BtIDNuXvDtniwwJn45gKDK5WTWqvF5phRl6PliTgQ7VJ4pu05+uSoaB2UhpM2z6
	pZg5EseYLwIZ5croPtH8BvHo0zeYw+Ltg93aFIsWexjPgS3TncFBT0zE45bIRp7q
	c3NL4LnY8RwDX0p4diDPjkvZ1GtlFXxSXNuSSgZhBKOvlhCb+vvpris5RLoGqeWg
	v0FnLQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bte5e3j3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 10:37:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c523d611ffso67512585a.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 02:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768991836; x=1769596636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00HJ2WKg5ks04XLuIgWAT3HUKXOTWnnXf74hpRf4Dtg=;
        b=A0Z1u0Pc9+/z9wOHH4Vmd06bVlgO7oCOa0iD6zwyh7ONq6/bUTZ2EcHYmwCpGDS8Zc
         AQ9lgW21UYEFWiwz9tkA6iD0M0HVtmyfERn+Qpj0/HmoWdY7NztFNmIeamUt3kEpMA20
         1EbYXiOxqcVxMcsj2frGe2C4Bq+9Lpm1FpDvSnCfeuei1B9b5ywV9Z75qOmdfY76ALdg
         I63OwBrS70ZP9sbm+v+2cx4p66CV2IjomFyIMoz+g7cJ2HVP1YXr3pIcNjLuFqGsxgqj
         pkOd1LCxfTP88at+JnSww1XLLeBOqURPBe3Fyu0m/bJ3SETQUketnUNhn3MEcsz5SfAb
         9zeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768991836; x=1769596636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00HJ2WKg5ks04XLuIgWAT3HUKXOTWnnXf74hpRf4Dtg=;
        b=BHnkubc+fJM5SpmVo00NkN92Z+V+1uk7cJqad7wlkp3Yb4bzCFjWKaazF9PtvUDx1S
         P6DiZIwVtLAaGcXtatvR7sMr+Ggdfo4tlP1b7MT3AqGMhTsWT8FHTuO7CuW2JDNekKrO
         cMJ1AQpbgTjD/diNhTiZCHnuAT+L0+V7I6yxPm3o80HjvMBTNLmG+9XzSvkkXl1j22mM
         R8Tl2CSc3Rqu0+uUekFtjK+bpsCJHOs0Ad0dYG6Yb/GiVn6H5i8DNBkglcfTKNLJMkaf
         wtI+77q7USJMlM6UtUBUxFTqF3j+GTbJkwJIt4gwWEkdVONQysNPz1tjMTMbK4riZZGt
         8Bcg==
X-Forwarded-Encrypted: i=1; AJvYcCVf9PYQfYI4pqWj7guLXcTV5JukJjNeqqrxJ4FS0BIw1QO4FIiNh1Slm8RY5lPYx+oOjkIdubEfQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRoeZR//PiXLzApxcYIJK+jw5rVSupauIC8kyeEbv71yv0CXNJ
	I3pGLHKvrU36D6fTFj1JFzh0yALhiXA9v5t759n5OVJEhCm1vu6AHokLHjVQqY7mfv4yM7TvZRS
	sxBWmI9jl+fh9+lp8hpPipmaXOFNiAh/YRnFgWxA3tIR4KVg5VcZUKBgU33vvoQ==
X-Gm-Gg: AZuq6aIRoGrel9+97lt1utaqshfdZatExLvBxbckHezyOnV7AqQh2uTeQTtOJD2Smyz
	Ba/uML9uOLvbV1w34t6fnsKg1wPkhisJGfqpo3LT2EDGESkW1WdBKidMdoGGZMWIRXzKKEbwZGN
	jrQrl0BuywTGqCKKdvRRFQVWpQN618iZsf7FUXDMBIm4Y3Qn/lxaKMAGG6wSbxrjhePwvgFP5RZ
	T5IG/gPGAW7kmeiOCvWyZn4ctd0L1sdSLXIVIdmQdcmYLrC2YtxM4q9CtQgxoMWdbwFZDYFWvUu
	ne6np7iWSWJoW5tBKL43vynzXxW8hBVMSjD5kQTgiLmbAC2XiBqA59Kf2BNoLH8c7vs7kzcyLZ/
	Xc+gwxH4UvBu7NB4vDR7LjtSBKWet4ZAMb0l6adEgFYbTAT/Vzy4k4SVj760lob33H6w=
X-Received: by 2002:a05:620a:2947:b0:8a2:568c:a88b with SMTP id af79cd13be357-8c6a67c6a94mr1633824485a.11.1768991836311;
        Wed, 21 Jan 2026 02:37:16 -0800 (PST)
X-Received: by 2002:a05:620a:2947:b0:8a2:568c:a88b with SMTP id af79cd13be357-8c6a67c6a94mr1633822785a.11.1768991835907;
        Wed, 21 Jan 2026 02:37:15 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6581d306580sm323754a12.10.2026.01.21.02.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 02:37:15 -0800 (PST)
Message-ID: <65ee478e-e0b6-4027-a6ed-10a3109482a1@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 11:37:13 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] power: supply: qcom_battmgr: Recognize "LiP" as
 lithium-polymer
To: Val Packett <val@packett.cool>, Sebastian Reichel <sre@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260120235831.479038-1-val@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260120235831.479038-1-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BKa+bVQG c=1 sm=1 tr=0 ts=6970ac5c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=G1jGPrsn_bHTxkitkXAA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 27GTV7lIJ0VC_JkhSMfqKE6utq_Js3qe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA4OSBTYWx0ZWRfXxRy5ckIdtNAd
 RNjNgLczLnCCZIr/1huSHfkat3lP8fAYyfEgZimbQby4wT/r3br3vKzIRLTBuLHPknygr5qmwv+
 Phm8CByMj0lWee5Z3MfI6YhBgJTZHKhHAYAj0x0Z0v6aXa1WwM0I6akWUNEuqf304j2p7OSwGCX
 nyHNO3dnbS4M59jaKq7HUT1y1E4gK7jRHTnnCA+QQyGWSiAylBc8kHdcuD0et+NXtzzONwHL4wq
 gX8tdXZlfBughwdn9cXBMa8BLRtoj8+RmWtjQE0LOx/+GREcROWWqWmXaarw3tG9Djpk3dUFbdO
 laUaEHhxnJAoy554v9BJo9aFjc4jpZ2y/ABf3oeX4VSJmdZID4tgpqxUuOr4jdRqDKGNxxUjnKw
 bm19aJzLxhiekqmRD8WoReSuO5lbtICEG0BB0SurRwXGZX15xXgB98IB6diLt313GiHJ3JQAqx5
 32EGbhJXWBOIv1nWN4Q==
X-Proofpoint-GUID: 27GTV7lIJ0VC_JkhSMfqKE6utq_Js3qe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210089
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41222-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,packett.cool:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9E6C055960
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/21/26 12:57 AM, Val Packett wrote:
> On the Dell Latitude 7455, the firmware uses "LiP" with a lowercase 'i'
> for the battery chemistry type, but only all-uppercase "LIP" was being
> recognized. Add the CamelCase variant to the check to fix the "Unknown
> battery technology" warning.
> 
> Fixes: 202ac22b8e2e ("power: supply: qcom_battmgr: Add lithium-polymer entry")
> Signed-off-by: Val Packett <val@packett.cool>
> ---

FYI I *think* this data comes from vendors so this list may end
up growing and growing..

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


