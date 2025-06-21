Return-Path: <linux-pm+bounces-29185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E86AE2862
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 11:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E772D1891617
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003EC1F3FE2;
	Sat, 21 Jun 2025 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VtZCrM97"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1A230E85B
	for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750499005; cv=none; b=aTU4I92W8tDm7E3XjYNU/RZ1Tv9D6cIDBUlW2FZphZiLbk7wfb5pl1HvMhkNnDNBJpYCU4IXgKMvW+wAbtv3xDlOYkrxRM+rP3UWJPXzx423VbklfuWlBXtvjQeATIIj7NDSZPZekLzimDgkBjrZ7wZjCziSHNGb5KPJCb9wVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750499005; c=relaxed/simple;
	bh=Eq6AbI9svxvdRWlHU6/Z17Y/ciqRWcpbrp8/qVkWxUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TznpC39ysMKHxnYGwCYlbkMIZRKa0q0D8RaDF0fXCVIhFli9bQSopKr/o2kRIYLFG7SPYU5AEjonrYXJ9u5V/Nsr8ZfHcyDYDC8Sbvd/iO4OC4HhYgVWyuoLR1BAsLaAk/OCVlQSLSv39AsHtT95Tk8iiVuppssKUOqGi7tBpQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VtZCrM97; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55L7pfTL024674
	for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 09:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TXX/nIm40ydEKyVs3/m/xeCNjeguyIaR8bfex/MG2eI=; b=VtZCrM97WnpWVuV9
	GUoT/kV0zfcfXYFx89VPNApGavL3IXsFCiHN2hUQG/sPjC1nlM1WMXrKNrARyCJI
	12ATt1f17vgzT5sHVIVFrDy7CrTMDYq0fzI0EyVm4X7O/iDrttvAW9Unhst/zewS
	50N1kW7JIYYrvgizDXEUyM1VGSnrU8Hn/Z8d7m8OcNOKfZQYtbP0DDnDQe6vnQkX
	zF7h4OEPCBP9bLvnAkXGpiefOEz/1eO6Pk+v+rEAfqbHvPlC4eX5qwvm2/9WZf1V
	M8yrGEanrNX170NxuYmkJKl/KHhPkP8n2GSdb4CpmiIIUiZdWY7n5hf4UAHVqD0Q
	mDMhDA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47drq8g41u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 09:43:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb5f7413beso5947466d6.3
        for <linux-pm@vger.kernel.org>; Sat, 21 Jun 2025 02:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750499002; x=1751103802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXX/nIm40ydEKyVs3/m/xeCNjeguyIaR8bfex/MG2eI=;
        b=T4rhR65pXy1tCi69KRtkjHiGbhOKDglQ3JEiWmngef6EuKqpzWIuc6oQg74Ne6yz+2
         HIrIj4qrLeOASHoMkrV9MHIGRvmxw8VWM5or6ES21j0Gxm+/3C27wGtnon+mF2QbCKyD
         jNQleYdhIiR0ZWQzIzHS4zQHfxOALVPuO/g3/IYqLKf7nC+f0nYcnugJO2/TmmdT5ucX
         lEYALFl2wKpR6ljtKWd3a/dqitR8nQuRUfcRGxLjPKndo17WLrSdYacgcGg4A7bhmkcO
         m7NZjcPscVUG8yhMYWoZen7TAr3q8j+HiWc6eKwhbppWAJf74aRFoWifG12Bo7a3gbFe
         9P3w==
X-Forwarded-Encrypted: i=1; AJvYcCX61r8LuzJ0W5BpuWT6uZZsYcutDl0vEk2ZCyHcARcz3Ql1Rbo1AiLhw4bpUa6VmoMJZvjE5BEjug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuhXdWSDJQ0IyZwMOGKN4xtj2oMaaVaqoGKDUdnSBa3OMQcBAX
	T8NKp68rpRc3SuaJa+L+uxOrGDtoMXzlnnBO9WjAb+OvqoRHAvcZTR7ZT2IzyyG4knbt32af5U+
	u1SvIACFvJuW2yPVPDJFAaKCfrIYi8WrmKDm6QNYr/LoaF5xflCelPE0jDQFBGw==
