Return-Path: <linux-pm+bounces-35595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3DEBAB828
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 07:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FCF3AC8B2
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 05:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9985277017;
	Tue, 30 Sep 2025 05:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CJmIWjj+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD82749D7
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 05:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211140; cv=none; b=k3EGhnMsqpOvIkLiB9DmAkdP1bVBh2af1ZNYJ8Uhkw0p1yuzy4VcczVoLt6T1JrLdBqMBPG5b1XrG5nbJvyeZYrXNILDhuu4pwf3mnWukFGm97l7L2gIoFhglZbcrETCeiSS6flxeB2ujj8rAR3yYn0XWALh1ugWZSHkGKshA80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211140; c=relaxed/simple;
	bh=ve6oIWZvymellrLLBdWVPtFWTwvtVVk811bmbemuMac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udTaW3eJXeEvYU1btQBuog8n4dnLqWn1PwBsUTdI6oAruYI7Rj3sOEaB5oCubeeGQGmwfzW9nSHNrblsctuEO5r3Dgt4IEz5NeH/bIB094aGh5t4iLWp5o8VqTSG427DXvQqfvhTo1KXqNj+m/j+Vf4wmnRgRstLIkXGoHkMVCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CJmIWjj+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4Htdl027898
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 05:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U+cYdN/Q52kS7p4GHmBZmzPjUkGPEpyNfvKUw3IGkUE=; b=CJmIWjj+s+7hFNw8
	Dn0WwLij4xqCtAyGV+eWk/+XhZMFMVt0YVD5Bsk0FxEn7f4Pun4CWRacVh1pNWkH
	SWe4oAX/zdNtqdaNeM4hciVc1mS6OZv47F3aN+G215hiFGjObpkotSfRUVYGjzvM
	JZNIlbwL7sCJRBE9EC8ZXeckAsSB0qHzj6MW2rd28i7HFhGaAgx3al2Nyszzom9d
	iHnGCK5CIjoyA/HIgXrm4N7+Q0qHXu+L6m24QeWYme6aa6m2VzyHF9Y1dqP8iv0o
	XaC3sFSAuufM9LjA2A4/TpZT0b9HRYZkjkIhRWdJAaw/0EFN2zNbDaDgKn7IJmOr
	ltPOBw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrf1bp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 05:45:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-277f0ea6fbaso65467545ad.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 22:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211134; x=1759815934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+cYdN/Q52kS7p4GHmBZmzPjUkGPEpyNfvKUw3IGkUE=;
        b=LOEFFXjieEWJk2H1e9+PFVQCtvmgll00oKbPpR4y/pnnCVVG5yQ1N4Udqln2TmX8ML
         3N3cYe9rMUgC1X6muUs1b4v05lek/r9TmUhzSdF7mdKzySuuOXf7IjKrjRmxmsNaeIk9
         hf2Wa3jPJ3wUG5JWD/m1798QPLn0COiawFoEeB84N72e0Cz7uM1CNtVw2hW3wX9Slru8
         pusak7RDR1kZyQKS7bbCecF0t1q9jOL3KIIqxJk0NR+juPPQxU4Yong+PIN9wvJ/n1/W
         dbIeSX4irO3OzMnprxmCjDLCApWXmZ72UFK5xs8/mWWniS1w7NHmTpRx6irLzT/fWJt9
         7QJw==
X-Forwarded-Encrypted: i=1; AJvYcCVxNd3gr8LNhWREamDjYMaeWIHP5tFwDsXEC7dPl33dudCM4TGoYPNtMc4+7uinTiaYNv+Qbr0coQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4nym2+sdbMLNJaDJa59hpkLtQ3/dxcAOa0NeLd+PYx1PvoRHl
	EOZfxOC3P/z8fn1407cEOH3Z6py5/f+TkJkvq/VLj3A9l6hsokM4Jp4iOPAKi2tyvEPWLZvmrWm
	MxrwotPi4YhOR6ZJn3zEHsEp9la2w8v04aOW/Z0JqUNJIx/dcGpolFBZxs730uA==
X-Gm-Gg: ASbGncu7WVPBG5Qtqrp1y/X4hHgLlrGt5Xw7Epro+gmmx4hskcSUYQ0h02cKgSreGxf
	wlOOrkYpItYDM7+XhcDnMgnkdk3XMTmpMGkKA/dRLo5XJHjWb06oiFx2Bl4wkEyrsOcYtWHzU4F
	i6XIPjENZJEjnRHiSav1rLvYsKP50tWUt7A8iL8bcte4jcuTDTKmMVVVzIDTmHiai5dl64lnvAV
	tOReGglzlt11hexeK0yebPBmaYp4N2GvMejGHZrL2D64HPFznhmE0VBlofa2WmV8BXLRaBf/4yE
	lxjEn70OP532abceaLgA/T2fDApeXmNMe3oRXGLwdWAHwvdlY/Wo44MsUKBym+j1zbQRLAzhtRb
	lYtAE3Qp1LCKl+A==
