Return-Path: <linux-pm+bounces-36161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A63CBDD755
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6442319C04F3
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 08:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FBF311966;
	Wed, 15 Oct 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ERA1fabA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541BA22A4DA
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517632; cv=none; b=UNaKOt5xdynUaXY4yjys2So+etSnXEyMrJ+tNtFn+1FhRq2EN9DCE7kysUtdZVEtLb9Pk94JnrHoy7foiRb97v/wK+LBNKWGh0WigTZTdOgVxr6xDtguhEcARw1BhGkfmywb4eVH6rGkxyoQjqgJy7A28DDd7wu5qP0bpaQqfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517632; c=relaxed/simple;
	bh=B1HU4XzpjvLoGBRdWYfuclPmNkqrtuYSBUbFU9qekvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTzs9sgVRbJyRsPzsmrISw5prTubgLc8VoDysim5PnohO80HvyZ3H5TAV2hUNTRjxwffajH9OwlhI0Kfcof8ITzf3bX1u9QzZRElymsGBpb3ByqZg7GDRM4qbnG5f6utN1yCxE2Mu1dTnRaZ3kn2p30dHYCgXj+2By4f4W9xMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ERA1fabA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sRAa005266
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 08:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n0NkvLFD9PifIf1hw60K2ieqObK9jLK25z7AF/7XH88=; b=ERA1fabAccWTUBw0
	x099SJ2xQXSqXMKDkvMnifMmbAtoioyy27Ov1wDm4ZyxD0asULryHzVitYp5emQG
	thQtmxFXcJQOSDFaXnJflt4svqCkfI4qZxhEN58skIHKpw7ztJtwN4Nhoi6yPtWR
	dX6rA98Xv7B/wSUe8MRJl+ZlLK3F/YYkCfXWdORVqVl0UOg/zSKzumSpzWT0ntcO
	s9wQOOqkWwRuqXYDLywE5Iu4FLfwXJOVrPKzCi3f/EjWGwZvMEeY6AxEPoDD8Osu
	5vrS428dbhoSQP24kRHe+Cx5JC7TsJZ+J9PIebXlpVu/xbQsORGnApQYtxWffTGh
	RudgCQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1ag0ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 08:40:30 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77f5e6a324fso17668804b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 01:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760517629; x=1761122429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0NkvLFD9PifIf1hw60K2ieqObK9jLK25z7AF/7XH88=;
        b=dtW/lWFHEKAHg5grt1QBgawAWUi476rE8EHb3SuH0+NED46rNWvgqmoUsIT+0Q76na
         xwkt4yfqWl8vfA7uC2uqdf/Rr85vJJv+GMH2xPJSyz6Ir/uiqmg8Xy0L7jt2HJku6uEy
         p/8/lyZD60JZdK9PzpgIG1sRC8tG9MpQr2QIQbWON7wpxEabgs4iwmAf2LH9riTm7McO
         itBQCOAAQIkaDtRPtHK8Q96NXf7Sc6aC8teUaG4CC535OjAQhfCIwcEma+BAp+aTbFQC
         3mnl4dTnkszld6bdNoTDjjiVDo16qr9y6jFcKnkr7/AOLwH3pEpPD1EQCwaTnm8CYzXq
         VcTg==
X-Forwarded-Encrypted: i=1; AJvYcCWm3d0wyl/2wUjVJgyyQmWkT56Y1QATJNe2i2NwRcqvUbGXGGE3HjJLXHL4zZCZ+wrQLDQTPrksbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJxdlGaY8OgWV63gzH3d78UUlkJFGQMv89n/yuCN9dDWUanZn
	PZvnXdl9QXPxHkWzcL2dpEPaHTWF/033ukb0NCAxgSiDPUBvCA5unbYLlbgA/22smb/02mQ6Q2/
	cuNu2AVgj2gm9cnUEAfHPkG/4IZ2qLbSZLxstupdqg1ndlzU4gn0U7UPBy0EFVw==
