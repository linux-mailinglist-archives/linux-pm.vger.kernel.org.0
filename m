Return-Path: <linux-pm+bounces-30578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A82B00264
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511475A6D55
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA402566F5;
	Thu, 10 Jul 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cLdcH+M6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C902C1E502
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151775; cv=none; b=co3tlJ85ilvu47j7Z9wry2F9umUOlUi6ClN89KVZuK2pi6lP2wABOtqf5JbOpECp/zQA15dm/s+1F+1vEpw1n8w/T40bsJW+4kMEY10s9Vv3IzXDSJkqrvwzEcRkVcqptEqlxCw5IXjRbH3DeI9bu3lNrWAh4pwEaDKVjzihThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151775; c=relaxed/simple;
	bh=93g6fWXFtPY3ctctjRZIkU5J1yopubHNG43C/SvFEKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agT3JK3kvpxBS9ki18XSNTMqrhKVGx2Ex/EVgeJyX50aKX//9ByfmT55Aev7/dRj/hguraiiBXtaOkDZr4FVl+qAYsqlwSWAxpnCdR6/gPbaVVfIuk1bGVH1sBVaozyHA2Ml0ygSP2I5P1ZGOVqIDeHe80F7fqOAMqLDgTkBLdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cLdcH+M6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9WoOF002907
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 12:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LedMUwDjkPamexuNUMtdPjxDpvYa1llz9E9EWYXjJks=; b=cLdcH+M6x7n0bHVi
	cJWjwzSjprUsvw3vkcfxEBniWZVfJYWo1I9V4vyH5mx2FVYVbHh0uc2G1hT7X2AH
	Vx/EaF10mCdLRgN8Q9e4ZBRuCwwisvqrgh+z14ifqJkfsDlDzj54hsLI3eP1gJJx
	3QIAXoK76lb0acgDagJAV+3gybD/zBo55oe4YtT8q6uea/enaSqQ5rf6+k2wplVY
	AU/cdLjfhaYC3N94QkbpYLN4JlrPwSKHSnoAvY1CvSyW8mxpNyzmWPJi6kw8fJOC
	j6tS1yNfvrOJaFrpAv+fFeCyWWdfqWC0lR+47sO+yKPVhfyO3cSE3LZlygIthTAt
	BcdFww==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2bg8s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 12:49:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d09b74dc4bso23744685a.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 05:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752151772; x=1752756572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LedMUwDjkPamexuNUMtdPjxDpvYa1llz9E9EWYXjJks=;
        b=NpA05c/bWmoyr/QWiFjp00qdhLJNhlX5YPLBHAsP1E5COiqjbPgayD77lAgtUpNT02
         ciOoTXL6wSYVFjTiErzd7avGSSyVTdwDYd4wy7I6J8UAe4/QwaYDQ8Zm3msZAPR1MlLw
         FGbbxAnyw3UYqDDLmOMnpuv6MiitMVE9yvEKDeLPtEVsoewSfWHGVwUUFh93lCzjqrll
         ABM8uwv+Upuh21ieKnTJ4WEx1hUBtRkWmT2pwCp07u6w8bImhjHCtR+mRZPgoceVesUr
         7BVdmCOIN9KDjFRqN6kOGoW0cZvf4RWIshhmB2zREeGj0hIcJ6jpQpSrBncRgvPU4pgP
         1miA==
X-Forwarded-Encrypted: i=1; AJvYcCWWgfuHgFwqgHxweOrRcaA76b767h7TO7eurDvADVYw0lqTTrbSEUrwT0axSv9e2dOQwq/fG2Lbyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKnliDvjaEvCVnpw8774b53AVWMPHALPh4AJ2dRTh4mCy/7sKr
	MLTAuhdvUIRBbfBPb+G8X7Fagc1QxiMRoRJHAdhLgK52+OwoDxijXblz9KvzgY1KGccVqCQwwB7
	xRzXKFmnPaVkMdbXYbtMfyRA5IE6l+QixHQRdIVBaiZmKzbsYBTviiOl/U9KFtg==
X-Gm-Gg: ASbGncuCBZ1oLmUIDYRSahkQ7Zy+f5hBKm2IU2lYq/eskQ4CFPhnISk+KfkaPSG5wR4
	GktvxduRCXrifieJxWL2zPsnXlXsljvxOy9FxkPDQvH8KY9uOn+BhrhV4wdu9FthwFZA0oL+hhr
	xb9cd5OJ9lwneUrn4EO6PfwPeacDzxPTMPJn8HZhKuD9eZm2dZxbfOjSTqz4yGGRbbN7U3NxYzt
	yfiw9BX8WqlXC9FzfTT8truSf76DOSC8diYIriLy9HJqRpDgQNxjG8gDDZAYHikJxZ5YH/bmM2d
	N5w+ec2rzkGN52RqTk2NZz8Johwdynnu6ukrw6o0HnlpC+TL7yp9GpSizwtjn0VjQeeauII81sT
	Bv0g=
