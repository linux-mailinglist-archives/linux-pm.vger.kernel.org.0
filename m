Return-Path: <linux-pm+bounces-37731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA12C46BE4
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 14:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C48C3ABE56
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 13:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E71F63F9;
	Mon, 10 Nov 2025 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d+q2Ky/t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OcFosmK5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587701AF4D5
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779743; cv=none; b=GTKx2oCe0r9+xdQeAp9k7p/jOq5JjkvtJi590zs4tIzcGAjf6eVstyqVJY4n3w3RCE27WEd4y2TEVesrX7lqxIBeO4vlKnvgtfFy0h0pkPGlCh3oN7zQhXU9padfny69HDaAEpXvgsiz/I8qOqAy4DZum117ZpC31c5KP/yHZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779743; c=relaxed/simple;
	bh=+4ZxlFrdzDO1qRTYzmjyUOh4/9jXixFylZZ+i7Vetns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4Uo9M1kKhGBvYgGJkY/htKuWhBkhvxoCGliWSE3kRLJbGSJ1G9UQtPEDfmhg5ZnuUfJZmW1s1fcwChKqngRbixPmmMkU5aiZM6o15uPYfkOe2PamrlxKdUYQ2JezJ1MS6nL1F81CaUdWP9T2Qn3Dir5FxELfc7YgBHFr/uZrfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d+q2Ky/t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OcFosmK5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA9Ejm82992502
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hdAqq6gqBND8Fs3HbuhQPOwr
	0iZNfL+XllM8w7ygkFY=; b=d+q2Ky/tFSl9HXhSKh09BtEuMStPhV34WMVQm4Sl
	FVNfpC5SRisHInQYah49vUOz+IFeW7d+oC4fzAlffHNosnx2fMYvjpTujpYa27qb
	hs2SUdA0SEkpgyBi5pvwixA7Ko1lTkwPVS4ArnB5mZi6eVuESyKqCwfc/Ce5v6+Y
	bxNQW/nKjvhMggEU6mYVWMNr5pBv0kjOs9vwtxQjKhg4j3a6eAFvG7BolKBSmIX7
	fgIYAV8Hbno/6ibkj25R6YcSGWDcGrZr9qHhhXoz2YHcAC0PMpid/VbJFwFNhSa1
	P1Wwj5ywSJAgQXH1VlSUS+Bl9Dwxhc8FnmwdHIX5/8oQDQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd88rn09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:02:21 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a153ba0009so6884571b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 05:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762779741; x=1763384541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdAqq6gqBND8Fs3HbuhQPOwr0iZNfL+XllM8w7ygkFY=;
        b=OcFosmK5fznaAytiL0QqbQ+TLVu8YyPdy7UEMT7k1CPfHw/bzZT6jXp0ax6mLCeEBf
         mP4IVFmNQKcV60XB4XHEAXSCyehRo2jhU3cUQVl3KAcQasPiNXJpBgdCtMnQfzU8Nkdo
         xt++qzDR2iVETA68qtxZFZSFeIGmPsqjhwkVGpPfhUtpcYuOif547FiW7iHu+QlMtF1S
         gfozUGbRw7y1468tfwufbIzhDO9+Ea6tDuE3yhkL7P0CuYwHXKxrH5QwXuyQgte4Tq4F
         W8rIlMASDoPd7p99NHLXF/a/hGYdJzBJ0MLbTwUduko3ep8ap9Fj6l/QWFCZgvL93qCQ
         QJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762779741; x=1763384541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdAqq6gqBND8Fs3HbuhQPOwr0iZNfL+XllM8w7ygkFY=;
        b=E0u0WMYIAEr3GOhRxBWorMAA0dIvzlbk1JsuKkx2lDEJdZ8dl88p5Sb06/REd20gyp
         FWcHLupwwT0FZEbOAJe7y/Xlx4LvB8WW/fTLUxD1tc9PR196qkfbrPXIQmIuNXhBwe+K
         cgGI+vjApFyV/DFZJPPy4/bcUSedTn1mSBCITL495i+X/htc2sx6F4HWtbMIlwMaMeZS
         SQmbQuiSV6uyEq9r9EXtdbZ7uE+tp9nw0Tbl9H1zJ5kb4ca4vZ4toN8+kYAMzg20fnEC
         kPhdv6oKMOHmrqQmL2oFqLLZAtQgM37p857HuMSgeQG+ngnDfvDEMLIYGstEDXtkJE9i
         kHhA==
