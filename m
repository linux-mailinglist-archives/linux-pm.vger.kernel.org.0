Return-Path: <linux-pm+bounces-36297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53540BE4D16
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 19:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17DCB4F0A83
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 17:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5943D21CA13;
	Thu, 16 Oct 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gohw4ps1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9F21A453
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635187; cv=none; b=G6przrJ0YDrL58OBMntreEJqXVp4oL7ZhtRNlpzP8ZvEKiuVhRc6umHu0kAlLnBcr1/gVGWwcgSvjfQygcFPsqsmh+M+NqFiQNFONEZJWOud+60IIxrFtI07v7/n9BIPXtG4zXlpRxqMtIYZQCAMYQcuuu0fvWctocSa3HovxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635187; c=relaxed/simple;
	bh=iCjjuLaISQPhiPCfSVOWiLqhl9nvQ9Mx8UGWwvNy8QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EISjAI07VnvM+GThCRXNcKecIYFeeFL1OQsIJaALeuiS8qPGASD7buaSqTdmkL23u28NGmeq3/D3RfpLVbvkr/avbE+0ADoPAuxRf0wH2ESH5Gy+mhnLiNAJiHJVZP5qx+3+3VBNaS3mOYsdS716LI1Xj+Ijdlaf4wA5ZLEhNc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gohw4ps1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GG2HfG016274
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 17:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ax94yOZGpPbJi/xkHkGG7O7SwfDjw1ym9nOUmMgbPc8=; b=gohw4ps1ahNQxtjY
	g6HwKuJdWImMQBH6Aa7c0ZA/c+8LQdaiGrfY9ChqFh/Ei+np3e02R7TOn/kqd0a6
	8FOsqmqtGAqrFyXEFn+JBz3bTgFQFceGi2CbXY6/Z490iaVL7L4RRiKyj3NBCSGU
	0OhgQnxhh4OBjFxPAINLgzVuaQ3rtOqTgomhenXRH4SlZSd4A3DKe5WOMisk0AoF
	uLHer1wLpjUwfMahIOTLgk6cUB5gCbfyYeNj1EDyOQ38cYZp8mPX2uGssJWx1K3w
	Xlstm/3v2XABbh1YLdullQ3cL4ptI92ZxF/IZlId/CXQKp6cRg+GY9tOqmheutIK
	gXJiqA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkh4nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 17:19:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so1665250a91.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 10:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635183; x=1761239983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ax94yOZGpPbJi/xkHkGG7O7SwfDjw1ym9nOUmMgbPc8=;
        b=irod3yJORWeMMWi3WzUXglGynRT8GEMxBietxyr8ma7Mz/C2H00GPxFW8jF/4gHUh0
         hYvLtHOB6mNCrgzQ06HXanVycM3vp0frrx1EqJKEffGjbu0CBNm1L9kCAKyKLYQ++PTs
         7PabtOxomzvDUCuWWlH5fuD8VvAYtekA5RkT6g5tL0w11uUjG3A0W88MA13tJtpglIpt
         hzXPuRjuKIQffR+6uLxDd8RwVSOewrF+0To30qz4/6NEHXpQf8ePBUvjNQ7vXS5OjheX
         VDEWlBrXLnj8sym2yULPSqixfVUsZyhly7cDZx+6I0Kk2HsVUwKAEX/jPyCKayHilEKi
         KY9w==
X-Forwarded-Encrypted: i=1; AJvYcCWopFXfHdFI0wJXFbdprww+AhE/niW84STX0oCNAXT4PF/x9NWxtw4FcORGsegAMpOm7g9nmOsCvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc67AdEpySuOUiJ+EoHk4+Uoo6czI+GLxagRbVkPBp5FDybOFe
	k21oRViD1/fpicoTYJ3fb3xUjvN+8NlcH6xI0q9teiv0lpI6cMUmem/hqW+dQ6zssTrxgvg6P1h
	DRRuzRed0WGz3R3YCaf+xV5UKuhEvmNKNlST6dyLVRVZcHtmcczFmRu9KMROvAA==
