Return-Path: <linux-pm+bounces-27634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D4DAC39BE
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 08:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97E73B2D68
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 06:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D4C1D5CD9;
	Mon, 26 May 2025 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KhrzV4+p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C81D5142
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 06:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748240398; cv=none; b=FustckG8NBPo8/oqbU2VDp4faKSFG4s2w3+Tz5GXs0OfaRj1PyPdUGsnpzqpLBXlSYkv8shpRffYQoptOPoJkWiARP25L5CsGVHXA4FgnVl2ALANf0sATcoaCtZQWS8WiOcLFstS5pB7KOfV/7kHiyQ3KC5vAJ8tvobgX0BTA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748240398; c=relaxed/simple;
	bh=kfKqrjxj7SWq9xEU4Nr35KADHrm9QuM4zBWdzxTlRIU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qoTx3k5Z/ylWcPu+xpqfGiAlk3LG9V/db6cxhkaaZK7pZ9yFeNAVRpiNo3DdFMOKG5oo93hpyGLK2YNrLNDiObfBbkuOSVw5iZK/3eziZpUdql6lLTAPKM5Av/YLSA0aw1L1RxiXfr4d/HrvTY+49EB3AGDXlOB8pn8r2NLHKmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KhrzV4+p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54PMeJSV020729
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 06:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jrpH81vVpBiCOEXoQcJthbVv1fuikJmHn767rBuFXaY=; b=KhrzV4+pKtB3HxOM
	uoWDa0wzmqu7cl5SPPw5PVsjzh8XrbdG5x5XTEtVAdlV24GaDnE8ilHcKbmiexEc
	fuL8imxn0TGSlfLn5O7bR/0n0a2AJ0sotBii/PhKG/l/Pq5KykJb2l9shCGzaGSb
	2QP4nPYWeSatrmbDvNOrM482BcTqcVYttDrGkln+NZwMt3F9dYZp1omaAJbZnMor
	27I8g2UC1OQnRS6KBYCFCmF3Uk1IXHnJq+fJAHkimeydKkOjdw1viIyEedrOcooy
	RPtc5bXp/rgH4bY1P8tMMsDOUcnu5BtGu2sCEKlo2Qy5czoR0T4XJwCsHAfezoWL
	rdvuuw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u5eju5q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 06:19:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7391d68617cso2187586b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 25 May 2025 23:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748240394; x=1748845194;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrpH81vVpBiCOEXoQcJthbVv1fuikJmHn767rBuFXaY=;
        b=XO7fHadnEQSXe6Sx962WlxMim0g6U89ald3bjyO2BUlGtXRIl3xZq8pSA0lobSYmVk
         mqdjC6OjxIzaqSMvOjoviLjwZ2gECjuqR8Xzj4ZfQZGVs/uSZ2n0il55U6yYmC0bFRnx
         0ZIakLNHw2Z8ydrgExS938de5VuJvPiCTKO21d0MeV6LU1rFqTOVIfqEsURoCSbuD7wA
         4zkvD5RFJD2EcekQSPgYxZPb2b2LBtGYguM+k5K98q4SN7MJjnqME9Qp0VIo8NzwKyKC
         wVIZh3OjkvNXGv2FK1I+J7ciAAjM9ZbU55UhUVvw+eA3zl1YgzOOlbYnUz3UtrdKZ2rJ
         C2Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVBD+u14d2Sp3NSBM3xKqrOqog+Zkiy/938GPLSlbF6Qfi8Eu5lvBC/9rzSpS2bDKmpA5N86u2a7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDYE4C6N7KWWqc3+dIPX8k/Cgx74lrg07lvtD5tv2THZwmeKWa
	ZlYaGC7N2U5027/AxTHhuKxi0RHoewSqRno4OGnuGqyonltRofBgY3kNY6C3jYbvVCrVEnlG/Z+
	AZps9LMe6KnVz6npTe3ZE9pGHGV9ABX8h7cSHUQQ1OKi0rvK0yt59k/XtVzvZkuh2A57a8s5Z