X-Gm-Gg: ASbGncsRU4lZb6M7a0W2b/heuZGsTpcucpM4Rd2/0WGualZaBNOmva0aHP8Unxnalke
	6Bc2s+klkaaynA7gtHPcA+7utfEs6oOypUoDcqDLC27dU5fTsQtswUwM52UyY1Eupnc8fA1njy9
	l4e9wnJcAd0XpuebqsjGyChycPgZo3p78E/pBIiTibpHiZj14B+w6E3n5aMXG0ycrlqzvyEn+Gs
	scj8saZnuld8Rk+Ybw18QrM27ydvGxrj9nps3Xj7uO+Lxipk+PI7aa6nUwHjVUaOqJbCZNVYusU
	08YNsoLtrna5G/QSkkIvM0DOAnyKAGmyqB0hfbICrJOd4UkqH20qYDqexPakOlL9LnyIMUNWxjw
	YdVc=
X-Received: by 2002:a05:622a:1aa0:b0:47a:e6e1:c071 with SMTP id d75a77b69052e-4a77a21e46dmr34837881cf.7.1750499002488;
        Sat, 21 Jun 2025 02:43:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMs3DMpojvSaLfHoGR2ZZXOth8bQIUjYHkyAWr22xj9mQ0gp5qHJrVSftHuw7FWFnQAMZAww==
X-Received: by 2002:a05:622a:1aa0:b0:47a:e6e1:c071 with SMTP id d75a77b69052e-4a77a21e46dmr34837741cf.7.1750499001983;
        Sat, 21 Jun 2025 02:43:21 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e80447sm331198966b.6.2025.06.21.02.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jun 2025 02:43:21 -0700 (PDT)
Message-ID: <c9caef81-deef-4360-9ddb-a317402495c0@oss.qualcomm.com>
Date: Sat, 21 Jun 2025 11:43:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] thermal: qcom-spmi-temp-alarm: Prepare to support
 additional Temp Alarm subtypes
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org, daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com
References: <20250620001918.4090853-1-anjelique.melendez@oss.qualcomm.com>
 <20250620001918.4090853-4-anjelique.melendez@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250620001918.4090853-4-anjelique.melendez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lU3S1Xb94mLOw6Dq7JNgBn1klRB9vzyM
X-Proofpoint-GUID: lU3S1Xb94mLOw6Dq7JNgBn1klRB9vzyM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDA1NSBTYWx0ZWRfX6pNFzp3MxITp
 xQZzHa7A+nNnF7H23Es25Yj7F47D2CE4eu1jWaF9WeZiXt9AkD3n+DL4Ob7YpWI2MkOUui+e2AH
 ppucpAw3h14EaFH7Cy/JOdcGtPeUdzp78yDR+FIS3pP8oNzy0mPKFHtLQV20dy2GInw/Zear46i
 JLP8xh4L/lG282ki8wFjVw+4fYZorV39pOusvqjK5L8C2Q9ecn8F/aXBmHVu35Kz+1e46IJt9Rr
 RBtciRlpf+ir6JYv4gVo8LEgxQmC+R47qEtvrAqAYh1eAFrEt+cKY1M2gzHav2TTQpeyimd1Asd
 aXQmt5LfR4TUigPz+9m9tKyz61nV+CyAIx9+OcgZ9sgm17/mwLU5c0qWucrs1yE8wGQImKyO1+G
 UrcOmdkD2OZCr8MBGhCM+PWqoW9zirEHJq9Scg7UqYmtcU8T1qzkfMaAyWbBiKWizXcieQzP
X-Authority-Analysis: v=2.4 cv=Kr5N2XWN c=1 sm=1 tr=0 ts=68567ebb cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=ryWYcZWYGYbgHTkFvRoA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506210055

On 6/20/25 2:19 AM, Anjelique Melendez wrote:
> In preparation to support newer temp alarm subtypes, add the "ops",
> "sync_thresholds" and "configure_trip_temps" references to
> spmi_temp_alarm_data. This will allow for each Temp Alarm subtype to define
> its own thermal_zone_device_ops and properly initialize and configure
> thermal trip temperature.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

