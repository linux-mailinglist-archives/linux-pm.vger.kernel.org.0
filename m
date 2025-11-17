Return-Path: <linux-pm+bounces-38137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF6C65A2E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 18:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89581363D86
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 17:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366AA3009E8;
	Mon, 17 Nov 2025 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Prlmxie4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CyTnJpGj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A6830F551
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401950; cv=none; b=MuUjxXo9yyKUf6EWDKEebx012P6v7OntC1OoLA4kUFZ5+sLTKhWaMWBuARzKhjWpoeQxwvK/qgw0N/LEXiaPhfTGtqOFeKXP2b0U3ew9/tsqlqP50VLFvzO13gan6+1ue1r/c5z92NIL0q/wX/TepRfpCpvhTgiMvGeLmYevDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401950; c=relaxed/simple;
	bh=j7juR+/XVeJU4C/31V9mX0gDA1eA9e1XUKn5lGCO8HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRrrA5B9BFtUSqJ4w+Ak5fYMNlIqVOZF7Ts8xJ2fIIH5t0uWIRe0S7zNVwD2ytwMsa2AZq7KRm57trjwDpIXW2v0eLiprHDXQWGQY+RQEjSP2W0epx3op8jxK8qna9PlLgpthMtEVgMzLrlfHuKV1ACazi9nmH2GEGwe9kEpUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Prlmxie4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CyTnJpGj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHAqEYW3921595
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 17:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	guTkQqA6wZDgu5rNo71qMOAbhvUpSh0i6lCnidrmG+s=; b=Prlmxie4+yYERLxx
	/+OuVVUO+N0fu5c7kFk6VzvvwoABHSUoe09BdigZwZzTmLL9jesvidMNmmvvoT6S
	j41q0uwKhIcSe0EnTzMxMxcWSyIQ9k+ucbUqpM0MmO1hWGnp+22tKCcvWHMU4jB3
	mvYiTwgpATeDCt1GsGix+PC8KB+wZFyDeY2Z5/jMzUteyzLLmdHpYAOdKM2je9rc
	XiU6iM0Mf17SQP7R/J83OrMgDZgnSjQkACvWKAItw5DAPkPcyI8sVxytnb6H2RS1
	sxmHgG2Q/Bywvg2u9QuVj0cmux2kmjvtd34wPcVu+W1u9QmyVahQd3FK9i23Jc9n
	GAqgnw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2ay981d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 17:52:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297fbfb4e53so81935315ad.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 09:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763401946; x=1764006746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=guTkQqA6wZDgu5rNo71qMOAbhvUpSh0i6lCnidrmG+s=;
        b=CyTnJpGjwDCCo8kvCFmE4Xoo3z8J7l1iftu203GUcGwVZwSGGPQW9IMBoP6a6ciyXE
         4HKoLLjSZYPzSAcQBPDFVOuWzF5pDiXhangbKeaKNTX7tsraCQtzFIvsrP8MvSAs7opC
         5+gEFvtzxk8B2/zY1fZd9oTGh08zAS29LtiygwGME5qFrV6mRyKQr3nmHBI9jSkfrwLW
         a+XfSntpe/LJ2eBok2pI03+LUssSWsCNmXbJ3ac+3OzKz3srjM0Od/qP2iO9usKbGWcV
         l/XoI4Sr45F5bGo74NfehcADVk8aY8xM00dQAeG+QOuADj9QBryiYowdLfdAthBnQx/b
         b1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763401946; x=1764006746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guTkQqA6wZDgu5rNo71qMOAbhvUpSh0i6lCnidrmG+s=;
        b=TsWm0/LZLljdmbjL/TvXx+THPiHOQnOmKv6mzLa8OLrVbbAlaoQw6ZQtr40PiXmMky
         gTj2eMIlLMc2vX4f0SLoLOM+5oSsCG5UjUhcUNFn4ymrJRYZx7ImMQmSx7dro3IUExY/
         7PP7ltjHFM0xDq0PZ4wF28eAfWpBpFhM05IJeMw/nMFPxRpZdcHcsjmm2StehitfyhwS
         rXJ751U3YhVe0u09sP+j2CK26L6PATy9qxPD36tC0scZemkbaYhMRjUVA8uf/EYGQdAI
         o+HQnIVYg0xJyuw852u89qoHRDYJvROtGhPCcpG6yj3bqGxgMoI3FZBw3/WuzCs10/FL
         fKUg==