X-Gm-Gg: ASbGncukbFR4cRdENdKM7BoaFVrVCUxMouLPXP1o5wIOVBZ7iI/ucWeg65OE8t43E0L
	1hkb0VQJK3Oj090gWKj5ILej1G1tdFbfa4ULLEj5r5N6H91wmNAH4FDQXg4QOwvMYavxTh6NZdW
	pbwWQVu5CdcFe+3ZTYjx1rcKgpBUwNLxOlq5n9Q5TKXqyQNQbHOPZi3wGEmgiMdBKOZcj4z7RWN
	99ExGq9GIUDV+cC4tcPM+bzroQmPd0kMIgkPRdKzeiW8KLCwgq0svY+BLI6FErdU1mYF9kYJeMY
	zDVQlikB1UseWmtcVjYeUlCsB+8TAN8PRA==
X-Received: by 2002:a05:6a21:9a01:b0:1f3:26ae:7792 with SMTP id adf61e73a8af0-2188b7186c6mr12136494637.18.1748240394034;
        Sun, 25 May 2025 23:19:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLnz0uckNYdWgaRUUv1Iy4mf9s2o5p3ZDDG1bu8ljveYmIuLe+S+fQSQXw8/Y/OCC+jguUEQ==
X-Received: by 2002:a05:6a21:9a01:b0:1f3:26ae:7792 with SMTP id adf61e73a8af0-2188b7186c6mr12136477637.18.1748240393663;
        Sun, 25 May 2025 23:19:53 -0700 (PDT)
Received: from [10.239.154.73] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm16407814b3a.78.2025.05.25.23.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 23:19:52 -0700 (PDT)
Message-ID: <1b1c4617-0e5b-40c8-9a66-d243b48c0977@oss.qualcomm.com>
Date: Mon, 26 May 2025 14:19:49 +0800
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
To: =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com
References: <20250523-qcom_battmgr_update-v1-0-2bb6d4e0a56e@oss.qualcomm.com>
 <20250523-qcom_battmgr_update-v1-5-2bb6d4e0a56e@oss.qualcomm.com>
 <db0e40b6-22f3-46aa-b35d-7a8729370ddf@kuruczgy.com>
Content-Language: en-US
In-Reply-To: <db0e40b6-22f3-46aa-b35d-7a8729370ddf@kuruczgy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GIgIEvNK c=1 sm=1 tr=0 ts=6834080b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=t2JPyoOaPHs4AGm2U3oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: R8bKxAnFnRcTo14BdAgQJO-i5WuKwxsJ
X-Proofpoint-GUID: R8bKxAnFnRcTo14BdAgQJO-i5WuKwxsJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDA1MSBTYWx0ZWRfX5dSIGrcPRiDP
 owXSw+iyA9a19Xhf0pZe56OYs0gggq+v2QJbmSZvzVLEoBzuxfB1Ozh7MK8uGsd9ZAkQCJXIoEF
 DB9PG9MIvMR7NxmWP+n2dV6VvNZdPcLaU91E1SgwgsNrNxnSWWx6wswsqqytBQwvzBZQek9wxi1
 Y1ybTWZYBLqR3qaARAyoxxeseXCRnjHy05bgxVt4pxvu1AW0XdElDXcHX9F9DHmleI49zYBo0Et
 xi9IH+KwVvZtTK6LAHbhiRnNQfxHasDf+djp5EhW1gsANnRtRMcjFUs11oG2XSqyWN2xSshnAWW
 txEyuT4T2KcOGulJFTKWPg0uJ6ykOET/SZtIHx0GXpWIgtuF09p26MjgXQYZobDMcOH0JBLDYKU
 DIUOcgocljuHJLJ1R+zM+xkHL6WcTrGLpktpCMK7JTZFwj1eU27TAFg1DSHHq+HDME2eiXXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505260051


