Return-Path: <linux-pm+bounces-31847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B85F3B19B10
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 07:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372D918960E1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 05:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95718227B95;
	Mon,  4 Aug 2025 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CdcymQFK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87831EDA0E
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754285276; cv=none; b=HHryAMTRejedppsdeGXNSJl3jhsFgLGzPLRZDHLPkrTYHAgj/7a5UKxiJkTBBhFqbS7j7ChXsJ1/qYifUjX16YQ2syBHKw7OeiEXlBVzYkNJvsiZZXNT82WC1YtL/r6KNW+kqtQ+Nse5Ijhnq1ZzCIS0yYTcuEDNEyZRXWbrEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754285276; c=relaxed/simple;
	bh=d3vV/G7V0bmKXNL2Y3FLl7Y8dp8ScwXojkhO7m2tRd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FO9uQrioRdaKcqQfsD55eeMDXktjVWVBB/7D+OexKeJjyJwXTwKVed86ML5YbHmiISY9fApRgicGOzUi6WO2lBJD+F8LoayDqDywogz/gC/zODG4PFc2mfE05+MqbgF6HChffjwSJGFAlIrKYi4yEdkn2BbiBMXWMydyO3ssKAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CdcymQFK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573LqDVG023147
	for <linux-pm@vger.kernel.org>; Mon, 4 Aug 2025 05:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W9s+eOLRBJok7GgVWtOTJbi4U5/Xi5KKOqJ5sUFGyI8=; b=CdcymQFKdty4h4yQ
	AQZDqhRoUpyFGqgT1H0hGk1Xp2hS599VBIIMQzFKYPQkYCF7ctPiO8CcA2QJP+YC
	dJygHwdRW1+0s28cTIXGDgUTXL+e2G3rwSqN8BhIphHj3R50dFnvELaWmMAFIl7k
	W0YeZ7TtM7+wScvN2kv6KlyTXuq2MLnktMPUx23mWDVlWquDmKJiDGrMVNJ4VVcn
	gbqe+gIV/jzYp+ZNru2Lt8toHZJ/3OcNwE86T4PJIhphcbIx7X0pzwJ9F83On8N0
	Rn2RaA8uDwmcsJjx9P1FzuHo7OrgqfZ06dGEXgIKy/khWPPIBMln/k0rKFYzYLkO
	WWdLxw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489arwkjun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 05:27:53 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76bd2543889so4642400b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 03 Aug 2025 22:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754285272; x=1754890072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9s+eOLRBJok7GgVWtOTJbi4U5/Xi5KKOqJ5sUFGyI8=;
        b=QPG2eu62tzekOoC/yiMuk9c+szuvyLSnVoR0yydMQlTWeTgttFBSZPEnOFqUcSKzVC
         90s+evZmCfSlCSy9LWKkl8WpNjMQYdJn36EoWiCOUBAmlCZjrM72CEN7b+ciE6l4gf64
         X7cFCG5I7wKltfntuzwEPk1nww7sP4LOuGSUy9k4mkdWV2zc9JSBxfZPuWodnY61LahR
         DLhNGiV1zxcuzV92sw5AcuC0W13bajkzVFf0KpB7jCirV9n0C6spcdG+b9BAl18V0QDG
         tayJy7NF7rV0MoJgTPd+Ltatwf0cqu67Ad1b0V0QXYgruiOpKdZh5g7Gk5zZcIyAiAAW
         G5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEGZE01n/oFXO/nTumF4QKCqiWTzniPUgv912iiKQx7ML7hHvhQWj4m03DuB/3qj2XPZwNufzRSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI4dcOqemZRz5NMQsmzGUrF1Qbx4J7btoSRIOG9PaknjPtpVDX
	C+bgnJfBQhuiDGt2ODDKDP3V7WTccO+fBQPL7B2ryvHfieESqWKMKNWAR6QEXSOu2Nl7I4f1DQO
	lCf41e5ZFFsQ/Q5PveWUVtRz3jPExmOUnwwgaLVb1z3YSclNR1InhxXLBaTZWAw==
X-Gm-Gg: ASbGncu91FTjGZX3Vy31Hsla/9Yfve1e44zc/4AZD1P+FyhCciTBqM33awh8ANEt1vE
	YTS018BrDRvtKYdGCJQI0kUg+oo/yYz3bvj0jNIGbBzMwNMtAXYI9UTlnvy8QgyWvMFRHMlJzi3
	kZ/Ifn2HEfsUIO+y95419FehCyYAGPywLLmhkVRtlytqLW8t+P7n5vblY9Z55/q+QPHCGZVPBW3
	IzKzdrRQgPQzYrHqwqtGS68bwYw9MZmOXrW65mnCaqI2gG+LYZIoWGSAKStptb11Zv03cZidK3M
	uLw3eaUn2Gm8/6aMjmr3ENlom22Eg3n9Uyljjca1OVctME9UAPt7RQOtpnF49HviY9KixlF2EXH
	dXrRJ