X-Received: by 2002:a17:903:19f0:b0:26c:e270:6dad with SMTP id d9443c01a7336-27ed4ae51c6mr177949255ad.60.1759211133841;
        Mon, 29 Sep 2025 22:45:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaNwtMS+L7JYb6fXEGvaAzNNfpnL39xLAuGz7lefMMjZVgnylqawU22M4IEG2k35nREeiThA==
X-Received: by 2002:a17:903:19f0:b0:26c:e270:6dad with SMTP id d9443c01a7336-27ed4ae51c6mr177948835ad.60.1759211133375;
        Mon, 29 Sep 2025 22:45:33 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821desm149919235ad.91.2025.09.29.22.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 22:45:32 -0700 (PDT)
Message-ID: <4276eeea-5877-4420-98da-a5f2eb5c0505@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 11:15:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 07/14] firmware: psci: Implement vendor-specific
 resets as reboot-mode
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
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
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
 <20250922-arm-psci-system_reset2-vendor-reboots-v15-7-7ce3a08878f1@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20250922-arm-psci-system_reset2-vendor-reboots-v15-7-7ce3a08878f1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9yOvlh7BmIdYpZAMsQR2FmQ6d_W-stwp
X-Proofpoint-GUID: 9yOvlh7BmIdYpZAMsQR2FmQ6d_W-stwp
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68db6e81 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=us_dTBczMLAT1r8_uQAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfX6fKLtNYGysye
 QhkqaGFC/jXzRDmVjesLYk6msgVoT2crkPbSOg8ajtF3pESLApz2nC2YZYkdKMWC/S6DTBqvXvH
 ZxlLuRwN77RuoRa0eRoCdOPbp89G4K7SZ+VaKT+1rnimKxzOAGO9LCXX6Z18os9nJQvO0m9yU/d
 4zhTydJK1QS6NJCNjxiR1FPaJz7jtSKo8GgvPjjABB6jOpuVohbR8lrvre5K5vPIXrpQkoGwy35
 QKnxxRmgnUmUO9hhUHO631ytsD2+Fs5GkhHoyqq6QPIdyt7jJvMlofNbluzMMZ5MJK2yKbAr7+H
 pcpQSQzk5xqUcXUMCcH78L9GI46hhyre8GnaWJLMoWxtyTOTK2/8SLtZiwSSpA0N7iREDJJ6j+J
 gsHkkSxr8egO8Mh7V60w5GPrcpcadA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175