X-Received: by 2002:a05:620a:2948:b0:7d4:589d:5cf1 with SMTP id af79cd13be357-7db87e0ff2bmr357279885a.2.1752151771724;
        Thu, 10 Jul 2025 05:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6MnMPHjfEvJ/d0p7Ft5taGsl78PlkmiIcddZTWSH7lx8js1TCtoXP6qMlLfgyrHVTt+MfQA==
X-Received: by 2002:a05:620a:2948:b0:7d4:589d:5cf1 with SMTP id af79cd13be357-7db87e0ff2bmr357276485a.2.1752151771216;
        Thu, 10 Jul 2025 05:49:31 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9735311sm822975a12.39.2025.07.10.05.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 05:49:30 -0700 (PDT)
Message-ID: <0d0d42fd-06e1-4584-b82c-965f4fb5fa74@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:49:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        quic_skakitap@quicinc.com, neil.armstrong@linaro.org,
        stephan.gerhold@linaro.org
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
 <20250509110959.3384306-5-jishnu.prakash@oss.qualcomm.com>
 <20250511140418.33171ca3@jic23-huawei>
 <ff19780e-5bbd-4074-9db3-b4f27922a093@oss.qualcomm.com>
 <20250628173112.63d9334e@jic23-huawei>
 <5b55acbf-065d-4383-a816-82561bf91273@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5b55acbf-065d-4383-a816-82561bf91273@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwOSBTYWx0ZWRfX8AN8MEpk9+Te
 42Aao5qBuVpY6iSkP6UShETpwpYxBlHhTEnflu4wzlO/qtUGOa9nVsoTQSW19nSZDvXaAk9n+Sd
 JnrijK6szpyNa9gStydAr4To+rsA+kUgnsrQqnv9oL/gL3evFUdUbVOZahq/ACa/L3JreTveQCP
 ync79FL2i90j+0qx2NmXUvbNCb2DnQLVLX5WhI0quMlZJz1+aPZssUrfMNrhjXcLQ4fYrc0kIDS
 7x0wLX5Y0oPrAYmWujVGRvFz4zC/atZiFIayGfMjDMgiU9VwY6C1p/2MJh8vNk7574Hk/qW5Ag7
 Vt3m88mhT8ppacgtGlrZ2yAVyWBj4+zPpZixWpuy9UJOProdLT80NWimNGoDJwqHSENfPO70KIO
 E+vzi1S3oy5USVlN1BQhz57U6rvq5OPuaUdSLtNik1FFAbRdSRN1SwsiBKddqWkQc/nrNOKc
X-Proofpoint-ORIG-GUID: 7d2y2CIeviG9lLtxK2FiuWDMTol_fs2I
X-Proofpoint-GUID: 7d2y2CIeviG9lLtxK2FiuWDMTol_fs2I
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686fb6dc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=5KJYxXw4eQHc87HR-wQA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=862 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100109

On 7/10/25 8:44 AM, Jishnu Prakash wrote:
> Hi Jonathan,
> 
> On 6/28/2025 10:01 PM, Jonathan Cameron wrote:
>>
>>
>>>>> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
>>>>> +				{ 15, 100, 200, 300, 400, 500, 600, 700,
>>>>> +				  1000, 2000, 4000, 8000, 16000, 32000,
>>>>> +				  64000, 128000 },  
>>>> Andy often points this out, but I'll do it this time. Fixed numbers (typically power of 2)
>>>> elements per line make it much easier to see which element is which in these arrays.
>>>> Reduce the indent a little to allow that here.  
> 
> ...
> 
>>>>
>>>> It was never worth bothering with release until we had devm managed form but
>>>> now we do the code complexity cost is low enough to make it reasonable.
>>>>   
>>>>> +	indio_dev->name = pdev->name;  
>>>>
>>>> Just to check.  Does that end up as a part number or similar?  
>>>
>>> I printed this name and it appeared like this:
>>>
>>> indio_dev->name: c426000.spmi:pmic@0:adc@9000
>>>
>>> It only gets the DT node names, which are generic, there are 
>>> no part numbers in this name.
>> I thought it might be something along those lines.
>>
>> indio_dev->name should be the part number so hard code it rather than
>> getting it from the pdev->name
>>
> 
> Actually there would be more than one PMIC which can function as the master PMIC
> for Gen3 ADC functionality, so I don't think I can simply hard code a name here
> based on PMK8550, if we want to keep the part number correct.
> 
> Since we can't get the part number directly from the DT node names, we
> could try one of the following ways to add it:
> 
> 1. Add a devicetree property for the part number
>    This would be simple, but I'm not sure if this is the best way, 
>    if the below method looks good.
> 
> 2. Add a string in the compatible property for the part number.
>    This means updating the compatible from "qcom,spmi-adc5-gen3"
>    to something like this for PMK8550:
> 
>    compatible = "qcom,pmk8550-adc5-gen3", "qcom,spmi-adc5-gen3";
> 
>    and then extracting the part number from the first string.
> 
> Please let me know which method you would prefer.
> 
> In addition, does the below string look fine, to assign to
> indio_dev->name for PMK8550?
> 
> pmk8550_adc

I don't know if it's a good idea to intertwine the two, but we
happen to already have a mechanism to retrieve the name of the
part at runtime in drivers/soc/qcom/socinfo.c, namely
qcom_show_pmic_model()

Konrad

