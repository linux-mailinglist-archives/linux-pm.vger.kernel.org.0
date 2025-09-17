Return-Path: <linux-pm+bounces-34917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DBBB81ACC
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 21:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816026220AE
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 19:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966EA2566E9;
	Wed, 17 Sep 2025 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nB8MtTh8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFBD1C84DE
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138456; cv=none; b=B+8pprX458cR78sSc7hd0M1aFQbudrRbGXdeMppgR3AG2eBUArtdnwjykn1OHhUqCwSJIfukiHK1MzPJZnqrPcb//q3fgxuG7ubUkOme15j4UtwWaoaILQBYaDBMYbhFiEPQg1f9s4f+sh8gfnJWywaXRyV9AuGXhRc+YSReJgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138456; c=relaxed/simple;
	bh=eCc3DvwwOCzNRdsPiK+c2P8cgXzJw5kUNDcvbfkn/n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZvNSpPfQFuRQduCU7AgTNXYlMxqGyhfob89mc8YBdjJKxYh5bKFxit4fUbf9mIa5D4VZJDT5NSs9oFlOGlWDrfoIkUk9X72cxnTYR7xtDoVY3AkPmIbDjQVeRNToiqce1xs6AOkCTKQAWoEGLksG2OEX/Zdtqm4dpPnUMkZFwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nB8MtTh8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HG3DcD020437
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 19:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NGOPpw3iuumSmHxje5vaDZCPavdx4WY1HpZ7Jmti/9A=; b=nB8MtTh8RSzbgZcm
	bqBFCcYv78eXzm9cR2KffIDxHEvRgL74+UwlbZmH1pURqJ7CJb6VT2Z+9/FM7GL+
	zAVqqY7I2Ad/xXWyoM7M61JCHyE26hHNa6ETqLWlF69pvas0bh1WAhMMJFwgaoPP
	gsUnSCzFToar+jGc7Dw3hfbHkBoxjlWQ4unbU8F2DvGnviHXLBbawDwwx9/yzB6C
	CIGHxVd9jPJCbR3gpWGhJVK/b8rf8k87/+Brx3bAyKjWVqk77mkfgWZl7GAmfpEP
	itIslCrFZ0eonyvd89OPxGsQg3/QcZr07INd+Nupj9xO3ImsEt2gH2EG8T8OkRIt
	7BZIIw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy1uprw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 19:47:33 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77619bb3871so329127b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 12:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758138452; x=1758743252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGOPpw3iuumSmHxje5vaDZCPavdx4WY1HpZ7Jmti/9A=;
        b=hqF+AYxclSBX52yqq2TgphUy+K8dg6Vfg4kJdZDmm++YHlbNEZN6kaPUSgykmTKl13
         sW/WEZCWOqdQ5jPJMgg9OXLYKfK/5X/Td10pzN+Qe58P7DEGrNWms5KlxUKQh4XKkSWs
         hHOBgY0Rrm+t0K1CfhOI/t8zJttbM5trOZKTnhANiiUQLVQTXrzS3x1T8WtT4gIZ6U86
         h4Krh0WB7p8NwXa5OQ73hyX2j86TYv/1HuvY/iGrlIx2tyaodqMd18AVDEQ5mM06ks5L
         quQ6t9NsceFmLGkCpQRN/5+D5W7RWqzdzVQXc0pamlnLNnPTPRMQWTu1etITUW9ZmHfu
         3vdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCfP6eSzxrEB1gkia5BKl5DUVyHuQROVbt78JToD/0LTsevtY2dfhQs/rQ3vaG5w+wfOXQ64dcOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxohuqay0sa3OvZgZyQGJd/yohQX2RVkpkFV+TOzVmobpXzE3cV
	gj+Rcwd0JJaFNfLw6fpDv1EjjdzO2fvmljn8Fg1usLBH0ho+lNjHpzrVkqUuBJb3HIevBAVZ0A1
	RmkQob3kGkBZ6FYLYgR5LgHDGRv5J4O+7ES+Qo3DPujrTArAxMexGsbb+OQ1FKg==