On 9/22/2025 7:10 PM, Shivendra Pratap wrote:
> SoC vendors have different types of resets which are controlled
> through various hardware registers. For instance, Qualcomm SoC
> may have a requirement that reboot with “bootloader” command
> should reboot the device to bootloader flashing mode and reboot
> with “edl” should reboot the device into Emergency flashing mode.
> Setting up such reboots on Qualcomm devices can be inconsistent
> across SoC platforms and may require setting different HW
> registers, where some of these registers may not be accessible to
> HLOS. These knobs evolve over product generations and require
> more drivers. PSCI spec defines, SYSTEM_RESET2, vendor-specific
> reset which can help align this requirement. Add support for PSCI
> SYSTEM_RESET2, vendor-specific resets and align the implementation
> to allow user-space initiated reboots to trigger these resets.
>
> Implement the PSCI vendor-specific resets by registering to the
> reboot-mode framework. As psci init is done at early kernel init,
> reboot-mode registration cannot be done at the time of psci init.
> This is because reboot-mode creates a “reboot-mode” class for
> exposing sysfs, which can fail at early kernel init. To overcome
> this, introduce a late_initcall to register PSCI vendor-specific
> resets as reboot modes. Implement a reboot-mode write function
> that sets reset_type and cookie values during the reboot notifier
> callback.  Introduce a firmware-based call for SYSTEM_RESET2
> vendor-specific reset in the psci_sys_reset path, using
> reset_type and cookie if supported by secure firmware. Register a
> panic notifier and clear vendor_reset valid status during panic.
> This is needed for any kernel panic that occurs post
> reboot_notifiers.
>
> By using the above implementation, userspace will be able to issue
> such resets using the reboot() system call with the "*arg"
> parameter as a string based command. The commands can be defined
> in PSCI device tree node under “reboot-mode” and are based on the
> reboot-mode based commands.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>   drivers/firmware/psci/Kconfig |  2 +
>   drivers/firmware/psci/psci.c  | 89 ++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 90 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
> index 97944168b5e66aea1e38a7eb2d4ced8348fce64b..93ff7b071a0c364a376699733e6bc5654d56a17f 100644
> --- a/drivers/firmware/psci/Kconfig
> +++ b/drivers/firmware/psci/Kconfig
> @@ -1,6 +1,8 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config ARM_PSCI_FW
>   	bool
> +	select POWER_RESET
> +	select REBOOT_MODE
>   
>   config ARM_PSCI_CHECKER
>   	bool "ARM PSCI checker"
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..40a27bc2cc3a3393acc14c7b2314155540ed06c9 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -13,10 +13,12 @@
>   #include <linux/errno.h>
>   #include <linux/linkage.h>
>   #include <linux/of.h>
> +#include <linux/panic_notifier.h>
>   #include <linux/pm.h>
>   #include <linux/printk.h>
>   #include <linux/psci.h>
>   #include <linux/reboot.h>
> +#include <linux/reboot-mode.h>
>   #include <linux/slab.h>
>   #include <linux/suspend.h>
>   
> @@ -51,6 +53,24 @@ static int resident_cpu = -1;
>   struct psci_operations psci_ops;
>   static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
>   
> +struct psci_vendor_sysreset2 {
> +	u32 reset_type;
> +	u32 cookie;
> +	bool valid;
> +};
> +
> +static struct psci_vendor_sysreset2 vendor_reset;
> +
> +static int psci_panic_event(struct notifier_block *nb, unsigned long v, void *p)
> +{
> +	vendor_reset.valid = false;
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block psci_panic_block = {
> +	.notifier_call = psci_panic_event
> +};
> +
>   bool psci_tos_resident_on(int cpu)
>   {
>   	return cpu == resident_cpu;
> @@ -309,7 +329,10 @@ static int get_set_conduit_method(const struct device_node *np)
>   static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
>   			  void *data)
>   {
> -	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
> +	if (vendor_reset.valid && psci_system_reset2_supported) {
> +		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), vendor_reset.reset_type,
> +			       vendor_reset.cookie, 0);
> +	} else if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>   	    psci_system_reset2_supported) {
>   		/*
>   		 * reset_type[31] = 0 (architectural)
> @@ -547,6 +570,70 @@ static const struct platform_suspend_ops psci_suspend_ops = {
>   	.enter          = psci_system_suspend_enter,
>   };
>   
> +static int psci_set_vendor_sys_reset2(struct reboot_mode_driver *reboot, u64 magic)
> +{
> +	u32 magic_32;
> +
> +	if (psci_system_reset2_supported) {
> +		magic_32 = magic & 0xffffffff;
> +		vendor_reset.reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic_32;
> +		vendor_reset.cookie = (magic >> 32) & 0xffffffff;


Minor Nit: Can we use GENMASK(31, 0) instead of 0xffffffff? Apart from 
this, change LGTM. With that,

Reviewed-by: Kathiravan Thirumoorthy 
<kathiravan.thirumoorthy@oss.qualcomm.com>


> +		vendor_reset.valid = true;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int __init psci_init_vendor_reset(void)
> +{
> +	struct reboot_mode_driver *reboot;
> +	struct device_node *psci_np;
> +	struct device_node *np;
> +	int ret;
> +
> +	if (!psci_system_reset2_supported)
> +		return -EINVAL;
> +
> +	psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
> +	if (!psci_np)
> +		return -ENODEV;
> +
> +	np = of_find_node_by_name(psci_np, "reboot-mode");
> +	if (!np) {
> +		of_node_put(psci_np);
> +		return -ENODEV;
> +	}
> +
> +	ret = atomic_notifier_chain_register(&panic_notifier_list, &psci_panic_block);
> +	if (ret)
> +		goto err_notifier;
> +
> +	reboot = kzalloc(sizeof(*reboot), GFP_KERNEL);
> +	if (!reboot) {
> +		ret = -ENOMEM;
> +		goto err_kzalloc;
> +	}
> +
> +	reboot->write = psci_set_vendor_sys_reset2;
> +	reboot->driver_name = "psci";
> +
> +	ret = reboot_mode_register(reboot, of_fwnode_handle(np));
> +	if (ret)
> +		goto err_register;
> +
> +	return 0;
> +
> +err_register:
> +	kfree(reboot);
> +err_kzalloc:
> +	atomic_notifier_chain_unregister(&panic_notifier_list, &psci_panic_block);
> +err_notifier:
> +	of_node_put(psci_np);
> +	of_node_put(np);
> +	return ret;
> +}
> +late_initcall(psci_init_vendor_reset)
> +
>   static void __init psci_init_system_reset2(void)
>   {
>   	int ret;
>

