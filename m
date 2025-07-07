Return-Path: <linux-pm+bounces-30285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E94AFB24B
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 13:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A423B647D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 11:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0F31FF1C7;
	Mon,  7 Jul 2025 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CV28eBDt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BCBFBF0
	for <linux-pm@vger.kernel.org>; Mon,  7 Jul 2025 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751887882; cv=none; b=F5K67AcF1Bh4e/L94rPc9F6jbtJ1muNX0jsqAdaBjfmwwhKkVl95oLViIZFFilbh/8FwkoUPWJRr4R3t4vqdEKv2myjxteTZYdd0EW7uf8tvr1L8xMXT2klQ1s8P+e4iO8ekx5hZBs24jyEqujRoSWWFZkVSNobjAXegm/9C3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751887882; c=relaxed/simple;
	bh=EHqNUQU89R3sore7iAI2H4xqVvujymPymPAR6GGY8Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fU1Dh5oOW5s5bq9Lc5NJitYNm8tDWNJVyaU9TEhvp4jJyGGy1wPTT8oe2zKRmVJskVGSdFge6905tg0cPTOXUdrDYh6fgR34i8m77WUPu0zez3kInWVjS0A8A0RyFwxMReHYE04SAydPVOMF8BfwWKZty78D9+539Jccv0HZHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CV28eBDt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5679L5fV018796
	for <linux-pm@vger.kernel.org>; Mon, 7 Jul 2025 11:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DWTeIruv+S7Tt3sFAKNHbEJ7BbFsYXgmX08CqCNfWkQ=; b=CV28eBDt1MmHCUvz
	9jfUSDayPh7r516Y9xM0ovaJvXwfZ78AeFUW87DjxUISO96qc4qOkzO/iS9hrR18
	9he3jmNF9p4jwQxpzHpsjGC2ZcTB5MpDLDnflcqdCtXonL50RWaFLMX3WrKMDLLb
	jl/3own5ZwFZk1Qp0c7NYX+nZMqiNwb71cIEa/wEheS1tTdSV5CJvYjmD/GA/aRr
	ATwdeekTIOwv4+tj8DwiYJgoo3w9/v8XNsYx5FDTzLYOZM3kzJ2LBD7jFLlpzJbz
	jPEoIn4XjnmGFEV1I3TNboGsm7xsVBSNTTzQuyS3v//hAW7shmIEf8cjgpwQwNQH
	PaMk2g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu0w4e83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 11:31:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fafb22f5daso9181986d6.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 04:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751887877; x=1752492677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWTeIruv+S7Tt3sFAKNHbEJ7BbFsYXgmX08CqCNfWkQ=;
        b=iuKaqIvSqHN2HAmtNbB4/wCApESbvWlaPP8Mxi6GZEEGWVd0CGI5z3Bgf1WzoB/Je6
         Ux02dvoTue4lTouZ0tQEiz3ADOpVG2gHrLUyUP1UJCoNTeZxiaPqjjdosBjqsxMQzS1K
         ZLDV8J/mRYYnLjLBM+aff7ixIEEYBmnIbKzzBJuNa3RlVPUFIOk68561Es4MQ1GNqphw
         7VkbgJCyb4Hy8eTwyv+qlEFYgWTkD8RNQfdJ2DA3K5zTY52I1retj7G8YHHcDE7lfW7k
         SittsXkvilhHMYYPp6g2TvFR5awSksOLVuofAxC/X4/eIM5zkVSYN9dDbbzhpOMnPCS0
         2hcw==
X-Forwarded-Encrypted: i=1; AJvYcCU0Fb54sOxMeIGIC6NQzxHZeTHjjJA+TKUXC7qS9z1w0SwKYbgE6deOiPgmr7qi73ogIvakrke+FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1LHG543dx1fyXsr3fqo9lIvZ7nogIg0Yb4n7uBqAqWePkUDd
	pEygKehduXvWk+HKDmmULOLAWksYYnrdKMgE8+qFUZA6c0w45riD1MMkEI1bfz4tWmWshqEPVOZ
	Vois/qGKBg/mTh2TXtvsJuVTWjeFr9NoIyZF/HLEotkRXwFy33CyrDamXJQBdOQ==
