Return-Path: <linux-pm+bounces-31613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F2B160ED
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB9B16AB58
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 13:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4EC2528E1;
	Wed, 30 Jul 2025 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ac6+sWuV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A365B21CC4F
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880624; cv=none; b=kZKnRqDeKZj3GiSXZBheiYeyE3It21/FzWUHTTOeIJ2qMCjW4ynvxUv/S6tCjdIfSgUZ8fhz3hqRKvde/xNfUFAZNzGwLjkYkuTXabLQqgnnT3g3n5KBYWrl1SSpiktWz1cz5CqBHMmLkEY4gz5CMIVHiyUJtoaG7cHU50HVm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880624; c=relaxed/simple;
	bh=awtvDgQkWKkMnY9QW/zzrtx/X/yzYTfZgoiVPJ8h1eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4XQIC5rkEzqPL7BrO1lqLvF4yXq65Mx4uCNZVKGk5zKQIo29Hscm4tuZwl8Bc8sNrje3BdcOfZrip3SgyUY26K2VnlCBi3rnlOknWOCxOep9W+7ugnAtgy8Rq6cbwMvr1VsWYhRBaxkkgBqV/9mep8cGzJrsl2YFWAhK+U0/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ac6+sWuV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCb9hh009740
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 13:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VkI3WQWbywiMbx9yHKEjkAeAkd4dqWhZHzhHA1MpbUc=; b=ac6+sWuVIk66bbmw
	+1wNn2vLJNkhWxYNALy2HU7n8y3t3/O4RRpaz8tE5maqxeJ8RY0JVT8t4H9Lo6h1
	BUAx8UKlUvmJJpcUJGzdIO/03PrAgJKXDOdbG4jPVonCLE0BkRay1AmQoKXd+C4o
	hCxkY7cExrTlC5GnXPJRBtuisMq5IeUUWIFcRtrspDxnhahujp0DWyRXEIMFYOJW
	7rcFa27cDDheKyAN/2aMz1CGGiv1l3lxN0IP2NZPzDPar2RTyveoJjiy0zWZhOO4
	W0MgDtSC9l8HpWQ8lyetBHPQovYQXZsPanPEDjs2wRE1g9HYnmRasZK9rYtTNYrH
	kydUwQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860ep157g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 13:03:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-240012b74dfso31379745ad.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 06:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753880621; x=1754485421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkI3WQWbywiMbx9yHKEjkAeAkd4dqWhZHzhHA1MpbUc=;
        b=f/54t0OoArUbrEXQSRLICzZ1jJuB/6qp9VqqYhpiu4obDp0nV53Xws2hAjHjuPiAdE
         SM8/ltZjd2d3G0HPXklaiLeLR21Bs/BV0a5NUS/ndVeDn7ky8Z868XkGxNuPpSuPFHuV
         xELDK4ocx5f8/dqycIR5OeUzWtuYbuwEY9BE1hHR5Qu9umD/36g2+yEaBh889zJZ/rZe
         QV/OjSQiT0jtZAx2CS/yVgPmN62vvDuiYS+AwE3sZBRFZ/MWZuOOPfPHe5vwZ0mnHY4z
         fLsanQff/mEKTJ5ivXaGDpVy4HxfkHRe5cVJTw7eX3kq7sCsO69dAxTxqINUR5mOQnrt
         EWZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzH3L8EkoSxWL8WGdDQIhHqCFbNIrOG70MW9ott3EdhhaFL0FCFz5JvhWBInRbxiweq8bGq01aFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+p4231SOAYRWEcx4KTDWpGZuLL+ugu2Qv/XxaXFSBlc863zb
	IjucsN8XMPmVq5MehJvfr7u3L6kGG2ho8LVlD5/bSqP64ixP0dQOOZ2irgRtGIxzLBpFghI5PG6
	F0dQARAdZVB3J+xh0GDSU7CWMW3NYEKtuG2Obubv006humIADeER7b5QSgYn+gA==
X-Gm-Gg: ASbGncvvasDuC7IfvVAIO9NBZG/WxbLj0NXXX+020TyMHOe5CWidVHmtNZ1oSw0x9iP
	/Hy1SAig4zUrx2SNuS45JaLU8r353vXULQa0MBG7gQdZN5YPZ4TRyZ2kArBPjeQt5hDjXZgijBn
	/V1uC8gojb3YeZDj7klNe1SWA5oTdWNQP8oxoSfAG4hb91WbUTVN1ZZvic4DyeLUZOgIU93gYVc
	1pWkzsxtHpwQwZf3iY4sz1F+wsPz+nsWnsegdS1/Z2Yjxy7cBGIgDldE+/PMnYhe98HSONsnF3g
	Ue/Ewb6jlLs6aJvQqfexvdL40ZXhJAGCIyCUeBU69mbJ6noSwdAH9vzKCBsi9SWaBp73jfF4UA=
	=
