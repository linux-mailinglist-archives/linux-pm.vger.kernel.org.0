Return-Path: <linux-pm+bounces-22463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9541DA3C735
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 19:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605973AA19C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 18:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DE2214802;
	Wed, 19 Feb 2025 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nkF8PQfI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7401BAEF8
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989020; cv=none; b=a3iq/IvRi8WLTni97DAUZWxuvl1O83gUJ5mSPH4jHAMRA8PefJGs8yUc8xv06ZIfIXIoW2iAsw7lwrim8ZR/DXoZSc095ZWs48EifOmcpFXLOdZZwNGbCBVvVdmjh2yDq11dHeZ/1H/aLBAuOGPo37D9UXEMcult3P5M1/B7Sqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989020; c=relaxed/simple;
	bh=15VaQUR3mVRx8iK8PNZZm73Twuwc4zEsxbB0vznGbtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N88lTVxV+n/Q4GaxvrWJIaQOiamac40PvCVnH3yv+ZODCMP6ZuYg4I0mwmHJjWXgdPKUbjGDWJMOAmD7wM6xwGdGuUd/44udPKaVyRvialj/APMJHTvFOD22bmJm2Q6ziL1m/32WT+qJWgiCwVSqeIoQUiraoAsP5+YF9kqAbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nkF8PQfI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JHCqQD026872
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 18:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qQslAvi5S986c+CjPVwrSpIZbbdcJIt8ngmHdJF+C/U=; b=nkF8PQfIfQje6KRr
	KSwQyilucMEK03aWgOdWOQcMz0xUn7tFMNh1KmwvNpCsHwh3giSMAbgAiQnQhSMo
	LLBemn5CCafeGH7ioa/s4KcOQ12No3Mnv7s0bKrTgRVizxN9/r/7Eh7G4GIqmPWS
	Wb/vKUXjxYWQA8MYykdPH+3mqwiFTVIHrI1dVeilISCDE+8BKudmRdnTxdThMmQJ
	Z6G5bI6MqIyKu8lm+iFwlUja2RwbUtQp0UoMIFob4NoqpHX6FSiEZ/9LGnyG7IYV
	iyJKYu69UINKTejKxldrLycXfom28oHUbJIe/uczQzZ/uhFevB8EMVT6vrN8d2oL
	mRDP8w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy0kkj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 18:16:58 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc518f0564so155215a91.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 10:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989017; x=1740593817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQslAvi5S986c+CjPVwrSpIZbbdcJIt8ngmHdJF+C/U=;
        b=Y/ROg2kohWqYs5kKzgSuEaL60Q66zX8DaDlI7qefOHro4vw1SRt6GDpqUS/zzOygXF
         mzrIezmQNBGwK0uDW/NhM0o+Q2c1v9eZdLxyg6i15IckA6vAVRbD1dwD3gJ+G7L2t6KN
         NJqB04kk1xZSPRzoC7LvpHXGu0GI1UkDiFz3qaJvOdkXMWKSDdxr0ghp7KdnBhW6ouyH
         XYJz48F3IHwgpjydogFuDV7RUJUAyDpu6H3DAFbopID4eoOmnaSLMuua3W/4r0bE33Do
         hzNCj5oJMC2puFAffUjcR5Ra4CUO4EN+GompQiN5n1xXLUYhhOqRtI0CsuL+79/Prijy
         zE+g==
X-Forwarded-Encrypted: i=1; AJvYcCU/eE5uAKhRarAKJ/IF5paA2MsllCBDSK9LBTVfvjCpuowQkwHRcFv1D2VSzv7FPtqkW7SbY+0ZGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFW45RcJGCWFMrldueSX5/j9cxCZTFtHLH/XkZklGLbeMEEH8D
	pvlS1C3UMWiV2ssbqertlFaNfnR2l6SyZFTFKvmJ0MKrmwTA54uQpxyzZU+XNB3yVsepzzL+TdU
	NaYoJxpo8O7OwuRg/of6hhC24+cj+Wr17Byf1cQFgeEa85A6oIahz8L2Olw==
