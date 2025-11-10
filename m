Return-Path: <linux-pm+bounces-37737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C579C46D7A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 14:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5E2188FCC7
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 13:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003B9303A22;
	Mon, 10 Nov 2025 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YSjH+mId";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HVeT2Sx/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6079B22579E
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780816; cv=none; b=hNyFssk+sCkmrXLs3F6+ZJmiakS+LHZNVxAZVznBoFBpFyTNIrvDVUc7MaZa7U7uebXMb2pZ4ExPTePym6jRuKdS0UBALUUBKA78FiXmSPmYffQBkdTMztVNMrzgqQFlhzoRrS8VsmPsM7RXjmRGZjQMA6daUmKmKdepAWM/Qms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780816; c=relaxed/simple;
	bh=9VScjyjKud5P25axVXhej/7B7c/JyF+EhHBfcxj2J7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZG374pHxH4sCxCcQ3YEh6syBmEjgVwk6FQgF7pSx4/dDbFylb8tr4tQ3CtNzTiAe4ujcTKFDw6FQgKEx+omafHR0EI5bH12JN0WZ7TgaxEo18oPgdOEB6nNFoRHHap5vJ+ai2654tE4gmbIkv2sKQN+iCFYnys4EiJkqwu9KQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YSjH+mId; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HVeT2Sx/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAAcVlL2547467
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aS5NUTTv3FdBLmHBPmYyttDzcW9cweq8QpTX4mKQofw=; b=YSjH+mIdOYFs2Mxh
	eEgTOHYlQYj4B2WIumQaiocY59afZzEYa2jfmodQal7oMbx6Hz1QrR8IEju6v8CM
	h2GI/W0DS8pzYC6D+qyGES+HZybkMClZJN6D0cnGN+ntODjCUNeyb4xyu4o/pmSL
	LXl4TEsqL4EsHk5OCgcoI8mIdaR5XOL5O2kRyvu7Du3aQV5/7CovPXl+UhUyJlD/
	6uBEHMs8lzPZvhaWbwxO2aXey2Bjql001ayuVH48S9vf5rbiGhHVU+7PApme7Faw
	jzavIpXn/moLfI8hNDLQGysbglrqgHDOlDGf68V723uHjEnrfkgeFdL85pAUcIJe
	gkoxgA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab8ea9jts-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:20:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b969f3f5c13so2932780a12.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 05:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762780813; x=1763385613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aS5NUTTv3FdBLmHBPmYyttDzcW9cweq8QpTX4mKQofw=;
        b=HVeT2Sx/CoL5rF3OLXqxZuEjwz9d3op/pgSoRYjYjB8YVHBObl5vwWDgHSHskiQb4J
         tVtjjpfjEN9p9Eu28w7jeY8lS6/UdGrFnfcmGFB0KPLgaBboF3S095Cl8AyZ8DDkMNH2
         A9LytBHSGABepDE35LNYKVHprpQBe8DbUL1PLk+8+L1ZEbjWLM9dLwiplT6+r10EHLZZ
         5FhLmuDqgrEWWjEzFPhHN/h7WsiG2TkRwOiP+HCmWs7M3VEd4GQNQAghkcpNcsquqORD
         bCD9sO1l1AUYdQUskRIdHNJ6fOvCEpHdbPZ/PlQ8lK6YUtAM1C8bjsy+qp9lms8yz5ol
         BVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780813; x=1763385613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aS5NUTTv3FdBLmHBPmYyttDzcW9cweq8QpTX4mKQofw=;
        b=aY9NMmeSBK8DtC+iOH14bM8meklajgTgIigBvCW0CnbUbo+mIsONDGFmo+mGCIYGWh
         kY83A6wIo9O9OX4MvMFjE5axdQq4OpHc/1QOje+TL6xvqs2Vr+pfGWGtthNkv5JrG7Bt
         3zdImzBmCqUAMarUdx8dKxdbvJM82uPQ3w4V0Sq0g1orarMwcfM2Y5phbDJtU2lSjEeK
         sKshw7rrGHabDvDGe0tUCrTPEQh7Pamhkj9E6z94SjT55YI00OlI01PlzGojehde2SNV
         ++UmlG0nOBAl22iiXZAAlRger32JQq0jiUaY7XtX1rmdK+JFnjq8QFDnPP78KGi9EpTW
         YkBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdwj73tIzn96AQgeQAgfOoDRGnNcnm52BNDflB3BJu5feIyzDI9/Q3fXhZC8kK0o3lw75Ux0HaxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ED9t3nw6v+w6o7CM1GqexHFZcIPQCv8nyMv7SnQV+3/oD1Z5
	HU6ZmbS9FeJ0OJwaJAYOLdILd/KzzRQN2iH1p70pqcAS8bLb3cLAed+cC14ybLYaTX/UaIRB1wO
	z2kKUYTfGeimO5ZdMBWUPVJHLa4rynmlYsMNeCXA4HJFpCOF4XfhcUA5iLpoikA==
X-Gm-Gg: ASbGnctl87FfZGm2jHiJIdV+2dKxzz8+uxCRG5CqlqUYAb1DQTUxNzHKo3FV+8VW8sC
	Z1hhNatEtpOfDlXi48dh1oUFo6b/uZFtcP0huZMOmGLjvCvBQW7vpwdn00pDOzC8pe7BhBbb+DY
	jI6baDPyCH2OR54HRKOloXciCnXgXxsuDdn6eV3YFq5VtJ9DazqRLOmp3Jqp+qwEyaibeRDIfQR
	RWSAfhcqy7xuZLbf+7XNJErNdNc/EiDMkIPTE78cfBDGBbsAPYYti58jG2/62LBIkmdlYUHQB7N
	cLA+VZH559vSG8WwTBi9R1XtVat4pVGIZUOWD7T60ZCY5/mzxFkTD9YyoI7zRjsyf8fg6/nE/PA
	PZuPNupi4KP28ZEQjAfhTmUmce6zCl3j2