On 5/24/2025 5:29 AM, György Kurucz wrote:
> Hi!
>
>> +static int qcom_battmgr_set_charge_control(struct qcom_battmgr 
>> *battmgr,
>> +                       u32 target_soc, u32 delta_soc)
>> +{
>> +    struct qcom_battmgr_charge_ctrl_request request = {
>> +        .hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
>> +        .hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
>> +        .hdr.opcode = cpu_to_le32(BATTMGR_CHG_CTRL_LIMIT_EN),
>> +        .enable = cpu_to_le32(1),
>> +        .target_soc = cpu_to_le32(target_soc),
>> +        .delta_soc = cpu_to_le32(delta_soc),
>> +    };
>> +
>> +    return qcom_battmgr_request(battmgr, &request, sizeof(request));
>> +}
>> +
>> +static int qcom_battmgr_set_charge_start_threshold(struct 
>> qcom_battmgr *battmgr, int soc)
>> +{
>> +    u32 target_soc, delta_soc;
>> +    int ret;
>> +
>> +    if (soc < CHARGE_CTRL_START_THR_MIN ||
>> +            soc > CHARGE_CTRL_START_THR_MAX) {
>> +        dev_err(battmgr->dev, "charge control start threshold exceed 
>> range: [%u - %u]\n",
>> +                CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
>> +        return -EINVAL;
>> +    }
>> +
>> +    /*
>> +     * If the new start threshold is larger than the old end threshold,
>> +     * move the end threshold one step (DELTA_SOC) after the new start
>> +     * threshold.
>> +     */
>> +    if (soc > battmgr->info.charge_ctrl_end) {
>> +        target_soc = soc + CHARGE_CTRL_DELTA_SOC;
>> +        target_soc = min_t(u32, target_soc, CHARGE_CTRL_END_THR_MAX);
>> +        delta_soc = target_soc - soc;
>> +        delta_soc = min_t(u32, delta_soc, CHARGE_CTRL_DELTA_SOC);
>> +    } else {
>> +        target_soc =  battmgr->info.charge_ctrl_end;
>> +        delta_soc = battmgr->info.charge_ctrl_end - soc;
>> +    }
>> +
>> +    mutex_lock(&battmgr->lock);
>> +    ret = qcom_battmgr_set_charge_control(battmgr, target_soc, 
>> delta_soc);
>> +    mutex_unlock(&battmgr->lock);
>> +    if (!ret) {
>> +        battmgr->info.charge_ctrl_start = soc;
>> +        battmgr->info.charge_ctrl_end = target_soc;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr 
>> *battmgr, int soc)
>> +{
>> +    u32 delta_soc = CHARGE_CTRL_DELTA_SOC;
>> +    int ret;
>> +
>> +    if (soc < CHARGE_CTRL_END_THR_MIN ||
>> +            soc > CHARGE_CTRL_END_THR_MAX) {
>> +        dev_err(battmgr->dev, "charge control end threshold exceed 
>> range: [%u - %u]\n",
>> +                CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (battmgr->info.charge_ctrl_start && soc > 
>> battmgr->info.charge_ctrl_start)
>> +        delta_soc = soc - battmgr->info.charge_ctrl_start;
>> +
>> +    mutex_lock(&battmgr->lock);
>> +    ret = qcom_battmgr_set_charge_control(battmgr, soc, delta_soc);
>> +    mutex_unlock(&battmgr->lock);
>> +    if (!ret) {
>> +        battmgr->info.charge_ctrl_start = soc - delta_soc;
>> +        battmgr->info.charge_ctrl_end = soc;
>> +    }
>> +
>> +    return 0;
>> +}
>
> These function names sound quite generic, but AFAIU this patch is only 
> adding charge control support for the SM8550. Is sc8280xp and x1e80100 
> also expected to be supported using the same 
> qcom_battmgr_charge_ctrl_request format?

No, sc8280xp and x1e80100 don't support it. So I didn't add the support 
for them.

These are generic functions are similar to 
"qcom_battmgr_update_charge_time" and "qcom_battmgr_update_info" which 
are only used for sc8280xp platform. Even right now charge control is 
only supported in mobile platforms starting from SM8550, however, it 
could be potentially supported in battery management firmware of any 
future platforms and the same functions could be reused.

> Thanks,
> György