X-Forwarded-Encrypted: i=1; AJvYcCU3WtlVv5QByK7agk6Jk3Q1ce5S2k23iaFCXGKPV1GMQs5yi6JQkp5skoc/5l9wRyvodc7D2cw/ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPGYEoujP45hCf2Koxqv6YhxwktTq8fvIl3LNBAi0vhqC/v7Ew
	WFa6VzZTw1LMvMxNGNqBqIx+l4+E7D/bRO9d7RsbTnfZQ01r+3paQ3e7GwWesb3suu4/ffTyWVn
	STfTkDYoIU6CJmjABfofE5/bQ0eOQNJs+nCqbJR7W9feNRBt7OBigUD2xL6QPbg==
X-Gm-Gg: ASbGncu7Rc8k/UnY807ECgjSa0dt4RfUupuQNi5XXSHklnznIYb85bD4GGFrkfWR58m
	W2xy9IS98ngwZ5w+egoMfrknJiP3ZSraQwfTt3LvsvK8JcCY10l79cjpC0BE6mj1smYoO/lllMv
	1mJKetM1ChFYS/L+S17J1o4hZ7aSEPVKrjreMMIe5JpArGlUyq0vZnUdJE2HBL/1i0FPniyAujT
	5GiAkYAhkyPXjl3apjj93XXD9SN8f6AfDAiaTl/lznrjiHALokydQR0eTgKFz9CZxXMCxixlF44
	7an3QpfBZrIVB6Nu/WhRZT3U+56oDPjwDZCJGzxbHduBzgCgWJIXPemaoClPWNHW+L1jiuYRW1o
	uh8xYrh2PVJcbgBq/+I6qxVHVyiVdUwErlQ==
X-Received: by 2002:a17:903:3c2b:b0:295:6d30:e25f with SMTP id d9443c01a7336-2986a75e7b9mr143345945ad.53.1763401945680;
        Mon, 17 Nov 2025 09:52:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWRzwGhq1DQhSIpL329PcW06uskMvINMd52o+8rAflr633fNQFaKCidj9r5mpG4u42nnL/WA==
X-Received: by 2002:a17:903:3c2b:b0:295:6d30:e25f with SMTP id d9443c01a7336-2986a75e7b9mr143345685ad.53.1763401945207;
        Mon, 17 Nov 2025 09:52:25 -0800 (PST)
Received: from [10.216.14.226] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d91sm147692395ad.63.2025.11.17.09.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 09:52:24 -0800 (PST)
Message-ID: <1c2963ff-fa1a-7e28-62bc-51bd2f6f3f5a@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 23:22:21 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Content-Language: en-US
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
 <20251116-next-15nov_expose_sysfs-v1-2-3b7880e5b40e@oss.qualcomm.com>
 <CACMJSeu6BGS+AyEXyR9S7d6qGkbP3GiEzq6qy1860QaOQ-peQA@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CACMJSeu6BGS+AyEXyR9S7d6qGkbP3GiEzq6qy1860QaOQ-peQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dL2rWeZb c=1 sm=1 tr=0 ts=691b60da cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=l74xf_ZpDOHI644j0-EA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: LvciphN8ysayccVto_Wf6iksnlj_71eT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDE1MiBTYWx0ZWRfX9o+AsR9tZmyo
 ZazOil2kIqRJHrVyI5dziMc03cnnZ4XZKyGfMCl3ofGtTN4ggxKApbSFFcCU2iFcvzbvz0X0PTQ
 7tBPjojB1CnfpWPMObvexWihoXPg6HJ8lMcs4DA79LfzdprZdrI/NVSnrfSfwFmngsJAOkpLL3V
 6BlHq3ewo2k6enjbLSuE4Tb4hLTdw4v221CLdIaY5/3syjTAPt9Q5KjZk1YC2sLfr8PxsWQQKYD
 E37qnMcNzDPjhPEcBwchsx+T+yOedZWX40frmiYaA92DjsY/tLrYSrASZZt2m61AFJ6aTANr4eQ
 Yz2aNZWI7mHTpHy0bksVpV207zuUje38iwYy1izgUdXM9Ms0LGOJcnRHkgzBSK92/RloDn9rN3e
 Hwi0uNdGX0xfKXHvob+fpdf74O5Wmw==