X-Gm-Gg: ASbGncvhJ/i2iDQUNNYRzjA4sPfqBSJHQp8V9bHio73iwAKCoozQxROAI8779EEuDwn
	5QB228OWMKIO4Axy3MOzShieeQMQTWg9LHqVV1Py2KOK7XkdMFGsI9M8Y2H5nLclFRgKnUO9l+j
	duDaGKGmOOoL0xjT0IOdtKGwDT6ZUQdsp2iedOmh0uDyvM6in8F0F7Eo1f34PmZh+GwFafiThZB
	jULVotrrbxpm9sCBeN//0UoVxSDNXAQykqPqlltfv6HU8RX7EaHbELrpyUZGfYB7PDj/whR8Nmb
	Y8Z+nT5WWL/Fqoy/PTPsLtJAuyr7S98+1sxHqyDyjBNrU2XVzrM6ECMA401qWyhWP2+Ynw==
X-Received: by 2002:a05:6a00:4fd6:b0:730:8386:6078 with SMTP id d2e1a72fcca58-7326144b06dmr34414959b3a.0.1739989017267;
        Wed, 19 Feb 2025 10:16:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkfav6Ju8/K3VElkqoRX368Q55GZumfH5apyL2HHSvMb+wlEvPQ8L6XzFqhtEEGHHEmIMxAg==
X-Received: by 2002:a05:6a00:4fd6:b0:730:8386:6078 with SMTP id d2e1a72fcca58-7326144b06dmr34414855b3a.0.1739989016806;
        Wed, 19 Feb 2025 10:16:56 -0800 (PST)
Received: from [10.71.108.77] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324f22fd95sm11016795b3a.11.2025.02.19.10.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 10:16:56 -0800 (PST)
Message-ID: <a9ab6b36-0801-430d-87e4-c02538510127@oss.qualcomm.com>
Date: Wed, 19 Feb 2025 10:16:55 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] thermal: qcom-spmi-temp-alarm: add support for LITE
 PMIC peripherals
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        david.collins@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250213210403.3396392-1-anjelique.melendez@oss.qualcomm.com>
 <20250213210403.3396392-5-anjelique.melendez@oss.qualcomm.com>
 <2v2nxdv2ofd2cwvatrpmo6w7o46o26y6w77myioailuin5ymal@z2mabzkbcrgl>
Content-Language: en-US
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
In-Reply-To: <2v2nxdv2ofd2cwvatrpmo6w7o46o26y6w77myioailuin5ymal@z2mabzkbcrgl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tejbAYZl0LmeFz1J75GOBZN6lAUxnHjM
X-Proofpoint-ORIG-GUID: tejbAYZl0LmeFz1J75GOBZN6lAUxnHjM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_08,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190140

On 2/13/2025 2:09 PM, Dmitry Baryshkov wrote:
> On Thu, Feb 13, 2025 at 01:04:03PM -0800, Anjelique Melendez wrote:
>> Add support for TEMP_ALARM LITE PMIC peripherals. This subtype
>> utilizes a pair of registers to configure a warning interrupt
>> threshold temperature and an automatic hardware shutdown
>> threshold temperature.
>>
>> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
>> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
>> ---
>>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 204 +++++++++++++++++++-
>>   1 file changed, 203 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
>> index a10f368f2039..081db1a85b8a 100644
>> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
>> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
>> @@ -22,6 +22,7 @@
>>   #define QPNP_TM_REG_TYPE		0x04
>>   #define QPNP_TM_REG_SUBTYPE		0x05
>>   #define QPNP_TM_REG_STATUS		0x08
>> +#define QPNP_TM_REG_IRQ_STATUS		0x10
> 
> Is it a generic register or a LITE one?
> 

This is generic register. All temp alarm devices have this IRQ status 
register at 0x10 offset but only temp alarm LITE devices read this register

Thanks,
Anjelique


