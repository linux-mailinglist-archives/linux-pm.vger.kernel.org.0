Return-Path: <linux-pm+bounces-16931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D679BAFBB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 10:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B65B21253
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C13E1AC426;
	Mon,  4 Nov 2024 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bxm7kVvh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD486FC5
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712945; cv=none; b=Hn6u8OlDASGs+JLYnPnTQmKYJD7Z/AuDGV64VdjzOlr+HIMD8BxJFRcuQlD7J4z4XHAX5+c1B9SUAgnhLeoxf7pQaeSpzahcr6HEwCqCD9XpugjlmtcWUYcl+MUSnkWr2MKorEs/Z6ASb+jvJormdTl5EEG50St0TFgfOwb/Lb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712945; c=relaxed/simple;
	bh=QcoTEie8FZ60+JPHif5psISMr/kD+U+xWtCc+upG3zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMIWBKhnqzccztIo3nA8eG90BK2HFTgZzF2zsPVMsguy56n9PHyjIApTeZUYk5rDD7PqNq7EQnXiRUqumWjoP8nbXmVB9lNBKnGynyt1aG1xaEA1e2INgm4+8Ghgi01kW441N37HOGYT2Q/dyrLZX6tdoUV24isrVOdb25pEXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bxm7kVvh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3LR0oT001350
	for <linux-pm@vger.kernel.org>; Mon, 4 Nov 2024 09:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a7ClmRGW/Dq8E6lrvmSf+/iEncnmMhHeY3NKR0VniJk=; b=Bxm7kVvhTNC34neX
	tREOAqsEVKHwtoztJBS4OwgmKZNd7VR0OIm99nCrKThOCj9KQv+tlYkDzudNw1an
	gph1o1zSZPh07IexQpH26STxfQ2u9ngSY1N+sDj0fFDEgjwv2MINwWXOYUyft3tt
	RCohAxjebOQ9P+3xEvcsxqZaYU4aQEMZiGwil5kta3GF3h0BriYfYjATjr7798wj
	s8ExedUoN5SH06k2ro/2+aV/VJfU947lViB37P358HY6pvn8p2nI/qC44pKjcgc1
	yvFX9cn4sTY/THkM9ouf2aVQTnTK2DNS+iFNIc5kxDnDLL4Nh+3xsJ40nwde3xkJ
	soE0Ug==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd2s3pup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 09:35:41 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-50d3d2d9a05so48031e0c.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 01:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730712941; x=1731317741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7ClmRGW/Dq8E6lrvmSf+/iEncnmMhHeY3NKR0VniJk=;
        b=NlWFSrLP46QBDgkM3H5A+aIK6+EG3Sp6dGo1UkXhOrxh3z1wG1rSMnlaP3CWFamcJ+
         0T3uOrF4fUFlrcm+WKg1Bum7yenaj1Ae/Ek9M7VYqgjGOfO2l4sD0mYjhxtJb7O+P1a9
         xY6Apl5EUo/aaG/vmPjJMZK4w7yqUD5ObtZ1geMb9VZKLeQntpfo6nZHTH8fTWgZgqBL
         x/L8UQMeketxLebelmYTywa1Z/1+S02Ule14hwZ1K+xtqtg0Sln7qr5Z2dydisNjHxup
         h0QH4lLUSDYCnhNWcl0cYZc6RYMbqa0J5DmF3lT01Ixoo4pECEnEpzrhsYPtYZOfegO7
         lXYg==
X-Forwarded-Encrypted: i=1; AJvYcCXB54HpM9QeGUmNSkDSQximtLuIGQ+ZDpD7a84WHwkQzzpTaHzu6aC2USkVaI/2F9QlfsdGzzAfJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyafB/hjZiWePVzwhLnKRZwYERjKAqzSUwzhbli/0Cdl+yxVzpX
	3pvWC8AYBlHsjQtRGkR4nqGQZr1ZIoO3grhB6ioKfE8bv+ObSjBLgyqfg7sWqhaQyuLl7KV1Xi1
	JXCghxE0v5MU7lVqld7YcEZlJDHJ+1xzBUXuX7wnaADBBZgwDolo0eKEXHw==
