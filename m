Return-Path: <linux-pm+bounces-42749-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJeZKwBolGlFDgIAu9opvQ
	(envelope-from <linux-pm+bounces-42749-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:07:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DE714C617
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67C42302B535
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 13:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AC229AB15;
	Tue, 17 Feb 2026 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pqjub6dT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GPI195iF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1EB257854
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333382; cv=none; b=GEsmDdAqAP8RRkGeASlukmihboXsgPG9Tv8PMlJ6aovwltXt6+3VYPxKwEuSYR+h/Q14yNPZk90IL0OTZurJRbv6g87w8GDeXuGm8v56D2x9YGtFrZvrDLhbofP3MWe16cX9fRnV6ne4ZSIlA8gFqmoSbksuBgwDWwrEJhHF4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333382; c=relaxed/simple;
	bh=6SgAWtQb8PX7DsmKfS1ar/bVGRlUSpjeBG8c8DPZxk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P2QnpOh66Mxxc3DsoJO5Df0chMPU8Re6qn9uon+F0gPPyM8kcAJDZIKvP61D12xix7ttcKmOXjLdXEHzhzTIG4viSM1Timn9itj/9++dbAUgzhBoA/Fsr6iLP7LCz32QTRNwTi00DaqsZ9oMDf6ojFxq+yhu62A3l8SUB7Oa5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pqjub6dT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GPI195iF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HB40Tj1943465
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	An9Vv1vqNs3nmIxOhXPvuWuNV5jNcLqHxON5vO95rRc=; b=pqjub6dT3JOUI6P3
	wc4MH7O+IKQiQYC/cVYHYH+MHZL/90CdVc3J6WCcSg1Zz51fh/6IFpCER7p3mSV8
	e5XdMWs/Ud/oAy7f8/Is2ECd+nZENAK9T8auz4y+A+gNl3LVey7Z940QrlEeP96k
	Zg2r4k+86LvBKU6Ivj0gdKKUZS9lxh8pdCYLpQUo4jxrkMtJ1gZpnjHjcnNiA/4D
	U+JiVs6msz+JLJfSY21PrtmTKu79/E3sNUBAo8PD7O00ZVS+YDshvO0XO3D1rddj
	X0xlVNGe1Y+s5fzRV3dw2ahUXhTE13v28GWUazROARARfL4JTk+M68dcIInmsc9d
	TaXDeg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccq4g0cmc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:03:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5064fbe2babso31827871cf.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 05:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771333380; x=1771938180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=An9Vv1vqNs3nmIxOhXPvuWuNV5jNcLqHxON5vO95rRc=;
        b=GPI195iFPAqMkXcaiJ6K0FcIuzx5eBDI1AB64UpxW6HsE69N2d+dsS/MKZoLWgBSo9
         C6Nah4Y4BP9oAMu/pTM9x+37cpvtCDC2dwrAw8BwcVSJ7pNQjWxlb4YlS8hS5gtgiyHR
         gS7bYzgz7E7BZENEm5VV9KmzC21KmrGrPk2iB25f+AxFBcxORt2nPjRmX01r0qA1H1Ts
         dBlSibBmSX6gDZGqnBpRNX9rBJS30B4ddA02/sV3NhI6VyULQXxoHIaDdiGcQNUFUTVx
         Gt9p7l6M57dJwZCMmvC+Pp4rjSBVC1Ylqo+h0mTmc3JGWkqb6+2uibt4bPGEwxgNKSkF
         N/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771333380; x=1771938180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=An9Vv1vqNs3nmIxOhXPvuWuNV5jNcLqHxON5vO95rRc=;
        b=BQ3A8RANgF+WloxAvzXC2Dostktxo0KxtCz901KQAfVy9zLLFByvzT4l1El+2ndDgD
         pOwVsU8QMpZlsq4iaK7W7FfmziV4nm915zQoKzbUt6KILvLQ961B/i7g8ldrCLtnhWDH
         Pn4UYLDVxSP6+8m3kSW0KrkBFuwM1FOCkgtgBshXFyBUViympfEXLsdddVkCfiHnh5Oj
         stYAtoIxbh70o2FPF+UJboV/lIpYMhPeCOLMPXjzGcotm9BTHW1L2g5FaeoHpHjtzNIr
         cLY+XCS1PBKAgDt/ut/KuFkbP9aoERXXd8uL9UTewCXa9zXSRY/hs+zrZB+MrA5/YnQy
         rUyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEpCgoUOA1UALS69Cm5b+a5RQea80DH4vkK/Rkk2GC+ljz7Xp3CCzAhhdIhzYgM+EJcQ/X6IS6hA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDAQLnv0BKx/AxtvKn8rI8xA3fz7gFy3qMtUvRJZ02XLG7yAwd
	6bARk8CNu1IqFcHgGqhqV5NuQVxpHq5ALehZoFYGmGT5PwnQ7Zug02xfqU/6PHlNQ39IaHBOA6T
	7Y+LQoo5V7Xo83wb+C3OFtPROYm1IKZa8osdOst3B4NlyItZ+42LrKupFgi5xQw==
X-Gm-Gg: AZuq6aK4zy/zw+R+UVRWi0bxFmWXCyRcCLUC7Z3KG9BHDTtmgc8n25k8bhkAjI1OB9y
	7LxJY01lt5RI7Aqr7dGlj5WdPfna8w0EMT4n7OQIl/zLQa6tQ7YWN0q9kRGE8l9KnUf8g4yrWXm
	7B0QyxAowx8HMSazxmamm/MVBMkUZCUh0bP7Uu/H+tVtUc0kYdJT1q8OHBmSfSmlrxBMUmO+kXU
	sTsB5mdlM9w9WoyIygExHjpyq8lzggRN48bG+Sms8f7M6l7lbhtuTWUttMknOGwJV00FecIbtUc
	Jabv4roej3tjlGR03mPgJ6RfAzninJQW2whdThXvCX9TIBPHqzN2p/+aBvkjSPc6GcHFX5frUxv
	o12qNUBk38tNWwXInarMxQIJJx2bcPWdPGOwEpEVJVHB4OBFEXzlcVqJRGhxqntUBx7wAu6ITEo
	hYOvg=
X-Received: by 2002:a05:622a:1356:b0:501:5260:51e9 with SMTP id d75a77b69052e-506a6815affmr133019521cf.7.1771333380040;
        Tue, 17 Feb 2026 05:03:00 -0800 (PST)
X-Received: by 2002:a05:622a:1356:b0:501:5260:51e9 with SMTP id d75a77b69052e-506a6815affmr133019061cf.7.1771333379236;
        Tue, 17 Feb 2026 05:02:59 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f563564sm3980554e87.4.2026.02.17.05.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 05:02:58 -0800 (PST)
Message-ID: <0cc60cb9-5714-4128-8e41-cb62eef513fc@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 14:02:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: De-acronymize SoC names
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260217130035.281752-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260217130035.281752-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260217130035.281752-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNiBTYWx0ZWRfX/CEsbQtc9Ne7
 ifXTYTlrYajCFNsAjix0lMgk8SkQRZYjNL+fsVtAGYqu8NNhZO7Q3a1Xk1sLOKvTQZUDDr1Lh7K
 j5vTB7UVWfdWHO3vDzXzZFEJOFr3ClPOnuvUPt1NX+zTY+CDMBQBuzTAB5YeQv7TfRtIrj7BnDH
 kgUs5L4vS1OXAB2K6N6pqR9VuwLQoIwJqIlsPM0EfyukyQIlIhQ/DFgABHI7JU6LCYpFucesDQB
 56wxJfFZW+ohjVf9oG0o9XxU2TqKJTumnR5knf4eWSrvKgVCYwSZTkll6sMavU1FkgTESZTtbCY
 DU0wkeYb0YF3TVa5zyDRSyD5yKNBNObhmc6Ehy024VZJS1NCkx11BKZUfsn+x33vban+XVSb1Zf
 zZk5MEhJo5NMzCz44Wg423uPEoOqZIzM4ZbjU0GtFZ+sS92/dCnQzyymyLL3nhHr5ym/iDaxLTk
 g30EtswkCYbivK+xbUw==
X-Proofpoint-ORIG-GUID: xz12k4xL-pX7QPp4Kx1NRAEIc5YlU__X
X-Proofpoint-GUID: xz12k4xL-pX7QPp4Kx1NRAEIc5YlU__X
X-Authority-Analysis: v=2.4 cv=YdiwJgRf c=1 sm=1 tr=0 ts=69946704 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=FlZS5g-ABFJi0eqNzBkA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-42749-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 27DE714C617
X-Rspamd-Action: no action

On 2/17/26 2:00 PM, Krzysztof Kozlowski wrote:
> Glymur and Kaanapali are codenames of Qualcomm SoCs, not acronyms.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

