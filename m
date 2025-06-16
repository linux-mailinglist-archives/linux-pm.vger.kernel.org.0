Return-Path: <linux-pm+bounces-28834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D8ADB5F0
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 17:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA85188E15C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 15:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F4427FB19;
	Mon, 16 Jun 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YjXswM0i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0304263F2D
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089204; cv=none; b=DTMkv2LqUuNKdFPET3EhcnRFkVsJJqNaFpXoeHysoAy7FtQEaKqpbcRS98hb+Syrw0Gc7f1ECPpkZY2lBQ+gea1LLooF1kyzcRP5gTztNlK2KNQi0qX2xLMKc6328aXqFvJD40KWLUPQE+gfRYF5xbsYoYpUutLLI2b/TUuNE+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089204; c=relaxed/simple;
	bh=xe8kV5y3CWGlDnK3dNNThBhNLUjz9DxmDV86Vg2im7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmRVA3cCW9PkGlhoqlSJB4Q9jMljQJS+OvmodNKMRBghi1WNJPAUukvatmMvpBBw+XuEiiwS+EcpRk6s4GfSR4BD7tCIBUQCEG2aW6fPsOGxqYbKTKk68kMWk/PJZGXxHsSuOwDZANGA8ovuBoyEmyMgJuEivZeXoxKii2k8U0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YjXswM0i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8ohSw025769
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 15:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ls5lBrZa1Chnre4Poq+4r9uvpQzSemOb2h+RYlU45Y0=; b=YjXswM0iC/mXVieN
	JntauwXDL0Yu2WWS/tTdJieZzcK9Jsfu0rhDapgiisLOHCsvfNnpFjVMdSAYutZG
	3+kCinjzgQgseveOc6Cy9J062wHe+nG/oQmRrm2+smJK+d/3gXUWYk2N3ChJts8U
	6hh9TGiAWxtjdu4tvilSwi2xV/1L96Dd0DTqcRyfh4gfEFvvN3nnfjWNcbKaHlE8
	Ns5m5+Isl+qDNHK34gSPeEhQMYmWtpM+uT7KtHqesbu1xShK1q5ZG2sYr+SkA87d
	2kI7AZqmsc4jRisbRvhIgKERvM9ZDIHU9I1LbhCM2aeKMTIF0m04lYSzmbWn0ZF2
	mzEsvQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791crn24y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 15:53:21 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fafb2f0a33so64892046d6.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 08:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750089200; x=1750694000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls5lBrZa1Chnre4Poq+4r9uvpQzSemOb2h+RYlU45Y0=;
        b=VfSbOipl5iYSRCV826+MnEUiBF9A2nZ3cAB4tr/yfhjtrUUtNN9iuozQMxKXiihqMX
         Jf9dJrhhkIFN/GaMI7ijnt+1o5DlPOmgllxlecEgCapjHvjsYq3TXBvrgnKUp0jPUtGW
         yPsNhtFEM/kMUrYeAvfq3RUzvrFRDEJ8l0vURljBX6YN8RWVaOhCIRxZ5hr6Ni1crj3i
         bPbiY7sfzEvYVWjl+hyc110rl8Yg+w0XtGWuO5E3WB925AdzgOTpHYFWCfKr479akDNH
         NGWeNqeTYi4A+lCOCBZ64+cyKZcR9BerEYyuN0DAPZHCMNAnOK8Zva0s7bGgOk6ZmK7y
         bdNA==
X-Forwarded-Encrypted: i=1; AJvYcCXPysWL4QlKXqSIFWug+rjM53At2X3l0gh5cTEKD1TYktRulwapGZcKUmlgBPIS6AAEqTj9bytsXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLwzYjJa/NMTIJOx5AX+thFSB93V7GZRbC0pTQd1t+nA/UT+N8
	LL5OdklgCgaQ7HSCwAubfNkPmBQ8Zrb2wq+zJaMTEj0dxwnfxL8VyQbfbDWFG8bt0GpKuNesOUn
	YWo7d9/PwP3ZIPxh0Sfrj++17/wdQ8zZOXlqldIQE6yLk6/3mo9ot9Qz6DGrUIw==
