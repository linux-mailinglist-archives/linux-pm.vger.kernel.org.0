Return-Path: <linux-pm+bounces-28218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00610AD0C48
	for <lists+linux-pm@lfdr.de>; Sat,  7 Jun 2025 11:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B4E3B0EA2
	for <lists+linux-pm@lfdr.de>; Sat,  7 Jun 2025 09:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802520C47F;
	Sat,  7 Jun 2025 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T7lx1wwo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCAB1FBEA4
	for <linux-pm@vger.kernel.org>; Sat,  7 Jun 2025 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749289584; cv=none; b=blkVOD/aJJDqJvhKSzSKCb/lRIs8+myHS6JVGUqBvaJlrWLMSjrNZKJjZxa8MjdSjQ53DpjMf5P4TJMKVMkSi9WCC4XocrKI3LD58szyOZdW7+SRi1K4nri/kGOu9HIo5SSYveGCtKmo0M5ja4qx2bxDZ2rIVVYxdpIaqoIkBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749289584; c=relaxed/simple;
	bh=RTIekZYMXT1HPwL+6JH2s6iXA9/KsXv5nouYl86M74U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4zod+qUXA/nZVpp7YlxhA36UCukyxUzrU3W6u/pt0FbetaY+Njw9iZMeWor8jLhBF8jUmpV4By8TvuhHDUvaeRTNBOPHY+9Vf2WKdDFp7Tow2BpC96MC6FwB1Zt9VUOoy2urNYMwNl/hDvzr1DwGsrJP+tkwhjE96OvZJP3axE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T7lx1wwo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5574CxuB026634
	for <linux-pm@vger.kernel.org>; Sat, 7 Jun 2025 09:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hOT1OH7Zs3RcqZzob/2wXtn6yUgIoxAj6wC5h6Z407U=; b=T7lx1wwoaYXYXFZu
	PWnTFfTJK53Q6R96BuWU/Vh70ppOHy0+pWHqAhGzxsvO0xQuCRKh/W4x+77rE0e7
	5KQfB9DiuhUKr2lxytKI3eP6fbnU/din7Ia8xVTf1l2il4BcF3JL2hT2X2PTNRYM
	X3kk7PUddjajdjxFZbwTRidUWCOb4ZyhecP1W0dz8xAv79OgM5GKK1V/HAcUsdnl
	pgvBpl8ilmWnew9u6KHuRjKJZzahyBUwCos3eAD0+7NDYEk8FCO/tJ/+QfxWJKo1
	NN+wmNmm3MKaGSxq+hH8N5WoTiL7HqQZgs5IYjUAuWNQMS0IsoYhY9o/f3gJsggo
	i8YnWA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474e6j8bha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 07 Jun 2025 09:46:15 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6facde431b2so5374356d6.1
        for <linux-pm@vger.kernel.org>; Sat, 07 Jun 2025 02:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749289574; x=1749894374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOT1OH7Zs3RcqZzob/2wXtn6yUgIoxAj6wC5h6Z407U=;
        b=CghbmarXUCMCE0RAD96+h//9d3JBVbo+f5Ej0hwSMFmz2BwdktGv6WNn3VzQc8ICLz
         GMIovWsbadk6y0gNRpqL8i/sawmv9KjZ4nAuA3HdHseEz9qhe7H9Mocu96uze0rAWzCw
         rQ2goKNwwbqahX1wwppjB4dUAG6ctD5OeETjwHhcw+irEhjqNNuqTaIW0gvjpOhQiYnt
         ubcvdlL4sdNVcwCrLapjzkXG/5vknOn/2QUY3RFvTLll1ANpyw1eYKa9IAVPmVeFrmFB
         s40XU6513iFlGeWSnyDmhXr8h8/7kvxLx+Q6fYb/L1CeSGp4Fr2JFjB4sr3Cde1CogQq
         gjvg==
X-Forwarded-Encrypted: i=1; AJvYcCURORHPk+J3tm63mX2twKhj+Ev8EZ3Myb/LOKWidVErCvhtyk31c/w1KyVshpo2V83Rdla5ONpwjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgTlyPggJ7NVMMQy131Za6AWMeSQEjf9JfJ0t7gOqpc9yyJiI
	/AHjDtgbJ5JjOYnI+7PkDSeCs19VmXWr70lvBv/x1+7ygLfyYqQ9wpvmlN5KhhpOpY120wGBIwM
	sCcUSu3f5B8JRUj09I0PIum0pMbKFCjvIOf2Fqen6I2mdKcgKzwx4obCQCjUMgUysnRG3Wg==
