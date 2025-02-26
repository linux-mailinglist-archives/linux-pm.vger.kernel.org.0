Return-Path: <linux-pm+bounces-22975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3D4A458DA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 09:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298E27A5C83
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8771A22422D;
	Wed, 26 Feb 2025 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLT8qfUn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58C20CCF1
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559875; cv=none; b=NeYBOt1++8rCnNRv91WaXDu8yLmTlaoy0VkWZ2Ix1/vx4S6O9k1MufOCeXab05LtIT8Ve4u0/+4pCgA17FtTb7GL2x5X5aLb9Z049bL3wYdISvMgzigM98UGgn5KtGDIyI3RDAF0w63bJvhBU230+6NokKT9yx76AR/lzR/uIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559875; c=relaxed/simple;
	bh=2viEWV9e7kJ90xVYLnVBY1QMwCp8ekGrGx1sdCvA9Zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRnrlf5rRkwnYo1L7gYLQ6lW2AVQAjmT6E1TZhbxyURTq9AV+XJVw0j7/NhyEodAxoABpzqED0dCAvWq1kFTWY52RELVaQ9gpxuTuWggjH56RHyFmeaSnBKhri2j56EyEHFsH5HmWlMlFZL+kUw2vkP8cPsKQU5HUlb5W1PIIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLT8qfUn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMX7bZ025285
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 08:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7aWGZVyJ1OvaCe4Hv0tS3ZL8LfJtxhk7LYTNGSNU6L0=; b=gLT8qfUnLMac3K+0
	2r+29PMc9DNYly3kgsw4apDA+HnfO6ibynP5Zz+19AXnbDx6RJKY0MzmBQSYn/2o
	4TSOW+DNlBR3kvoIObHNWCdL1SLI5chFzQSIfwuji11T2X9W2onuI36OlNIu8A0L
	xWsJAkbHxzG7NgMLJE+7R7OCR0wfVRgiobB293zpKxlxr22va5E7aAYeyvZ4NUMB
	sgyNzxwm++rvZdUjj21rykf4XkRl2rzuupqPGRbQQmwUJsNv3nMyL0OFuNMdWC9Q
	xUxayUb/fqAZ5evkcbvU7fPuv+bZ7scsey708vL1EJckuRT/SeRL4ZusiHyCp/Bk
	KjODZg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prmhbbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 08:51:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fe916ba298so132281a91.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 00:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740559871; x=1741164671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aWGZVyJ1OvaCe4Hv0tS3ZL8LfJtxhk7LYTNGSNU6L0=;
        b=qAR8w4Jgt0GnN8ULrEIPoa/cWBm3K9icxsltEK5jcAEFHVWWuW2QPCLUWmYyhVjZI0
         vTry9WKEU4JB5BW4Joi8TaS48OCg5wKNuo6jENS/2HEX+QWUbs0RSh2uro6gMzHS4rS0
         ijd59mZfZ9BNLxjvOuaCl+tuM8ePaxHouBbYXaJqgJ1cKrNvbdgRjQsnGUQj7tATbN3U
         YYcQCv8rbhvlAguDbg7D6zsPHPSVpZxIu2HcB2ngMURq0LzpCMyQo/NnGPFlyUjoNHDE
         M9rRlmBHvSj3ZqnsD4xqAu97gTcu5UKxBb/AviYffRdeuGMj4uFRUwIsf5ZN1xx46p9V
         /9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUsZpxlMbJ2/kGm7O+wJtFHCDPkd4l9pecFwvsVWgTrHu3tDashqTBHJKWZm1BHWZB3UQd6Jqt6TA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPDzZrWcMf97YIc2NWgG9yp+g1tbEnVXK1O2BcNo4/ZrVgKCNj
	qYYxiHWkbfHc8pfB6iuj9j1c9dNPfHjk32uxCkn0ZnStnUUjEK++LG67IjRSjw9dOHlRw6hZahz
	rtlhnq0yAa6NwDRHSU6qmFQs3+J3dlzGVf3qZlJIoB8gl4CTRehgOBFHBqw==
X-Gm-Gg: ASbGnctSWsxfgvfgQiuzZzHO9cmSmUk6R39ZtmS7Ma4Hm8o3snXAlj7go3s4pGbVvze
	lEUapVcevWycB0G+SnokxnoVcIk+B0TiAuRMDz69rWDXzBc88nHdvdvJIdMLWhlgDIBhkcBmcEB
	6jW0qY92Xlyh88LrHuALxBTpYFR/A1cAz0Yli71H2oxu4Ik2Mo2RbB4qjDx7idUGNDEQ61AiHT4
	Xtn/Kj9O8S5rUH7CNVRmBbmglJAv3koxS1QvqHZe7F+N9gKV/Z3Ysxh8zoT5xnO5BCkz+N23sO+
	wepgb0KTlnZ1Jy9e/9LmDqxqR7hw3/WknEzD8jauI90R
