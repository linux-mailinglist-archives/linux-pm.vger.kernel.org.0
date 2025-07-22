Return-Path: <linux-pm+bounces-31288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D04B0E17D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 18:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871E83BBFE9
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DB42798FD;
	Tue, 22 Jul 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFqYFtca"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F604685
	for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201053; cv=none; b=u0TZ+Q8U8EPU8HMRtG811gbh6mg0dzMPnD7/dUT2zkx67dloaIjlgVlpJpN1JEgH4vbzRx29HTTokU+ShUZCOiEfFln4sip1/ItF46G/CO2Numm64nnv32gT0Y/sfsDyPiY6wafEExkoFV7YKqWs0NpRy/hKbvqoERZtADcd5ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201053; c=relaxed/simple;
	bh=w4dpdLGtoBj80ExZtaOkPcAQU61LkwxmuI3CYMvS53c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T/sxXUH+irZPU3qSfZeF/vwV+ZQt2VlO9jR08ch06+UsmOZ5GHf1ia9U7ZGMPv8/EppYsNZK1wXg/+OgYZaYUj+/AaO4qR1euERcZNMUVLOWzFC9xgVfn2XBsIReRbNkmez1j7tK/BwRv/tfcwFmGGFA83/37F8WzWyGB4Onv6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IFqYFtca; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MF3Nd7020153
	for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 16:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9nCrpRv1Mz+G5QXSFlJHgBDudrIiUMOp8bzN0yyhpp4=; b=IFqYFtcaX36DN33z
	f3HQlKpeuDNBFnpQMHdxfv6Y7ay3qM99z2oZ9kwZOvd3r6kd3umiMUjGG5nYXiJ6
	x7bpCfI6TXNNDis7RbkPo9vSsgZcikqTK8VWuWttIXDNorCWGO7xPj5s98tj2yCf
	7uo3pSTDbmLEHM8a+OI0B7HgDWHaubFS1efZGCZohoJXQuNobWBy7L+d4CO4sGUb
	ou1nAFt5Z1qqm0RXzj9lcGtmNIj91oupeYr9Rj2znT8zsetyjurawRl/YKGWEFnD
	eHYNX+3X8ZCzFJ9AOXVliTRdoO33tr+713q9EMz6AA30nnnrz7EJW727Lo0/w8Pq
	cQrEFg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na0hjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 16:17:31 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso8537894b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 09:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753201050; x=1753805850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nCrpRv1Mz+G5QXSFlJHgBDudrIiUMOp8bzN0yyhpp4=;
        b=Xc+httip+5EWP8r/B8esw2cQ2qkKUCxpJIfSbbHmiqCdZ3iZSyRJtqtXg4HfMSlziP
         KZvLh20S8qEaAZUkvlTKcpmNz1UUCOFJy2tVRzIO/cfjwJRipg22aG3V75bLN4Bk28Ye
         P/l1bfF83CdlKox5690RTl0qHl94RLwv02d8BNY9CV3CgFE21Yz1V9oP9nezgdGKfz6H
         1m2mvvcflYoZI8mVhPTm/hLJSeaCGSbvDgaDAaSZPu58dh9M/+j54+jEc4Tk44wVy5C3
         PItS88R+C/D8qQ94Ma86C+lzkSiCjipgtWxGfFXknhxrMhfE2kKw3cXMu0eUoY1PKb7e
         70oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxGsyEiukM8xtg0v0CVklNbFO3wGLd4beMMdqsC6CaE6vMqx+WKercIGn4KMKpCBv7TVOMuHlYow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWT3c1RM95X3Z9IA3HkCMLvBe5qdmuCYZtVa0s2pSpRubvTIS7
	8q3jrbgtiju8H5STTGsupHnpUY/IGlMVrdq2+u4bR1lw8snfkCUc/db8RzxRbBMVGoXjBXjZ6VN
	3rmCPDQLuZpQDRkXV4mUz4C5Da5TRpIwDsuEW6hEEwk2II4fPrWMh8tOO8SbGQg==
X-Gm-Gg: ASbGncu01nYnNKrSnHf5sULbLsDxM9EKVXOn7RX2DeaPYsMHvZUxGn5h9/jLPZ9yoTt
	E5v5Z7xsiszTgzikxWSlmVckQTXRxy8Nr3g79PFR1hkp9MaGVUc6FHiAFOjR8iYnGsd4zh7gqlh
	J2OSTvjCy3B+Jef+mOoIS7I/PAuZsTd47qRreRvs6Wnjf/XbPCui+qHqNbAdnY9FCLFIw0krlQ+
	Wx8aKLZ4zIgHQiuQgoKQ6vBJQpLbhMyVX6cRDsZiemiRuRTxWqJiTBn2hVEJalnNghUuPkUJupC
	p/IOBaKPrKo+4Wsf0Dwq3maWNQEjizJdRa5kgV/YM/6o6Dyg+Vs5HtGpB/zDGGCC2icZRPvIKMB
	JVeSLK+0=