X-Gm-Gg: ASbGncsImlsPRL89jMEnoowJCC53uhHZrVAiMOjCekpg4webJphFtGe1BgqKRGmnw1M
	aCWiR3Uf1u9i22baS2bOtb+SjewGL3DSr0CViHLvkgTks9NBjSImaStev+I7KbgRvK0fgHfE86/
	L/4k2V7AqtVoT8iRo3GuCiImP+d+dtzYkEg9AjdXVEHysjWXj7BCdRz8BP0PuKYYyCOXJXG3TRb
	ZhYXtboYJGv/uTDG5+Oqr07Q0xoBaghC6XIZ2NNSfmYITp1WiWNGwwhUovwDBHzxJQqa6lVJSwj
	ZAV4bmDloDt3S1zmw+EVbMwzBmiMtZ/mZBIkPgMCmOD0vuFX/FzeeUbsq2ewhuWtbWtaNirWhO3
	9
X-Received: by 2002:a05:622a:ca:b0:494:b4c4:8d7e with SMTP id d75a77b69052e-4a6691b6c5emr32043931cf.12.1749289574332;
        Sat, 07 Jun 2025 02:46:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwWPtI2+ioHKumywO8IMNaOAQ5iYNQdemythHKIGMF/B1bpE+Qxn0ZZITwuEqzQ+j9BmQlPQ==
X-Received: by 2002:a05:622a:ca:b0:494:b4c4:8d7e with SMTP id d75a77b69052e-4a6691b6c5emr32043651cf.12.1749289573920;
        Sat, 07 Jun 2025 02:46:13 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783c0581sm2174164a12.51.2025.06.07.02.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 02:46:13 -0700 (PDT)
Message-ID: <219a46d0-446c-4eed-8809-4f2400de0ef9@oss.qualcomm.com>
Date: Sat, 7 Jun 2025 11:46:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] power: supply: qcom_battmgr: Add charge control
 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <20250530-qcom_battmgr_update-v2-5-9e377193a656@oss.qualcomm.com>
 <f2e0f1da-c626-4cf0-8158-8a5805138871@kuruczgy.com>
 <8bb3a056-c00f-4ae0-a790-d742d31f229a@oss.qualcomm.com>
 <5knsdgk7o5zifkvzlrqiplmhztnsyhlxnqiuikqf4l7wkx2qvh@s3vzkiezw2bc>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5knsdgk7o5zifkvzlrqiplmhztnsyhlxnqiuikqf4l7wkx2qvh@s3vzkiezw2bc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Id6HWXqa c=1 sm=1 tr=0 ts=68440a68 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=j_8uj707ZTFaWRZCUGIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: -gqQbUTm_e3ilwOhEDHQrB41Gq3hsUeQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDA2OSBTYWx0ZWRfX9FMGsWQ4D4YQ
 iBLGuuIEmYkX9SIjoOB7bGpjKZhBCFBjcl8lUcN94U9nZwQSTKmBSTWqrapNijL1tx9WRsLEYfH
 25kdYtM3CZtl1bbYXqVBq7AVNDL7RljQtmU4+2f12OZtc2fMwvYN7y++RnaAqByODtffBtUnCBa
 AHEBqGuSY4JlD/1Z4+iqoo1Fejg25WH7mXw9wJmJdAVYqoNniJgEVt2S9vFZIA34U4NBFMhdRUE
 C/trvD6VykHUyXBidxJFseG4+xaO9S3kOvnBZtZ/nc0ZDOg0eZA5HK22I9h4eN7z4QLYAZrZ57l
 FbO5sIAFIZc5N0Mdl/uwxTHz3Mnj/EPv2y+NyU8mYqlif8DrdhFQ8Q3PZWEf0ZLRUuxIW+j1u0G
 zwPXwAaBt8lMpFnQsXjh7VdhYDOT4su7JxBU36epmRDxCpdZq4nzZ9N9m1G8JbLvC+YApWDM
X-Proofpoint-GUID: -gqQbUTm_e3ilwOhEDHQrB41Gq3hsUeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=759
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506070069

On 6/3/25 12:37 PM, Dmitry Baryshkov wrote:
> On Tue, Jun 03, 2025 at 01:48:11PM +0800, Fenglin Wu wrote:
>>
>> On 5/31/2025 6:36 PM, György Kurucz wrote:
>>>> Add charge control support for SM8550 and X1E80100.
>>>
>>> Thank you for this, tested on my Lenovo Yoga Slim 7x, the limiting works
>>> well, I finally don't have to worry about leaving my laptop plugged in
>>> for too long.
>>>
>>> One small thing I noticed is that after setting the sysfs values and
>>> rebooting, they report 0 again. The limiting appears to stay in effect
>>> though, so it seems that the firmware does keep the values, but Linux
>>> does not read them back. Indeed, looking at the code, it seems that
>>> actually reading back the values is only implemented for the SM8550.
>>
>> Right.
>>
>> Based on offline information, X1E80100 doesn't support reading back those
>> threshold values in battery management firmware, so I can only use the
>> cached values for sysfs read.
> 
> Which limits usablity of the attribute, it is now impossible to identify
> whether it is enabled or disabled. Is there a chance of fixing that for
> the X1E80100 platform?

Is there a chance we store that value in SDAM and can read it back?

Konrad

