Return-Path: <linux-pm+bounces-32677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB62B2D3DA
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 08:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094B51BA6C39
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 06:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA32741C9;
	Wed, 20 Aug 2025 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pORbeOdj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D624166E
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755669983; cv=none; b=roqUBTz4kVDtae1IRk08c1k+CGAzZoTI2EikqCG0t4PmyuWpMR9D2pYShUHBWbsgCKADEnOq0GhUcvmCKY6irP2KfXCbzXkEDF1aQgpeL53AFOu1kL5Sk0DLHtUC6TyBs77zDnbaB9mwfCW6o50gSau62afpty3xK6aozBfKazU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755669983; c=relaxed/simple;
	bh=OAYi4ydQnL8gJ7D3NaAl3MOZsDT1GK3ec/6XjP4fSxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRCuFJTNn/kRu3v7/QD4TTtIhwy4wQz9sv8fMMDZrUtKlpclCbO6s3HLrZjwwlansyRLtcMrGLdSF+V9mq5lPElqmFGHFEe+49aeJ5cVNdAtbhkdhrszgm/YS/JV7yaIZVdcsfQuZCDsquAiOomyUSpOpiGVrXPOlEidasPQAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pORbeOdj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1ocas024155
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 06:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	59SyR1NERy3Y1jC5JNhL4yeE7jcVGgkH9O11kosKuSk=; b=pORbeOdjKuCWzxmP
	Xj310mNvt6KzKO3evFW+U8qvLljVoOPgxbF5zC1UpP8TjN/0bRjQnc0kaIgcbl4O
	YVltmMNJIdmUKGQ9IOve9iA4D5rCB7wyqa/R9q8RaYcJJ3qIKy+YdkwYoRF5xjE+
	y2o1E8QbyXwb0sOid/GPtQd0aM5byxkH4DZLUKtxjiHRtQbenl3nU7OIA1vd1m7u
	tRL0LjrKdt6WDSz+jZr9gJH9CqSxHM7h+JlXnsiuDjwjUSoAUo7X9iuq1VhJj+Ho
	vPAGBvKwMHavRkBKyyqdRvIW+VEREZ4UX08uTs5Sphci2GpmB2Z3BfcLcf3JuEs2
	CQ7HmA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290k5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 06:06:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244581ce388so139516005ad.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 23:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755669980; x=1756274780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59SyR1NERy3Y1jC5JNhL4yeE7jcVGgkH9O11kosKuSk=;
        b=v7KOsyfhyf862K1/Z58e0Mwg8HssQId8CJj59WIjLXLUmpmNUpf+o7kRkA41fNMtxB
         0rqQVdte/yM6KaArIaK0YoLFGvwEf03+pbcsHAPNc56xXXkEN21fc+3yVJjUo2z5l0Vg
         hSm7Yh49t3Vvw9HD1a+W2CeOqa2F0orc1+Honekqqt1LS2lBYkrGoWTSRWwUBK7LK0Z4
         nsCX+ySldQ8wArtzlVf9oklokM+AcuhxacBOqQS1jpdW3inkmRGTSUIre5ac2lt+PUoZ
         z3WPFnbz9TEchO+piAPP/dNuhc0Pcswe+NWUGXeHHJB/VWJwa+PBoWDmHAVT9PkxAEsz
         FC3A==
X-Forwarded-Encrypted: i=1; AJvYcCU6povg3kGQfhbdvbyIQ7t4gxlDEFtdRgza5ptyvaWEwIawsYgLVXxk3TxCVTiPTYtMUIRfrv1EoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzO4NXepRtmk/kaYuvOCtUX+3drEp9xykWNZpi/OP4bn1oNPYea
	2C4AldGkUH/g44GERQ/pJj5snqD1DtDCqo+vZuAHdyV7mi42HPtEk0BQBwMs44adQ23XCcY+lRn
	TDLPk5aTOMPukmbLIN997QdTjIPXGZsUQKOTq2hN+q0RL9rOrKyqCMPyNosAoew==