X-Forwarded-Encrypted: i=1; AJvYcCUuHQo02IMvNT+aYGqFQD0D44Loim+kuOPv+7qzbqFE8QT/JT/H4OafJWVKzwGjP02ey2vjI4XRyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/44feqrg8XGDzaZcEe7CwvRthfxnJBFMtvfkQ8uWx3dUSZrye
	XHa3iOUiS4B2WA+9c5SMqPzG44oTO6jHFtNNR3pOLKfanqn4CNaczjagjJNz0RqNcoX66jZOHiE
	eG38Ls3/Pf9NZR9/8YvRb+tlimg4QfOBz0uRlkPuvAXP8nqCGCynq4YWRttkWKA==
X-Gm-Gg: ASbGnctwVmTU68D6CTyzuC6i+zan6NWBUwiRMg7ZdCmkvRsO3yYWGEg5P1oxHamLImr
	FgqeoZhv2ZzKvcYYQ0Ji7iIN3Rt0B1SnyU/KfOvVBmAV/Dq+jb/LIS7yhOaRuS3id74uXE+t4mb
	KqhRvW87MNP3j77aOp2OQs3suSGrQCa7XrAst6t0vNlr5Wms5XPpFgmZB7qwLbGzDnyqaPd3EEN
	AXcYWGV3CEzw245zUoUaYaFvf3zA7RpDBTF4a1Do2i7fDlN/zs77jk+ebThHgQ7+nYztat/enZP
	1tbky3j6r7qCHWWLddjqbQqUSQfQNdNInjG9tGzfclW6ucb4Fi33rWtLgqOgBHPcMzb2pN6eMuI
	vfdHr7hXfLEy+0DJJnymSMNnBfQ==
X-Received: by 2002:a05:6a00:4b07:b0:771:fdd9:efa0 with SMTP id d2e1a72fcca58-7b22669dee0mr11189862b3a.15.1762779740441;
        Mon, 10 Nov 2025 05:02:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhpkm261mrE/5oxpuaFgBIprvalMVyj0gtY+UxkD+iayB45fXNN6yALoTWNcWUZ4aTaxY9NA==
X-Received: by 2002:a05:6a00:4b07:b0:771:fdd9:efa0 with SMTP id d2e1a72fcca58-7b22669dee0mr11189754b3a.15.1762779739516;
        Mon, 10 Nov 2025 05:02:19 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff8538sm11894371b3a.28.2025.11.10.05.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:02:11 -0800 (PST)
Date: Mon, 10 Nov 2025 18:31:59 +0530
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
        Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v17 01/12] power: reset: reboot-mode: Remove devres based
 allocations
Message-ID: <20251110130159.pzfmh7mr3p7xz5o7@hu-mojha-hyd.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-1-46e085bca4cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-1-46e085bca4cc@oss.qualcomm.com>
X-Proofpoint-GUID: cxbwuUjeD6Pzmwhf2RJz2ive5i8EVeDU
X-Authority-Analysis: v=2.4 cv=PL4COPqC c=1 sm=1 tr=0 ts=6911e25d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zIWh1NZzt5suZCnL7JMA:9
 a=CjuIK1q_8ugA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExNCBTYWx0ZWRfXzE0ipHigv28+
 GcfzhAlGpCs1tTbnbLsaqlW2kFGdgtL7U54qZYW3ppKMbtmymcAnhZFsifHF7pCAFVNVet/qqA1
 R2hOSfqD7rGQOP5IfbQHGsoGTXuHCaOVZm8EMcOaIMR7YRjNJIjGw9FlfjWIcSSchMDgKlC2Glw
 Ojcoh58BIFIZiZKEuQarrybAHWUdZhUkwspE09SfBkb8ALCFEUXIENOEXfmF+Js/optENSEseNl
 kN8o4epBauNCb3EbwKkD6GwGoiFxYazPTCAgFIJ+pGE6u+bVuXVCZRlmqOcOBGeeJBASQJVFyqQ
 Nhnyp7n+7CQ7zg9Bg+tVQOyTZkDPmfe3p59Ja0pFI3VbNzRHvEeWG9PBK0ykgNY5tppH3gMjezj
 f8mBRKO2E/z99Q0OVqq84Iw0vAqgGw==
