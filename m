Return-Path: <linux-pm+bounces-31655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3DCB16B98
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 07:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB64758268B
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 05:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEF823B61F;
	Thu, 31 Jul 2025 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kqmfks5D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CAF187FEC
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940116; cv=none; b=M82SNyMsUuIZ87G2rWiqoyviSmIMP89is9D3sz0h2Ak5KNVTkkWve3nQYjGXdQgleGgTv9o31p3aFUVamaMbzNqqSq9ckD5ahZX3XVKU2xh337s50XnQZu5LbrwMmiJsDJlbHsmb4bLAV8SgsVjMj+j+jHit+slxEl+fMnkcVhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940116; c=relaxed/simple;
	bh=GbF0+Uo5KU3Y/c2HEvGrtn8MHSZHycg4Pf15RuOT7Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ne6cG4Yc7JzB3YRgRTtLgfecMHUv2vu7NmMtx+nMcrdGYlFjXLCea+dSZCM/EP9yt7Iq//Bm+Ptu6oHljSLP1ojliQU/WmdVQh7QAlN5jH+qKBJPWVtPn4XgmEGa7qYL6c+etemtmmMdrzgGBvdPQ0+HHPCOHMqzqZnJ1wgrOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kqmfks5D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V1fNYV022173
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 05:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ccFeXTR7pLPx1bBuVe3LNgdCi8JdpQE+Z5torLzxTE=; b=Kqmfks5DQbfxR3gV
	+a6RHyxwYbL9rRsvvbrLdPvILAO4sJg35j8ajZ7ukurS1CLSqrcFKrV9nk423OSe
	rahz6RU9Jh7jDf/XgYuCWykvPmZ4rjnvBjWeak9K+/+pJty88yikVz8HdMb9HTjs
	24k8HXy5NgysDpWfh8RB9DDDPScRmY8oy19e+VzCAp14M+sGv5XjOouVt0o87OgL
	XEqo0Qjtp49nKVeDHXjP5s7bwt9Swk7PEqbFB6fhv65gSjPBgoDe5Dk4nL2f8Kbb
	gREgk8fuOlHssiQFOy1a7rLATeJyI5vqJS2ZaKHywJttLFH9BTFxyjD9pTqP8yYS
	+B5n2A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nyu6td0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 05:35:13 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74928291bc3so621887b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 22:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753940111; x=1754544911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ccFeXTR7pLPx1bBuVe3LNgdCi8JdpQE+Z5torLzxTE=;
        b=LdAVx7WPfMO0wuCxjSRPnhEhl8ntUACL8pI2hYmcLyjfj5Ulzu9SFUxiRBHZmeZSfY
         UAUROm1BCpdfow2Co2CiVrRn1dqpbOG3X6Um7lAbOq21b8ExN41iiOC4ErIW6d5M4wRk
         DyTa1evoSHz8BuouRCQvqDoVakNap9XGkzsmBLsY1TezZJJlHon2o6G9dzG1F9/aY9eH
         B3d46/Uij2gFe0MxXRksdUpZk0Z9einoTCzzb5zj6cypx7/gRG81Z+BaVQg83EP5ag2C
         37vs7QZIk40KN74W/Pc7Gr0Lx0t4HqnN5QXbV0ZyLPEm8+JET7oOD1MYFdE95d/cjRps
         1QJw==
X-Forwarded-Encrypted: i=1; AJvYcCWno/xL6IaXhiF1HJTSlw0nBmz3mC6p2AjHndauA+Y6lfnYy39zHbNqc1FESBAoqvUxvDV1iE8fTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnA+U9ylSTWCKBurwR959SDx8DjhenlT4+RAbZf69jMfBTAkP8
	GdTZVGZthffuFm6o9lLYpHLMMoWzZ45JSXq8m3U8o4dEtYFSf7u/XS+JEP70pndbfjuyFwHFFnR
	Pi4CFkUSDKpPrtzSXssdebU9YoBj7VqwpgSmLrumFX+IGIQCiC1N8HBRnvrjRlg==
