Return-Path: <linux-pm+bounces-31075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B541B0AA36
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 20:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848D91C80CC4
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 18:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6342E7F1F;
	Fri, 18 Jul 2025 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8XqDrW5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F252E7BC4
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863835; cv=none; b=REH81qrQ3LuVm0FUkA3VASacvschuXBw2mqRzMeWzctH2uPeYu2+frP/vqjgx9MukMyNT2Cl5lLOZdWRjO0S6m0ksOhjkyQaaFDHOkaJ1FpwDKc674Y6wLmI6uGh6F0ZnISm4pd7THiKfUtYJPo4AMjhwyGJwfE39987GYZ0n+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863835; c=relaxed/simple;
	bh=FD9HooRQCc+PXCUOKvmD24mEJXDixu8d1mCmEOHZHmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHUwioD4IOYAkwRN6esiH5SA0NPQQ4ivKS/JpgnlS3qzmKhslKSXeA9CATQ/Fda03ziTGhsQjhNlcb7UN8+v7Rz3bEkF6mFrkXwRFHmJBvpLKO9Td1s9QMU7aFGwGQszPVYiUYaKO8DZaHP68jRiAauOfzb6kH6wHANoeyFtil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P8XqDrW5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IF02me020653
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 18:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ALPvAyKfQjtdHFgs68bECM2y
	VyHmmPwO24e9jJdHfv0=; b=P8XqDrW5iPG1Zr+qNYrNvxjbOiTer6Kt+/d6Vte1
	U/MkzM1dytcaMlu0aj78H5itvp5IMCpGjxy4Tr0j8VO6daAVabH7uLGgt70TvUit
	UjofSgTWIoF8kkxkMpum7buUxBLgxVGoko/N05tbu/R0p948qF3/4/vy6S8pkNnM
	zeR6189Rz37Cr/c2wJumOJ5j/DYZGwIxN+mp8qkBhfd3N5T+gODgkedqQW7ySpHP
	lI5pkGZdb44ABl6RHSCz4X2wfzp7fVtjK6+Hwcy+v981IgTMULCtGrMW37R8V1VF
	Y+8s2w9sWCBHf9o7RNJpZK0iQTgVJHcL3m3/rBu6N4+w1w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpqp9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 18:37:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e093bccd5eso370204785a.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 11:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752863832; x=1753468632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALPvAyKfQjtdHFgs68bECM2yVyHmmPwO24e9jJdHfv0=;
        b=UFyPoZNRqBLjeHiKJw+D7voChMAs2bzpbkq4nms87SxVeUHW12eLKOhYrXp7w5ZxkW
         rcgcSuSn67uNLFVruDulahOk2u+NROVsdOpiOKx7CUhHEyoRwiFZL9oJhM4p6UypHIr5
         GHR5s8pBhGFjF1xgt6u3OsTbWoM/qIxCMioeqiy3NcrTBF5A+5AfDJguQB6HRXwBinLn
         6ewXXE5CZA4jjdlfcAlqt84+HbOBMdQZDTqXI9c7aXu/6APNYW51OcsJniIGR9mWF6Pa
         01iPuEimJ0eGgjVHvIMZzGeGlK3FeSI1Cxn634JTYfNYRVL8KvzHtbaKi0VkCqf+EqIQ
         pH3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWk1wgc357Kf8UrIDM11iVbuhvbqdCyYI68Jh05hGS23IUQCiw9oit6sZPPy3N3PsrpVcFf9XhMTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKVoYpIp5zS9tMBftBF/uswEbz74kieC76O8yWPmF+gvYr9ma
	ZkzIudGTHGre7p7Vj+zV63msxIgyjUsnRBD5pyzoucmcCRNochGCA9VemSidAUwQ/ktpPDt6v9p
	N3XwEFDqqVeBz9TxaIAsTYHMUH14nrMxGktrKzy61JUoRqzpbkJsPjM69cO8esw==
X-Gm-Gg: ASbGncuOYuMNwzws3HQZQoNkq+UcQItBBVNuDaUPbFQchYok1MJiKQxe1aApPWulOZ+
	GvuEI6bDxY6OTalEX7IeZOypNaFGXTUisepwZOyMy4DGjwTCq/4M3apz03nC575pnNKgUNGVR6+
	oVCUMgrF6cKB4pi4K+rxl83GwQ0kQECb2/2rnSONl+Go2HGJ0arcJwnoNQr3unZcDArG/GHkSEG
	wp2/MZTQzHWBzWoThI4GsBulSZVXS7dfRmtru2jQRwGTIwIthK5Rxh3PZC7wFCM2IzvkgJUc+Ny
	AvizpLojdrCUA1Rt1CcDi2qIuKKTCQ6gQ/FxCTS7+wrl4URKGgn6HEhiAImGGj5CV/ZLx517oOo
	7GlO9Skh+/On1pGT8qg5LYoVkbtyLIcO9IWrsM1NwddSQPTLJlnBV
X-Received: by 2002:a05:620a:268d:b0:7e2:769a:c857 with SMTP id af79cd13be357-7e34335131amr1702167585a.1.1752863831617;
        Fri, 18 Jul 2025 11:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHElvVFF8dizfyr2Wk3GnhytPZl7LLlYnIUcaoY5rC3+dyUZxZapzDDTomhRW5XbvK70xXqrg==
X-Received: by 2002:a05:620a:268d:b0:7e2:769a:c857 with SMTP id af79cd13be357-7e34335131amr1702161085a.1.1752863831040;
        Fri, 18 Jul 2025 11:37:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91d8db4sm2741471fa.74.2025.07.18.11.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 11:37:10 -0700 (PDT)
