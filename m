Return-Path: <linux-pm+bounces-27640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0ECAC3BE6
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 10:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA391888105
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 08:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F801E5716;
	Mon, 26 May 2025 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ca08TtmH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357A3258A
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748248991; cv=none; b=jJJdY1kMsMSP88HML3vTQNNQ4+Hsv4olPEveGRLf9RclxLQ05vmucU/8wqZb7gy1qMxGl5WGWIOkvaT3MyMX61izfSbIKWsJB+KUcn4amBxnBmPMbNGyML28iRol1F4vMiwZRXlwwu8HhoMo+nP2h0g72fQ4oPPuvFiWaVjgsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748248991; c=relaxed/simple;
	bh=wvtD7UOxWptjnLXoK3lgX+akul/om9cVgjZjaIgSqCI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mvYzpVdSXs77XUjUI+Km+bAjp0mH4i51VGAlqwVHxhi+dCcyOn3gb69vSFRdEmhUdd5PXKQyV01UIaVriWH9DKxTQFx1QaYE+nNJpD3PRdkh7vygZZ3W4zwzjz63To9YfNmbG8vK85bG4bVygwHHVHzYWwf3KtPCi9gfLwe3zlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ca08TtmH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54PNF1kj012378
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 08:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sinlLLdJcZNbmFp3xHrrm5fCnPkdkH7iM8nLujxdoeY=; b=Ca08TtmHn6xL1Kff
	9TY+DrLlT5tBGf2HciqNM3pLFiHurugr8mbxD+kee1q+ZRVdVXwhy8+pqMo3o1u4
	RHcv4lOz412qSamlE7WkpvGLTufVaR63UDAHpxqKPQVd1GtE4OPK8m93y4YZhW7E
	lzF9vbNQNfGZlllJe/gPfkZtPuOBrgdXcYbRp9LOrhuR3VZjLlX4/6HEv1KhEHEJ
	DjFyyhYfC6JakozqpmoPuQxEXaRqtn9w+HVMnSHmiKg7LKlN47EpHmsAtvkc2vNr
	819CDeb5zqiXjx9XPebktV4TdnaKYf9+8fra5jkTH9aXh1J/zgCE/fHwzES0fRwe
	xjcwdg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6b5kk9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 08:43:09 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-742aa6581caso1453131b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 01:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748248988; x=1748853788;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sinlLLdJcZNbmFp3xHrrm5fCnPkdkH7iM8nLujxdoeY=;
        b=W5psmydGvSpznXiibs/pv9K4QGxW8SNIQMwm3hKtvnaPiqFWmw3JnbbLADvKBtVHcM
         5kttDD/Xi0/NjazHNSc84AnO0QOyRPiOtVswvAo7lEStZ1GQc0Izi45i0Gs3L6JOcPMw
         cqKjSAZQqf3xYe8HTXCn0IcxYgXppFZtnvHIheYUrFP5hPWWVr23VsxwBiNqqyKqTsUU
         DCMCiLZO4AbEqQHrSi3PvzPMHSzsN9FKcS+HNxLKCyJUhhPmwvUUKLqpH2C+2kgAEe6p
         IitpR/4iRMCVa2pLDFXLsuBKkEP33JZNxxZqyFrb4NjelNWOrV6po8pvcrZ4RNwbsZF0
         DtRg==
X-Forwarded-Encrypted: i=1; AJvYcCVjfiS2wIcXH4sjfgfNSOqcK25NYh3lccViY7qTtVc4vFul/QT/WBRwjWwKcC/1Vmc3nQwVRNRjdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvbDE/9So36/ITpVdLnoa5yeuVu+LpC+q0LRPg6qUYU95DBrA
	+u3Dba0/BrQwebfvjXHDFHuKWRvczkbdILJbmh2rtxLtdAwLCXPvATPOTgGd0vFrODMvvwAoDRv
	8hx2/xVnIM61DQQyd4Ypj7PfHNPwml08Kk096KfFppdlFPM6GFusMoEcq8Hd2Wg==
X-Gm-Gg: ASbGncvtNEU4UWRMPrjC5cnucoccCvWV/Yxt0Ek6PE+l2iU2ksAfNT5zudJkIagwf8E
	i8zP/xj6go/GVHfWEj3rtGVnxqiPiA/FbQFUeawqR1gA2hhXog0MbAOYW5qbK93+aWNmOy1Mjt9
	TBgcQEe4BKWPxqEtkfS8HD7VF0N6e0jrp9BSV0OzohFzNKUsKC+gMZ5QFAACaAQBPaVuvNAQoBo
	HAc18LXnBPP9Pvm3NFOLs5he1CzcwsspfjtQfSe3Sy36hlyMxmCgKJ7Gg573wus3rDPKqCd1MLH
	0CF9XApuSRAoDyXtHuIUMVr9DRcgUxX/fw==
