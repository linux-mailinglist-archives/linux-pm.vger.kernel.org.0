Return-Path: <linux-pm+bounces-34919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E18B81ADE
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 21:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E34162203F
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 19:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3297326059D;
	Wed, 17 Sep 2025 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GpD6o0Yw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A372F1C84DE
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138494; cv=none; b=eJZ92TRinItYRG+iReFaLbPlCj9GpGzQlcwVrkYiQ8CjOVkVjgBheTehYpmEO3um0TYDY6YsyP2K9Y0XClonfNYN+UvspJDKXT2/IlYk1GaYZVbQyOFZSdmDg28F/Q5weBWn7EgPAuIAp2bKbdjgvRqDagpIWvn6GErHf5uB+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138494; c=relaxed/simple;
	bh=gc4XDbpi/SHiw+dIuM7XRaag8prdni7GHABTYWIpL6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxN457VLRa7qM136m3PQ6bEhGIAkyUlJDQAatooEQojKC1lVM24PvBS/5RpV/RBvBJrOeKIm0O0UqGbA1PNrKZFFFQmgh7jnd0tVYtGaXSwUUtnuuFyzJBEg+6qwBqrC1RfYXIGZKBedD/voMN+q7Qz1RRFf8GWlavjpqzKBgKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GpD6o0Yw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HG4dDi029815
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 19:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jGYCeRo2Nm2iHZbBrOloUMVIcfNZlQpAwgAkvYACT7Q=; b=GpD6o0YwTSxSy0Kp
	04CweAao7LR1ZHrx1wCp8sY5Upn/Pzu3m8eb59eHCO0wr16aN+J5Fzvw/1yJNn5z
	sttNHbvb8I39/pBW1nbVJ4ymqDFODZIhD7wL7Kq9WStjHIHYcNtU4fJRsKm+62Vs
	H9LVkhTmZc8JzRsMT5Hu1k+J/qjmQKsLfnSvKsflWug0TP7r8DFnYGKwQcK+Va8r
	TJtfNcm8wuNVEtlJuPzjj/wO+m7F2AUCaOFXHXmYogr36Mvpb7jlPMRIazSdFqM/
	jYNja76a7NWsTxxhO0cnlJ8iQMo6B65f3qFaWjQHxJZ4SrOK/Y9/5ijPTMmL39zi
	Uh/gmg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxkpdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 19:48:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329b750757aso105271a91.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 12:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758138490; x=1758743290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGYCeRo2Nm2iHZbBrOloUMVIcfNZlQpAwgAkvYACT7Q=;
        b=klVzhZZIoRpQS3vrqzxlwGnINS9EO/rS7kPgmJ0yBYbGBSve+kdamt36qwTNjqIEBS
         +TWWGB6PZVN029thCV8JDqE/ypaDqmWdscZmBqYbKwcUz8AYiwFC24jephuRtzoKFkPf
         FyC1vgwbzqaTffFebD3VeU+lTODXO2SbiB2D+kf9chImznW/5L1eSmbEqGMmg1SHq3mr
         +PArB9QS7gymXtuzIo0LIQ8Qy6WkqTLpyVD1rsLEX3lOml2Ut0LrhKsY1jHseMyoxHLD
         fgXkyNthSYAN5OyhOvhj3Pz/QHN7IBX479s9o73cEZ0rTex3OaFfE8m8ebhVyd67pxR6
         PNtg==
X-Forwarded-Encrypted: i=1; AJvYcCVcG6SPoYxuHu/0UR/sbIDma5mMs8S+B66VE9fD+sTVBU3cPeTsl83ba1TMWpiPjOQ89nfA2m63Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+m71FljIZwnmEnxbk70KHSXk1thO9Uku+h74P/m3IdsP337Vc
	Ij5MCwSK3fabXC/EfRhhDrgYoZ6DqChL1q3XhaJznS+5athEGIpXmas55FDMGuAQqlZPZ5z5Jue
	3yYn9UVjH7BVduWq6ZNpNJQa5PH0qe8a+DHyzVkHS/bcLp00ta47yGbyE4wmRww==
X-Gm-Gg: ASbGncvyF9CETRKTDNOM/wTCndjQ2w6fyJzpJi67p9fyfZMIyM6VcMRaB8Y6kM9IUAi
	bjRoETns0Rkzdx6k3M5oMTX3W3gCZQXSjAfyY3mCYZk7KJPcZ6c6bH6BhaJMflZsx8EvBxXwSb5
	oaUEEcOh4qt0tQ8kSEuJacih+Bp84mTt0VZbh7zVTrdm4TP0RP1BBtf+AjM9zCvL4A4lJzrr1Hh
	SqXk1jcxL1ub+hcWr8qzjVcb8zRchgstIrMromxwdegF5/t6WZ1+mTkAd5/zabFYzE/mWW6tgLF
	lNjz2AVpWw0c22/wcSYvr1skrXMZExhhYOGTG8L8Tf4LKAMjfylG0KhsbCs55A8591W7u6Q=
