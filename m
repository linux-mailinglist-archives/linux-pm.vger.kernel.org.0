Return-Path: <linux-pm+bounces-31088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E2EB0B0A7
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 17:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0AA1AA29D4
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AF82877CA;
	Sat, 19 Jul 2025 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IzqsN7Yl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62392AF14
	for <linux-pm@vger.kernel.org>; Sat, 19 Jul 2025 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752939338; cv=none; b=S5F9TldnUMwgWSPZvUne2/Fa8vU3/swoeNqPBW9E5ieB7wQMDN3QovcHog2G9Pv1vLCJhnU5p0muE9B3RsUwgqLwA4FEye8DXJUMCzuu3UmpjSjrPUTj41q7EMLvSV12VGDPhLAeKZ0RjbHTdNwSiWy4O1KiHs3PEIGZ/rDpX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752939338; c=relaxed/simple;
	bh=vDFFxQ4927Pmm0dZVmNoM9bCl+rp3L97nHz4D4bV4gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bx8nEudn39ynIdStcToN3zUGUiObizDByTjEgfrMjOt8rJa+h+5V9AkqWHKtpn5IFdw+7e8X/+l2K0KRZauux2rICUhdzexMHqNSEODkvFhRP985L2M7NajrZ1RsOSxepKcRIcqh1EBPuwmpuNs6yelVjRHq52x10QMC707BVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IzqsN7Yl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56JBcTnx008388
	for <linux-pm@vger.kernel.org>; Sat, 19 Jul 2025 15:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XydjBg1XxLlIiQ3n9lIqoq9TZugRKk685ZRW+FjNQmk=; b=IzqsN7YlE9pZmOdg
	xEzykRiESdHT4Jun6FJu/RgkJRlF6xWOtrNhGsGehXW1YtcTmySinWj7anCc2lMQ
	XRSRj6kGx85BjnD41MMXbivYi+kHDtdu394/PCKnBW/t0h9KxbRv7H5IurmNICgR
	G6SuKzpW5QShLJiojYOfZnIbNk9rXAuok/UbvDwfO+jVVWLnNq075TtphqK4XVxX
	yd7NZmGOzJh63xvaosBTT1eMSm6TH52AFhtaiRhWMOMi4EMr4vpu09wHJhOhWNcl
	opMunKnkpzpBb2qokkOJJD+SBQed9nryGzX27KmOUnPIX9/q937PGQlNHv46CNuf
	YIz50Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048t8u27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 19 Jul 2025 15:35:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235e7550f7bso30113335ad.3
        for <linux-pm@vger.kernel.org>; Sat, 19 Jul 2025 08:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752939328; x=1753544128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XydjBg1XxLlIiQ3n9lIqoq9TZugRKk685ZRW+FjNQmk=;
        b=po/ZhxgD0idrFrg7pSnhz05lFx6neosjp2zN97NoUYEDhZZLEAo1A/otstLAagGTkq
         awR8huF8iboG94+PoMxKKZOLbMSZAVackLDoYt0vn1y2M5ax7PSNLZwJPuXxGp05BNHt
         67ab8uFrs/31j8xXlaLq4DWJ2MjV9UWmPKQ8zhNXwBgsNKiEPV6+aa88V5UnStgHXk1I
         HR8jCa4EJ63zBSoByguJlsscn6pdAPKnVmiRD1RrqIgM9guZ3ASgb9hP2SccJqqS7e2S
         8AgMng12hvatNF2q7/OgxHT2E5fPMKEQ23rYi+80aaQe4S3cIIsJpMBmS8FoAmaVoqmn
         yB2A==
X-Forwarded-Encrypted: i=1; AJvYcCV8fH8T+Bp+v1u5yJyrHH50JQT46gN/PND3j4KPWgS6PQPMog9c45sduoe26RXg7+nFuFRvptgGkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/AZe7CvQNzTfSvJqTjKWZsJTsu504qbDvJ+iaaUynTDBtVVg
	V465W+h84CdqvZk39h4au7jofonsyXx1IbkOzcC4nXnQlxpA1WYyqodYSoN3iOyAXlkrh1XDy8I
	mzNN88rTrkPUZUkj7nAuj5TO0nwVrPKoChSInS+6MvIjxcfOTLirlvOKGcVvC6Q==
