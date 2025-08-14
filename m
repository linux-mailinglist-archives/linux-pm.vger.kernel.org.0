Return-Path: <linux-pm+bounces-32367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB03CB25C75
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DFA6B60E86
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C6B25E44E;
	Thu, 14 Aug 2025 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F5z3xqRI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C225B2E3
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154747; cv=none; b=C0FyHKz22jYA36lrRjlPtI8Q+Kf5668q3xHk0w2TnNle+NV4dCmLjRaWggZObhAVQRpJBjU30vfW/3NVDXRmBYPHFjMRUeuEIKrncXiUGnYDzRjLPwRiIdJ9Y+WQ/1pK9ofDWWVYA07tNDA5ymB/Jhkg0/V5ETlH4PNr5eZB75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154747; c=relaxed/simple;
	bh=cv6dE0f1+2HJ6ifD9wlGrnlDAszs2lyg6y1T+FM/GXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tf5jBLdT+AZuSqZ7AtRQy79w2K26ZD8G5o7S8j2ePM33j/MA7H5aUdDRYAxgMTzMRmrzT6N+yQ0h1L85+fI7SvIYlOU2sbTZz2O9N06pXJb9vt5b34dd/fnA3oqQ/TlQ43iyk+cqJ9pG75+8zrbSbQkHFpDV22c0qEDmgrGb9Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F5z3xqRI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMdRDZ020573
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 06:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xmxXpUgGKiuhKsdFeSAj9dw9kez65OgZ099Ql8PubOs=; b=F5z3xqRIEKnrF8D+
	rJn0OfWlC80aesDqxGaBES5tnswbIK2ph/chq0F6D0dWOA/bKIwjuoo8gkt0iPeY
	ylCgKvJEkCLyhlilQz3vSK7rt/rkzhZcBJvjhu0p+gg3oGEZ9GaZD5zxCU399iWu
	vpFpUJrL6LiqCzVejzWupW6zNS0ySDNetRncpzZAdZTTaR98PFVR1LTh+pBPTyx0
	8ikOzXPVkjP46AeaQtPk0DBDD2mwX6aPgCS5hwgZqBNhcn4SIWY95xwTj+eSU9D+
	d8Wqyu0+DF8UY4ILwBoMF+baIt4u+T5E/kthHk1Ay/ij2s4j2dveuJ64Z+rnqjwt
	5ZPF7A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmemws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 06:59:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-323266b41f5so1256957a91.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 23:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755154744; x=1755759544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmxXpUgGKiuhKsdFeSAj9dw9kez65OgZ099Ql8PubOs=;
        b=LsKO3+256HhpcyrOcRlvmHcPCaaabj5Ll6YIxnA+Lzdve3F+Z7jJPl72MSJtxaQ6EW
         lYSHKp8elKN17Gj+F9IdQSt9FYx2M0oRkZcfyTktRzhEmQgGxYYzBpRHp10l9FCbJgou
         V6pJOmNijAD6lphkzKIMi3i0lz9TXuN9nd/1Bu44WkS5IDgXGygs/MJaRUoaCmgLLng/
         /uE8l4MyhL0396uE+dOw9a2Rv7CTd8lY4r2kOIBc2HSyqoyrr12YOA235iH3F0GJMFcq
         n11CBCaby25VyEh4+MB0Wfb+wsyx+DTV2X0de/+5I/HDw2TFP8ypRaVFZ2xRgQvVlZ2V
         GQlw==
X-Forwarded-Encrypted: i=1; AJvYcCWJDoqcB43TT4Y1/hM4Lp2X7xpmyjcQo5BJ3WjrziaaApZRhqEQLDGlj04va2/5b8Kza7Dqy2Ac6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrpDKpv0AjAQQC+pG+fqD/9cXK1qXQReEpiOLmRF+PGZOPLyao
	oMWwGwlHC+L0D5qxwGguq5Yg1fCE7hxu4KE/1GoE7bFgC4rXefYUEylDLsIem959Ns1GYbv7m7I
	BthHmrBqKuSAK0lSu6jcSSW8R8hGwgt/B5PaTQ1PA4hJxNlYtixjHHFaCrbt9cw==
X-Gm-Gg: ASbGnct6zxlj+bJpUVtyFeU9vnfIxHC6FbfWP+XUTZZBtBxq+DsRQmQcdBtl/gDXZwQ
	E3ahYJN2ixFi9VqSTBd7Fnbs9OuoQk/T56iyYgZGAyS0lKbtfhwe7ih5Y0fs4QPnjk7G9xUlY4w
	YjRTHb40FXf3Jhr1gRp5bwLYXvVcKD4paUj5cj6vkpCJMISfIezV/nbC27+OT0CPesrNIj7m+Ct
	e7DCRX8P5I88TsiCidv98avfxRjq5lTb4ZZ1Zwkjguccpxc3/fQrGeDBEcwdqX0fm1Q82Rl4GS8
	XLAagErGHOo406ptUjRvpT6kgSeu+9vBAxhP045KulXfXsQYPJ+ft4IHRw3VKEWaSHGk
