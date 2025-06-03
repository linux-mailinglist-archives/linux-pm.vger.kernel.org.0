Return-Path: <linux-pm+bounces-27984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B0EACBF5E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 06:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E04188A376
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 04:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CA41F418E;
	Tue,  3 Jun 2025 04:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="epiK/rGd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4051F3FF8
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 04:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748926235; cv=none; b=OMjgcFUO00KVSQ6Gn/0IchwiwMMljVf3uZci2Hp//WfX7JFgO/16W09PalRRDsn/bO0mnYBV+277kAoCyX/UYvKwcO3P1RHpTr1ejK3y7wUdBxf6EkwSgUMWXD6jtM82qBvN7y3XAn+4jneKkv3a7BxtjuhDVcdFHyMAbYZ9jqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748926235; c=relaxed/simple;
	bh=EAWMMPXYQsq5FrA4pI/irtKbs8fNougcyOgPFx6H7xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0APPP9pU5Y7D2KYuIP4QNNeku9DcSjtZItL++WJac4OylgEXsgZS7jwE40Tt1HNdhgOjj+qX7ZVihv7lQfbCUHLrJfDi/9FeTqkQ1A37I9nUdGaRCOddl3J6uigI6yGicqYB/2dWra5TYjOoQLgBzSPpUU6SCZ4AA/4JQuG3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=epiK/rGd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HK83c013872
	for <linux-pm@vger.kernel.org>; Tue, 3 Jun 2025 04:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gPgbSgzbuSX+oCXLN0CPOpwtJsFOAf4HOx9xrqhDi6M=; b=epiK/rGdoF+xny/0
	VJrSdYTpZI0oBOJhhVEV/y/wJHUY9qTplfLc4k10k/oI1kd/9R8mILzYYOo8Ppty
	0AjbWAeuSK47RC5WicIbcnmA10rEPRr5L5HO1KLyli8N0XeCYi1Zran/TWNUOEdn
	lZh3fOdorweK1xT3wdQsTh141SiUnBmNnH+tNnj56wsOtY1mPiTokZVEFfWKT45t
	S3yDYKH+6Nw+OyFlTKs9t/ILZvcXs/BKhSOYrXDPxZhfKa/2AOx2wBiShRMYLW0L
	lFFOYCGR9/iWwdVhjnLfDd3kzrMLbSpww53M7ipNjzbImqdmzkRuBWNEOhIW4X0j
	7uptJA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g91hac8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2025 04:50:25 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74620e98ec8so4374594b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Jun 2025 21:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748926224; x=1749531024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPgbSgzbuSX+oCXLN0CPOpwtJsFOAf4HOx9xrqhDi6M=;
        b=tkUDIEz1Q6EEeia85B/Q1YBgKB4fh5qKPIUZQVcdmCmPhSs/JIjt9rMee7zqf16x5a
         ZdDu77ym3g2QHKTB/pT62+L5YQuutqt4EapKYqvhk4eQMxFylIjyeL8e8CfP1i6wb4Yh
         xbFKaqRnfTeFDGjEKaJN6/9d6aJD4ENIrmTUPROu4zvX03mw++fLZjI3fXomzuTAk1eh
         zu4WpxmVvThgHl9MlcNFZAwfUWp4B6VAeEPhTkbf6KBNqQDFqpTaLSReY4pAUgapira0
         ck8QOQ5Gy9wy3fRi0AX5AAEVdz3R/DxFUrLzA/SbRFRJPmEnMZ9USCe/i4IqLvrx+P2A
         S8mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdUQwCwyCNz4UqjXr8P3AsRV9yma9AIeVqITFd4lAHkzDo6bA4pBioCvIVLpWVqjP+U7ODxHGMlg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yykqk+UD4YafTxrmzrva+xJPETghZl2L8K2OMtneej+ijd8M1G+
	fXbnBibSVy6T9hWRTuzsKsjNazcn+vFKGIIsGWe0OqUvYBNbPglpeEqBteY/RWfFsPBuVwDEJXZ
	pe2f+/Jb0yzJDAS24Y7gFCUpQtXWQZ+hlvGKru7uzQ18SBluFfPh2xZJkCiiTlw==
X-Gm-Gg: ASbGncuBIAQqlt4z2Wv/S4x1dHmIcAdy+67BL0N0pCTJUoKd7n9z/TaYhUBwtmYuuaX
	zmYcPCioN80YzvKly0eoDtzUyNebYt9X3NEXCnSW7X4eK8uNeD81AIUAYSAnBqgXAF8lwHmwLyJ
	uuYJE1IIKM9MzpBjIEhOvzAfxOWdLO/2bMXSP/ZY+qGz4tbcMvy6L1VU7Wj22Wy7A94oH0Fn/sX
	zZyD3dcAT1eLcrCKxFtGZoQOeIybw2aI5QWVLrop5bNVn2eim7wGA5VuqqDzbO4JdftvoGkuMkm
	9l+1JFiwwAwy7LwRLpcXr7CXOKn9mj6P/z+tGb1MqJT+xiTB/aVYYqeddQZPicukcA32ETZb8qy
	F6IfQnLrPa24=
X-Received: by 2002:a05:6a00:1a88:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-747fe0592ebmr1545687b3a.10.1748926224410;
        Mon, 02 Jun 2025 21:50:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/MNuXs73ZR7bdTTIBXIjCQZZHAjylXKanogS/OWyKFVp5YdY/f9egp4CsPahXdsrioevBJA==
