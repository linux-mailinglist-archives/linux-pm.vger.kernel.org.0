Return-Path: <linux-pm+bounces-26006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BDAA97F28
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 08:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9452E17AE56
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 06:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23706266B62;
	Wed, 23 Apr 2025 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="amOuxyhc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC5A95E;
	Wed, 23 Apr 2025 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389721; cv=none; b=i0PQbJklyEMFpSFEGYVwcX73howizlE5j19Z0mXh7CuBFuBasvnBBezsyB9U89JdQ4U57IIf6lEsPSy1/FDcGR5F6c3zoyNTiP7LShxhvfOoTYSGG6vuDBfQECn+rXAb8B+2NycecBGvCfZAS+6hoGyg+23qkGpQqcuA/yc/cyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389721; c=relaxed/simple;
	bh=WDYlnT1pVakmNI/GWTpsN6Uo55Yfh7hzS3h+/RSVzd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OMepCxvh1nwp0FJ2yzmiOX0zoWMbejHwBRVXVldjnUtncOIcRJ27qXgCxlS0eTnAM31wM6J/uDynU594a5j2VVQUJek1UpYYZSk3oz5cKdLa8GEpuVUwdjUgqE/X5+iaJlQsxBgu1xJTYPP28YFDU3WJ8eAtMn3UoKEyXd0AeEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=amOuxyhc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0iA2t016256;
	Wed, 23 Apr 2025 06:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WDYlnT1pVakmNI/GWTpsN6Uo55Yfh7hzS3h+/RSVzd8=; b=amOuxyhcNMyVBEG5
	aaCM9VqxPA7ifN/DAFV9EgBwzRozNymZX2NDfuJbZ3MZUqVCkwYbYqJ/rB8XffVe
	3A8bOlvRjaDpxVkGSjrY4WjiXyP7MU39aMyx+Wxrc/5cM2Ua1lAMKEt+QHJxt789
	P7gbytmoebVxowK4O2QQ8hSL5jm+ieJn2ONtgButI0pBfvUH5FYbGpvnzHLCAccL
	BpFkTYFlaIhws2lS1Ln+GbQM1wS2iZrmzHur2jE8hEGZAgfo+RLxBdqf3N5OOL5e
	v+KFN3f9kfzO1a2ZY3zv3jMobEdt4qiVaJH4auY2MoFstEZR1Eq/PRfZtt1AM6MO
	NixD+Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3h32h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 06:28:26 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53N6SPnk011165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 06:28:25 GMT
Received: from [10.216.54.177] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Apr
 2025 23:28:18 -0700
Message-ID: <66e30117-3944-4731-955e-62d1c78ff456@quicinc.com>
Date: Wed, 23 Apr 2025 11:58:15 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] opp: add new helper API dev_pm_opp_set_level()
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd
	<sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <psodagud@quicinc.com>,
        <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>,
        Nikunj Kela <quic_nkela@quicinc.com>
References: <20250418151235.27787-1-quic_ptalari@quicinc.com>
 <20250418151235.27787-2-quic_ptalari@quicinc.com>
 <20250421074004.yttb42qq4p5xzi3o@vireshk-i7>
 <e6e1ee6d-a12f-4e18-b2d7-65d1ccca5308@quicinc.com>
 <20250423053605.63njjtz3s3krdeqb@vireshk-i7>
Content-Language: en-US
From: Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <20250423053605.63njjtz3s3krdeqb@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gX7GzNgdLmcAW09nUkWLVsUPSpZAx8If
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA0MSBTYWx0ZWRfX6GKgVV7QNeZ8 S+/VCHHKLqFmG+t6hpmAN5tKYxvQpCCoXLLeSMHM7n91rjkwki9Am8wqqVt8Jol/s8XEpGWc3lj UXF6OnDVwFFC8Kl8K4zXxW3uD/pi9CGEdz98iHyiF+DcXH5O7VJ57lkXipptUld4fsCe65GSEW2
 m2DQh+apYruIx9qIhk/YgLefus4b0cz38zMMxmLjqaPDmx05+DAhkU4he0PFy14IfEaUhyGU+Mn oo+x7gRiPAmNq5QyGRbBJuja9KrocV4pbma+36Ij50Rlpq9LHQse8nAiAiFb8O3rmbazmZK1wPt xoep1L/UjLUV+/UdUU6B6Jr3i572d7b9dtiXY25KFsXN0z/3gd7PGyH7WNgRVjQn9WQbgmkSFsa
 CEsZ0RSq1xcJSFi9pOaRv/mdZKvmS0H6QynTGC0iso4hrILfj6M4lBh19a+u/2p0JkYxOzML
X-Authority-Analysis: v=2.4 cv=ELgG00ZC c=1 sm=1 tr=0 ts=6808888a cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VUDmVVODwOu91iT8A_oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gX7GzNgdLmcAW09nUkWLVsUPSpZAx8If
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_03,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230041

Hi Viresh

Thank you for reviewing.

On 4/23/2025 11:06 AM, Viresh Kumar wrote:
> On 22-04-25, 22:37, Praveen Talari wrote:
>> most of helper APIs in core.c and even i don't see any helper API in
>> pm_opp.c.
> This is more of a wrapper over the existing C routines which is being
> added to reduce some boilerplate code from drivers. And so it makes
> sense to add this as an inline helper. May be there are others which
> can be moved too.
i agree and move to pm_opp.h. Will update in next
>
>> as reference of APIs in core.c, i have used  -EINVAl instead of IS_ERR(opp).
> That would likely be wrong, maybe we should fix those too.
Ok i will update as per if statement check for return as well.
>

