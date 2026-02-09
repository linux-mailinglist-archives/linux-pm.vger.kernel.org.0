Return-Path: <linux-pm+bounces-42329-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JXSpCa9xiWlA9QQAu9opvQ
	(envelope-from <linux-pm+bounces-42329-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 06:33:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC00410BC5A
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 06:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AB863001463
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 05:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06355309DDC;
	Mon,  9 Feb 2026 05:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N1YFD8CG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jp2eOuw5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B14246BBA
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 05:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770615210; cv=none; b=LWWb75MwHGlAnT9F6D74NUiGgh3e2dt370oV0U2UyNDhnOBviCy4CoJPSiYPhyrqR3RsvBr6rQiMLSI0IfpGSHNByXNVBVZN2oLIBWYtVX4CmZPsHZIzqB10Kns8dqZUikPp9Os8Uo2dQA1gTAkl+vT/IO/6xZpBLZ/jV5yZRc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770615210; c=relaxed/simple;
	bh=iU9ndyXsUxRU5ybXQL78dQGD3oec8nQZFvUtRzer5l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmJNmZ+/JBey64oZC1SY6NQG6IAH0/chtgIclC6dzdlJkqAVEXuDVitn2gnq67CcCirrBpnrbobOu+zLYTOR9vmjs8LZqj7q4+lcOg4FafIfgOB1wX5kcITi1x41h8K30kpnvzSP2sVoDlYIWpzpqxV3dYpOCpGguntj6XXgTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N1YFD8CG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jp2eOuw5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6195NnqN2032225
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 05:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C5YlhjmvNyjJ9U6RPPq6HIt0CbIE+cBIgsc0g8lsze0=; b=N1YFD8CGKGdQsOAi
	Bk4dArqsoIGIYJreU6Oby5msKqQq2UGkSFyknZf/zm63c/FS6up/idLiu1KbOpSC
	7lvnFo9GvgVhq/JqLvu0aTUoJpZ1+RnkXjsfonlwnrZPzz3Scj7hN6YSlx/sAHZg
	ayicO68WiF+zvs+zXkCo9SU8GxPPqDqCINbOfYB64mp/J71XhESlexFnXUOUyz0q
	Nn4Rv5/4LDEX5T8lnT2zaxuJVwVBbyhvGnUeG2BoRUi1TYyxMxkdEFdS5CdppktE
	+wtYxnYQArkXdvvLhPLa1vbSocnjxtynbwvfpefv2gUBQ6aIfr1dAUhzm8sd8utd
	AKpcdA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c79d300rd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 05:33:29 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82451f11c4dso810472b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 21:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770615209; x=1771220009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5YlhjmvNyjJ9U6RPPq6HIt0CbIE+cBIgsc0g8lsze0=;
        b=Jp2eOuw5Z4etqFAAKr0tZuHtzB6KkKMPww4511lnLkkga5SCsteREkdK6nJh+jFAWi
         zRkCUVZq3pEflM2UGbFWCPivGVT/rdXBi3ylsqp1frz+WzuXmKG/rEbR153kpDRVqHbY
         OcyE0wpBSDXsZkG3ruRw1viq3x02NVSQ5a26dIrSnvsUqhEntisz3OIGxEhl3OV91K/1
         lE7sgSFJoYEGCRsyAx/pP1lNwepshxjLd/jDKQtBWtyMJJh8Hwejp1mvQi4gepD07Mg0
         +2w99hVXR/ODrFz1EKJhhWYUsy6qTjDkeB8ao+tGCe2pS0hDCobnJ3E0O6R1oIaKEO+H
         qnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770615209; x=1771220009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5YlhjmvNyjJ9U6RPPq6HIt0CbIE+cBIgsc0g8lsze0=;
        b=jdHA0rpliT9Xd6aawhEa5NSjvclkrhFSml3s6yr5zcw5ITOdrCNejJgwjpG1uIYPMT
         YOuBztbXu+hVNSsnX4Bxmrm9vcnFpY+bNjOwYaaqFnFLQNpiRy6KCi96m4vtkiTrYhZj
         PeTRmY9MbhztXm/6iYypVphcXKFR0Hm8bIcH+HS7hgeycyXao5HoKpeyo5TVcI67T795
         EYtP/WSa8I6+Af4Fp65bKGRG3YnEwYR+g8B1NUrjGHs/onmCcQa3cBslSzujChv8dmf7
         RExWYyDlbXMyfXFqLq1UMM/iNAlbnnuSnHH+2BWJHr+gn0/pU4Vsm1LX8Q0TNC0sijhU
         AKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWskxHB2SKAMvu5D+vPwGCm+R31+bPgiFsRmaCYPb7q2F1HyNVXUtXWaEvHsxINsr9+KxmpRw58sQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOriTQhwOUy7KrUgyRbtBER+4sbmLxP/a9gPie0P0D+O0bsjnE
	d+OnslIQoDbAyRslIrpAly2C/MRL/xEgRaBDCQCDb3xEEb5L02szTy/V6q5M4OQVEkg18N0Oa/Z
	CS+qiaUDM7jOCVVSpfdpVjyToxz0sEGQvEZ5j/mK7GQDa7FI2CU7OGc1zwb2iAA==
X-Gm-Gg: AZuq6aJy6nvz0Qt86teTJLpi7DMiX9vtPnB1mh70iEGA4PW6xdMjFieEmdIcZT6FVsj
	lvHREOYaayF5CWiat7I+mmEM5qwzKxcYpHt2MGOiKvplX+EKQ/j4STpSII4p3kShvQUpYJnKCc6
	HOH5TmZP1vJIdbXJWKyk0FhG6xFak+Zu47n+IQ82ED82Q4+S50Ih2b6x5u7mUXPospJ/DGVaeQ6
	dANZVeZq1lsyhhi7XITpcGI5tP6HFrxNLFvK8BjNTCTmL7Em+zMTWg2JwHtq0Icyh09DiUCEqfm
	zCqBgRF2yRLLzDttJeTdeBz+60QO1JNJC7Jt8FxGn8u6KKZkVVlpwIIsI3G7Yg1AyhZjMjx3XTK
	2LKsSzw8sQl3nz3nghifPMbJMaPORZW7jFBXBNMg=
X-Received: by 2002:a05:6a00:3e02:b0:81d:dd3a:b8f5 with SMTP id d2e1a72fcca58-824416f7a6amr10078154b3a.38.1770615208731;
        Sun, 08 Feb 2026 21:33:28 -0800 (PST)
X-Received: by 2002:a05:6a00:3e02:b0:81d:dd3a:b8f5 with SMTP id d2e1a72fcca58-824416f7a6amr10078129b3a.38.1770615208241;
        Sun, 08 Feb 2026 21:33:28 -0800 (PST)
Received: from [10.218.12.237] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418a70fesm8717016b3a.45.2026.02.08.21.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 21:33:27 -0800 (PST)
Message-ID: <415c6b8d-9e66-42df-bc41-c57136822d84@oss.qualcomm.com>
Date: Mon, 9 Feb 2026 11:03:20 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] Add RemoteProc cooling support
To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>,
        Casey Connolly <casey.connolly@linaro.org>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
        amitk@kernel.org, mani@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <2a39719e-e73b-4558-95fa-d54f94c43220@linaro.org>
 <6ae95761-6428-4a01-8c60-54df5e54b71f@oss.qualcomm.com>
 <cca414ad-0a98-467a-af31-72d40c43e27a@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <cca414ad-0a98-467a-af31-72d40c43e27a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA0NCBTYWx0ZWRfX6lCPP0S6CuJ9
 cewwvowHRQ4kWYDhrnenehYALQ6IrBeHLlUhc3OxoUdMflNoBxMW+HrRuHS+MraYB0jUlPz0sYF
 JgWYd15Uu+O+WHnEc3qYixWFmucG15XZbcoLxxNfQMrJVW0Ig0qz56d9ghiYIvHDawxKivsFJl0
 G5gUI3zwCO60qGP3jiR8noUMtEfuHE2+QFS3NKA9pzdYtTWalMVhrAhto2smV4DqDoSLzLGK9Sx
 H0XkE5WzHn0BDFP16VzlN6aurREV9s1bccYeVJsNaLgvPq21GUx0Wdnx6bMVYaNbxDL0XnJmR4k
 dVia5g10TaZvyJYLR3oyQycBcGiFbSIQCZXJMGgNwKhdK7ZD3UvMxWK4EfPRDidrE5iYgluTTwl
 hKC4C6YlOMke+vmc/2VP5OJ4JSnA4uwBBmvN3zsZtBCEjGixF9iPzKWGMKwnSprAEsg82plCUle
 1RwXjegIAKe7cbYhMMw==