X-Gm-Gg: ASbGncvbFxwgEu0SMKGSyfZG9JiMYnBIB7+qFBLlMqi+KV/TI2pPw9eb/qp1RTKJzMp
	rz2uBnbixYj5d9gi0zgJYKbN274BPBEPWI2Ws+p9oCe608G991vkjwVn+ShJUVoLwr+ufjV6lQv
	N/B2DB5BP2AiattQKDyF7eJiZq8iIrdPqXcyl9nZQVbqU28UA7cTfiRL5Ecn1hEx+kQXIzSs1FW
	JPdOh35uRKQaqZJnpnYA5qoXl7N0q1fnfGGWjciHI1Im0NCNDyEP7wslBSZJgTb8poTLkj4MoDl
	TqnogYjdZWyqYWx+I/tRu4EyVNK1L69Grfv22imU8+gydMrhnT1nYwODLhyim2x8JHynYkviQA=
	=
X-Received: by 2002:a05:6a00:7601:b0:748:f6a0:7731 with SMTP id d2e1a72fcca58-76ab306de54mr7689437b3a.23.1753940111390;
        Wed, 30 Jul 2025 22:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaifupYStAioKzSiqVhcYtVa3o7OtXWpuYLllgS30iPPMtdEGkyK/10qHMAwHvtNzs1loIUw==
X-Received: by 2002:a05:6a00:7601:b0:748:f6a0:7731 with SMTP id d2e1a72fcca58-76ab306de54mr7689405b3a.23.1753940110951;
        Wed, 30 Jul 2025 22:35:10 -0700 (PDT)
Received: from [10.219.57.35] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd88dbsm559110b3a.103.2025.07.30.22.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 22:35:10 -0700 (PDT)
Message-ID: <473f7269-3852-64a0-8aa6-7299be0fc85f@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 11:05:02 +0530
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
Content-Language: en-US
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
 <b92c164f-c6df-a2c0-1416-67652a01b179@oss.qualcomm.com>
 <34c52c88fd8fcbf68c453c1e94e4cd6294becff1.camel@linaro.org>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <34c52c88fd8fcbf68c453c1e94e4cd6294becff1.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JojZbwoggi8ejIoNTp993inmTMkY-F7g
X-Proofpoint-ORIG-GUID: JojZbwoggi8ejIoNTp993inmTMkY-F7g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAzNiBTYWx0ZWRfX/Lx/ek5d5qpg
 qlFWGbOcy4MLrCIr02U9+No/IhvLwSOsGRdzs/NSL9l4HkJL9Uh2pqDDzxjX2JcHDb2ocgiMwl1
 JhmssBl5Ivwaw2f0Vmqjkh0KnHZo63QnM+0psm039ai91sTE5VdfVStGOdjPAasYWm/9m/7gpQu
 t1/b2cWqB2pxwrvVKwTXaHKJ6SChOTZ6iR0hpxuGqsUNlnMvfIJtZgaQNm1oxf8V9PJJaLo2DeW
 zu2GmoJBMur+K8AzEgnyXpMQPJlV0DtXcUEpGW4WNIt07SvWZ9IMDh1CvSYvGW/21GH6joAMTZF
 ZRthbQ5q5QdPwa4zsEOu3kGr2cweo9xWU/z3wbjBO11tfpe25xB5BsEnDihkfPKswMj8muoSu4A
 eDUA+X6SIoM0TUQghUwaadD991VibZel3OtaQqLJ5ZNJkzSGazD34eiF1j5FHSJPEqwvXEY1
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=688b0091 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=JUEddJpOQUfTzmi4ydgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310036



