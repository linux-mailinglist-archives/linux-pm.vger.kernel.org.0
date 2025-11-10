Return-Path: <linux-pm+bounces-37739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3468EC4707A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 14:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4543A3B76A7
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 13:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A4619E97F;
	Mon, 10 Nov 2025 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="buUwUdVb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iGKLGuxO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A71DE4CD
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782347; cv=none; b=HQWOr3xj3cYrEkG5yCYzDKgQVwFADHnxJH6jWvuWQtOKOBhHRkQkeXilCBeWhkcm44vevqLTkqFHt281SS0cDTGE+KwHCTirGiLCULPjps9lspaardbkYO/myi62CamD9kVE226jSNLAuXdheLifixTPgHjvPLTTzUufYG014cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782347; c=relaxed/simple;
	bh=H6f8G2F54zA621dwndHMSg6QNIyKcA40Xj5J9hQ37Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWCHSURiCmnbxYmnlKtT9Q/fCQ2uR0q6kaTchebchpzVC6YV7GmPUFcFJeRtU4RKD7ZT9wMuavJaCmBI6cWaYDoTamLnjLJOn23Z9rdOPCKh5/zqSjQr8d6eCxNnT/zF8ZoQfX2LT1p5qNwLfsdsjeERnpWBl+stiod5QMW8Jz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=buUwUdVb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iGKLGuxO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAAi2k42546912
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O8mCZ2i/SwfCz8Y6dHfv1Z03BRuaemPsHfu8tHyYWV4=; b=buUwUdVbzeXlAURk
	SuCksaVMl2U9A06IGjD1MZyq7quSX0tdtw0yK59FVwlgzihRMeQkLPt5dMCv44Fy
	rNW0FMTerkbARkiqPei3t+v0lOV7UavpmtwoGH5inJqA5mw6Vt7VbZpLeh9dxWJX
	Da5KOBgcZTqcxoeK9lVd/iyrjqXVfVpTXx465aOD/JZLR0jAUf+iGLYrtIlJxjb1
	TrKZfsH1SlZ2PVsL+tUKcfb9vzlei81Mta6YX/bbPPNNCebCp/TkGxfS0uAEx7wJ
	5F3Yn9M7C+FzGfZgkX6YzfVLEMEfq5yu9EDiomZkXIkAvAu94teyTEsnjVlnvz8u
	F/efUQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab8ea9msp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:45:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7aee84f1defso5587412b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 05:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762782343; x=1763387143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O8mCZ2i/SwfCz8Y6dHfv1Z03BRuaemPsHfu8tHyYWV4=;
        b=iGKLGuxOi1CD1XiBNfvziQ/5iH9AM6SuNpRolLoHrEZ36Tvvayag1FMOJ20hCOlXZs
         evC1npSjh3CdSfBir9s+Me+ET6n8Xr3fG5XbaGHo3UZys5Z7DJQzoEChTjAEb5FFHx5E
         vNnS23ZJRpJ2Lq679yHMuTzzXYJekMVlmzWYgkAymRuM1N54yPHihmmLOEDfIna7+Tzd
         +SFwkHCJQAWg05O1UeuL9rl3yzd6d3MPSHeREeNavMSA11grgj9byTw5oBPI5naf44yS
         shoTJGdo+cyzvNjqr/+JJSKnKdU5lc8D4A6bz4f9O7pSVDNVK1syirCmh4AWHwBQ/5Zx
         OhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762782343; x=1763387143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8mCZ2i/SwfCz8Y6dHfv1Z03BRuaemPsHfu8tHyYWV4=;
        b=rBBYpWfBrPxaKCvMMy1Gem54qZjEyg4Pje68cpEYevfQT331TfJL/qXgZO8q4e1kN6
         05dvnZgAz73ToIP5N2fuAJR0a9n2NKk4aqtia3bQIY0yyEvd7NtNVwZ41EEPCzEa3cBi
         w92msHuAMYOpyk5qbkHvCfB+pSETHLQd5uEfrGHMlo3cOWYcz1TUjhw4EPQbaB2MlmXt
         rw+23MgUbBXPvP+7jQtkFmW0h33WZVFLMfzzPzD78MKtPRDDwHjO2fm9cX+imGHxStU9
         0NS1E10vEqJVo0pjLm+aiU4Jigtcbf0EeiO+u76z+WV47LwogelrgHw6OWDrMAy2NJwJ
         yc4A==
X-Forwarded-Encrypted: i=1; AJvYcCUO5QjDb+dAfWZUaPlBoXCeMFgC+gUDyXgTrhHKXgW8tZeRj6pCeMioJWcC5inqjSAB1p/6tgkZ0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzakI67dqq6FA0m9G2sYpTdyCod/Ve2Vdy3XDbNFe2ijhVE6FFH
	lPsS3zOQJMvONvp20L8PFwIijaTIVhr9SsAcv1lr+c7Vu+VYa6pZoz7El0jhR1p5OTvxbWMrHP2
	TVVroZULu7vRFyqa0lxF8tIi/IMF83T+qFzYp99Lu5tpI5tcR4HQvUEHeLjLaIg==
