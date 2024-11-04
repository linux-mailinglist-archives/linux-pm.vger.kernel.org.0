Return-Path: <linux-pm+bounces-16956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 271499BB6AD
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 14:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C820A1F22220
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 13:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BD614A91;
	Mon,  4 Nov 2024 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SItzWc9U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C08BEE
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728285; cv=none; b=Pu18DKe/GrkS5N4i3s+J9MMzVuraT0Y7viceJ+7Um/X3DBkzpMBZm9o4H4rIVeQ3ddqkSOS9f5XaqIeOlujszEwkDpPlLIgg35q2G+uTF9xwOWvkaC6wUvJH/T9XfUx+I52wRku6Smj8GHCZh33fUdofTwuOfXz7bH2SNvdhIvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728285; c=relaxed/simple;
	bh=yHsIXd5nkO+LMf5xN/UBFpUESu98mQJHpMkCwWTphDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THD/KWvNI0y8/7L30si8TmKcgne6MoUc73R6Itm6jJc8Zzod7dQtHnLZ7RfsRXdvQ5YUxo/Md3qdbNuQ4RRam8TMRzvS6m/hGLIgQt68jiJUBYf/81kdiI0j5vE5av6GODNO8UnkrWzR4UrbLJPN9FtfoCX7t0sn6VwrfhqhKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SItzWc9U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BjXUx013477
	for <linux-pm@vger.kernel.org>; Mon, 4 Nov 2024 13:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q+7hgCYK899f0FJbEY/vMXn0wJqm6OxSk7/yIGdwDuI=; b=SItzWc9U8yLNkDxI
	41AHDteGPUMg5kJiTHxOiwF52+0ODUyOkQD1EY3zzchBjfTNvm3HlF2sv9wwLks5
	xpz0TQ7MCPzm7igp+R4EMwQH6OTgXlyOKlnRenO2NbpGZjWAxTtCNGmbBURZfUXI
	W4AjIwPhLD+nZ7ioIO6DcwEMYBsYwxxVTURjICL9SHvilaEUrAzvnTi5yG58hI91
	Pdijc6SOJCoAZorwEyaODy+j1K+oZy1NlZNkwQoqdxl3xXypsQ6M3BrCpLEd9MSc
	k07aJyd+3x+KEvva60hsW8f5sJhcZlXPpac8aJox5Ob28w8IZ2r6Gep9h8ZuwBlz
	e2JCJw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd4ume0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 13:51:22 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7180db3ca26so416904a34.0
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 05:51:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730728271; x=1731333071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+7hgCYK899f0FJbEY/vMXn0wJqm6OxSk7/yIGdwDuI=;
        b=kVWp8xxB7it0iqWVgoIhEtaLwRqDqzVyGaMxa1fgX6lmvm0hQ8d79Hbwn3x/dMeyKE
         pDzTqWDrpiyqW73GX0ilKaBoOYtT400TfA0YqgzQJPKX/KUxKeIwHrHIhbFj71ysvBsc
         A8Tm0G+ofCVvnK4tP7hMoYQ3ziJ//vhZ5Pfe04+0saSejzUZ9Otz7hEoc5xnZdrbHTO7
         yfHWRB//O6YihBNiRoDtC8ARCkw3mz+9ht1vps+48rjr5wf3VLlSZzDgMtzKWvpFvH3h
         AtxbF526bm4uiM0R8dJIyAKhZGHWUSUPfRSLGmxZS8u9TgnHfCTTK+mS3BMR0J2YDYVL
         ZuZA==
X-Forwarded-Encrypted: i=1; AJvYcCVGylu61hY6IJEsP2DCTeqvIu2fbwZo0PmIqSLNhnlxapzAZEaEG9h4PWV3jP6+Ntb99CTb8LnPpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVPA96PBSEi0B/yOQBOP4KsGr81Wd4bLIAQw7L+L2CfeLam1ze
	6t6DpEZSGVAzp8Lz6S6dfi+IRqhDn8qxlyluuPBcGs4Z5d3Dv7ajz4FZnBDfxaTJTfbgzuHk80f
	tdMVTyJ6cJBLaeX/XPlCb20bIPWbtDSTgywn7DCMNBL80IZrI93OGPizFSg==
X-Received: by 2002:a05:6808:2111:b0:3e6:49e0:f16b with SMTP id 5614622812f47-3e649e0fb7bmr6547838b6e.1.1730728271366;
        Mon, 04 Nov 2024 05:51:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4cnc3xqY8a6NcTMGPZ60dRJUOHzCgUzfXFzm9uWLTFW4bfNOfHKp4a3z7OM+82mgUNhac/Q==
X-Received: by 2002:a05:6808:2111:b0:3e6:49e0:f16b with SMTP id 5614622812f47-3e649e0fb7bmr6547824b6e.1.1730728270940;
        Mon, 04 Nov 2024 05:51:10 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564941f7sm554474766b.20.2024.11.04.05.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 05:51:09 -0800 (PST)
Message-ID: <91ea0f03-9bbe-491d-9056-ebd9fdc73bfa@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 14:51:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] arm64: dts: qcom: ipq5424: Add thermal zone nodes
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
 <20241104124413.2012794-8-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241104124413.2012794-8-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MPX1LHyXrpgtstu1OUVDjDS3x-p7V4i4
X-Proofpoint-ORIG-GUID: MPX1LHyXrpgtstu1OUVDjDS3x-p7V4i4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=767 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040121

On 4.11.2024 1:44 PM, Manikanta Mylavarapu wrote:
> Add thermal zone nodes for sensors present in IPQ5424.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
[...]

> +
> +		cpu3-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsens 13>;
> +
> +			trips {
> +				cpu-critical {
> +					temperature = <120000>;
> +					hysteresis = <9000>;
> +					type = "critical";
> +				};
> +
> +				cpu-passive {
> +					temperature = <110000>;
> +					hysteresis = <9000>;
> +					type = "passive";

You have a passive trip point without passive polling

> +				};
> +			};
> +		};
> +
> +		wcss-tile2-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;

These are the defaults

> +			thermal-sensors = <&tsens 9>;
> +
> +			trips {
> +				wcss_tile2-critical {

Node names must not contain underscores

Konrad

