Return-Path: <linux-pm+bounces-31080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08BBB0AC1B
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 00:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89344AA6DA1
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 22:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A787221F26;
	Fri, 18 Jul 2025 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BoIyU7b3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888E17CA17
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752877074; cv=none; b=SVdf/DmqXnY+TNeJcvkecS6hJovgr2SSSf5OYXAgTf6d8iJiDCw7Ar2B7/1f/wLptPNQ2zRsLC4ZorHp1z9CfOaJaQLVXFYeXUfd3Px9xAK1XZfVaOERHP7Pgh8WA0qkZL2R6vaBpuTcTpSPPlA6YLAxeOfQ6MbMEsur3y1AeM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752877074; c=relaxed/simple;
	bh=gYaUQ/510T9arEarBG/9EIkUrk4nlQseoKIqq2zvOu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ML/7RTBxxhJNlabObLjd1zHLdDoRB8tt/9pcXBm6SsaoFe1PDzXjLRu6pzWL0uhebu4vn/pceAJmxYpW2sRMZOlkxvjT2MHoV7t8g80UuvLFLyrJlkrePsnlPqLCN9bYh0h5Wj2y/JO4GTby3csOBjCCfXMsfNoMjNDhRpQycVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BoIyU7b3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IGKhWw032260
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 22:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0RQn3Hr+L8e3KUR0zmvMetsQjNiIYpQFjrWjwmHgudE=; b=BoIyU7b3i8+sBltK
	SQlaxEUoDNR/JlE+4IWz7MRYH1q71UfnViZMMVo+wa/SnXbrq4S5/SK9x47ofBkG
	eWdQex5WRVsxMW/sKd5cxYY4A4eXqoXmJsQ77Ab/9sbvl1RmJekEkJ7I8Civ1VPt
	7NFrElffpOEc32+JAyRzl89oA3jJALbMauXZX7u2jeyIUpP62pOa3m9LJ1l51uNU
	MgkIRbVUa61WrVuwIYy2c0b26xETu8meG1wW4csuffqAWMMtKFoFs6t5KRAuM3qT
	BVqZG4MD/DROULYjB4ml4k4R22/XjaSvmWWoGix+b881HqBNnSJryxVgIezi1Hbf
	jvxjAA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug38d7wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 22:17:51 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fb030f541bso8270586d6.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 15:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752877070; x=1753481870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RQn3Hr+L8e3KUR0zmvMetsQjNiIYpQFjrWjwmHgudE=;
        b=NkSBsxiD0z1gyei2a5y9Y20b0KZS6dQsiLLVNMpuZT0XtfpaiicDfFwt8r037zLFBJ
         Ghy0sEJt7JkVUwHgQis0mV5TKVElkqGewdklEgTbQwoecr6hZ6pWedx5GyNR/J3ohT6F
         7prXwal2E+4bBdixf/g7SHAiCSTfb79kWHKvPrbjsJMCkvjIqRXxGh/5c0qMOQy577TR
         5XWyCn1qSAj1esKEjKzFrozGnOPBi+FaCAA8PzBO7aZboKftgVryz2uywZfL9oRZeI2o
         1IiC1FoODmubvkkmcePF9kxMpkgS0fLEsCbfag2JY5FBQIuffmB89jlIhHkW1GSTPFa6
         LEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYfqOESO6H0QysCi4bbdo365jaqD7mVvp5mVk/28Zl7ZK5yP8N76s2zgrKFVmabyMCWfAHmLqHYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5hihR4U+aavHAH/bWm7u/CilXeEXmmBmrkp8Ldn6QQFFp6Qf
	zIMhVa4SxANgxgh2v6HVAkJNVtMmmTOuO3yMMhQvGBMbNi94OtAgJnx+SPO5itIUVQ85mS0NAM0
	5uO9FmebWysEW2m8kfjRSmTMt4wmd6SmgfrJQ2FeiYQ+NvOqAh2KY0Zxl/P45DA==
X-Gm-Gg: ASbGncvShfUV19Pme5dVEami3KQUJGEh73o734qkzqV8bafYspv0BuTpStXkDTps/Vq
	YG2GR40YqzupCABp2XK+0wu4vdb6PyUkZiaXEZ7lh1mXaFxRGZSkPqXRibIV93tSwJ9evgEwdee
	Tt+bF3RvBVn+z6WhyQ8wRO4bsYN2lg+RZn24tCcfm0zv8F7npJF1+t/b+1sYrbmYK4htoxYh/hC
	kEE4A6om7iBLmr3kU7m9cj8hLAK5X4rQOtcoaC0/duEcwuJpIvdTS88n81O0vmcB5391j3taHgC
	G+3ysQyY30d8Zaf7Yp53UB0HiJpNMvH38rKfr3M7H+Q6VMUChQ31CT61LEsdTbvXfV/I6OX8ecw
	joTY4TYhbWsJAWW29LBmH