X-Received: by 2002:a17:90b:518c:b0:31f:32cd:97f0 with SMTP id 98e67ed59e1d1-3232799c1a1mr2789292a91.1.1755154743855;
        Wed, 13 Aug 2025 23:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8CTJ/JcSa7RvClhZ1Noj4UnKmQoScP0H0m62yaCrSPHKaqpNUci8RZ9cH7R5dNw7mRb715Q==
X-Received: by 2002:a17:90b:518c:b0:31f:32cd:97f0 with SMTP id 98e67ed59e1d1-3232799c1a1mr2789250a91.1.1755154743352;
        Wed, 13 Aug 2025 23:59:03 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.31.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32328d0a204sm500314a91.3.2025.08.13.23.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 23:59:02 -0700 (PDT)
Message-ID: <d81740ac-f83f-4ed3-ade6-193b8bb59bd3@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 12:28:56 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: qcs615: Add clock nodes for
 multimedia clock
To: Bjorn Andersson <andersson@kernel.org>
Cc: Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio
 <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>
 <vxeadjzwywqjjqm7elg5pltq3jtnv7fprquhdoydhxnjihpsw7@tlqoq5wpgcr3>
 <d56920b0-0bbb-4951-aa02-152da6b9f9d2@oss.qualcomm.com>
 <ii366w2aftbitlhlmsa5fhbcn4s2n2fc35plrrb5tlsmtv4udv@btbtgo2vr4tw>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <ii366w2aftbitlhlmsa5fhbcn4s2n2fc35plrrb5tlsmtv4udv@btbtgo2vr4tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX53EdJtBexqR2
 fWue+pVlwKHrB1qYr2xHmp/eNwVLYpVZkFKYPI0VROQGrgbfdAIk/ahXbRND/ysacRkG60j1ZtM
 uoTc429/D9eCVitqaZxJd6Pb9GE+lzQYiHNGKVEPPSeAcWUoIbEo1UQNWLKfYahGl5Wjln2KJue
 AKXPoQalAEEjZy5WrEc+Sy+os6nBHgNXnLDaFbUT+fof/CvdWLASP8h32UmtAEE3c/jMGW9LBfs
 n5eAVFv2o2IQ36TNYMnbpJlIOvVFikykwypjo/TMipIJn00FLlKpV4/3bedwuwYlyHa1m+Tn8Z7
 HqnuwvVjpX46wSucYNIqh7qfrrO3R/qvfjzfPbOAwTtBbqAoDeEMSuXyDm8CjRvVpVXTLSULkTi
 Rn9kLgOy
X-Proofpoint-GUID: J0MO0m28SnMFClcdVmhN_hRcF13d2SAi
X-Proofpoint-ORIG-GUID: J0MO0m28SnMFClcdVmhN_hRcF13d2SAi
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689d8939 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=/kiP2gCwObMqexHosDfpNA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=5QP-OhRlovnELOG5v58A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119



On 8/13/2025 10:50 PM, Bjorn Andersson wrote:
> On Tue, Aug 12, 2025 at 02:25:12PM +0530, Taniya Das wrote:
>>
>>
>> On 8/12/2025 9:15 AM, Bjorn Andersson wrote:
>>> On Wed, Jul 02, 2025 at 02:43:10PM +0530, Taniya Das wrote:
>>>> Add support for video, camera, display and gpu clock controller nodes
>>>> for QCS615 platform.
>>>>
>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>>> ---
>>>
>>>   DTC [C] arch/arm64/boot/dts/qcom/qcs615-ride.dtb
>>> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@100000: 'clock-names' is a required property
>>>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gcc.yaml#
>>> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@5090000: clocks: [[43, 0], [45, 2]] is too short
>>>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gpucc.yaml#
>>> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@5090000: Unevaluated properties are not allowed ('clocks' was unexpected)
>>>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gpucc.yaml#
>>> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@af00000: clocks: [[43, 0], [45, 29]] is too short
>>>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-dispcc.yaml#
>>> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@af00000: Unevaluated properties are not allowed ('clocks' was unexpected)
>>>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-dispcc.yaml#
>>>
>>>

Bjorn, I will push another series which will fix the above errors.

>>> The missing clock-names in clock-controller@100000 predates this series.
>>> Sorry for merging broken patches in the past, please fix that as well.
>>>
>>
>> Bjorn, would you prefer that I add the clock-names property to the GCC
>> clock node to resolve the warning, or should I instead remove the
>> required: clock-names entry from the qcom,qcs615-gcc.yaml schema?
>>
> 
> It seems to me that the qcs615 gcc binding and driver is lacking a
> number of clock inputs. Can you please look into correcting this, and
> based on that resolve the dtbs_check error?
> 
> 

Yes, Bjorn. I will surely look into to fix them bindings and driver.

> 
>> Let me know which approach aligns better with your expectations.
>>
>> -- 
>> Thanks,
>> Taniya Das
>>

-- 
Thanks,
Taniya Das


