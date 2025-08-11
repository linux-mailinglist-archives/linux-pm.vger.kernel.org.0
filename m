Return-Path: <linux-pm+bounces-32160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5F0B2053A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 12:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30DD17C385
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 10:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8123522A4DA;
	Mon, 11 Aug 2025 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QpAAKqbg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B71EF36B
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907881; cv=none; b=NmYCuUKkKiZWuqt5PmAR130bFy1Kl6z3OciRLqcHz5rlhDC7s9/CJ7aQ7wFlXt6ka6vWFjBpaPfFpWTgMbk469bfbrNMpDbopo6woKvOuOAblS40oBLbLkrbmh/ua+xspb8lfck8cHU0DwykIr6nKg+pUSnHkO18vrz8JAQXPZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907881; c=relaxed/simple;
	bh=Idy4XcMA5LlhLNDuASjp0sZOf5p6aefxiafLsNXwvG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayo2n1kFPHiaqeQcTDRbIk1TPFu3y61tr1S2KErAEJf6H1pvAfrop5jQgJZEri5gn+BK2g9cJ80eJ9Ut1kr6t23vjDcwi1h7nMPOm2he+cvsd4fR5HNz1YwDX/LNmzBRWcMbwDf/gmPVzKRVLb2OqGQy87RzaOTVFt9j9cxvlHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QpAAKqbg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BAGLPq024316
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 10:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4pAGJmR2f7v+hM4FOe0CvotdF0PXmkmvYERDFPHK8F4=; b=QpAAKqbgV8O3w6+H
	blMt/Dj3BYfL0JrnENL7tQiPikVaeB7D0ZC58sY6z36Dr/49EwD0EwajPLD+34wC
	kvJ7e+gJON8ZYRZUpv9k2BvGyN2CVlvBOPjkLMsm9QAWFTsPEEv7WspNxaZ6xgf7
	JCIxU8wyR7LVXKXI53jThbr1LlcwPDzwzH8+oPnb9UJZwWLJQNPH2686OZPlf7L5
	Iaz/iUlO2oELvlcNUMyd/XlLoi+ISAbWxhFy2R+Y0Qk06zH0S+YdQhUmt9/IrzD+
	mSZK8T3dz5Bm9L2hiEQ1/wJQyUzxeoBX0EnorCUhZvi9/Wt2Xjkb1jJdb6p9f8gq
	8evh0A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem480hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 10:24:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3211b736a11so9182951a91.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 03:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754907878; x=1755512678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pAGJmR2f7v+hM4FOe0CvotdF0PXmkmvYERDFPHK8F4=;
        b=vBKqxF5vUm2ojue+EZB0J3D/2d098yboJEfIGfLBJKgyAQirEga/8ZRAJyylB8MzY4
         YRB/SGXJ91CWL1VFN9JBfH4Hba565/fQorm98XShP1mMvY+yVt2QYUKnvlc23fuYfldw
         yXmr9spCFerSJT2dSnMOXcQHLgoUGVlodOhzHcm3Lh/dRcqN5EW+QyAaNXkfyNFJHloR
         4PouJfG/373qz7NftfBMgDm4EXcs9dch/dE8A5V/2i/uHMiXSz8ElRBBUZRbtQhxqSAA
         Yk47eZWKFgtn2Mz2DIZF5p7fhwPGztOnuY3KjKz6HlxVgiZqIOxN/a2NoDDnptnpg0pH
         xPew==
X-Forwarded-Encrypted: i=1; AJvYcCXmN8JmxC4e9gxghFG85ZALOe97nyHVHwDyxExH8Tpfe6a9ZC3qNZwHSgn13dJsy5AokAaR+AvTjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWzaA9vptSv3vzQ83ch5rEuPiKCKxHs1DkYx6kJ+d2PJMlSR6E
	lmtjEsCOdMoBP21P4o3lSwnbyUvIr7QqVZFSxelci4ztvEOdHjhyHkbCkcfgmXhAONxRoaozPFm
	rq4riX+qRmpbbBBJ0P5n/BYbnnHKf3qyF9tTzf69l2nxOBspnu14Iv/LW5taSUg==
X-Gm-Gg: ASbGncsrtYgKJf5SpcKTiyx9BskE5BMZa/3XRcycXZXzohnnQoIOwjGMh1frh/Ev98c
	UmJqXQP7FBIg8QbchEJJnBKgJGdKJKP1mK2XEeZMICqGybgpVDTJ8cRqclQuoW3XV+PhSGuqh8b
	Pm2bOlo1BGEWDE9Y8D3wRhPP8FdJrjVER9WOE0LRPzZFL76rGSYdCVghuGYLr/uuQ9UN7UYi0J3
	VBstqkR/DPS2lRiKIAeDAx4gjj2BErxZw4EOKSWtqzav8lO8BCKIqbTBD8L8lDVy/wrgJ/HTA2N
	iOZw3yJD088/lqfBhTLjld7w9ZvOlNYsR5uupZ9aCARcAL6XV3UAXHQOKmyZAvrZBL8+Z3AeTg=
	=