X-Received: by 2002:a05:6a00:230b:b0:76b:fd9d:8524 with SMTP id d2e1a72fcca58-76bfd9d884fmr5176291b3a.2.1754285272506;
        Sun, 03 Aug 2025 22:27:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOqPaYvNvCPBWN9SHhU6yFEpBm5CLiD/SABKYbt05bxK4+KJDWsmPyz6/DFC4jUVaiYKvL/w==
X-Received: by 2002:a05:6a00:230b:b0:76b:fd9d:8524 with SMTP id d2e1a72fcca58-76bfd9d884fmr5176275b3a.2.1754285272044;
        Sun, 03 Aug 2025 22:27:52 -0700 (PDT)
Received: from [10.218.15.248] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f6bfsm9523318b3a.23.2025.08.03.22.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 22:27:51 -0700 (PDT)
Message-ID: <04687e3a-5761-4d1c-bece-fcc2241f0c28@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 10:57:34 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcs615: Add OSM l3 interconnect
 provider node and CPU OPP tables to scale DDR/L3
To: Imran Shaik <quic_imrashai@quicinc.com>,
        Georgi Djakov
 <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar
 <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804050542.100806-1-raviteja.laggyshetty@oss.qualcomm.com>
 <20250804050542.100806-3-raviteja.laggyshetty@oss.qualcomm.com>
 <a9d9f421-1bde-4609-81db-b139952bfd3d@quicinc.com>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <a9d9f421-1bde-4609-81db-b139952bfd3d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAyNiBTYWx0ZWRfX0XXFMU8rjT5q
 sULstaIDMtuRcTvl4hZCFOxw+eJhbHpSydyk0rGWnAOjEZgxZ/dw0hubYam8q5fJbgC72T4EISM
 8HvtbgE9hgWgK3O6BsY1+eujM4iwsRGWKNhdlNsiBRwG4wD3rxc20KEa517xH3myMcz1AW3LfpH
 UWI4cJwo1qPa36+CdBm30C8QAcVe45r1pysZDYSUR8WWXqXhA5sY/e9Nd/MV2nebC0yjO3RID/K
 9qIpacYYeQYvzxpEiY6jy7nU0yp9/vFlZ2/UWGKQMZ0t0tCcvzZ9kJ5Mtlb57k/rVGQ0mTk538g
 XVJNdCwMPmMpwyD1eZC+AtmKAVEvGg5Vuiej0fwFXlZT6b1r3Ehbif7DEbtnig+nQPw7hhvqVes
 Lb4An6mkvSEv4mQ7wjaMqpbf2wLajLgMqRUk0PyuC7aUGLf70qn7dxqSyJEw3HTgDKb5Geaw
X-Authority-Analysis: v=2.4 cv=We8Ma1hX c=1 sm=1 tr=0 ts=689044d9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=3QpX9JWOmuBQJw_HQg4A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VZh4WY1leLcQGkZbxzoPtkLMs9iZb-m4
X-Proofpoint-ORIG-GUID: VZh4WY1leLcQGkZbxzoPtkLMs9iZb-m4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=885 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040026



On 8/4/2025 10:56 AM, Imran Shaik wrote:
> 
> 
> On 8/4/2025 10:35 AM, Raviteja Laggyshetty wrote:
>> Add Operation State Manager (OSM) L3 interconnect provide node and OPP
>> tables required to scale DDR and L3 per freq-domain on QCS615 SoC.
>> As QCS615 and SM8150 SoCs have same OSM hardware, added SM8150
>> compatible as fallback for QCS615 OSM device node.
>>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 148 +++++++++++++++++++++++++++
>>  1 file changed, 148 insertions(+)
>>
> 
> This patch is functionally depends on cpufreq-w node change [1].
> 
> [1] https://lore.kernel.org/all/20250702-qcs615-mm-cpu-dt-v4-v5-3-df24896cbb26@quicinc.com/
> 
> Raviteja, As discussed, please mark the dependency on this change.

Sure, I will add dependency and post V2. 

Thanks,
Raviteja

> 
> Thanks,
> Imran
T