X-Received: by 2002:a17:902:e5cb:b0:23f:df56:c74c with SMTP id d9443c01a7336-24096ade845mr42859825ad.14.1753880620357;
        Wed, 30 Jul 2025 06:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNUn1eUO9r0CsK9snk8Amv0Q5O2izLQsu4h9m62zFXz39lSAwZnmqj49t0viIaY9A0s5Gjxw==
X-Received: by 2002:a17:902:e5cb:b0:23f:df56:c74c with SMTP id d9443c01a7336-24096ade845mr42859175ad.14.1753880619783;
        Wed, 30 Jul 2025 06:03:39 -0700 (PDT)
Received: from [10.219.57.35] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2403ed55780sm62154095ad.166.2025.07.30.06.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 06:03:39 -0700 (PDT)
Message-ID: <b92c164f-c6df-a2c0-1416-67652a01b179@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 18:33:31 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v13 07/10] firmware: psci: Implement vendor-specific
 resets as reboot-mode
To: =?UTF-8?Q?Andr=c3=a9_Draszik?= <andre.draszik@linaro.org>,
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
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
 <20250727-arm-psci-system_reset2-vendor-reboots-v13-7-6b8d23315898@oss.qualcomm.com>
 <b45b157593f1865a402f4098cdeafc298a294c6d.camel@linaro.org>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <b45b157593f1865a402f4098cdeafc298a294c6d.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TZNeJ88pRr-iYMLa2-2FNTmQa9Ut48eB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5MiBTYWx0ZWRfXzx12uHW+RIoX
 KF11jghyl5oLZliieIEKXPP4FRRD76jFmBNVZh9UsVnyLguJg3Ze77cqX3EVJ6OMi70+zu/VSpo
 upUSdjapppaenwVaSVpzIMkpolJn18ybcT/XhFoWomRv3TD/2UOijeDIF5zZZ6D3nOuI5jpYVBO
 MKjpk6bcvI8G0exf0WUwZmfhAcId1TBJ217NEd+Eeu0NqD/2jJkY7DYpIWvWZQ6EtJ2+xNm2Fex
 Bsz6uKPS+WVv1yzyBXx1EudnBa+M5wj0Kq9ilObMVZSXIrmtYI/tTFYxhbR/+V5SRZHt5C6ctJD
 V4+LUV6gKcHxoIfuEoKkXHYBffLt5T3AxEpKIuvUh71qASbimwmVNqKOlaCH55wMKI0rPaq2rg5
 AvQJonHARL8jIaVPADC1YkSJSIaxmpa9pTskk2I8eMRJR1dp3krt851fNFOPs76arz+B6pO8
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=688a182d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=dOR7WsgJQ9bLIEUHlCUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: TZNeJ88pRr-iYMLa2-2FNTmQa9Ut48eB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300092