X-Received: by 2002:a17:90b:1f84:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-32ee3ef7071mr4546621a91.15.1758138490216;
        Wed, 17 Sep 2025 12:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNUj9iiTkIiBdyuwHV1qhUP3oLhWgJBvCsq76MF3fHoniGNQ6FCUfXLye/WwI6WYVKAKakdA==
X-Received: by 2002:a17:90b:1f84:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-32ee3ef7071mr4546578a91.15.1758138489768;
        Wed, 17 Sep 2025 12:48:09 -0700 (PDT)
Received: from [10.216.40.15] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec3f454sm199284b3a.75.2025.09.17.12.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 12:48:09 -0700 (PDT)
Message-ID: <47f7a917-3bb6-4331-8813-49f6646333e5@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 01:17:58 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 5/5] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-6-jishnu.prakash@oss.qualcomm.com>
 <20250830185809.5bc010cb@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250830185809.5bc010cb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXxUAFyCwzxBtA
 xXuIXENLTg5r5ArRlYNl6PI9Jo7bPRy5ZWzGsf8Qg8W+R112xy0yA2pORgjqpDKBfxnf1N93FeP
 KRv/LHivcTAuw1xqe/wPGIYcs0ieYvhixQH3B6vH2o68RB243t91A0ATGiIxhTyo5VRzyxReYRL
 V+ZuyEx6oK17q8VSLGYaXwP6qJGP1r9GQZlAFlUMqVcSjDMW2dA113NUlCyy49aQqGYOVdvWknA
 DL2NcZnI8EMpce6zjeAN70g01B29HwX3E8Wa5vFx+eUeRhfjKX2QMPlld2vTHUbsVysBAkdV76N
 fo/R07pg7YY3gAADMHGGJIKbcuF+tuGtuwCBgirzJ5HlJkhVo5oCZU4uk3Y8j964imenJ0j/qDW
 now4tVUP
X-Authority-Analysis: v=2.4 cv=MMFgmNZl c=1 sm=1 tr=0 ts=68cb107b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-qQjPGFekNv0xv3-IhUA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: pxjmGjfY7bJcIfr92-d08HMinBy4yiEP
X-Proofpoint-GUID: pxjmGjfY7bJcIfr92-d08HMinBy4yiEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Hi Jonathan,

On 8/30/2025 11:28 PM, Jonathan Cameron wrote:
> On Tue, 26 Aug 2025 14:06:57 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>> drivers, used to support thermal trip points.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Hi Jishnu,
> 
> A few comment inline from a fresh read
> 
> Jonathan
> 
> 

...

>> +
>> +	adc_tm5->dev = dev;
>> +	adc_tm5->dev_data = aux_dev_wrapper->dev_data;
>> +	adc_tm5->nchannels = aux_dev_wrapper->n_tm_channels;
>> +	adc_tm5->chan_props = devm_kcalloc(dev, aux_dev_wrapper->n_tm_channels,
>> +					   sizeof(*adc_tm5->chan_props), GFP_KERNEL);
>> +	if (!adc_tm5->chan_props)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < adc_tm5->nchannels; i++) {
>> +		adc_tm5->chan_props[i].common_props = aux_dev_wrapper->tm_props[i];
>> +		adc_tm5->chan_props[i].timer = MEAS_INT_1S;
>> +		adc_tm5->chan_props[i].sdam_index = (i + 1) / 8;
>> +		adc_tm5->chan_props[i].tm_chan_index = (i + 1) % 8;
>> +		adc_tm5->chan_props[i].chip = adc_tm5;
>> +	}
>> +
>> +	ret = devm_add_action_or_reset(dev, adc5_gen3_disable, adc_tm5);
> 
> I'd normally expect a pairing of a devm action with whatever it is undoing.
> If not add a comment for why that isn't the case here.

This is meant to disable all ADC_TM channels in case of a probe failure.

But thinking more on it, ADC_TM channels could be enabled only by the thermal
framework calling the .set_trip function and that could happen only after
this line at the end of the probe, for thermal framework registration:

        return adc_tm5_register_tzd(adc_tm5);

So I think it makes more sense to move this call to near the end of the probe
and to make it devm_add_action() instead of devm_add_action_or_reset(). I'll
also add a comment mentioning what it does.

I'll also address all your other comments in the next patch series.

Thanks,
Jishnu

> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	INIT_WORK(&adc_tm5->tm_handler_work, tm_handler_work);
> 
>> +}
>> +
>> +static const struct auxiliary_device_id adctm5_auxiliary_id_table[] = {
>> +	{ .name = "qcom_spmi_adc5_gen3.adc5_tm_gen3", },
>> +	{}
> 
> For IIO drivers I'm trying to slowly standardize some formatting choices.
> For these I picked (for no particular reason)
> 	{ }
> 
>> +};