X-Received: by 2002:a05:6a20:3c8f:b0:23f:facd:5bc3 with SMTP id adf61e73a8af0-24055131e68mr17744504637.23.1754907877700;
        Mon, 11 Aug 2025 03:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjZkSDx/8+e1xEj0oO2axJzU+5A8J3EKcthnGd8UJEhVRSCo/y7+q7R8C8QxpEsYuccLMoTQ==
X-Received: by 2002:a05:6a20:3c8f:b0:23f:facd:5bc3 with SMTP id adf61e73a8af0-24055131e68mr17744473637.23.1754907877306;
        Mon, 11 Aug 2025 03:24:37 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4248f1d75dsm19304065a12.51.2025.08.11.03.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:24:36 -0700 (PDT)
Message-ID: <d73c5beb-fe00-428e-81d2-c67ed394fae9@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 15:54:30 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
 <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
 <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
 <7bac637b-9483-4341-91c0-e31d5c2f0ea3@oss.qualcomm.com>
 <20250801085628.7gdqycsggnqxdr67@vireshk-i7>
 <7f1393ab-5ae2-428a-92f8-3c8a5df02058@oss.qualcomm.com>
 <20250804111340.t62d4y2zg77rr3rp@vireshk-i7>
 <6035a961-7c5a-4fde-b4ea-e9ea9d88e6c1@oss.qualcomm.com>
 <20250811084453.ocibslv6kxkib6po@vireshk-i7>
 <8e67bfa0-e62c-4060-9ac4-de212ae63570@oss.qualcomm.com>
 <20250811101729.vwrtqg33lusk7h6p@vireshk-i7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250811101729.vwrtqg33lusk7h6p@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IcuFXKZsr2Qq7SZ6hqkZCDvS8ZWQW5D9
X-Proofpoint-ORIG-GUID: IcuFXKZsr2Qq7SZ6hqkZCDvS8ZWQW5D9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX3iwwpPSTLAXJ
 6VoCHjlqrlB+1tfWdjw6zKjpAb4nyg3TYNSibqlB6cGALgAPN8DmMP7Oc9gxP9JWGjDy5WwVxbE
 iBRE74VV8cTdPZnQ6tosGcZo+P+5lrTNMGsCIcijjKCW/ROw7rOPdyu6IEHRpZEVjvhQRdyALQE
 LnFoNs/oLOhvKcCKijb/6nazLn+BWE2TrJKin+zvuUM0SCxv/FN2QyST/oPazcDsqLuEjVdLAgp
 OuTi4vBZ2FYgZLHc6iKqR2nMt/lI891jWK/RlY8oNCcKOv9SAFnG27nhNPt4kUVX9BCld8tUwQg
 ztUlrS0UYo6bvF89qG2+/inMijSbujhyXjEC3eLx50AxtcWX/2KJmnMdDC3aM8OV3VoTZxVLKNa
 1rwB1xdk
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=6899c4e7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=n_ICUChmHomsGDmDg90A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068



On 8/11/2025 3:47 PM, Viresh Kumar wrote:
> On 11-08-25, 15:35, Krishna Chaitanya Chundru wrote:
>> Thanks Viresh for the suggestion. We will try this.
>> Can you confirm this is what you are expecting.
>>
>> dt change
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -2214,13 +2214,23 @@ opp-2500000 {
>>                                          opp-hz = /bits/ 64 <2500000>;
>>                                          required-opps =
>> <&rpmhpd_opp_low_svs>;
>>                                          opp-peak-kBps = <250000 1>;
>> +                                       opp-level = <1>;
>>                                  };
>>
>> -                               /* GEN 1 x2 and GEN 2 x1 */
>> +                               /* GEN 1 x2 */
>>                                  opp-5000000 {
>>                                          opp-hz = /bits/ 64 <5000000>;
>>                                          required-opps =
>> <&rpmhpd_opp_low_svs>;
>>                                          opp-peak-kBps = <500000 1>;
>> +                                       opp-level = <1>;
>> +                               };
>> +
>> +                               /* GEN 2 x1 */
>> +                               opp-5000000 {
> 
> The node-name has to be different, but freq can be same. Something
> like opp-5000000-N, where N = 1, 2, 3.
> 
>> +                                       opp-hz = /bits/ 64 <5000000>;
>> +                                       required-opps =
>> <&rpmhpd_opp_low_svs>;
>> +                                       opp-peak-kBps = <500000 1>;
>> +                                       opp-level = <2>;
>>                                  };
> 
>> And in the driver I need to have a change in OPP framework which
>> returns OPP based on both frequency and level something like
>> dev_pm_opp_find_level_freq_exact(struct device *dev,
>> unsigned int level, unsigned int freq);
> 
> I thought you wanted OPP based on freq and bandwidth ? But yeah, a new
> OPP API like: dev_pm_opp_find_key_exact(dev, *key);
> 
As we have can have same frequency entries we will select the OPP based
on the level. level will differentiate between different PCIe data rates.

Mani,
Can you check this once and confirm any issues from PCIe perspective.

- Krishna Chaitanya.
> where,
> 
> struct dev_pm_opp_key {
>          unsigned long *freq;
>          unsigned int *level;
>          unsigned int *bw;
> }
> 
> and match all non-NULL values only to begin with.
> 