X-Received: by 2002:a05:6a00:1a88:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-747fe0592ebmr1545650b3a.10.1748926223981;
        Mon, 02 Jun 2025 21:50:23 -0700 (PDT)
Received: from [10.133.33.126] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafac9sm8492120b3a.112.2025.06.02.21.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 21:50:23 -0700 (PDT)
Message-ID: <cd2964b0-e28e-4ddb-b319-9b65fb78b73c@oss.qualcomm.com>
Date: Tue, 3 Jun 2025 12:50:18 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] power: supply: core: Add state_of_health power
 supply property
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <20250530-qcom_battmgr_update-v2-2-9e377193a656@oss.qualcomm.com>
 <6oixvnhihgjucqaovkayzm6cpi35jfmtwmm67wa6h4nlmhr6w5@ggb7auvjzos2>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <6oixvnhihgjucqaovkayzm6cpi35jfmtwmm67wa6h4nlmhr6w5@ggb7auvjzos2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDAzOSBTYWx0ZWRfX2yIgarkEoBPK
 MfX8ytBQZx5bpVBfobMmkHBdcrf3YVq6/cOe1pNZ9PJ7jc2WLkOKQYF+Ghvn6/mX0eKBF783eJX
 cpZMfXRk2sKNQvAMZtoIFkiyvumSM6jvVLtdycUy9C5gXn4CbOIP5KNbHxmjagHnjNfmS7ZMSzQ
 vr+LMMUw01yYX4+rwiQ4u3rxMi0RqSo/w9bSEMYmPIrlQjevwER64+fPZabSAP2mwTW8XMQZMHo
 Id/Pr7Eb37WrYkgdDhv25ZyAvEHSWmYjTTrYeB6xZAPFW4lDjFl7bQlFF65uTaYLu/PqPu0c8WI
 fYuPYDuORuAXoZ4URWWLc/723Co/+pokLsBI4jQhYCqeNmnXs2Z23+SEV3nFAenCK2nfRpqGgM9
 MDmGcBNeUpx/VTde786pFFm6/uYAeQpf4lqM+OxnjtRQLqUCMO24ZD2HeMLdejuZIbf+B7lW
X-Proofpoint-GUID: GdvRs3e7LvlRy1gnSgkqTCV3QwufL12y
X-Authority-Analysis: v=2.4 cv=KYHSsRYD c=1 sm=1 tr=0 ts=683e7f11 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=vB8V-zSZfwPQ_sZj9vMA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: GdvRs3e7LvlRy1gnSgkqTCV3QwufL12y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030039


On 6/2/2025 2:17 PM, Dmitry Baryshkov wrote:
> On Fri, May 30, 2025 at 03:35:07PM +0800, Fenglin Wu via B4 Relay wrote:
>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>
>> Add state_of_health power supply property to represent battery
>> health percentage.
>>
>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>> ---
>>   Documentation/ABI/testing/sysfs-class-power | 10 ++++++++++
>>   drivers/power/supply/power_supply_sysfs.c   |  1 +
>>   include/linux/power_supply.h                |  1 +
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
>> index 22a565a6a1c509461b8c483e12975295765121d6..74e0d4d67467500c3cd62da3ae0b2e4a67e77680 100644
>> --- a/Documentation/ABI/testing/sysfs-class-power
>> +++ b/Documentation/ABI/testing/sysfs-class-power
>> @@ -562,6 +562,16 @@ Description:
>>   
>>   		Valid values: Represented in microohms
>>   
>> +What:		/sys/class/power_supply/<supply_name>/state_of_health
>> +Date:		May 2025
>> +Contact:	linux-arm-msm@vger.kernel.org
>> +Description:
>> +		Reports battery power supply state of health in percentage.
>> +
>> +		Access: Read
>> +
>> +		Valid values: 0 - 100 (percent)
> What does it mean that battery has 77% of health?

I will update this to explain it better:

Reports battery power supply state of health in percentage, indicating that the maximum charge capacity has degraded to that percentage of its original designed capacity.

>> +
>>   **USB Properties**
>>   
>>   What:		/sys/class/power_supply/<supply_name>/input_current_limit
>> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
>> index dd829148eb6fda5dcd7eab53fc70f99081763714..12af0d0398822ff23d8970f6bdc8e3ef68081a1d 100644
>> --- a/drivers/power/supply/power_supply_sysfs.c
>> +++ b/drivers/power/supply/power_supply_sysfs.c
>> @@ -221,6 +221,7 @@ static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
>>   	POWER_SUPPLY_ATTR(MANUFACTURE_MONTH),
>>   	POWER_SUPPLY_ATTR(MANUFACTURE_DAY),
>>   	POWER_SUPPLY_ATTR(RESISTANCE),
>> +	POWER_SUPPLY_ATTR(STATE_OF_HEALTH),
>>   	/* Properties of type `const char *' */
>>   	POWER_SUPPLY_ATTR(MODEL_NAME),
>>   	POWER_SUPPLY_ATTR(MANUFACTURER),
>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>> index de3e88810e322546470b21258913abc7707c86a7..dd0108940231352ac6c6f0fa962d1ea904d81c7a 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -175,6 +175,7 @@ enum power_supply_property {
>>   	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
>>   	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
>>   	POWER_SUPPLY_PROP_RESISTANCE,
>> +	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
>>   	/* Properties of type `const char *' */
>>   	POWER_SUPPLY_PROP_MODEL_NAME,
>>   	POWER_SUPPLY_PROP_MANUFACTURER,
>>
>> -- 
>> 2.34.1
>>
>>