X-Gm-Gg: ASbGncsmwXAN7b96x9B5KiagBw7NCQ+V3RQgZZHaEZFAqJo9rlvKhKvXGJ9RxGc0lhR
	vUPVwONcByimWRJ+1ABMMKfd6L49hAHJ9+QbQTO4+uJru/c6FrKUYe0vTRknyRqw1Ae5DygjyhY
	/Iy/mAml5T4c3J89PgAlrYnlJvW2sNj3GeexiNe2D3wjciaspD6n9s3XyZ0DNVrKa6vR6kVl89N
	fQ3aes0B3cEL401B1LJ1AKEjoEbsmt83IFOd1xm/tXXgwXW30l37qdiskwvG8zwCfSzSfA7oMOT
	yWSmNvFFYaC0Lq65I35I120lX3i12LncWHIwJjVkl2GnHnnvTtveWqWEXKZTJK4XmSjAOpNTpPL
	l
X-Received: by 2002:a17:903:1105:b0:234:8a4a:adb4 with SMTP id d9443c01a7336-23e3b79a73emr90078115ad.21.1752939327853;
        Sat, 19 Jul 2025 08:35:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsIXRK/U7kjcNQqkbSjngoR8dF0R0lYOxXpmmF/dV3BhNwAi2WvyTXE4mAh5pE2+0gLI3SlQ==
X-Received: by 2002:a17:903:1105:b0:234:8a4a:adb4 with SMTP id d9443c01a7336-23e3b79a73emr90077795ad.21.1752939327352;
        Sat, 19 Jul 2025 08:35:27 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.231.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3d37sm30619365ad.16.2025.07.19.08.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jul 2025 08:35:27 -0700 (PDT)
Message-ID: <54eaf8e8-2b4d-b0bd-b65f-1262e72a54dd@oss.qualcomm.com>
Date: Sat, 19 Jul 2025 21:05:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v11 1/8] power: reset: reboot-mode: Add device tree
 node-based registration
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
 <20250717-arm-psci-system_reset2-vendor-reboots-v11-1-df3e2b2183c3@oss.qualcomm.com>
 <y7xhfbiwkduo3lytb5gbukdu3yptx6uajtbngbspqbqkyt5dzo@gy62zoxwr6ah>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <y7xhfbiwkduo3lytb5gbukdu3yptx6uajtbngbspqbqkyt5dzo@gy62zoxwr6ah>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDE1NSBTYWx0ZWRfX9xUFbYJw3Tfs
 NjlwklFJ8V7l+cVFq6DsGYTNMUadgRN4UWGs0sNbv10PGJlGrZlHs+TfpF8Xq4DDgPyogOiZCBw
 zbIoQghihVEbJSNxSRSoFGfzmFBG3sqIT4eur4M3ANakoZ5Zp9ESw6/kcV3V/enm0wV0+UdY8bf
 9NwisfLCZArffukuF6nhvqBloP9mbhEBy0QzVf+8m7nYk8bGELPW8MxcP6cMfnoS1UNccAOrDGU
 RIBPW9tvTTeC9VZnm4ALEDLMoHVLXDNs7FsmcWIPTIln0MR/7PpCp8G9d/g0htuUyJPxrdwrdRx
 jUFmOvLZzfPCDunAaFnTeIRjHfkLO6erQsebWby9ocVhyJCPJa0fXiGOM0gxUQbU2rL7UQ2f1Uy
 rzDXUzgLd8+0ZlSVoXcix30dPWwpMDmE01MI9LRgzWWVfTCjLkUIQwOj9N/uOLxoMU08Vl6f
X-Authority-Analysis: v=2.4 cv=Jb68rVKV c=1 sm=1 tr=0 ts=687bbb41 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=PsbcbGlCJbaar3GLNM5paQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=fCp3oo7GvzJIsszaBaoA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: FUg5ilLZHdW-pG_0vrkRN8m9sHXFKP6Q
X-Proofpoint-ORIG-GUID: FUg5ilLZHdW-pG_0vrkRN8m9sHXFKP6Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507190155