X-Gm-Gg: ASbGnct5og39mi2NCgu4xMVXe0KDTGcwcK+tkdNy1VLrkLCMVarVktx7qZywoHenuB0
	/jYs9g4xCN2jMV2tGALT4Euo1oPRjQNW7TxwkwgNRCfwXTxTt1ScVH/5g33Po64TOUNwU9PdGEm
	kCtyoo9125aZ+wrr36hrRfJu6wSNrwv7Yvm0UJX8Ea3Uy4h8qLihSS/+LqtTwOKu//nTDOkgBGh
	zHdKllo9igmRSyCx9W7EaSuhOP/oSjF7M1ntITW1/+lkcadUw6xctkZtZfNt0mrXfhIi6+Gf6YX
	gmW0p3qwGrdUEIgr8R6UeNUtmeRcSrkg9oBdGQjYdgF/Rcge4acn1I/EwcaleK26GcLt6jM/rOV
	Iv6r/olYS4vjHmiiYKt+L+y4JCA==
X-Received: by 2002:a05:6a00:23c1:b0:781:1b5a:95b2 with SMTP id d2e1a72fcca58-7b22717bb94mr12240180b3a.28.1762782342804;
        Mon, 10 Nov 2025 05:45:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwTkVKCC8Im0eYgJqpdGEW0O85HjOMi5fKaAZ3Jnn0Gmv9OubICv0N6ZVNCMiI6Qbx9GYJBw==
X-Received: by 2002:a05:6a00:23c1:b0:781:1b5a:95b2 with SMTP id d2e1a72fcca58-7b22717bb94mr12240084b3a.28.1762782341965;
        Mon, 10 Nov 2025 05:45:41 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ca1e7595sm11836585b3a.33.2025.11.10.05.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:45:41 -0800 (PST)
Date: Mon, 10 Nov 2025 19:15:29 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
Subject: Re: [PATCH v17 03/12] power: reset: reboot-mode: Add support for 64
 bit magic
Message-ID: <20251110134529.uljjqzb3vhda3vya@hu-mojha-hyd.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-3-46e085bca4cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-3-46e085bca4cc@oss.qualcomm.com>
X-Proofpoint-GUID: 5hBNQ5TmpHa51wdDx3TK0D9pEJKA6x8V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEyMCBTYWx0ZWRfX7dMWQ3BtS+zR
 CFXdgURZVUVnRgWkxZrRGxyDLK7Mh4B9Tum4Rg+GqWVuYgoc0aOQNQKqnjm2Ub6ogEPICfvBUAQ
 LMrX+7VJUOjznHIGcX/TPgvctrdrG1TFeR37CdqKPeCYQDMpLbFzO8ACNo+/ItWJA+hlkPl1AKQ
 pKe/oHhcRtyK3Jw2ZJtJJn2OQ7l6jk31OiTTr+ARTHbYI42zfUg5eu5jlp/6sVKIgjZHyvrlPhO
 At7CMosjcY8KU39r/HrZD0OH//T/qCPr3/6/EAZcGZjhBx7DvfCQJo6JfpYibBQGDXWS6NkFcBy
 HC5WEsb977/cesrxeM6o6aJP2FYXpYmsH3zaxWO7LlZs60UQcF31Bvi+Rs/dS6RmypCUEm5eKt3
 oAWnrLotiEcSx5ni2Tp8zpYHLkOFuw==
X-Proofpoint-ORIG-GUID: 5hBNQ5TmpHa51wdDx3TK0D9pEJKA6x8V
X-Authority-Analysis: v=2.4 cv=QLxlhwLL c=1 sm=1 tr=0 ts=6911ec88 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fKl0S-9-5daLM7QqcyEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100120

