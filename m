Return-Path: <linux-pm+bounces-27376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F591ABC6DA
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 20:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7362A3A01D8
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B6A288C3F;
	Mon, 19 May 2025 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ds4IZ/aq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD101E32C3
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677600; cv=none; b=gqHaNtpnyI8Lt9wv07XUUA3ypT8SbpEdLf+4mZcYBqxrxWzrwsQRP0+fIDoOUtjjqgrpyjo+FAuWYGRjxviVlM+piL1BTNB2ySNVFqeS5gzNqAZECsvww3UNugtN1hCk2s0oczxLUEiGnvAE23ZtPi/GHe73IShXq6dtOSQt5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677600; c=relaxed/simple;
	bh=oPDuJpU2aDI3veakBUF05VkL4vY3wVTvTbUP2qIWjRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olwqaPGGHGevuMmFsfs2He7ZQqucsGCyfvQDHIesCDojIU3U4FH7G/NVxZ2yAFCiL+eUsvQBJqDC8qhwElWmbJTxunai+I5YLQjs9ZxrTdifMSE+AbcmZc+e6RkPJDfIuJ6mZ63ELSyti8f3VNL1OeA9Es4lo3uNgJlHKforPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ds4IZ/aq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J9W3oh025924
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 17:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QRhDmJNbBgVCCdG1SgH+0GcltALE5aKIBtKkQzfk7nA=; b=Ds4IZ/aqZWmGiwgn
	sbE/4AUgRZZPZf7UKwixi6I6ie5LuUHBSIx9C+FkPIgEs+BNY3vFdt0JdMi6ZGHp
	tQzILFDQa1Z3NHC3gmoA0lvOYIqNjAtHo5RxKw/Pmc3e7CsFfDA75z7PANnvIa+t
	3RS6WIha7u3oZEWvl77NyzPstdRhm+WRJX/C21I9930VSIq/8h/pFPjIrbZhL9cg
	Jy4PTZv5icbdJljTHf8Qkq/18/brtnkkSbZN7Js0Yh7bV4Heq0pcX+9B5viFmeSt
	+/VdXSVpfK1IAt81vAJ8yOV7XMC5ADO37uSfZJfJBNYNcub8XavqfARykSf3HpVv
	fSDrnQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjkynahr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 17:59:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-47983a580dbso11765221cf.3
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 10:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747677595; x=1748282395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRhDmJNbBgVCCdG1SgH+0GcltALE5aKIBtKkQzfk7nA=;
        b=Vzt+Zd5ZMxk4bWThgXkbur8oNTHjid6OzD9kDKn9OahmkFQpjn05Pmo3crI+Sxqiea
         GB82qa1QDw4xzFnvzhtTTPNhzIz9TgNJnYpUwFDJYGiYSCCsVXnWcoz7IWOKRuMmY3KA
         AYP1yMdXb/vKYkZnhHG8Q3yqi7gMqPKsXneL0jwwxZcJP57Yf2Ro/WT4AoLZQF+0YgLB
         meNJvsi+1mFg8N94OZU/meLzMpF5lyzAHqj9rxUXegBYzORTOMc3QQwGpb0FIs2Uh01L
         wP7Cy06w82DwVNKn4gkrNUNhopY9nyyoig8ufgtChDA6cyfgFLBqZ1ZclPWcwpn6so4z
         xB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXl9jh+iXhnyvJBFO5tgoQ0xH4gWgMaMxjZ+IOBZZJkGOjQfBxCoy4ooRkx9UyTnwJMzEidhjmqfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy/NuLEHiNLXQg30AjDRzdLaWjYi/VEGNOBfbqsoJF/3l8QV+z
	jsg8bJXS1HPS//sk3q1RBPmuFSXrwdhzrNYV/oC97RqrVZL9eJQA5C0rg/LD8ZU0N20WOQr5BrV
	5Ur0LwzGky6OwBNdtOLnlzf/5kS7/FbbM84A69P56KUrVdWT1ysbRwNk6rsGtxw==
X-Gm-Gg: ASbGncvACthK6UDjlb8gbZ9HVEGFYltx8PxNXaXyO/Jg1r8Mh+MzlfYRIskfs9WCQDW
	Jw7iH6wvrc7f8BGFxvhQn7PO6ZKDUe1CoP9fZUBhJsLbmVr7Wuoq0veSkEEMviTZQtZC0Hfdg67
	XV5FdSjiSXlRbE288Ej4qffM1qEo4S3nLmX+24UJFycVS2aC7HEntWA7bY+3ylvM5WxD4Y5GeeO
	6OOz+yJPAYeKbKRrMKcR2ZIWD83xyU1zbG/qFynoqnzwGxkvT2I8V3U00MFUObmQ1fDLHuNjzEA
	cqUJZOHvdFxKu0+xGu0JP17Oj/wYVP2S6bAH91P7TCQVA6jZjITpZtXUi1XQ0ymzYg==