X-Gm-Gg: ASbGncvX3ZCLQPU9QL92Q3Cbnw3BmnnAWNgqobZfNKKrFANNLdHypfs770gjNakHfQC
	5rU/b8boIPsKHUrXkZaEW8KNKYH20VRUeYddIcg1fKSrIOWLA/8PdInSV0nVJWmNe7AWMPMSn4v
	MdUFFgIQXmaNpqYYZrVoQUfb35w+YpeOT3gNc8eRNbz44V5chJHpSn0NwTJ/KVhMie5A46BSkNo
	nsjb8L4tLFqZ10D3s7a7e80TDXfmERHqQYU340WKx1BYP4OE066uSlDEKsqsk3vzHZ5h5BpV1u4
	toHORw1FwJLOkTjMAfpk3EVNRPKFxEhAwhuh488pMAkXphasyP3fxKj7AGQRQ5sCXLdO1KeCmH8
	zEJh7
X-Received: by 2002:a17:902:ec88:b0:240:a430:91d with SMTP id d9443c01a7336-245ef0d5915mr18789965ad.10.1755669980378;
        Tue, 19 Aug 2025 23:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYNnNUSwyVV4DO93t9r+GVSsYWrJggZoyswSr8zmZ7BeWtlIFh6WiE7AN8ne0wvDrWqtx+YQ==
X-Received: by 2002:a17:902:ec88:b0:240:a430:91d with SMTP id d9443c01a7336-245ef0d5915mr18789745ad.10.1755669979933;
        Tue, 19 Aug 2025 23:06:19 -0700 (PDT)
Received: from [10.218.15.248] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4ebc4esm15327645ad.115.2025.08.19.23.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 23:06:19 -0700 (PDT)
Message-ID: <73921d66-8258-4f82-95a8-f4e9fe8acc8e@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 11:36:15 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add interconnect support for Glymur SoC
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Mike Tipton <mike.tipton@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
References: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
 <7806e54a-4355-4173-91f7-8da98cbfeef2@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <7806e54a-4355-4173-91f7-8da98cbfeef2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a565dd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Q7FFX_n4-uy2H0W7qW8A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: pXL4DFF_SKJQwXmxECbM6InvoaDEE4Tm
X-Proofpoint-GUID: pXL4DFF_SKJQwXmxECbM6InvoaDEE4Tm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX0zK0d9xjKz5a
 s1AHLudoGIi96e9/qqAdZE+rthAJnqseW4nCuZcMIMOLYObZyOcu8n+QHrZTNETO30875z+DJUH
 UnvJSVnEBXW5Y/8d+S8u0i3ZRlPyeUGiawKdNi0EHQ1Ldm4ZFv+aF1wQdTSKZ58ONKatn7APfMI
 y+2Nry94Chal2FdfaS2NoYuR93zzoJeLYMXW9QxumATLu0EPGdf+LmNWeW37q1de1ACO0abn2YC
 aW1R8/8e2qBNM9pjCALivcqjAz7c9aXrX1nmmQclqiONmZFzcqggKJpkC5IsLnq3BTgbbIcWjGf
 VL7L/ka5+5k9mbi43pTMUjKycf9Yh0w3LpGwBAXDwn5pFPP/Ysv1CzJfdIIbW3oA/cdDl/EargV
 +ai6m4p5bX1KWuYeG+4uYfON1jL3XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/19/2025 7:22 PM, Krzysztof Kozlowski wrote:
> On 14/08/2025 16:54, Raviteja Laggyshetty wrote:
>> Add interconnect dt-bindings and driver support for
>> Qualcomm's next gen compute SoC - Glymur.
>> Device tree changes aren't part of this series and will be posted
>> separately after the official announcement of the Glymur SoC.
> 
> 
> No dependencies explained, so how maintainers can understand that they
> CANNOT apply this patch? :/
> 
> Nice example of throwing the code over the wall, does not matter it does
> not even pass standard checks...
> 

Sorry for the trouble, I have added dependencies using b4 prep
edit-deps option and I tried pulling few older changes using 
shazam command and found that it automatically pulls the dependencies
from prerequisite-patch present in cover letter.

I made sure that dt_binding_checks are passing with dependency picked
into workspace. In future patches, I will make sure to explicitly point 
out the dependency in the cover letter apart from adding it using b4 
options.
Sorry for breaking the dt checker.

Thanks,
Raviteja

> Best regards,
> Krzysztof