X-Proofpoint-ORIG-GUID: 1WpJ40HcH-Epw5BWoajh779jOwrQjzI0
X-Authority-Analysis: v=2.4 cv=GJAF0+NK c=1 sm=1 tr=0 ts=698971a9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=C7jLkf_o0pUfgFifxXcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1WpJ40HcH-Epw5BWoajh779jOwrQjzI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090044
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42329-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AC00410BC5A
X-Rspamd-Action: no action



On 2/2/2026 1:50 AM, Trilok Soni wrote:
> On 1/13/2026 1:33 AM, Gaurav Kohli wrote:
>>
>> On 1/10/2026 9:43 PM, Casey Connolly wrote:
>>>
>>>
>>> On 12/23/25 13:32, Gaurav Kohli wrote:
>>>> This series introduces a generic remote proc cooling framework to control
>>>> thermal sensors located on remote subsystem like modem, dsp etc.
>>>> Communications with these subsystems occurs through various channels, for example,
>>>> QMI interface for Qualcomm.
>>>>    The Framework provides an abstraction layer between thermal subsytem and vendor
>>>> specific remote subsystem. Vendor drivers are expected to implement callback
>>>> and registration mechanisms with cooling framework to control cooling
>>>> devices.
>>>>
>>>> This patchset also revives earlier discussions of QMI based TMD cooling
>>>> devices discussion posted on below series by Casey:
>>>> https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/
>>>>
>>>> That series introduced Qualcomm QMI-based TMD cooling devices which used
>>>> to mitigate thermal conditions across multiple remote subsystems. These
>>>> devices operate based on junction temperature sensors (TSENS) associated
>>>> with thermal zones for each subsystem and registering with remoteproc
>>>> cooling framework for cooling registration.
>>>>
>>>> This patch series has a compilation/runtime dependency on another series [1].
>>>>
>>>> [1] https://lore.kernel.org/linux-devicetree/20250822042316.1762153-1-quic_gkohli@quicinc.com/
>>>>
>>>> Casey Connolly (2):
>>>>     remoteproc: qcom: probe all child devices
>>>>     thermal: qcom: add qmi-cooling driver
>>>
>>> I'm glad this series is getting revived. It would be good if you could explain what changes you made to my patches somewhere.
>>>
>>> I also remember one of my patches adding the DT parts for SDM845, would you be willing to pick that up for the next revision? I'd be happy to provide my Tested-by.
>>>
>>> Kind regards,
>>>
>> Hi Casey,
>>
>> With this remoeproc cooling abstraction layer, we have integrated your patches for subsystem cooling. As lot of comments came for qmi-cooling driver, so need to send v2 with cleanup.
> 
> Gaurav - the question somewhere in the series was that why you had marked your patch series
> to v1, when you had revived the original (v1?) series from Casey? Should we consider
> current patch series as v2 then? I don't know if that comment was concluded.

thanks Trilok for review, i have marked this qmi-cooling to v1, as using 
this as part of new remoteproc cooling series.

> 
> ---Trilok Soni