X-Gm-Gg: ASbGncuU5c5hyAfFNAeVAACqotlTz1fJvF0Lkj2tDjhQ1u1qUbbHxxhCKHIHPSWQ0bN
	Wh97ElgLlbXw4j6oLofFWgQDe9CPDDYxN5mLBBT7hs/duu8E6mrEZOLHG+SQo14Vbq2v0XN6XIj
	7tbLBDO9XkSRZvQI7s+T02nzVb5VNFF06jJ4qi00V67fvvYzVK5iC64fKeH4J0epZryEt/n1tgm
	izMWe90EtrxD5bC1BCIaMcLvv0skF66KHBu/4l5LhlcwbbC6o7R88eiTD6fVBGu7qk/Hc66hkjE
	q/+MxqZ2v+/ji+HdYcHRh2cfBy1ZUvQMUU8tUSHL7aaWm9Xxf2CA4LabTn8sVDsP1uVjwgqNa6x
	rfRDoCZB9l02dz98zMinx22mVUIT7XIwz
X-Received: by 2002:a17:90b:3f8d:b0:33b:be31:8193 with SMTP id 98e67ed59e1d1-33bcf85d59dmr763819a91.6.1760635182591;
        Thu, 16 Oct 2025 10:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1rRrAo2QPBaKZifUQLJIoZpvDEaFp+zcbkMAZ+fOe6tW2DlqTpsxyKkKUiFkWY1Ph4rjsWQ==
X-Received: by 2002:a17:90b:3f8d:b0:33b:be31:8193 with SMTP id 98e67ed59e1d1-33bcf85d59dmr763793a91.6.1760635182106;
        Thu, 16 Oct 2025 10:19:42 -0700 (PDT)
Received: from [10.216.0.133] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb65222b1sm2611494a91.6.2025.10.16.10.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 10:19:41 -0700 (PDT)
Message-ID: <fa42adf0-8f15-ad4c-3788-578b1bee1c72@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 22:49:26 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v16 02/14] power: reset: reboot-mode: Add device tree
 node-based registration
Content-Language: en-US
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-2-b98aedaa23ee@oss.qualcomm.com>
 <CACMJSesvTLe28Jz83b=zfHD2rvmf7-i_2+2DoV=dgooVqFEYbA@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CACMJSesvTLe28Jz83b=zfHD2rvmf7-i_2+2DoV=dgooVqFEYbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jJ22KcMjQaV4OSLKQpcrWnUebdRt-li-
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f12930 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=8ps4eDoI1eVci98EcxQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: jJ22KcMjQaV4OSLKQpcrWnUebdRt-li-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX5p10Qrx8G0O3
 B/yqdE9FY6/sbL7OGTFmesxwhG+upqpmexJ9b9bvVMbc95TFevlS4XkCKGrgwzK5abmYC9f0HX7
 zsOT3MRsYvIQ1YsSAXYxJolI67R7cUrneNyBTv2cC784u4J7Ye/s8sj9OEuCacKls++0e21xWPB
 00tswYHPNtj5iLmwrCxlU+4ebzgr5akA6g+fhtG8HqtqnM6t4Q66wm7AznJBnPtbzeQkuPMrvsu
 g9rDKIxHGBtZK+A+J61ccW+GyBIZv9CRatwrK3Q5s3HmKRKL3JN/lOJBpApx2W8gcnEgPG0+F9F
 NQJA9jfmjDgxc/iW4WVk2Qp1bUEoc06FBo1LNeEuyh5OGjrgmgtFIIukhMd6W/TIuhDn99OxX1J
 nOeggfHI0Mwn3OQzDr5SrTxyfbyEZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 10/15/2025 8:10 PM, Bartosz Golaszewski wrote:
