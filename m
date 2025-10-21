Return-Path: <linux-pm+bounces-36535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1952BF4562
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 03:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3483218A7961
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 01:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FAC25D527;
	Tue, 21 Oct 2025 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JXBsHQWP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708CF25A2BB
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 01:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011923; cv=none; b=hupyjfgv1JwR0cdIHfdmZmfZi6ijDzap8qLReji04CpGlJpQwGVHhj4hWfNq1vT8FIK+Hd8F1mia58A2oDyPPDRRTmkERykFOwhVNhSoJr81PEtV7Mbi0zOAsJg759Op76sPiJi+t0Q5MuTAPQ8JR6suSz/mstxnVU/KMr/+grg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011923; c=relaxed/simple;
	bh=TaJ6Kpu5C42O4zfV+T1Ms1+yf77uSZazTk3VhrzJq24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bs0EO1axQ6MMIfBKD2id3ZCpaOeGKVC3q6zblmuECjzeL5MU/nx/Bp6sbN532vP2SFeWYa5UZK6vvZtOFelnz9KGCDJJbaGUFBQeh6Jk4o40Cr62Tve/Clk6qb029dSTQ2CLge5iDGPYuGdOThVDcqLLu/7D7FZB91EJBYbNio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JXBsHQWP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KL10Rh031133
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 01:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TGwpn8/U0jGDBsJ9vOkeOjiPiuDIq8W2qVCHqYYf6sc=; b=JXBsHQWP/qTEPR9F
	aj4n17ekAa9v3b3yCN3CLVOyV9Y3CFau8yYJ5UxGlaWaVCHIzJUZiNECUDH8uvfu
	NMfAHF7EddZz90C3hfNCc8AQxdeBEKSapbVXxF4TZlUQJifc4T1/edYz/UyUh1q5
	DRcydR/YamYHAJfLAjN1BwAgctF90VM8+41EECsk8Nozpv15KDy0lkJ8/1hpOVMZ
	vdGudTmveBsuKN/2trnGZvx4tU0N2thLNudNnyl4xj3eBse5VjcHYb4juEZPJoEc
	UpaomhHCr7Tnfi5Qg8pm9w4Uoeqk9iCTeFQUVZdrEjFORLuikPu3z++4sGr48i/m
	DmFi2Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42k6mv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 01:58:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-286a252bfbfso134374065ad.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 18:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761011921; x=1761616721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGwpn8/U0jGDBsJ9vOkeOjiPiuDIq8W2qVCHqYYf6sc=;
        b=p1B1DZF9suiDI8DUzPVz7T1h1aWH8mzo2/d2TCwrwFPlGctzUqZH6bLsN1H1tA5NOf
         Q2pWw4ERoSAeuny8UMgj9yyc9/SAJ8ZTMiiZtTdsenoUOrZ3gszdK4EONVeGR7f9y2wk
         4RgdaM+EPie0HpyuCedjyhl6R4DfYg2mdxygzS1CvV5qN0JIwohkQskui3plFEpmEnwE
         kje1nxqb2oWFqfWtCh/iUKVb+oHiiHX+yA8MV5VyrNokLV9tEgJiDv8hjxhAauqtIxdZ
         /WSheiI5ZCuj+jkRjQ0V1+aL+jZRuKvIR5FrbcVXLQPMYBkow4U7Mk5wyAFB8uP+bTv7
         edYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJCN4xCfC5UteXuuy9YM+UQF1QNF7QCFLNwoiII9srEDP2wcJrYswei2GX6KmLqW0itTANzNemaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXjKmitikpJR6HYHs5vfX/uvU9c0UeX57B6ifu2qj2rQkD3Ilq
	3jLv8zbILSYzcYZmcBkPd3yOzyoy+SY58mI2nO1pOO+RXmFtOmLIDTV97//qVotkEz8KSjcbx/+
	D8MlVUKAfYYgoFZn6FzrRe2FVInApjlUz1/u3TwwKzDRRhUMGqLsOeN1GNFB3mA==
X-Gm-Gg: ASbGnctrlepdaAZwP1W83aGXMB7AgV4yxoQFS/rbycq6IdnzFlJ9B2y/1KYTXIl2qSo
	5bZ57tvTeZiWSmgjyLfdjvMzW6OWFRqp0DolAF7HxpnnD3J2J4d2MuFfASvgur04fkxkH3SIVQe
	ST7XwoMUj2Ln/mcrCDYZGFDSaWrqDbzzOdr1yr0ntq59hb6nbogwRhsTkN79rkUe+LLt6ZLsbcw
	+H52oPOdaZXj4Wbw8FPvk39ZsJu9O25bJZS6POaRQ3LEaHIj/03GQVh22zPl1XFwK7O9s8n0Trf
	vB8Zy2dBjbXVo0u5dUAW8cZsPlicYRXZlIKnvFSSNE8I/b4Is7tlEc8CzQGDjTm64AyTUd9FmSJ
	G6p+CQVl34Khq0EYSVPVDCeiC49D3IjDBSFf+aotJVh0tORTaDPS4YXlk8GnwExdoYNq3fHKi