X-Received: by 2002:a05:620a:3907:b0:7e3:3357:3dc with SMTP id af79cd13be357-7e342b693dfmr818715285a.12.1752877070524;
        Fri, 18 Jul 2025 15:17:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExXb+GPDMiphUZIbB3RMlhp/AKQQZhzdoIKBhChXGFZUoa3SwiJ/PxCIpW/KcetK4sODN0wg==
X-Received: by 2002:a05:620a:3907:b0:7e3:3357:3dc with SMTP id af79cd13be357-7e342b693dfmr818713985a.12.1752877070041;
        Fri, 18 Jul 2025 15:17:50 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7bc78sm192207666b.113.2025.07.18.15.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 15:17:49 -0700 (PDT)
Message-ID: <a2b837f8-eb34-4283-8d7c-17031a7a682b@oss.qualcomm.com>
Date: Sat, 19 Jul 2025 00:17:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/28] interconnect: qcom: rpmh: make nodes a
 NULL_terminated array
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
 <20250704-rework-icc-v2-3-875fac996ef5@oss.qualcomm.com>
 <859be3e3-be14-411d-b5ef-07bdad91a878@kernel.org>
 <efvyk4ojddr3emsdavex4uqrl476sj5hz3ihd6kditdxd373jm@wu2av4fvqc4h>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <efvyk4ojddr3emsdavex4uqrl476sj5hz3ihd6kditdxd373jm@wu2av4fvqc4h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE4MiBTYWx0ZWRfX3oFm4U7IBW8d
 4WMoBPAVzVDQYKb++zFuFufLT0Fy8DdbY2UebAvrv5umZBJJQNA+1CK3JeNkCVtAI6EJjNTzdcc
 PMANgD6LthN8wEN1EQHH+zEBiV6ZNwVO57h6jrxiDN11zKEiy+RFd2+uyp0mnX1dmJzwIyvvJCL
 3ut6aAld8Dp+LoESPvgcWtiVaEHIHp7wubvIBJmIeCIh3rsauvZmJDYECd3ZoOd+6KZAo75CEQr
 wXEb45JnkGqYw0kHwmXp83vBv7mcOpeoXZm5Gbx/TZNMAWBG+BXkqUf62cIZz8bT/Ha988sqXA2
 YpMowv55zoGuGu6ns6FRVwvsxHTzjRdkA0DbxX9GJeBxMnCbCknB8v9cpZD/zh6Jl6z/519bV0j
 PwzVnuIB3mcJP9OSKXLfDuf+zt0x9c+oAAa2wPM36CQWO+B978yLG/ksf87YpPv9roBwJVWh
X-Proofpoint-GUID: HvnXaeDKSUlID7qltQfHJWv7LJxBx6zp
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=687ac80f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=klZMuIcs0EXzT4WS5EkA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: HvnXaeDKSUlID7qltQfHJWv7LJxBx6zp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=601 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180182

On 7/18/25 7:26 PM, Dmitry Baryshkov wrote:
> On Fri, Jul 18, 2025 at 04:38:02PM +0300, Georgi Djakov wrote:
>> Hi Dmitry,
>>
>> On 7/4/25 7:35 PM, Dmitry Baryshkov wrote:
>>> Having the .num_nodes as a separate struct field can provoke errors as
>>> it is easy to omit it or to put an incorrect value into that field. Turn
>>> .nodes into a NULL-terminated array, removing a need for a separate
>>> .num_nodes field.
>>
>> I am not entirely convinced that an error in the termination is more
>> unlikely than an error in the num_nodes. Aren't we trading one kind of
>> error for another? Also if we omit the num_nodes i expect that just the
>> QoS of a specific path will fail, but if we miss the NULL - worse things
>> might happen.
> 
> Exactly, that's the point. It is easy to miss num_nodes, while omitting
> NULL will crash the driver. So the error will be noted during
> development.

I really don't wanna step on your development, but again, I don't think
this is a good solution.. maybe WARN_ON(!desc->num_nodes) would be better?
Some static checks?

Konrad