X-Received: by 2002:a05:6102:3a0e:b0:4a5:bff5:4ee1 with SMTP id ada2fe7eead31-4a8cf9d4693mr10223872137.0.1730712940774;
        Mon, 04 Nov 2024 01:35:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFym09hnNdijaVFukhOsYz+216T1RS1/Kf0jAwrcJdxn4xJijzfx2HMy+bQo+HqXyxcUUNhlg==
X-Received: by 2002:a05:6102:3a0e:b0:4a5:bff5:4ee1 with SMTP id ada2fe7eead31-4a8cf9d4693mr10223860137.0.1730712940325;
        Mon, 04 Nov 2024 01:35:40 -0800 (PST)
Received: from [192.168.212.146] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e08e6sm527905766b.129.2024.11.04.01.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 01:35:39 -0800 (PST)
Message-ID: <925202f0-7fd1-4422-88fb-138c9027ac2c@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 10:35:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] dt-bindings: interconnect: Add EPSS L3 compatible
 for SA8775P
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar
 <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
References: <20241026123058.28258-1-quic_rlaggysh@quicinc.com>
 <20241026123058.28258-2-quic_rlaggysh@quicinc.com>
 <7k2vnjop6xyshquqlbe22gm7o5empeluvsohfmq5ulnaas3keb@yzomhzi4w7vf>
 <2ac4604c-a765-48b1-84b2-8979f18c29a7@quicinc.com>
 <vljb7wwqaaqgdcm6whf5ymhnh4jbtswyibto4qpqmbgwvshudy@unh3jhbyeac6>
 <00c9feac-722a-481a-9c57-36463fe0b3ff@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <00c9feac-722a-481a-9c57-36463fe0b3ff@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Cp1GvGl1GVp_jTKcksSfZL_i1h2G_Qwf
X-Proofpoint-GUID: Cp1GvGl1GVp_jTKcksSfZL_i1h2G_Qwf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411040084

On 4.11.2024 7:40 AM, Raviteja Laggyshetty wrote:
> 
> 
> On 11/1/2024 12:26 AM, Dmitry Baryshkov wrote:
>> On Wed, Oct 30, 2024 at 12:23:57PM +0530, Raviteja Laggyshetty wrote:
>>>
>>>
>>> On 10/26/2024 8:15 PM, Dmitry Baryshkov wrote:
>>>> On Sat, Oct 26, 2024 at 12:30:56PM +0000, Raviteja Laggyshetty wrote:
>>>>> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
>>>>> SA8775P SoCs.
>>>>>
>>>>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>>>>> ---
>>>>>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml         | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>>> index 21dae0b92819..042ca44c32ec 100644
>>>>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>>> @@ -34,6 +34,10 @@ properties:
>>>>>                - qcom,sm8250-epss-l3
>>>>>                - qcom,sm8350-epss-l3
>>>>>            - const: qcom,epss-l3
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - qcom,sa8775p-epss-l3
>>>>> +          - const: qcom,epss-l3-perf
>>>>
>>>> Why is it -perf? What's so different about it?
>>>
>>> The EPSS instance in SA8775P uses PERF_STATE register instead of REG_L3_VOTE to scale L3 clocks.
>>> So adding new generic compatible "qcom,epss-l3-perf" for PERF_STATE register based l3 scaling.
>>
>> Neither sm8250 nor sc7280 use this compatible, while they also use
>> PERF_STATE register.
>>
> That is correct, both sm8250 and sc7280 use perf state register.
> The intention for adding "qcom,epss-l3-perf" generic compatible is to use it for the chipsets which use perf state register for l3 scaling.
> Using generic compatible avoids the need for adding chipset specific compatible in match table.

That is exactly what bindings guidelines forbid.

You need a SoC-specific compatible so that you can address platform-
specific quirks that may arise in the future while keeping backwards
compatibility with older device trees

Konrad