On Sun, Nov 09, 2025 at 08:07:16PM +0530, Shivendra Pratap wrote:
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
> Reviewed-by: Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/nvmem-reboot-mode.c  | 13 +++++++++----
>  drivers/power/reset/qcom-pon.c           | 11 ++++++++---
>  drivers/power/reset/reboot-mode.c        | 19 +++++++++++++------
>  drivers/power/reset/syscon-reboot-mode.c | 11 ++++++++---
>  include/linux/reboot-mode.h              |  3 ++-
>  5 files changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
> index 41530b70cfc48c2a83fbbd96f523d5816960a0d1..5d73dde585b1fd438b1847f884feb37cd9e4dd5c 100644
> --- a/drivers/power/reset/nvmem-reboot-mode.c
> +++ b/drivers/power/reset/nvmem-reboot-mode.c
> @@ -16,15 +16,20 @@ struct nvmem_reboot_mode {
>  	struct nvmem_cell *cell;
>  };
>  
> -static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
> -				    unsigned int magic)
> +static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
>  {
> -	int ret;
>  	struct nvmem_reboot_mode *nvmem_rbm;
> +	u32 magic_32;
> +	int ret;
> +
> +	if (magic > U32_MAX)
> +		return -EINVAL;


I believe, we need a comment in all the client driver.. 

> +
> +	magic_32 = magic;
>  
>  	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
>  
> -	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
> +	ret = nvmem_cell_write(nvmem_rbm->cell, &magic_32, sizeof(magic_32));
>  	if (ret < 0)
>  		dev_err(reboot->dev, "update reboot mode bits failed\n");
>  
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
> index 7e108982a582e8243c5c806bd4a793646b87189f..d0ed9431a02313a7bbaa93743c16fa1ae713ddfe 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -27,17 +27,22 @@ struct qcom_pon {
>  	long reason_shift;
>  };
>  
> -static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
> -				    unsigned int magic)
> +static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
>  {
>  	struct qcom_pon *pon = container_of
>  			(reboot, struct qcom_pon, reboot_mode);
> +	u32 magic_32;
>  	int ret;
> 

Since we are doing this change in reboot framework, client driver should know about
it too about this new check because of framework.

> +	if (magic > U32_MAX || (magic << pon->reason_shift) > U32_MAX)


is this (magic << pon->reason_shift) > U32_MAX really needed ..?

> +		return -EINVAL;
> +
> +	magic_32 = magic << pon->reason_shift;
> +
>  	ret = regmap_update_bits(pon->regmap,
>  				 pon->baseaddr + PON_SOFT_RB_SPARE,
>  				 GENMASK(7, pon->reason_shift),
> -				 magic << pon->reason_shift);
> +				 magic_32);
>  	if (ret < 0)
>  		dev_err(pon->dev, "update reboot mode bits failed\n");
>  
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index eff60d6e04df2cb84ba59d38512654336f272f8a..873ac45cd7659b214b7c21958f580ca381e0a63d 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -19,12 +19,11 @@
>  
>  struct mode_info {
>  	const char *mode;
> -	u32 magic;
> +	u64 magic;
>  	struct list_head list;
>  };
>  
> -static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
> -					  const char *cmd)
> +static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, const char *cmd)
>  {
>  	const char *normal = "normal";
>  	struct mode_info *info;
> @@ -56,7 +55,7 @@ static int reboot_mode_notify(struct notifier_block *this,
>  			      unsigned long mode, void *cmd)
>  {
>  	struct reboot_mode_driver *reboot;
> -	unsigned int magic;
> +	u64 magic;
>  
>  	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
>  	magic = get_reboot_mode_magic(reboot, cmd);
> @@ -80,6 +79,8 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle
>  	struct device_node *np;
>  	struct property *prop;
>  	size_t len = strlen(PREFIX);
> +	u32 magic_arg1;
> +	u32 magic_arg2;
>  	int ret;
>  
>  	if (!fwnode)
> @@ -101,12 +102,18 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle
>  			goto error;
>  		}
>  
> -		if (of_property_read_u32(np, prop->name, &info->magic)) {
> -			pr_err("reboot mode %s without magic number\n", info->mode);
> +		if (of_property_read_u32(np, prop->name, &magic_arg1)) {
> +			pr_err("reboot mode without magic number\n");
>  			kfree(info);
>  			continue;
>  		}
>  
> +		if (of_property_read_u32_index(np, prop->name, 1, &magic_arg2))
> +			magic_arg2 = 0;
> +
> +		info->magic = magic_arg2;
> +		info->magic = (info->magic << 32) | magic_arg1;
> +
>  		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
>  		if (!info->mode) {
>  			ret =  -ENOMEM;
> diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
> index e0772c9f70f7a19cd8ec8a0b7fdbbaa7ba44afd0..3cbd000c512239b12ec51987e900d260540a9dea 100644
> --- a/drivers/power/reset/syscon-reboot-mode.c
> +++ b/drivers/power/reset/syscon-reboot-mode.c
> @@ -20,16 +20,21 @@ struct syscon_reboot_mode {
>  	u32 mask;
>  };
>  
> -static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
> -				    unsigned int magic)
> +static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
>  {
>  	struct syscon_reboot_mode *syscon_rbm;
> +	u32 magic_32;
>  	int ret;
>

same here

> +	if (magic > U32_MAX)
> +		return -EINVAL;
> +
> +	magic_32 = magic;
> +
>  	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
>  
>  	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
> -				 syscon_rbm->mask, magic);
> +				 syscon_rbm->mask, magic_32);
>  	if (ret < 0)
>  		dev_err(reboot->dev, "update reboot mode bits failed\n");
>  
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index 22f707ade4ba93592823ea8718d467dbfc5ffd7c..e0d3e8a54050a76f26846f456120b4c7e371d284 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -3,11 +3,12 @@
>  #define __REBOOT_MODE_H__
>  
>  #include <linux/fwnode.h>
> +#include <linux/types.h>
>  
>  struct reboot_mode_driver {
>  	struct device *dev;
>  	struct list_head head;
> -	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
> +	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
>  	struct notifier_block reboot_notifier;
>  };
>  
> 
> -- 
> 2.34.1
> 

-- 
-Mukesh Ojha