On 7/19/2025 12:07 AM, Dmitry Baryshkov wrote:
> On Thu, Jul 17, 2025 at 06:16:47PM +0530, Shivendra Pratap wrote:
>> The reboot-mode driver does not have a strict requirement for
>> device-based registration. It primarily uses the device's of_node
>> to read mode-<cmd> properties and the device pointer for logging.
>>
>> Remove the dependency on struct device and introduce support for
>> Device Tree (DT) node-based registration. This enables drivers
>> that are not associated with a struct device to leverage the
>> reboot-mode framework.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  drivers/power/reset/reboot-mode.c | 29 +++++++++++++++++++----------
>>  include/linux/reboot-mode.h       |  2 +-
>>  2 files changed, 20 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
>> index fba53f638da04655e756b5f8b7d2d666d1379535..0269ec55106472cf2f2b12bd65704dd0114bf4a3 100644
>> --- a/drivers/power/reset/reboot-mode.c
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -3,13 +3,17 @@
>>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>>   */
>>  
>> +#define pr_fmt(fmt)	"reboot-mode: " fmt
>> +
>>  #include <linux/device.h>
>>  #include <linux/init.h>
>>  #include <linux/kernel.h>
>> +#include <linux/list.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/reboot.h>
>>  #include <linux/reboot-mode.h>
>> +#include <linux/slab.h>
>>  
>>  #define PREFIX "mode-"
>>  
>> @@ -65,33 +69,35 @@ static int reboot_mode_notify(struct notifier_block *this,
>>  /**
>>   * reboot_mode_register - register a reboot mode driver
>>   * @reboot: reboot mode driver
>> + * @np: Pointer to device tree node
>>   *
>>   * Returns: 0 on success or a negative error code on failure.
>>   */
>> -int reboot_mode_register(struct reboot_mode_driver *reboot)
>> +int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np)
>>  {
>>  	struct mode_info *info;
>>  	struct property *prop;
>> -	struct device_node *np = reboot->dev->of_node;
>>  	size_t len = strlen(PREFIX);
>>  	int ret;
>>  
>> +	if (!np)
>> +		return -EINVAL;
>> +
>>  	INIT_LIST_HEAD(&reboot->head);
>>  
>>  	for_each_property_of_node(np, prop) {
>>  		if (strncmp(prop->name, PREFIX, len))
>>  			continue;
>>  
>> -		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
>> +		info = kzalloc(sizeof(*info), GFP_KERNEL);
>>  		if (!info) {
>>  			ret = -ENOMEM;
>>  			goto error;
>>  		}
>>  
>>  		if (of_property_read_u32(np, prop->name, &info->magic)) {
>> -			dev_err(reboot->dev, "reboot mode %s without magic number\n",
>> -				info->mode);
>> -			devm_kfree(reboot->dev, info);
>> +			pr_err("reboot mode %s without magic number\n", info->mode);
>> +			kfree(info);
>>  			continue;
>>  		}
>>  
>> @@ -102,8 +108,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>>  		} else if (info->mode[0] == '\0') {
>>  			kfree_const(info->mode);
>>  			ret = -EINVAL;
>> -			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
>> -				prop->name);
>> +			pr_err("invalid mode name(%s): too short!\n", prop->name);
>>  			goto error;
>>  		}
>>  
>> @@ -130,11 +135,15 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
>>  int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>>  {
>>  	struct mode_info *info;
>> +	struct mode_info *next;
>>  
>>  	unregister_reboot_notifier(&reboot->reboot_notifier);
>>  
>> -	list_for_each_entry(info, &reboot->head, list)
>> +	list_for_each_entry_safe(info, next, &reboot->head, list) {
> 
> This feels liks a missing lock.
Should we add a lock here? The list will mostly be fully created only
once at the time of registration.
- thanks.
> 
>>  		kfree_const(info->mode);
>> +		list_del(&info->list);
> 
> list_del should come before kfree, otherwise it's possible to access
> freed memory while traversing the list.
sure. will make it list_del(&info->list) and then kfree_const(info->mode).
- thanks.
> 
>> +		kfree(info);
>> +	}
>>  
>>  	return 0;
>>  }
>> @@ -162,7 +171,7 @@ int devm_reboot_mode_register(struct device *dev,
>>  	if (!dr)
>>  		return -ENOMEM;
>>  
>> -	rc = reboot_mode_register(reboot);
>> +	rc = reboot_mode_register(reboot, reboot->dev->of_node);
>>  	if (rc) {
>>  		devres_free(dr);
>>  		return rc;
>> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
>> index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..36f071f4b82e1fc255d8dd679a18e537655c3179 100644
>> --- a/include/linux/reboot-mode.h
>> +++ b/include/linux/reboot-mode.h
>> @@ -9,7 +9,7 @@ struct reboot_mode_driver {
>>  	struct notifier_block reboot_notifier;
>>  };
>>  
>> -int reboot_mode_register(struct reboot_mode_driver *reboot);
>> +int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np);
>>  int reboot_mode_unregister(struct reboot_mode_driver *reboot);
>>  int devm_reboot_mode_register(struct device *dev,
>>  			      struct reboot_mode_driver *reboot);
>>
>> -- 
>> 2.34.1
>>
> 