X-Gm-Gg: ASbGnctUxO8nS8vxa4dsO6Y6TS7JKzM0i1pURcZOLE4VZCGjJ4T7du/Il8hCLZLwiLE
	1SuxLOOh9oqVxqSM3JQo0xh3fVOXLyXFRni7vDyOAjcSVlB3OLTDyl+SCdaMozKRi2tmGJY/EOg
	Ksa3t5v8iFlDCP/uartukuH+n1vGHGQq8Qu4AnjGi5+V3+U6A3XGNPNjq7i+t5OrsGSBgwgLI42
	ybm/GbPkIdcYa00+dIaBCUO8e5B95/U14OHrWBHpjsnex5XS1uzFDa8BwmSskO6/eCwDW3qLth0
	S31aArPg+O7EfRPVI4zgPVPAeCM7vZ0EVsmRmmY+5kOsggvByZTONJULFG/hrJw2THVrTOQ=
X-Received: by 2002:a05:6a00:2405:b0:772:934:3e75 with SMTP id d2e1a72fcca58-77bf72cb228mr4006559b3a.11.1758138452415;
        Wed, 17 Sep 2025 12:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1hWyfo8vXPdXPEvd94MNzd2+BYNOV1vlcuwDNTBjCR38g8b9XRkJWcMjCwmG6wxBK4HRxrQ==
X-Received: by 2002:a05:6a00:2405:b0:772:934:3e75 with SMTP id d2e1a72fcca58-77bf72cb228mr4006514b3a.11.1758138451980;
        Wed, 17 Sep 2025 12:47:31 -0700 (PDT)
Received: from [10.216.40.15] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc24b4f6sm215021b3a.37.2025.09.17.12.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 12:47:31 -0700 (PDT)
Message-ID: <a0e885be-e87d-411a-884e-3e38a0d761e5@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 01:17:19 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-4-jishnu.prakash@oss.qualcomm.com>
 <20250829-classic-dynamic-clam-addbd8@kuoka>
 <5d662148-408f-49e1-a769-2a5d61371cae@oss.qualcomm.com>
 <4e974e77-adfc-49e5-90c8-cf8996ded513@kernel.org>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <4e974e77-adfc-49e5-90c8-cf8996ded513@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XqqNhSvezJSoLohQVN29zfUu1RflyoHd
X-Proofpoint-ORIG-GUID: XqqNhSvezJSoLohQVN29zfUu1RflyoHd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+4FSOGTkUsIy
 KjrEtB770R5X0D/At5I1MyS1wp9U62mHola2xMsY404DvmrrXl3tv9UsNm8oPhWF0uhvjDUWDKf
 gyaoz5xQhiZk138KqckaBTzor3Ckh2f6IOjKeTwxumUjqjJg+JSW6yKLL5PajKVXhqu4C+He6aM
 F7FYE4Xr5dSPoF4Kbihd7raoLvp63BGnMguB2sHcfJaopFLaloWxWLMidZkO2RsJZQ+LORRsWrL
 GAHqjpV/QxEq/Z2E9i7bLKfF2sa4PmnsD7ZLhXpvzJbPDS8fmZMZ+c0h9IBfxWRmj02BRiIu3WN
 Z6ORVsX2RDC4WBNZ508WxKbbQEAm7Njh+OuJqNyFL+JJJQ02WoNjM+uBMDXfLtXvKm/hmb98p24
 pvF489NZ
X-Authority-Analysis: v=2.4 cv=cf7SrmDM c=1 sm=1 tr=0 ts=68cb1055 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=9_5l9IA32bTo_oBAx1EA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Hi Krzysztof,

On 9/17/2025 5:59 AM, Krzysztof Kozlowski wrote:
> On 16/09/2025 16:28, Jishnu Prakash wrote:
>>> You cannot have empty spaces in ID constants. These are abstract
>>> numbers.
>>>
>>> Otherwise please point me to driver using this constant.
>>
>> These constants are for ADC channel numbers, which are fixed in HW.
>>
>> They are used in this driver: drivers/iio/adc/qcom-spmi-adc5-gen3.c,
>> which is added in patch 4 of this series.
>>
>> They can be found in the array named adc5_gen3_chans_pmic[].
> 
> Really? So point me to the line there using ADC5_GEN3_VREF_BAT_THERM.
> 

We may not be using all of these channels right now - we can add them
later based on requirements coming up. For now, I'll remove the channels
not used in adc5_gen3_chans_pmic[].

Thanks,
Jishnu

> You responded three weeks after review, this patch goes nowhere and way
> you handle upstream work makes it difficult for us and probably for you.
> 
> NAK
> 
>>
>> Thanks,
>> Jishnu
>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
> 
> 
> Best regards,
> Krzysztof