X-Gm-Gg: ASbGncuHgxLAAH/O8rSTMkWX2K9Saq5fRQqT07pipjE6EkPNRIlORmhICOOxTJXTY2P
	ZjFFjek78ouV90jXmzMsCaQ5+8GxD2uTMnt1OC1pkzwh6HFmfkPn4J0AiOekBon/b8QRa98soH8
	1gb5ro027qk8su89G6/vOwZu5GSYDid4276lx4H4oYKqbzEFF0TipgHQ+jobD9+uAGJZ6kDlhk4
	MwMu4MYBOz6HiHcI8ZxrhHJ2tJKERG6+0wBC/L3+l0ebVDSXXcahuhylbx3aivmEtmHslCnN3dq
	lnuKBM69e1p51M626rov2ky52R41p9cdSEfXEPf6HDxz+B2yk7/6Th7Y14vUplAZq8xkNnzYCp9
	W1rY=
X-Received: by 2002:a05:620a:440b:b0:7d4:5cdc:81e2 with SMTP id af79cd13be357-7d5ddc9bdd4mr594385885a.13.1751887876787;
        Mon, 07 Jul 2025 04:31:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpaw9CJeuBmYG3lV7sOgssLhggh0DGHOI8ZYixyktqQXpKdT92pvO9ZNob3HUzwHwWW0HtQg==
X-Received: by 2002:a05:620a:440b:b0:7d4:5cdc:81e2 with SMTP id af79cd13be357-7d5ddc9bdd4mr594383685a.13.1751887876211;
        Mon, 07 Jul 2025 04:31:16 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d93c8sm699187866b.11.2025.07.07.04.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 04:31:15 -0700 (PDT)
Message-ID: <f2793909-4210-4ea0-9f26-af03e0200c5b@oss.qualcomm.com>
Date: Mon, 7 Jul 2025 13:31:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pmdomain: qcom: rpmhpd: Add Milos power domains
To: Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
 <20250707-sm7635-rpmhpd-v2-2-b4aa37acb065@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250707-sm7635-rpmhpd-v2-2-b4aa37acb065@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XwRtWPqyDoaQhPn_NgTWi3h-B2aes9pn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA2NyBTYWx0ZWRfX0CeXoQFwTEiU
 rVxg9DNNtMMOWVyzCV2MdQTjgEtxZ9dcuxbyWCUO84wxXeFKp9DOw/ymFWC00SLtfcBcLbYSvrc
 eWK7beI8+tFMXFNFMMSXGHKxGbYHNRtIqJ+LJ24mFfKfB6TIll5PU9XF78rUQb4rGd/bXy5Nc+S
 /C5TR5ErOn0KTL+Cg1WhCUNVH3ekQj4xcb6KVgal/NrbDeFUvGgfEA3DztAOUifC8V40vXIvgX/
 VHWhdeUjFqsKVq4cJxWmia555XVcP+tDCBxAiDnA+H5yxe8IJHYlOsN5ET/9sYvunGr8KNDdaLI
 nprAyo5eNlX54TYs4HSZS80f/Vgw3xXdy6+VR5az8EOLAftXf/XhO5pwjur+M00PJBEbdIkv/K0
 i9j2wHg7rucs2fhECwoAstrp7uysDMCzXG0+4M9DdkJX/x/EhYhTQEG1VvxLkrgGetKrmgJS
X-Authority-Analysis: v=2.4 cv=Rd2QC0tv c=1 sm=1 tr=0 ts=686bb008 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=WWQFUNGd85j635JlVwcA:9 a=QEXdDO2ut3YA:10 a=AYr37p2UDEkA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: XwRtWPqyDoaQhPn_NgTWi3h-B2aes9pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=984 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070067

On 7/7/25 12:18 PM, Luca Weiss wrote:
> Add the power domains exposed by RPMH in the Qualcomm Milos platform.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