On 7/30/2025 8:53 PM, André Draszik wrote:
> On Wed, 2025-07-30 at 18:33 +0530, Shivendra Pratap wrote:
>>
>>
>> On 7/30/2025 2:14 PM, André Draszik wrote:
>>> On Sun, 2025-07-27 at 21:54 +0530, Shivendra Pratap wrote:
>>>> SoC vendors have different types of resets which are controlled
>>>> through various hardware registers. For instance, Qualcomm SoC
>>>> may have a requirement that reboot with “bootloader” command
>>>> should reboot the device to bootloader flashing mode and reboot
>>>> with “edl” should reboot the device into Emergency flashing mode.
>>>> Setting up such reboots on Qualcomm devices can be inconsistent
>>>> across SoC platforms and may require setting different HW
>>>> registers, where some of these registers may not be accessible to
>>>> HLOS. These knobs evolve over product generations and require
>>>> more drivers. PSCI spec defines, SYSTEM_RESET2, vendor-specific
>>>> reset which can help align this requirement. Add support for PSCI
>>>> SYSTEM_RESET2, vendor-specific resets and align the implementation
>>>> to allow user-space initiated reboots to trigger these resets.
>>>>
>>>> Introduce a late_initcall to register PSCI vendor-specific resets
>>>> as reboot modes. Implement a reboot-mode write function that sets
>>>> reset_type and cookie values during the reboot notifier callback.
>>>> Introduce a firmware-based call for SYSTEM_RESET2 vendor-specific
>>>> reset in the psci_sys_reset path, using reset_type and cookie if
>>>> supported by secure firmware.
>>>>
>>>> By using the above implementation, userspace will be able to issue
>>>> such resets using the reboot() system call with the "*arg"
>>>> parameter as a string based command. The commands can be defined
>>>> in PSCI device tree node as “reset-types” and are based on the
>>>> reboot-mode based commands.
>>>>
>>>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>>>> ---
>>>>  drivers/firmware/psci/Kconfig |  2 ++
>>>>  drivers/firmware/psci/psci.c  | 57 ++++++++++++++++++++++++++++++++++++++++++-
>>>>  2 files changed, 58 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
>>>> index 97944168b5e66aea1e38a7eb2d4ced8348fce64b..93ff7b071a0c364a376699733e6bc5654d56a17f 100644
>>>> --- a/drivers/firmware/psci/Kconfig
>>>> +++ b/drivers/firmware/psci/Kconfig
>>>> @@ -1,6 +1,8 @@
>>>>  # SPDX-License-Identifier: GPL-2.0-only
>>>>  config ARM_PSCI_FW
>>>>  	bool
>>>> +	select POWER_RESET
>>>> +	select REBOOT_MODE
>>>>  
>>>>  config ARM_PSCI_CHECKER
>>>>  	bool "ARM PSCI checker"
>>>> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
>>>> index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..e14bcdbec1750db8aa9297c8bcdb242f58cc420e 100644
>>>> --- a/drivers/firmware/psci/psci.c
>>>> +++ b/drivers/firmware/psci/psci.c
>>>> @@ -17,6 +17,7 @@
>>>>  #include <linux/printk.h>
>>>>  #include <linux/psci.h>
>>>>  #include <linux/reboot.h>
>>>> +#include <linux/reboot-mode.h>
>>>>  #include <linux/slab.h>
>>>>  #include <linux/suspend.h>
>>>>  
>>>> @@ -51,6 +52,14 @@ static int resident_cpu = -1;
>>>>  struct psci_operations psci_ops;
>>>>  static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
>>>>  
>>>> +struct psci_vendor_sysreset2 {
>>>> +	u32 reset_type;
>>>> +	u32 cookie;
>>>> +	bool valid;
>>>> +};
>>>> +
>>>> +static struct psci_vendor_sysreset2 vendor_reset;
>>>> +
>>>>  bool psci_tos_resident_on(int cpu)
>>>>  {
>>>>  	return cpu == resident_cpu;
>>>> @@ -309,7 +318,10 @@ static int get_set_conduit_method(const struct device_node *np)
>>>>  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
>>>>  			  void *data)
>>>>  {
>>>> -	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>>>> +	if (vendor_reset.valid && psci_system_reset2_supported) {
>>>> +		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), vendor_reset.reset_type,
>>>> +			       vendor_reset.cookie, 0);
>>>> +	} else if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>>>>  	    psci_system_reset2_supported) {
>>>>  		/*
>>>>  		 * reset_type[31] = 0 (architectural)
>>>
>>> I don't know the PSCI spec, but it looks like with this code it's not
>>> possible to set a reboot mode (in DT) and at the same time instruct
>>> the firmware whether a warm or a cold reboot was requested.
>>
>> The code added in this patch is kind of dead, until vendor_reset.valid is set to true.
>> It can be true, only when both below conditions are true.
>>  1. A SoC DT defines a psci->reboot-mode command say - "bootloader".
>>  2. reboot sys call is issued using LINUX_REBOOT_CMD_RESTART2 and the arg* as "bootloader".
>>       reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_RESTART2, "bootloader");
>>
>> With that in place, warm and cold reboot just work same as before until above conditions are true.
>> There is no effect on regular reboots or the reboots with a "command" which is not defined in
>> psci->reboot-mode DT.
>>
>> Now lets take a case below, where a SoC vendor wants a combination of psci->reboo-mode command and
>> warm/cold to work in combination. For ex. a requirement below:
>>  - reboot command say - "bootlaoder" should do a cold reboot along with some extra HW reg writes.
>>  - reboot command say - "edl" should do a warm reboot along with some extra HW reg writes.
>>
>> 1. For this, both commands will be defined in the psci->reboot-mode DT Node with the arguments that
>>    are defined and supported by the firmware.
>> 2. Further, such requirement will now be taken care by the underlying firmware that supports
>>    PSCI vendor-specific reset. When we call into firmware with vendor specific reset arguments,
>>    firmware will take care of the defined HW writes and warm/cold reset as per the mapping of the
>>    defined arguments. Firmware and the Linux kernel here are in agreement for executing the
>>    vendor-specific resets.
> 
> So that means
> 
>     echo warm > /sys/kernel/reboot/mode
>     reboot bootloader
> 
> and
> 
>     echo cold > /sys/kernel/reboot/mode
>     reboot bootloader
> 
> can not be distinguished.
> 
> The firmware can not know whether or not cold or warm reboot was
> requested in this case by the user.
> 
> More importantly, if e.g. an OOPS / panic happens after the reboot
> notifier has run (and set vendor_reset.valid because a reboot mode
> was requested), a panic handler changing reboot_mode to warm to
> retain RAM contents will have no effect, because the the original
> code above making those distinctions can not be reached anymore.
> 
> Above scenario with OOPS / panic after reboot notifier could e.g.
> happen as part of device_shutdown() - see kernel_shutdown_prepare()

We can handle the panic path by adding a panic_notifier in psci
and make vendor_reset.valid = false. Do you think adding this can clear
the panic scenario above or there can still be some leak?

thanks.

> 
> 
>>>
>>> Doing warm reboot is useful if e.g. RAM contents needs to be retained
>>> for crash recovery handling, or other reasons, while in normal cases
>>> doing a more secure cold reboot.
>>>
>>> On the other hand, of course it's useful to be able to specify the
>>> reboot target for normal reboots.
>>>
>>> Is this a problem with the PSCI spec or with this specific change
>>> geared at the Qcom implementation?
>>
>> SoC vendor should define a vendor-specific reset in psci DT only when they support them in their
>> firmware. 
>>
>> Do we still think we are breaking anything in the spec or in the warm or the cold
>> reset path? If so can we discuss such use-cases?
> 
> I don't know the spec, but see examples above.
> 
> Cheers,
> Andre'