X-Received: by 2002:ad4:5495:0:b0:6f8:daec:8b7c with SMTP id 6a1803df08f44-6f8daec8c02mr14808286d6.6.1747677595376;
        Mon, 19 May 2025 10:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj+7fg16x74gYzVk+YjiEHRe8Kboy7RuyCWGBLuiZoGpt6d9MsVthshVMvw3wwrX5PCaJACA==
X-Received: by 2002:ad4:5495:0:b0:6f8:daec:8b7c with SMTP id 6a1803df08f44-6f8daec8c02mr14808056d6.6.1747677594815;
        Mon, 19 May 2025 10:59:54 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d498b2fsm622845466b.147.2025.05.19.10.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 10:59:54 -0700 (PDT)
Message-ID: <071255ad-ad08-4a15-97d3-016703e7d9a8@oss.qualcomm.com>
Date: Mon, 19 May 2025 19:59:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: sm8750: Add BWMONs
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Melody Olvera <quic_molvera@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shivnandan Kumar <quic_kshivnan@quicinc.com>
References: <20250304-sm8750_bwmon_master-v3-1-01a5cb330dd9@quicinc.com>
 <d2640b21-41f7-4bb4-a616-42b6bd9cab0b@oss.qualcomm.com>
 <cpwyee5bgu3r36sh76mfd2o7oc2dnm3weuvynkvbsklr5nhm7l@gb2utngj6vfl>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <cpwyee5bgu3r36sh76mfd2o7oc2dnm3weuvynkvbsklr5nhm7l@gb2utngj6vfl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JBrKZVvv4a11Ag_5RAOXV_K8GL2KpdnC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE2NyBTYWx0ZWRfXwPuaZSJHqScn
 XVfk6ufaLCPIMVxbtADiWENP6+dtVMQ43Ufsyn9v/6y3QDWONSHktqtAyBAVid9lxQw8cEA5GcO
 I4u3ugbA1b4gpp9xV+sEiNjvbGLdRCIU731S7NnJfYanx6uRxAnhnOrkD6BUnXz4S4kUBPhLPRU
 0PpWEyDd0L4hgnTTe47JroO+BK9ZPh10fQXGZCzUznus7M44rUkojHbZ4YUaTh+DayyGllKgr2d
 0tAvblb1XOuq6pge4LVZfc9g2J0ofvs3aDbkeaVLoy53SvEKnluv7XNIh5WDnw7tMfl7tIemM4y
 7M6oB00tYR/z9ydl3Z7wmgB9jA1LeBaSQADdTfgzPXXzI2Zm6vIx08wQ510ZJPVHwMr7CBKVQkd
 lXuHEyeT7BS5n1TjPYvzEKL4uxI5PntHUyh5kykyzbwvz+oZ9JPpNjxMZb30dqFlxSmknQpp
X-Authority-Analysis: v=2.4 cv=H8Pbw/Yi c=1 sm=1 tr=0 ts=682b719c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=wbSWbzf5WjKv6xKPGGgA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: JBrKZVvv4a11Ag_5RAOXV_K8GL2KpdnC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190167

On 5/18/25 12:37 AM, Bjorn Andersson wrote:
> On Sat, Mar 08, 2025 at 07:15:06PM +0100, Konrad Dybcio wrote:
>> On 5.03.2025 1:33 AM, Melody Olvera wrote:
>>> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>>
>>> Add the CPU BWMONs for SM8750 SoCs.
>>>
>>> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>> ---
>>> Changes in v3:
>>> - Change cluster 1 destination interconnect to tag active only from tag
>>>   always
>>> - Link to v2: https://lore.kernel.org/r/20250304-sm8750_bwmon_master-v2-1-ead16909397d@quicinc.com
>>>
>>> Changes in v2:
>>> - Change destination interconnect to tag active only from tag always
>>> - Link to v1: https://lore.kernel.org/r/20250113-sm8750_bwmon_master-v1-0-f082da3a3308@quicinc.com
>>> ---
>>
>> This looks good, but I found that this platform may require some more
>> changes for bwmon, we're investigating that
>>
> 
> Did we reach a conclusion on this?

Yes.

Melody, LMK whether you want to proceed or want me to resubmit with
the necessary change

Konrad