X-Received: by 2002:a17:90a:da87:b0:2fa:1f1b:3db6 with SMTP id 98e67ed59e1d1-2fce875b1e1mr32942270a91.29.1740559871060;
        Wed, 26 Feb 2025 00:51:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECiylrQlK960oN+myaYEe+QpHxYo2jDM3eXLVu6qHaHgHcEk+DCVPvWzFzdemQRAZ62hc97Q==
X-Received: by 2002:a17:90a:da87:b0:2fa:1f1b:3db6 with SMTP id 98e67ed59e1d1-2fce875b1e1mr32942218a91.29.1740559870642;
        Wed, 26 Feb 2025 00:51:10 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d31f3sm1038485a91.28.2025.02.26.00.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 00:51:10 -0800 (PST)
Message-ID: <cc328ade-a05e-4b1d-a8f0-55b18b4a0873@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 14:21:01 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/5] dt-bindings: iio/adc: Move QCOM ADC bindings to
 iio/adc folder
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "Rob Herring (Arm)"
 <robh@kernel.org>
Cc: jic23@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
        lars@metafoo.de, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_skakitap@quicinc.com,
        neil.armstrong@linaro.org
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
 <20250131183242.3653595-2-jishnu.prakash@oss.qualcomm.com>
 <20250202-convivial-stingray-of-promotion-1123b8@krzk-bin>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250202-convivial-stingray-of-promotion-1123b8@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BC4x0k7_4Dxtryc5QDa38lCICIPT2TqC
X-Proofpoint-ORIG-GUID: BC4x0k7_4Dxtryc5QDa38lCICIPT2TqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_01,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502260070

Hi Krzysztof,

On 2/2/2025 6:59 PM, Krzysztof Kozlowski wrote:
> On Sat, Feb 01, 2025 at 12:02:38AM +0530, Jishnu Prakash wrote:
>> There are several files containing QCOM ADC macros for channel names
>> right now in the include/dt-bindings/iio folder. Since all of these
>> are specifically for adc, move the files to the
>> include/dt-bindings/iio/adc folder.
>>
>> Also update all affected devicetree and driver files to fix compilation
>> errors seen with this move and update documentation files to fix
>> dtbinding check errors for the same.
>>
>> Acked-by: Lee Jones <lee@kernel.org>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---
>> Changes since v4:
>> - Updated some more devicetree files requiring this change.
> 
> I don't get why this fails building and nothing here nor in cover letter
> helps me to understand that.
> 

I have tried checking multiple ways for anything missing in my build setup, but I'm not getting this error when building in my local workspace. But the error itself looks invalid to me.

This was the error:

    dtschema/dtc warnings/errors:
    In file included from Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dts:80:
    ./scripts/dtc/include-prefixes/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h:13:10: fatal error: dt-bindings/iio/adc/qcom,spmi-vadc.h: No such file or directory
       13 | #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.

My patch moves both "qcom,spmi-adc7-pmk8350.h" and "qcom,spmi-vadc.h" from the "/include/dt-bindings/iio/" folder to the "/include/dt-bindings/iio/adc" folder. "qcom,spmi-adc7-pmk8350.h" internally includes "qcom,spmi-vadc.h" and I have updated its path too within the file. These are the relevant changes from my patch:



    diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h
    similarity index 97%
    rename from include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
    rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h
    index 3d1a41a22cef..161b211ec126 100644
    --- a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
    +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h
    @@ -10,7 +10,7 @@
     #define PMK8350_SID					0
     #endif
 
    -#include <dt-bindings/iio/qcom,spmi-vadc.h>
    +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>




    diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
    similarity index 100%
    rename from include/dt-bindings/iio/qcom,spmi-vadc.h
    rename to include/dt-bindings/iio/adc/qcom,spmi-vadc.h


I have tried checking for other similar changes where dt-binding header files were moved and other files (driver, DT, documentation) updated in the same patch, but I couldn't find any similar enough to this case.

Perhaps the kernel bot is not able to properly handle this case where multiple dt-binding header files are moved and also one of the moved header files includes another of the moved header files, with the new correct path updated.


Anyway, I think this could be fixed by splitting this patch into two. There are two ways I can see for doing this:

1. In first patch, move qcom,spmi-vadc.h alone, updating its path in all other affected files. In second patch, move the remaining dt-binding header files referencing qcom,spmi-vadc.h, with similar corrections in other affected files.

or

2. In first patch, copy all the relevant dt-binding header files present in "/include/dt-bindings/iio/" folder to "/include/dt-bindings/iio/adc" folder. In second patch, update all other files (.c, .yaml, .dts/.dtsi) to use the newer ADC file paths and delete the header files in the older "/include/dt-bindings/iio/" path.

Which approach do you think is better?

Thanks,
Jishnu

> Best regards,
> Krzysztof
> 