X-Received: by 2002:a05:6a00:14c6:b0:736:5438:ccc with SMTP id d2e1a72fcca58-745fde87a75mr12107165b3a.9.1748248988336;
        Mon, 26 May 2025 01:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoizJR5p+a89MPZAfJfUO3m/tGSDp0byZESTr1wQfYRLYacqwKo8ENa6edgbqkfWqehnyKgg==
X-Received: by 2002:a05:6a00:14c6:b0:736:5438:ccc with SMTP id d2e1a72fcca58-745fde87a75mr12107134b3a.9.1748248987935;
        Mon, 26 May 2025 01:43:07 -0700 (PDT)
Received: from [10.239.154.73] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970c8a8sm17197718b3a.60.2025.05.26.01.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 01:43:07 -0700 (PDT)
Message-ID: <a6deee53-6106-4e50-8d53-f1a87e50e9f0@oss.qualcomm.com>
Date: Mon, 26 May 2025 16:43:03 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Subject: Re: [PATCH 5/5] power: supply: qcom-battmgr: Add charge control
 support
To: Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com
References: <20250523-qcom_battmgr_update-v1-0-2bb6d4e0a56e@oss.qualcomm.com>
 <20250523-qcom_battmgr_update-v1-5-2bb6d4e0a56e@oss.qualcomm.com>
 <db0e40b6-22f3-46aa-b35d-7a8729370ddf@kuruczgy.com>
 <1b1c4617-0e5b-40c8-9a66-d243b48c0977@oss.qualcomm.com>
 <70b6d885-ca52-4731-9a78-80dd25248e2f@linaro.org>
Content-Language: en-US
In-Reply-To: <70b6d885-ca52-4731-9a78-80dd25248e2f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZcodNtVA c=1 sm=1 tr=0 ts=6834299d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=Htw2NgF16vZQhe7wStQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDA3MiBTYWx0ZWRfXwfOdMlB7JPIH
 4ryeY3v6xagZZJmQi8XM6NpcL00Bw401/6j0cXDqM/Urhr9selGbdnLwSL1lEJEJi1qRLXeOU9I
 cv4j6dFXzE6GVSTx56lpgalV75X0hM8Xl/jAzfYPkiWdSN8ekM7uJdPegF4dUeqg7pp0PyhhW4d
 43SfwS3RT17j5zr5r81cxQ965Fph9XxuFgdwHwuBFUdPdorsyd2lLR2lCGsWO8UVe+HmdB+ToC3
 5rfJJY1X0TewqNtIu1aQWDx7H9VRgKo0+/cGCfjqr2cPfoI90VUJF2qRUtCnJeYQ6R91Z/Wny44
 7io6O/hDUl949A4KyT342H0IyZl7R1t2k3P3cFDDbYWYHZIYXWi2ZD3Ek195oOglGV5gfPTlDUj
 P3YJ1GXgdi33k70zgPkIUTrlf7v/+JHe+tPKyI65hw81AMgzc2jyJml4HyklVzjPEfJ4W08G
X-Proofpoint-GUID: bcGpHsyUZYxlkClr-zx3fYlMob_6vlf2
X-Proofpoint-ORIG-GUID: bcGpHsyUZYxlkClr-zx3fYlMob_6vlf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505260072