Date: Fri, 18 Jul 2025 21:37:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v11 1/8] power: reset: reboot-mode: Add device tree
 node-based registration
Message-ID: <y7xhfbiwkduo3lytb5gbukdu3yptx6uajtbngbspqbqkyt5dzo@gy62zoxwr6ah>
References: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
 <20250717-arm-psci-system_reset2-vendor-reboots-v11-1-df3e2b2183c3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-arm-psci-system_reset2-vendor-reboots-v11-1-df3e2b2183c3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE0NyBTYWx0ZWRfXwlvCIIt3RbSs
 eQGid7IiHDE8+6QE1SAbetwj2LCUJ5nLuo6TCSUfM5mKkQIFQNPHVItTBkLbMzZ31QGyGaAm12i
 ZjnhXvaXnRetZHjMri+c6SEaNnnpYDJlmmcWIxDQdUY0xBuFa4tQKtTzzK/HCLet5rh5cV0j78r
 xDy66ka0cUx1tmZzUh7s3etVkHcoo3I5e5vaSK5gFBdU0r8JF8ay6Pe2GozRwgh+qpUrv/OluSd
 tn8sc/hzq0CYkELVphNv4iYD45Yir79zJYbWG6klFWy9yjj0Tp8OOUtZenZRtchFbTWIzWf5xRk
 ynJve440pWCKPXFiFHC3Mf5GmOeGhW+GCUgkPZWBiOsoCcu6+sStJ9kpumkC3qxdkCKTQhGMoan
 OtVCtVCK4HXd7SRN9RGtpmCm/EGSGxGjCTGlTXwbu+6p/y5H6jNfP2cDorngELzoq1JpgAtg
X-Proofpoint-GUID: ZiHkTKb0gfJ1u32Vhik8S3Cr9pQnYiTd
X-Proofpoint-ORIG-GUID: ZiHkTKb0gfJ1u32Vhik8S3Cr9pQnYiTd
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687a9459 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=vZ9_uWrtemhWx8VJ4wEA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180147

On Thu, Jul 17, 2025 at 06:16:47PM +0530, Shivendra Pratap wrote:
> The reboot-mode driver does not have a strict requirement for
> device-based registration. It primarily uses the device's of_node
> to read mode-<cmd> properties and the device pointer for logging.
> 
> Remove the dependency on struct device and introduce support for
> Device Tree (DT) node-based registration. This enables drivers
> that are not associated with a struct device to leverage the
> reboot-mode framework.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 29 +++++++++++++++++++----------
>  include/linux/reboot-mode.h       |  2 +-
>  2 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index fba53f638da04655e756b5f8b7d2d666d1379535..0269ec55106472cf2f2b12bd65704dd0114bf4a3 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -3,13 +3,17 @@
>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>   */
>  
> +#define pr_fmt(fmt)	"reboot-mode: " fmt
> +
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/reboot.h>
>  #include <linux/reboot-mode.h>
> +#include <linux/slab.h>
>  
>  #define PREFIX "mode-"
>  
> @@ -65,33 +69,35 @@ static int reboot_mode_notify(struct notifier_block *this,
>  /**
>   * reboot_mode_register - register a reboot mode driver
>   * @reboot: reboot mode driver
> + * @np: Pointer to device tree node
>   *
>   * Returns: 0 on success or a negative error code on failure.
>   */
> -int reboot_mode_register(struct reboot_mode_driver *reboot)
> +int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np)
>  {
>  	struct mode_info *info;
>  	struct property *prop;
> -	struct device_node *np = reboot->dev->of_node;
>  	size_t len = strlen(PREFIX);
>  	int ret;
>  
> +	if (!np)
> +		return -EINVAL;
> +
>  	INIT_LIST_HEAD(&reboot->head);
>  
>  	for_each_property_of_node(np, prop) {
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
>  			continue;
>  		}
>  
> @@ -102,8 +108,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>  		} else if (info->mode[0] == '\0') {
>  			kfree_const(info->mode);
>  			ret = -EINVAL;
> -			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
> -				prop->name);
> +			pr_err("invalid mode name(%s): too short!\n", prop->name);
>  			goto error;
>  		}
>  
> @@ -130,11 +135,15 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
>  int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>  {
>  	struct mode_info *info;
> +	struct mode_info *next;
>  
>  	unregister_reboot_notifier(&reboot->reboot_notifier);
>  
> -	list_for_each_entry(info, &reboot->head, list)
> +	list_for_each_entry_safe(info, next, &reboot->head, list) {

This feels liks a missing lock.

>  		kfree_const(info->mode);
> +		list_del(&info->list);

list_del should come before kfree, otherwise it's possible to access
freed memory while traversing the list.

> +		kfree(info);
> +	}
>  
>  	return 0;
>  }
> @@ -162,7 +171,7 @@ int devm_reboot_mode_register(struct device *dev,
>  	if (!dr)
>  		return -ENOMEM;
>  
> -	rc = reboot_mode_register(reboot);
> +	rc = reboot_mode_register(reboot, reboot->dev->of_node);
>  	if (rc) {
>  		devres_free(dr);
>  		return rc;
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..36f071f4b82e1fc255d8dd679a18e537655c3179 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -9,7 +9,7 @@ struct reboot_mode_driver {
>  	struct notifier_block reboot_notifier;
>  };
>  
> -int reboot_mode_register(struct reboot_mode_driver *reboot);
> +int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np);
>  int reboot_mode_unregister(struct reboot_mode_driver *reboot);
>  int devm_reboot_mode_register(struct device *dev,
>  			      struct reboot_mode_driver *reboot);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