X-Received: by 2002:a17:902:eccb:b0:278:9051:8e9c with SMTP id d9443c01a7336-290cb07a023mr215059315ad.42.1761011920717;
        Mon, 20 Oct 2025 18:58:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTGO8LNhqSw5LRNEv7/Nl+bkPzCeoLUOMnBS6Q0IAq/GhPgb1srkEd6w74xcF3soP78u6rQQ==
X-Received: by 2002:a17:902:eccb:b0:278:9051:8e9c with SMTP id d9443c01a7336-290cb07a023mr215058935ad.42.1761011920307;
        Mon, 20 Oct 2025 18:58:40 -0700 (PDT)
Received: from ?IPV6:2405:201:c416:5052:e167:a6da:f5f1:b45? ([2405:201:c416:5052:e167:a6da:f5f1:b45])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec20a4sm93752155ad.7.2025.10.20.18.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 18:58:39 -0700 (PDT)
Message-ID: <766890b0-099c-42e0-971c-cc94114c0d7a@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 07:28:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Kaanapali SoC
To: Eugen Hristev <eugen.hristev@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Georgi Djakov
 <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
 <20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com>
 <ea291acc-bfdc-4a04-ba60-fc59a55ada28@linaro.org>
 <f4e7a388-54fd-42a7-8960-be6a3de7ec6a@oss.qualcomm.com>
 <70569fdf-7a3a-495a-b1ca-d35ae1963592@oss.qualcomm.com>
 <f5c5254c-537e-46ad-a7cb-a8b18b07632c@linaro.org>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <f5c5254c-537e-46ad-a7cb-a8b18b07632c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ggw5MWwLdeAhLz0RtUtZVggHkQzAFtiz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX0lmKvsLonhz4
 tCjsOQvyFs+PlGpEkFK8mMVaKz7+L/jK2fcSRfsRv5ybT+2f0/ORLQRuB6egIXzK2+uB1G2BcPK
 wunfsQ73XejJLgGhfbryYmPju1ZZDYwpBSHTP5ukADFDW4J/IT3QWuwsvmEi/VW+4/pim1pE9py
 rthl3EpkZPAxLrkVdrRcWgm0VFzGSF0dkTYs6fCCguGSy5rhwo+MsyZbGuJ4RQzwkSfXL/DqxfZ
 ls/TlvGkHTi8xjc9T+J/wmuwAQK/FQIszR8FD5+TRpIFuFO+xrjjON/Eklk8v6G7dlh8nAm+k9u
 XTORKAN26LVciLjPzPkPdkEA0rGbZEI7knYRDZd0lCN7SKUG+jYsz7/S3ytr9rUuQsLrWbFo/+D
 /q9O3gIr18ZFg9CxwgkB796grN0x4A==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f6e8d1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=lx9-Q6l9dX336bKDy7QA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: ggw5MWwLdeAhLz0RtUtZVggHkQzAFtiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031



On 9/30/2025 3:27 PM, Eugen Hristev wrote:
> 
> 
> On 9/30/25 06:06, Raviteja Laggyshetty wrote:
>>
>>
>> On 9/25/2025 6:10 PM, Konrad Dybcio wrote:
>>> On 9/25/25 10:57 AM, Eugen Hristev wrote:
>>>>
>>>>
>>>> On 9/25/25 02:02, Jingyi Wang wrote:
>>>>> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>>>>>
>>>>> Document the RPMh Network-On-Chip Interconnect of the Kaanapali platform.
>>>>>
>>>>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>>>> ---
>>>
>>> [...]
>>>
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - qcom,kaanapali-aggre-noc
>>>>
>>>> Hi,
>>>>
>>>> Does Kaanapali have a single aggre node, or there are several ?
>>>> On previous SoC, I see there are two (aggre1 and aggre2).
>>>> Also in your driver (second patch), I notice aggre1_noc and aggre2_noc .
>>>> It would make sense to accurately describe here the hardware.
>>>
>>> They're physically separate
>>>
>> Yes, they are physically separate but the topology treats them as a single noc
>> with two slave connections to system noc which you have noticed in the topology file.
> 
> Is it any difference from previous sm8750 where there are two nodes ?
> If yes, can you mention the difference and reasoning for merging them
> into a single node.
> If no, can you reason why the decision to merge them into a single node
> this time instead of keeping it consistent ?
>This is due to HW design issue.
qxm_crypto port is on aggre1_noc and it's qos config is in aggre2_noc. Since
aggre1_noc and aggre2_noc are separate devices they can not access intra address
space. To access qxm_crypto qos combined agree1_noc, aggre2_noc into aggre_noc.

Thanks,
Raviteja.

>>
>> Thanks,
>> Raviteja.
>>
>>> Konrad
> 