X-Received: by 2002:a17:902:f690:b0:298:321b:2694 with SMTP id d9443c01a7336-298321b2b47mr16561115ad.19.1762780813074;
        Mon, 10 Nov 2025 05:20:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTU/9CTN1kUz0aU6N4B5Am7ZyLyMmtt5oyD6FCGHb0vg/r8pz70jik7u/krNQAcxQRtx7PiQ==
X-Received: by 2002:a17:902:f690:b0:298:321b:2694 with SMTP id d9443c01a7336-298321b2b47mr16560465ad.19.1762780812519;
        Mon, 10 Nov 2025 05:20:12 -0800 (PST)
Received: from [10.219.57.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5c72esm145613585ad.33.2025.11.10.05.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:20:12 -0800 (PST)
Message-ID: <c3dc392c-eff3-199b-c047-7fabe155ae98@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 18:50:02 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v17 01/12] power: reset: reboot-mode: Remove devres based
 allocations
Content-Language: en-US
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
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
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-1-46e085bca4cc@oss.qualcomm.com>
 <20251110130159.pzfmh7mr3p7xz5o7@hu-mojha-hyd.qualcomm.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <20251110130159.pzfmh7mr3p7xz5o7@hu-mojha-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6D6SyBBRqw0Jhw2_5j8E5ZRwwFWled8B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExNiBTYWx0ZWRfX18paTlUsG2vV
 zXH/tP3EDsWmnea/oSwcrm7nTDA6jghKfyjNgqKaRd+mQGIqotMhkAT5IjZcWvh+q1U7GlogWvA
 HmKPCRf4Qe1ewjK2V2LkfZvbAvlfRgSqe2+VJc3UQLE3m53xvKKcdDY/5SzRco+GsDd0X9QOxT+
 LtwqlCaMtl0Ky4cuA7ANH/iLKNWor8GhUwapAffpTEEtBZFclQXXeF3XUN3KtKzf1QCXfj3Ll/p
 ye5+wj4yh3FKalGV2z3owRt/autmzXW5moMzi1v0qby6iAe4SYtOL7d+fgCfX3z7lSrIOLxj6ll
 wM1YBD/oBw1zo2qaQQH156E96Lh79ZCNgKf9py/rJX93KwTCe1MOT0yGADIcLqzdnwPCmc4mdSq
 z8QuG8ol738GdC8O2JhwOzwoBHZXFA==
X-Proofpoint-ORIG-GUID: 6D6SyBBRqw0Jhw2_5j8E5ZRwwFWled8B
X-Authority-Analysis: v=2.4 cv=QLxlhwLL c=1 sm=1 tr=0 ts=6911e68e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=otca4u8OHQj9NKxAAEcA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100116



On 11/10/2025 6:31 PM, Mukesh Ojha wrote:
> On Sun, Nov 09, 2025 at 08:07:14PM +0530, Shivendra Pratap wrote:
>> Devres APIs are intended for use in drivers, and they should be
>> avoided in shared subsystem code which is being used by multiple
>> drivers. Avoid using devres based allocations in the reboot-mode
>> subsystem and manually free the resources.
>>
>> Replace devm_kzalloc with kzalloc and handle memory cleanup
>> explicitly.
>>
>> Fixes: 4fcd504edbf7 ("power: reset: add reboot mode driver")
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  drivers/power/reset/reboot-mode.c | 30 ++++++++++++++++++++----------
>>  1 file changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
>> index fba53f638da04655e756b5f8b7d2d666d1379535..ac4223794083f36960b2bd37a601b7e1f1872de5 100644
>> --- a/drivers/power/reset/reboot-mode.c
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -3,6 +3,8 @@
>>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>>   */
>>  
>> +#define pr_fmt(fmt)	"reboot-mode: " fmt
>> +
>>  #include <linux/device.h>
>>  #include <linux/init.h>
>>  #include <linux/kernel.h>
>> @@ -71,6 +73,7 @@ static int reboot_mode_notify(struct notifier_block *this,
>>  int reboot_mode_register(struct reboot_mode_driver *reboot)
>>  {
>>  	struct mode_info *info;
>> +	struct mode_info *next;
>>  	struct property *prop;
>>  	struct device_node *np = reboot->dev->of_node;
>>  	size_t len = strlen(PREFIX);
>> @@ -82,29 +85,27 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
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
> 
> This as well could be avoided if we move the above memory allocation
> after of_property_read_u32()

ok. Will re-order the code to avoid the kfree(info) here.

> 
>>  			continue;
>>  		}
>>  
>>  		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
>>  		if (!info->mode) {
>>  			ret =  -ENOMEM;
>> -			goto error;
>> +			goto err_info;
>>  		} else if (info->mode[0] == '\0') {
>>  			kfree_const(info->mode);
>>  			ret = -EINVAL;
>> -			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
>> -				prop->name);
>> -			goto error;
>> +			pr_err("invalid mode name(%s): too short!\n", prop->name);
>> +			goto err_info;
>>  		}
>>  
>>  		list_add_tail(&info->list, &reboot->head);
>> @@ -115,9 +116,14 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>>  
>>  	return 0;
>>  
>> +err_info:
> 
> free_info ?

Ack.

thanks,
Shivendra