On 7/30/2025 2:14 PM, André Draszik wrote:
> On Sun, 2025-07-27 at 21:54 +0530, Shivendra Pratap wrote:
>> SoC vendors have different types of resets which are controlled
>> through various hardware registers. For instance, Qualcomm SoC
>> may have a requirement that reboot with “bootloader” command
>> should reboot the device to bootloader flashing mode and reboot
>> with “edl” should reboot the device into Emergency flashing mode.
>> Setting up such reboots on Qualcomm devices can be inconsistent
>> across SoC platforms and may require setting different HW
>> registers, where some of these registers may not be accessible to
>> HLOS. These knobs evolve over product generations and require
>> more drivers. PSCI spec defines, SYSTEM_RESET2, vendor-specific
>> reset which can help align this requirement. Add support for PSCI
>> SYSTEM_RESET2, vendor-specific resets and align the implementation
>> to allow user-space initiated reboots to trigger these resets.
>>
>> Introduce a late_initcall to register PSCI vendor-specific resets
>> as reboot modes. Implement a reboot-mode write function that sets
>> reset_type and cookie values during the reboot notifier callback.
>> Introduce a firmware-based call for SYSTEM_RESET2 vendor-specific
>> reset in the psci_sys_reset path, using reset_type and cookie if
>> supported by secure firmware.
>>
>> By using the above implementation, userspace will be able to issue
>> such resets using the reboot() system call with the "*arg"
>> parameter as a string based command. The commands can be defined
>> in PSCI device tree node as “reset-types” and are based on the
>> reboot-mode based commands.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  drivers/firmware/psci/Kconfig |  2 ++
>>  drivers/firmware/psci/psci.c  | 57 ++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
>> index 97944168b5e66aea1e38a7eb2d4ced8348fce64b..93ff7b071a0c364a376699733e6bc5654d56a17f 100644
>> --- a/drivers/firmware/psci/Kconfig
>> +++ b/drivers/firmware/psci/Kconfig
>> @@ -1,6 +1,8 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  config ARM_PSCI_FW
>>  	bool
>> +	select POWER_RESET
>> +	select REBOOT_MODE
>>  
>>  config ARM_PSCI_CHECKER
>>  	bool "ARM PSCI checker"
>> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
>> index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..e14bcdbec1750db8aa9297c8bcdb242f58cc420e 100644
>> --- a/drivers/firmware/psci/psci.c
>> +++ b/drivers/firmware/psci/psci.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/printk.h>
>>  #include <linux/psci.h>
>>  #include <linux/reboot.h>
>> +#include <linux/reboot-mode.h>
>>  #include <linux/slab.h>
>>  #include <linux/suspend.h>
>>  
>> @@ -51,6 +52,14 @@ static int resident_cpu = -1;
>>  struct psci_operations psci_ops;
>>  static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
>>  
>> +struct psci_vendor_sysreset2 {
>> +	u32 reset_type;
>> +	u32 cookie;
>> +	bool valid;
>> +};
>> +
>> +static struct psci_vendor_sysreset2 vendor_reset;
>> +
>>  bool psci_tos_resident_on(int cpu)
>>  {
>>  	return cpu == resident_cpu;
>> @@ -309,7 +318,10 @@ static int get_set_conduit_method(const struct device_node *np)
>>  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
>>  			  void *data)
>>  {
>> -	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>> +	if (vendor_reset.valid && psci_system_reset2_supported) {
>> +		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), vendor_reset.reset_type,
>> +			       vendor_reset.cookie, 0);
>> +	} else if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>>  	    psci_system_reset2_supported) {
>>  		/*
>>  		 * reset_type[31] = 0 (architectural)
> 
> I don't know the PSCI spec, but it looks like with this code it's not
> possible to set a reboot mode (in DT) and at the same time instruct
> the firmware whether a warm or a cold reboot was requested.

The code added in this patch is kind of dead, until vendor_reset.valid is set to true.
It can be true, only when both below conditions are true.
 1. A SoC DT defines a psci->reboot-mode command say - "bootloader".
 2. reboot sys call is issued using LINUX_REBOOT_CMD_RESTART2 and the arg* as "bootloader".
      reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_RESTART2, "bootloader");

With that in place, warm and cold reboot just work same as before until above conditions are true.
There is no effect on regular reboots or the reboots with a "command" which is not defined in
psci->reboot-mode DT.

Now lets take a case below, where a SoC vendor wants a combination of psci->reboo-mode command and
warm/cold to work in combination. For ex. a requirement below:
 - reboot command say - "bootlaoder" should do a cold reboot along with some extra HW reg writes.
 - reboot command say - "edl" should do a warm reboot along with some extra HW reg writes.

1. For this, both commands will be defined in the psci->reboot-mode DT Node with the arguments that
   are defined and supported by the firmware.
2. Further, such requirement will now be taken care by the underlying firmware that supports
   PSCI vendor-specific reset. When we call into firmware with vendor specific reset arguments,
   firmware will take care of the defined HW writes and warm/cold reset as per the mapping of the
   defined arguments. Firmware and the Linux kernel here are in agreement for executing the
   vendor-specific resets.

> 
> Doing warm reboot is useful if e.g. RAM contents needs to be retained
> for crash recovery handling, or other reasons, while in normal cases
> doing a more secure cold reboot.
> 
> On the other hand, of course it's useful to be able to specify the
> reboot target for normal reboots.
> 
> Is this a problem with the PSCI spec or with this specific change
> geared at the Qcom implementation?

SoC vendor should define a vendor-specific reset in psci DT only when they support them in their
firmware. 

Do we still think we are breaking anything in the spec or in the warm or the cold
reset path? If so can we discuss such use-cases?

> 
> 
>> @@ -547,6 +559,49 @@ static const struct platform_suspend_ops psci_suspend_ops = {
>>  	.enter          = psci_system_suspend_enter,
>>  };
>>  
>> +static int psci_set_vendor_sys_reset2(struct reboot_mode_driver *reboot, u64 magic)
>> +{
>> +	u32 magic_32;
>> +
>> +	if (psci_system_reset2_supported) {
>> +		magic_32 = magic & 0xFFFFFFFF;
> 
> I believe usual kernel style is to use lower case for
> hex values.

Sure, will make it lower case.

> 
>> +		vendor_reset.reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic_32;
>> +		vendor_reset.cookie = (magic >> 32) & 0xFFFFFFFF;
> 
> dito.

Ack.

thanks.

> 
> Cheers,
> Andre'
> 
>> +		vendor_reset.valid = true;
>> +	}
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static int __init psci_init_vendor_reset(void)
>> +{
>> +	struct reboot_mode_driver *reboot;
>> +	struct device_node *np;
>> +	int ret;
>> +
>> +	np = of_find_node_by_path("/psci/reboot-mode");
>> +	if (!np)
>> +		return -ENODEV;
>> +
>> +	reboot = kzalloc(sizeof(*reboot), GFP_KERNEL);
>> +	if (!reboot) {
>> +		of_node_put(np);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	reboot->write = psci_set_vendor_sys_reset2;
>> +
>> +	ret = reboot_mode_register(reboot, np, "psci");
>> +	if (ret) {
>> +		of_node_put(np);
>> +		kfree(reboot);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +late_initcall(psci_init_vendor_reset)
>> +
>>  static void __init psci_init_system_reset2(void)
>>  {
>>  	int ret;