X-Received: by 2002:a05:6a00:3d07:b0:756:d026:10a7 with SMTP id d2e1a72fcca58-75725a89319mr35996879b3a.21.1753201050108;
        Tue, 22 Jul 2025 09:17:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm++ZLMXmAYAQkNZgMSqeo/I7WJon6D9QhDXy0vQr/omCJkB9Jb05Hhf+LFMrk9yKOHj21Ug==
X-Received: by 2002:a05:6a00:3d07:b0:756:d026:10a7 with SMTP id d2e1a72fcca58-75725a89319mr35996814b3a.21.1753201049597;
        Tue, 22 Jul 2025 09:17:29 -0700 (PDT)
Received: from [10.211.220.100] ([152.57.179.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d5d8sm7849327b3a.112.2025.07.22.09.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 09:17:29 -0700 (PDT)
Message-ID: <13b6be8a-9cd6-e49d-2311-142f79c27328@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 21:47:08 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v12 1/8] power: reset: reboot-mode: Add device tree
 node-based registration
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
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
 <20250721-arm-psci-system_reset2-vendor-reboots-v12-1-87bac3ec422e@oss.qualcomm.com>
 <33gq4iyx5jxrr6f5w3ctgy7l7om53jdvb4tmfmxzourhfvpc3t@cr5re2dab4tc>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <33gq4iyx5jxrr6f5w3ctgy7l7om53jdvb4tmfmxzourhfvpc3t@cr5re2dab4tc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: z7KhzTeuqJ55uUAqE-gxYdBaMeBe7JHD
X-Proofpoint-ORIG-GUID: z7KhzTeuqJ55uUAqE-gxYdBaMeBe7JHD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEzNiBTYWx0ZWRfX3dmj+eGE5J47
 tV88rV9qLwfOlZDX9ankGPM1iHm8N7j4ABh1PJDyXh9RN1UwuuAgaZeix5Y1TMzisEPxR9n6q1H
 cTUTwDEdBbB8Y3krgSXkCYsW0grtgE3fGZdp24cWKAyr20ncrX2+AcDBOiiwuMrdnAENiqeHsCp
 5BupI/maieS27pmjhIIArEXZigz+f5+4WmH6mYBCrtNIRj91Z8aZ8swXCrhP90b/RMN4XF1HxD/
 bdmkWqJiRoEhdzP1AuUbdikIoQiZ6F1lz25JoVplTBF5A0k9zNEB7h8vW3x8RUUTuvTZB+ca+GG
 ESfSrnR/2d/HfXU+cGZ5RMYquIeCu5Ra9vQ1JmDYqiAl1NQA/jmL/uuYVBdwtcWAt+KHxZMS1f6
 JvNy5lBRa6hFDj7RLVl6zzrPHOtlHGY2clHTm8gi+4wm/YBwZP2L/H/2j6xuCTFZOH1K49rr
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=687fb99b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=p0YknvR/5ooNN0yes+ndXg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=33cFMSo4UqZHzB7ybJ8A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220136



On 7/22/2025 3:06 AM, Dmitry Baryshkov wrote:
> On Mon, Jul 21, 2025 at 11:58:48PM +0530, Shivendra Pratap wrote:
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
>>  drivers/power/reset/reboot-mode.c | 45 +++++++++++++++++++++++++++++----------
>>  include/linux/reboot-mode.h       |  6 +++++-
>>  2 files changed, 39 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
>> index fba53f638da04655e756b5f8b7d2d666d1379535..5dd3f06ca88cb28606d9fd2100ce03383c14d215 100644
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
>> @@ -55,7 +59,9 @@ static int reboot_mode_notify(struct notifier_block *this,
>>  	unsigned int magic;
>>  
>>  	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
>> +	mutex_lock(&reboot->rb_lock);
> 
> This one should go into the get_reboot_mode_magic() function, otherwise
> it's not obvious why do you need it here.
sure. will update.
> 
> Also, please split mutex addition to a separate patch.
Ack.
> 
>>  	magic = get_reboot_mode_magic(reboot, cmd);
>> +	mutex_unlock(&reboot->rb_lock);
>>  	if (magic)
>>  		reboot->write(reboot, magic);
>>  
> 