> On Wed, 15 Oct 2025 at 06:38, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>> The reboot-mode driver does not have a strict requirement for
>> device-based registration. It primarily uses the device's of_node
>> to read mode-<cmd> properties and the device pointer for logging.
>>
>> Remove the dependency on struct device and introduce support for
>> firmware node (fwnode) based registration. This enables drivers
>> that are not associated with a struct device to leverage the
>> reboot-mode framework.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  drivers/power/reset/reboot-mode.c | 45 +++++++++++++++++++++++++++++----------
>>  include/linux/reboot-mode.h       |  3 ++-
>>  2 files changed, 36 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
>> index 8fc3e14638ea757c8dc3808c240ff569cbd74786..c8f71e6f661ae14eb72bdcb1f412cd05faee3dd9 100644
>> --- a/drivers/power/reset/reboot-mode.c
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -3,13 +3,17 @@
>>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>>   */
>>
>> +#define pr_fmt(fmt)    "reboot-mode: " fmt
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
>> @@ -69,17 +73,26 @@ static int reboot_mode_notify(struct notifier_block *this,
>>  /**
>>   * reboot_mode_register - register a reboot mode driver
>>   * @reboot: reboot mode driver
>> + * @fwnode: Firmware node with reboot-mode configuration
>>   *
>>   * Returns: 0 on success or a negative error code on failure.
>>   */
>> -int reboot_mode_register(struct reboot_mode_driver *reboot)
>> +int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle *fwnode)
>>  {
>>         struct mode_info *info;
>> +       struct mode_info *next;
>> +       struct device_node *np;
>>         struct property *prop;
>> -       struct device_node *np = reboot->dev->of_node;
>>         size_t len = strlen(PREFIX);
>>         int ret;
>>
>> +       if (!fwnode)
>> +               return -EINVAL;
>> +
>> +       np = to_of_node(fwnode);
>> +       if (!np)
>> +               return -EINVAL;
>> +
>>         INIT_LIST_HEAD(&reboot->head);
>>
>>         mutex_init(&reboot->rb_lock);
>> @@ -89,28 +102,28 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>>                         if (strncmp(prop->name, PREFIX, len))
>>                                 continue;
>>
>> -                       info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
> 
> This change is good - devres should not be used in subsystem library
> code, only in drivers - but it doesn't seem to belong here, can you
> please separate it out and make it backportable?

sure. Just to confirm we should separate out the devm_kzalloc part of the
change and add a fixes tag.
 
> 
>> +                       info = kzalloc(sizeof(*info), GFP_KERNEL);
>>                         if (!info) {
>>                                 ret = -ENOMEM;
>>                                 goto error;
>>                         }
>>
>>                         if (of_property_read_u32(np, prop->name, &info->magic)) {
>> -                               dev_err(reboot->dev, "reboot mode %s without magic number\n",
>> -                                       info->mode);
>> -                               devm_kfree(reboot->dev, info);
>> +                               pr_err("reboot mode %s without magic number\n", info->mode);
>> +                               kfree(info);
>>                                 continue;
>>                         }
>>
>>                         info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
>>                         if (!info->mode) {
>>                                 ret =  -ENOMEM;
>> +                               kfree(info);
>>                                 goto error;
>>                         } else if (info->mode[0] == '\0') {
>>                                 kfree_const(info->mode);
>> +                               kfree(info);
>>                                 ret = -EINVAL;
>> -                               dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
>> -                                       prop->name);
>> +                               pr_err("invalid mode name(%s): too short!\n", prop->name);
>>                                 goto error;
>>                         }
>>
>> @@ -123,8 +136,11 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>>                 return 0;
>>
>>  error:
>> -               list_for_each_entry(info, &reboot->head, list)
>> +               list_for_each_entry_safe(info, next, &reboot->head, list) {
>> +                       list_del(&info->list);
> 
> Same here, not deleting the entries currently seems like a bug? Do we
> depend on the driver detach to clean up the resources on failure?

sure, so this should also go as fixes? and should we remove the other
dev_err(printk) also as fixes? or that can still got with the change
where we add fwnode based registration?

thanks for review!

-
Shivendra