X-Gm-Gg: ASbGncvRUjHCqTRXUPklLy7owOOX1biQhQoAElnh83Dc5esH6Atxoe2Rr9kChME5wZW
	XlC87QtibxBoypT7vysuiNruZSJIZjbR5B+DII3zzgKP09xPXLFsoVs5KN2r/c7q7Bby0fcMp/i
	Lq2TCb3A8WyJsOLWLr8b0L7KgG92WxKRkEtq5ZmLINd86AeGdwt0kZuIiprTUVMqdvOEYKKb9Ww
	99iFoMGVDF6d3/uHz3tz5SzfVelxVeU9RzRGs8BjU8tRcAYoBAyQFtbmBCVNVu7fGa0FqQvVlR8
	wErwxxXgqoZlMSaOV4X9+9Ihv7Ui2vqAHJlgxTpFrcFonIILxqwXmU1othJem8Sy+kP92NjmQ0D
	oBaUii4a+CrqCEFyCmF5YMkrJgOExjJ+gmPE65S6YeZ109cExOaQVW22UzYUzIoUvWcAHDvyquq
	0=
X-Received: by 2002:a05:6214:4589:b0:6fa:c81a:6229 with SMTP id 6a1803df08f44-6fb477a4fd7mr146959906d6.43.1750089200288;
        Mon, 16 Jun 2025 08:53:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9lFS4BlqFJWe80LkGYOUJy1z8hb3H4PDMo7stBR5xzLLNxsbI4MtjzfYuC4UMNrju/BVvSw==
X-Received: by 2002:a05:6214:4589:b0:6fa:c81a:6229 with SMTP id 6a1803df08f44-6fb477a4fd7mr146959496d6.43.1750089199802;
        Mon, 16 Jun 2025 08:53:19 -0700 (PDT)