X-Proofpoint-ORIG-GUID: LvciphN8ysayccVto_Wf6iksnlj_71eT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170152



On 11/17/2025 6:55 PM, Bartosz Golaszewski wrote:
> On Sun, 16 Nov 2025 at 16:20, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>> Currently, there is no standardized mechanism for userspace to discover
>> which reboot-modes are supported on a given platform. This limitation
>> forces tools and scripts to rely on hardcoded assumptions about the
>> supported reboot-modes.
>>
>> Create a class 'reboot-mode' and a device under it to expose a sysfs
>> interface to show the available reboot mode arguments to userspace. Use
>> the driver_name field of the struct reboot_mode_driver to create the
>> device.  For device-based drivers, configure the device driver name as
>> driver_name.
>>
>> This results in the creation of:
>>   /sys/class/reboot-mode/<driver>/reboot_modes
>>
>> This read-only sysfs file will exposes the list of supported reboot
>> modes arguments provided by the driver, enabling userspace to query the
>> list of arguments.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  drivers/power/reset/reboot-mode.c | 72 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/reboot-mode.h       |  3 ++
>>  2 files changed, 75 insertions(+)
>>
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
>> index fba53f638da04655e756b5f8b7d2d666d1379535..062df67735c4818cfeb894941e537f19ea9d4ccb 100644
>> --- a/drivers/power/reset/reboot-mode.c
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -7,18 +7,77 @@
>>  #include <linux/init.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>> +#include <linux/mutex.h>
>>  #include <linux/of.h>
>>  #include <linux/reboot.h>
>>  #include <linux/reboot-mode.h>
>>
>>  #define PREFIX "mode-"
>>
>> +static DEFINE_MUTEX(reboot_mode_mutex);
>> +
>>  struct mode_info {
>>         const char *mode;
>>         u32 magic;
>>         struct list_head list;
>>  };
>>
>> +static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +       struct reboot_mode_driver *reboot;
>> +       struct mode_info *info;
>> +       ssize_t size = 0;
>> +
>> +       reboot = container_of(dev, struct reboot_mode_driver, reboot_mode_device);
>> +       if (!reboot)
>> +               return -ENODATA;
>> +
>> +       list_for_each_entry(info, &reboot->head, list)
>> +               size += sysfs_emit_at(buf, size, "%s ", info->mode);
>> +
>> +       if (!size)
>> +               return -ENODATA;
>> +
>> +       return size + sysfs_emit_at(buf, size - 1, "\n");
>> +}
>> +static DEVICE_ATTR_RO(reboot_modes);
>> +
>> +static struct attribute *reboot_mode_attrs[] = {
>> +       &dev_attr_reboot_modes.attr,
>> +       NULL,
>> +};
>> +ATTRIBUTE_GROUPS(reboot_mode);
>> +
>> +static const struct class reboot_mode_class = {
>> +       .name = "reboot-mode",
>> +       .dev_groups = reboot_mode_groups,
>> +};
>> +
>> +static void reboot_mode_device_release(struct device *dev)
>> +{
>> +    /* place holder to avoid warning on device_unregister. nothing to free */
>> +}
>> +
>> +static void reboot_mode_create_device(struct reboot_mode_driver *reboot)
>> +{
>> +       static bool is_class_registered;
>> +
>> +       reboot->reboot_mode_device_registered = false;
>> +
>> +       scoped_guard(mutex, &reboot_mode_mutex) {
>> +               if (!is_class_registered) {
>> +                       if (!class_register(&reboot_mode_class))
>> +                               is_class_registered = true;
>> +               }
>> +       }
> 
> This could be achieved with DO_ONCE() but you still haven't explained
> why this needs to be done here. Why not in the module's
> subsys_initcall()? As of now, the class will not appear in sysfs until
> the first device is registered which isn't a very common behavior.

sure will add a subsys_initcall() and add it there.

thanks,
Shivendra