X-Proofpoint-ORIG-GUID: cxbwuUjeD6Pzmwhf2RJz2ive5i8EVeDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100114

On Sun, Nov 09, 2025 at 08:07:14PM +0530, Shivendra Pratap wrote:
> Devres APIs are intended for use in drivers, and they should be
> avoided in shared subsystem code which is being used by multiple
> drivers. Avoid using devres based allocations in the reboot-mode
> subsystem and manually free the resources.
> 
> Replace devm_kzalloc with kzalloc and handle memory cleanup
> explicitly.
> 
> Fixes: 4fcd504edbf7 ("power: reset: add reboot mode driver")
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index fba53f638da04655e756b5f8b7d2d666d1379535..ac4223794083f36960b2bd37a601b7e1f1872de5 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -3,6 +3,8 @@
>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>   */
>  
> +#define pr_fmt(fmt)	"reboot-mode: " fmt
> +
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -71,6 +73,7 @@ static int reboot_mode_notify(struct notifier_block *this,
>  int reboot_mode_register(struct reboot_mode_driver *reboot)
>  {
>  	struct mode_info *info;
> +	struct mode_info *next;
>  	struct property *prop;
>  	struct device_node *np = reboot->dev->of_node;
>  	size_t len = strlen(PREFIX);
> @@ -82,29 +85,27 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>  		if (strncmp(prop->name, PREFIX, len))
>  			continue;
>  
> -		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
> +		info = kzalloc(sizeof(*info), GFP_KERNEL);
>  		if (!info) {
>  			ret = -ENOMEM;
>  			goto error;
>  		}
>  
>  		if (of_property_read_u32(np, prop->name, &info->magic)) {
> -			dev_err(reboot->dev, "reboot mode %s without magic number\n",
> -				info->mode);
> -			devm_kfree(reboot->dev, info);
> +			pr_err("reboot mode %s without magic number\n", info->mode);
> +			kfree(info);

This as well could be avoided if we move the above memory allocation
after of_property_read_u32()

>  			continue;
>  		}
>  
>  		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
>  		if (!info->mode) {
>  			ret =  -ENOMEM;
> -			goto error;
> +			goto err_info;
>  		} else if (info->mode[0] == '\0') {
>  			kfree_const(info->mode);
>  			ret = -EINVAL;
> -			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
> -				prop->name);
> -			goto error;
> +			pr_err("invalid mode name(%s): too short!\n", prop->name);
> +			goto err_info;
>  		}
>  
>  		list_add_tail(&info->list, &reboot->head);
> @@ -115,9 +116,14 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>  
>  	return 0;
>  
> +err_info:

free_info ?

> +	kfree(info);
>  error:
> -	list_for_each_entry(info, &reboot->head, list)
> +	list_for_each_entry_safe(info, next, &reboot->head, list) {
> +		list_del(&info->list);
>  		kfree_const(info->mode);
> +		kfree(info);
> +	}
>  
>  	return ret;
>  }
> @@ -130,11 +136,15 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
>  int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>  {
>  	struct mode_info *info;
> +	struct mode_info *next;
>  
>  	unregister_reboot_notifier(&reboot->reboot_notifier);
>  
> -	list_for_each_entry(info, &reboot->head, list)
> +	list_for_each_entry_safe(info, next, &reboot->head, list) {
> +		list_del(&info->list);
>  		kfree_const(info->mode);
> +		kfree(info);
> +	}
>  
>  	return 0;
>  }
> 
> -- 
> 2.34.1
> 

-- 
-Mukesh Ojha