Received: from ?IPV6:2001:14bb:a4:c3fb:c59f:e024:c669:a69b? (2001-14bb-a4-c3fb-c59f-e024-c669-a69b.rev.dnainternet.fi. [2001:14bb:a4:c3fb:c59f:e024:c669:a69b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1fcea3sm1587702e87.254.2025.06.16.08.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 08:53:18 -0700 (PDT)
Message-ID: <8af6ce19-7aa3-4fc7-a963-d8ab0cd22b02@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 18:53:16 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/28] interconnect: qcom: icc-rpmh: use NULL-terminated
 arrays and drop static IDs
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
 <786e3337-4c14-4281-932e-6a93aac53cf8@linaro.org>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <786e3337-4c14-4281-932e-6a93aac53cf8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wW88QeK7pQBqFu0tWSfRJJzkvfJBPBNe
X-Authority-Analysis: v=2.4 cv=BoedwZX5 c=1 sm=1 tr=0 ts=68503df1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=ksxQWNrZAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=_0zWR6m1PiBrtj89O7MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=l7WU34MJF0Z5EO9KEJC3:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: wW88QeK7pQBqFu0tWSfRJJzkvfJBPBNe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEwMyBTYWx0ZWRfX57qbCdCGpi0s
 czOI7WOuqQi1aZBHqSzC5XMEfhGEXr6tePAc4trxvJ+UZKpfL69Z27Bq9dwEHaLgxzM7Pbcb427
 XYJZNKZGvXjtmPgCAcYsLCaKThw3dXpxBlIFkRFMjFZXH1soUvAppfPtLIC4+J0JBXeoupXxNHr
 tZIB4PHHD2EVcw+4xmtChif6C94/pFSk0Q7XJdDLhR3pIpSHodGhVuwmv+5ycCoTtd6fWHGk8Rx
 wEoocSBPrjVPgl8pN+UIXCG6wytGlQJRLYerZY2K3iKWkVYAuQyDkqd/Y/CkJ2Y51FA9CmjA1Fv
 tX0uKlX23pnpoAWvUyaXUWa5NHumMMbVEihbpXSLmrOmD/b+wiPzWebO51eL/yPsGO1VmTJ4zM1
 RTdmQGIUyKG3mQip4dSFOBahXBJcJIJcEl+IGFKE16f6iher2fti7DwUtqTYLTvQZcaLlPrR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=912 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160103

On 16/06/2025 18:51, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 16/06/2025 02:28, Dmitry Baryshkov wrote:
>> Qualcomm interconnect code has been using .num_foo fields together with
>> the arrays embedded in the structure, which results in hard-to-notice
>> mistakes if .num_foo gets omitted or incorrect.
>>
>> Rework RPMh interconnect code to use NULL-terminated arrays for the
>> dynamic IDs case (as now all the arrays contain only pointers) and,
>> while we are at it, rework all the drivers to use dynamic IDs and drop
>> static IDs code.
>>
>> This series touches only RPMh interconnect drivers. Corresponding series
>> for RPM drivers will follow up shortly.
> 
> Can you specify on which base thie patchset applies ?
> 
> I tried v6.15, v6.16-rc1, v6.16-rc2, next-20250613 & next-20250616 and 
> they all fail to
> apply on patch 5.

I'm sorry, I forgot to mention 
https://lore.kernel.org/linux-arm-msm/20250613-sc7280-icc-pcie1-fix-v1-1-0b09813e3b09@radxa.com/ 


> 
> Thanks,
> Neil
> 
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>> Dmitry Baryshkov (28):
>>        interconnect: qcom: sc8280xp: specify num_links for qnm_a1noc_cfg
>>        interconnect: qcom: sc8180x: specify num_nodes
>>        interconnect: qcom: rpmh: make nodes a NULL_terminated array
>>        interconnect: qcom: rpmh: make link_nodes a NULL_terminated array
>>        interconnect: qcom: sc7280: convert to dynamic IDs
>>        interconnect: qcom: sc8180x: convert to dynamic IDs
>>        interconnect: qcom: sc8280xp: convert to dynamic IDs
>>        interconnect: qcom: sdm845: convert to dynamic IDs
>>        interconnect: qcom: sm8250: convert to dynamic IDs
>>        interconnect: qcom: x1e80100: convert to dynamic IDs
>>        interconnect: qcom: qcs615: convert to dynamic IDs
>>        interconnect: qcom: qcs8300: convert to dynamic IDs
>>        interconnect: qcom: qdu1000: convert to dynamic IDs
>>        interconnect: qcom: sar2130p: convert to dynamic IDs
>>        interconnect: qcom: sc7180: convert to dynamic IDs
>>        interconnect: qcom: sdm670: convert to dynamic IDs
>>        interconnect: qcom: sdx55: convert to dynamic IDs
>>        interconnect: qcom: sdx65: convert to dynamic IDs
>>        interconnect: qcom: sdx75: convert to dynamic IDs
>>        interconnect: qcom: sm6350: convert to dynamic IDs
>>        interconnect: qcom: sm7150: convert to dynamic IDs
>>        interconnect: qcom: sm8150: convert to dynamic IDs
>>        interconnect: qcom: sm8350: convert to dynamic IDs
>>        interconnect: qcom: sm8450: convert to dynamic IDs
>>        interconnect: qcom: sm8550: convert to dynamic IDs
>>        interconnect: qcom: sm8650: convert to dynamic IDs
>>        interconnect: qcom: sm8750: convert to dynamic IDs
>>        interconnect: qcom: icc-rpmh: drop support for non-dynamic IDS
>>
>>   drivers/interconnect/qcom/bcm-voter.c |    4 +-
>>   drivers/interconnect/qcom/icc-rpmh.c  |   20 +-
>>   drivers/interconnect/qcom/icc-rpmh.h  |   13 +-
>>   drivers/interconnect/qcom/qcs615.c    |  713 ++++++++-----------
>>   drivers/interconnect/qcom/qcs615.h    |  128 ----
>>   drivers/interconnect/qcom/qcs8300.c   |  911 +++++++++++-------------
>>   drivers/interconnect/qcom/qcs8300.h   |  177 -----
>>   drivers/interconnect/qcom/qdu1000.c   |  470 ++++++------
>>   drivers/interconnect/qcom/qdu1000.h   |   95 ---
>>   drivers/interconnect/qcom/sa8775p.c   |  493 ++++++-------
>>   drivers/interconnect/qcom/sar2130p.c  |  795 ++++++++-------------
>>   drivers/interconnect/qcom/sc7180.c    |  892 +++++++++++------------
>>   drivers/interconnect/qcom/sc7180.h    |  149 ----
>>   drivers/interconnect/qcom/sc7280.c    |  840 ++++++++++------------
>>   drivers/interconnect/qcom/sc7280.h    |  154 ----
>>   drivers/interconnect/qcom/sc8180x.c   | 1013 +++++++++++++-------------
>>   drivers/interconnect/qcom/sc8180x.h   |  179 -----
>>   drivers/interconnect/qcom/sc8280xp.c  | 1257 +++++++++++++++ 
>> +-----------------
>>   drivers/interconnect/qcom/sc8280xp.h  |  209 ------
>>   drivers/interconnect/qcom/sdm670.c    |  712 +++++++++----------
>>   drivers/interconnect/qcom/sdm670.h    |  128 ----
>>   drivers/interconnect/qcom/sdm845.c    |  986 ++++++++++++--------------
>>   drivers/interconnect/qcom/sdm845.h    |  140 ----
>>   drivers/interconnect/qcom/sdx55.c     |  611 ++++++++--------
>>   drivers/interconnect/qcom/sdx55.h     |   70 --
>>   drivers/interconnect/qcom/sdx65.c     |  577 +++++++--------
>>   drivers/interconnect/qcom/sdx65.h     |   65 --
>>   drivers/interconnect/qcom/sdx75.c     |  498 ++++++-------
>>   drivers/interconnect/qcom/sdx75.h     |   97 ---
>>   drivers/interconnect/qcom/sm6350.c    |  838 +++++++++++-----------
>>   drivers/interconnect/qcom/sm6350.h    |  139 ----
>>   drivers/interconnect/qcom/sm7150.c    |  860 +++++++++++-----------
>>   drivers/interconnect/qcom/sm7150.h    |  140 ----
>>   drivers/interconnect/qcom/sm8150.c    |  930 ++++++++++++------------
>>   drivers/interconnect/qcom/sm8150.h    |  152 ----
>>   drivers/interconnect/qcom/sm8250.c    |  977 ++++++++++++-------------
>>   drivers/interconnect/qcom/sm8250.h    |  168 -----
>>   drivers/interconnect/qcom/sm8350.c    |  901 ++++++++++++-----------
>>   drivers/interconnect/qcom/sm8350.h    |  158 -----
>>   drivers/interconnect/qcom/sm8450.c    |  823 ++++++++++-----------
>>   drivers/interconnect/qcom/sm8450.h    |  169 -----
>>   drivers/interconnect/qcom/sm8550.c    |  683 ++++++++----------
>>   drivers/interconnect/qcom/sm8550.h    |  138 ----
>>   drivers/interconnect/qcom/sm8650.c    |  713 ++++++++-----------
>>   drivers/interconnect/qcom/sm8650.h    |  144 ----
>>   drivers/interconnect/qcom/sm8750.c    |  779 ++++++++------------
>>   drivers/interconnect/qcom/x1e80100.c  |  819 ++++++++++-----------
>>   drivers/interconnect/qcom/x1e80100.h  |  192 -----
>>   48 files changed, 8655 insertions(+), 13464 deletions(-)
>> ---
>> base-commit: 410f15dcfe222c06f0d6379adec630061e88dc72
>> change-id: 20250613-rework-icc-0d3b7276a798
>>
>> Best regards,
> 


-- 
With best wishes
Dmitry