On 5/26/2025 4:27 PM, neil.armstrong@linaro.org wrote:
> On 26/05/2025 08:19, Fenglin Wu wrote:
>>
>> On 5/24/2025 5:29 AM, György Kurucz wrote:
>>> Hi!
>>>
>>>> +static int qcom_battmgr_set_charge_control(struct qcom_battmgr 
>>>> *battmgr,
>>>> +                       u32 target_soc, u32 delta_soc)
>>>> +{
>>>> +    struct qcom_battmgr_charge_ctrl_request request = {
>>>> +        .hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
>>>> +        .hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
>>>> +        .hdr.opcode = cpu_to_le32(BATTMGR_CHG_CTRL_LIMIT_EN),
>>>> +        .enable = cpu_to_le32(1),
>>>> +        .target_soc = cpu_to_le32(target_soc),
>>>> +        .delta_soc = cpu_to_le32(delta_soc),
>>>> +    };
>>>> +
>>>> +    return qcom_battmgr_request(battmgr, &request, sizeof(request));
>>>> +}
>>>> +
>>>> +static int qcom_battmgr_set_charge_start_threshold(struct 
>>>> qcom_battmgr *battmgr, int soc)
>>>> +{
>>>> +    u32 target_soc, delta_soc;
>>>> +    int ret;
>>>> +
>>>> +    if (soc < CHARGE_CTRL_START_THR_MIN ||
>>>> +            soc > CHARGE_CTRL_START_THR_MAX) {
>>>> +        dev_err(battmgr->dev, "charge control start threshold 
>>>> exceed range: [%u - %u]\n",
>>>> +                CHARGE_CTRL_START_THR_MIN, 
>>>> CHARGE_CTRL_START_THR_MAX);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * If the new start threshold is larger than the old end 
>>>> threshold,
>>>> +     * move the end threshold one step (DELTA_SOC) after the new 
>>>> start
>>>> +     * threshold.
>>>> +     */
>>>> +    if (soc > battmgr->info.charge_ctrl_end) {
>>>> +        target_soc = soc + CHARGE_CTRL_DELTA_SOC;
>>>> +        target_soc = min_t(u32, target_soc, CHARGE_CTRL_END_THR_MAX);
>>>> +        delta_soc = target_soc - soc;
>>>> +        delta_soc = min_t(u32, delta_soc, CHARGE_CTRL_DELTA_SOC);
>>>> +    } else {
>>>> +        target_soc =  battmgr->info.charge_ctrl_end;
>>>> +        delta_soc = battmgr->info.charge_ctrl_end - soc;
>>>> +    }
>>>> +
>>>> +    mutex_lock(&battmgr->lock);
>>>> +    ret = qcom_battmgr_set_charge_control(battmgr, target_soc, 
>>>> delta_soc);
>>>> +    mutex_unlock(&battmgr->lock);
>>>> +    if (!ret) {
>>>> +        battmgr->info.charge_ctrl_start = soc;
>>>> +        battmgr->info.charge_ctrl_end = target_soc;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int qcom_battmgr_set_charge_end_threshold(struct 
>>>> qcom_battmgr *battmgr, int soc)
>>>> +{
>>>> +    u32 delta_soc = CHARGE_CTRL_DELTA_SOC;
>>>> +    int ret;
>>>> +
>>>> +    if (soc < CHARGE_CTRL_END_THR_MIN ||
>>>> +            soc > CHARGE_CTRL_END_THR_MAX) {
>>>> +        dev_err(battmgr->dev, "charge control end threshold exceed 
>>>> range: [%u - %u]\n",
>>>> +                CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (battmgr->info.charge_ctrl_start && soc > 
>>>> battmgr->info.charge_ctrl_start)
>>>> +        delta_soc = soc - battmgr->info.charge_ctrl_start;
>>>> +
>>>> +    mutex_lock(&battmgr->lock);
>>>> +    ret = qcom_battmgr_set_charge_control(battmgr, soc, delta_soc);
>>>> +    mutex_unlock(&battmgr->lock);
>>>> +    if (!ret) {
>>>> +        battmgr->info.charge_ctrl_start = soc - delta_soc;
>>>> +        battmgr->info.charge_ctrl_end = soc;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>
>>> These function names sound quite generic, but AFAIU this patch is 
>>> only adding charge control support for the SM8550. Is sc8280xp and 
>>> x1e80100 also expected to be supported using the same 
>>> qcom_battmgr_charge_ctrl_request format?
>>
>> No, sc8280xp and x1e80100 don't support it. So I didn't add the 
>> support for them.
>
> And what about SM8650 and SM8750 ?
>
> Neil
>
Both SM8650 and SM8750 support charge control functionality. I saw 
SM8650 has already used "qcom,sm8550-pmic-glink" as fallback compatible 
string, so it will have it enabled by default when the change gets 
accepted. SM8750 platform can also use "qcom,sm8550-pmic-glink" as 
fallback to support it when uploading the DT change.

Fenglin

>>
>> These are generic functions are similar to 
>> "qcom_battmgr_update_charge_time" and "qcom_battmgr_update_info" 
>> which are only used for sc8280xp platform. Even right now charge 
>> control is only supported in mobile platforms starting from SM8550, 
>> however, it could be potentially supported in battery management 
>> firmware of any future platforms and the same functions could be reused.
>>
>>> Thanks,
>>> György
>>
>