X-Gm-Gg: ASbGncuMTpkDAcZhWIdhnCW4x022ZwIjYv3ik1HBJFBrsWODM9fdlwrpdpGnauphR5L
	QUbwqAP2VUCwW0i893CgxpfnqlM2y7futoG8HmAIEfUxScsPBJvja4bVB7BuAs0cnPch6kdxN0a
	ou1FhG16RZuFCRs6XS1b3SGIN0/ZQoSSDMOWUcflD4Ig1PUMFnDKVeEo5YaD2QKHykqYEuJYvaa
	whsBpU9ouCFvbhRIcM/qDhF0hKZzawRaM3HlJ8OeSkj7VDKNOeoP0YBtXH4yzwAk6khqJfdlKwl
	8EwxyNZXhKRM0fPiwKtN+rGzICqqC7rcH/0csq58u3jOU13hWCF0Z8McDMCD0IzG4pqZ1Gk=
X-Received: by 2002:a05:6a00:4c11:b0:79a:905a:8956 with SMTP id d2e1a72fcca58-79a905a955bmr19850811b3a.14.1760517629504;
        Wed, 15 Oct 2025 01:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkvRS9mqkw4xAmKHSN24pxFC4rUHTz/FMp8QKwR3Q9/4/dkq/owOCSgKDO0abpL3A0/sRbMw==
X-Received: by 2002:a05:6a00:4c11:b0:79a:905a:8956 with SMTP id d2e1a72fcca58-79a905a955bmr19850757b3a.14.1760517628915;
        Wed, 15 Oct 2025 01:40:28 -0700 (PDT)
Received: from [10.92.210.195] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e198bsm17833032b3a.60.2025.10.15.01.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 01:40:28 -0700 (PDT)
Message-ID: <2bc64bc2-97ac-4a08-9721-7d39c665a95a@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 14:10:17 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 03/14] power: reset: reboot-mode: Add support for 64
 bit magic
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-3-b98aedaa23ee@oss.qualcomm.com>
Content-Language: en-US
From: Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-3-b98aedaa23ee@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68ef5dfe cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xyQZWzCWjP-v2z6xiYIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: wDCmyGUrJuNif7JKq-ZUAaNFe0n69NSX
X-Proofpoint-ORIG-GUID: wDCmyGUrJuNif7JKq-ZUAaNFe0n69NSX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfXxlCGUtSVQF8E
 dlIkdXz1swloW61e0K8zXu+Ucdk80LczTutJIo+T1yZnRIkcC23VJRL59aZyprRKp7E4s6y5/0R
 005VXbr+9gehJ6H24bQVr0Rku9vfE7kAxDzI0y1P+gaNVcaLCwORAHrU2vl05jT06wWQuWNL+b5
 cfaU7PUywjnNQ/GJJwSHAlnefuLNhgS47cvNwgT25Ou7HJVAv3e/Or0xPRolvRcrBbIhrkJ32JJ
 sTUXwDo7iBZmrbN33iMK6JRLujeqdwC00ZkkyAm8WQbH1HTzImLQFuSL///98xNURrIx8QcwyKB
 nAYn7Di6UUXyw1Kzbbkm/LApNUhLvCehTsSsPyoRmyMWWfn3GT/m2J75hRn4yxr+lp/aDqG+KEe
 AOBa4dRnHhQPheztParKk0rzawbUCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035


On 10/15/2025 10:08 AM, Shivendra Pratap wrote:
> Current reboot-mode supports a single 32-bit argument for any
> supported mode. Some reboot-mode based drivers may require
> passing two independent 32-bit arguments during a reboot
> sequence, for uses-cases, where a mode requires an additional
> argument. Such drivers may not be able to use the reboot-mode
> driver. For example, ARM PSCI vendor-specific resets, need two
> arguments for its operation – reset_type and cookie, to complete
> the reset operation. If a driver wants to implement this
> firmware-based reset, it cannot use reboot-mode framework.
>
> Introduce 64-bit magic values in reboot-mode driver to
> accommodate dual 32-bit arguments when specified via device tree.
> In cases, where no second argument is passed from device tree,
> keep the upper 32-bit of magic un-changed(0) to maintain backward
> compatibility.
>
> Update the current drivers using reboot-mode for a 64-bit magic
> value.
>
> Reviewed-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>   drivers/power/reset/nvmem-reboot-mode.c  | 13 +++++++++----
>   drivers/power/reset/qcom-pon.c           | 11 ++++++++---
>   drivers/power/reset/reboot-mode.c        | 19 +++++++++++++------
>   drivers/power/reset/syscon-reboot-mode.c | 11 ++++++++---
>   include/linux/reboot-mode.h              |  3 ++-
>   5 files changed, 40 insertions(+), 17 deletions(-)

Reviewed-by: Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>

Thanks,
Nirmesh


