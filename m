Return-Path: <linux-pm+bounces-30618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3101EB00789
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 17:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BB11661E7
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8235A233715;
	Thu, 10 Jul 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KnNb1FX5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D8F13B293
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162322; cv=none; b=sJmuOBRbwa0WfO4GraNWA/cmg1u1bdLpJ69Jf8vwBBsmeqoLyGdoiEbXH3S76Cuw8WJaZt8BRs4u4jzCOjNjDOF8BIpWQG/axz2PcM6gYd/sSqMD4Iu83Z4slTztCsmR4rbrC3HIo9KXrLzzOxNr2qsI7CKzcr7y/mQOchoKxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162322; c=relaxed/simple;
	bh=sWLNbRGR1WallWCM4ueaRFzJawzsy7FQNASnovpTbV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBLgMG8T5Kb6/eJn9oMNWuSPy1Gt/srXJC/idT11n5HuxpPUpIKZ1Jce6P2C/vc71SKfIWMpUamiVGuTwPwkpC85p+bdOv6QZjy2ddq4ssf/f6nxv9ccsysYJoTOU88rfC2i9UEV9xe1on6TghonD3Wvpha0kXMCr57kIgN+l5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KnNb1FX5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A95Y9e016649
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 15:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Ncm63/MfiuPbDjDVklTQd8+kupDoVzcsE+k6jeIleo=; b=KnNb1FX5hzQYi1xI
	zA7Uh98UKUkyt/1X3LPA+iboHhUo60Q8NsuQ+j/+pYe+V7qm/tdkojBRTi5GoUkX
	nPMaDQzL3Wy8yMmK8Bke6qmNICNdt+b+pJEo7gOKKm7moVknA276ngxWtJI9K7ux
	hadHKYaTyBxM3ndfT+EmJPJxL4KWJbITB/2JWZbHJK6k1zpzRYszhYf366yP7Q5+
	VLnfL+zNUfcmJk7YHDU4yqMlV+1NhXfhYElD9wD5zJ6gWVPTKY3rqFj8xjkk4Hhf
	2hUhXMgwOTO0cGdte45iIxSOpCdFB+1zryLDHG6KpNvv0jVVCJ9ouQgDdAd50ChW
	t9iZYQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap5gpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 15:45:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a9b1f1fa5eso1707981cf.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 08:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752162318; x=1752767118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ncm63/MfiuPbDjDVklTQd8+kupDoVzcsE+k6jeIleo=;
        b=hw4IIsSax3vL/OMg/4Ga40KcjACgw5c8xJP1EM9xNfknnBc5cqahhcqArPicacPXwP
         ZgUWDknUQ20fqaK/PIHH1WpP2BX8ZK1X1DGM/vQ4sNe+2GxnuMOkpIc8DCyy6G5/1vN2
         ID4UOQkjkMAlpIedkjvzcDAS9HOTpADhg+Hm++fw40P4oLdUgLU4OP2ulFi3h1VilvdS
         1KLzQoWHInti95tIRAcym+KhQh9sr3XGQZHEWYkE728tDwtitojW7aXXbB0HVv9SVHw1
         wAd0YXuj1M4Kj1AeTXOfq7RiPlJLydixj/C7Dhe7l/TqtirHtPkprgsHUrPZTLqTNYcQ
         /ZvA==
X-Forwarded-Encrypted: i=1; AJvYcCVUnOEnTmXNSa2tmcGylI0zPXIImOuDG+1fD8Vfr7ijm/k6R94uYX8ZAIunsO8XRwHGyTfX1V8dAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyln5uWSANvkDwvwOQPRafIeuNprvd+pWnZoJn2+Yoaw8uTzeFw
	CVVyiIkgrHxeh5Yr0Q4rmdnM//vcAT7ydNHp2/0KUNxDZCwBfZ6HvfGP3+RosUg7+3JC555EUgX
	zEm89kUTs4rI5EZKa3cX5cmEGKbk3M8YUVDsjEDGyJ6f9QIBJ+sLPPRstdO8Yeg==
X-Gm-Gg: ASbGncs6FaNB+78Kr/sG1gd3wedQLvAOKqiYfECUdfLoy57wluf0j/T7K6pgtHUWUqS
	DS2n7IzQtFdzL8WmiX0jRa5cybbDf53ymdaupF6s/gqDquMOOuBe173gs+MfOFlIex0GcI3fm64
	Vd5rR01nisReMoj04klPIDqFvSV8hR3cTtL1Db0i4PT/+sleyq5wZbxBKMRzfSrcldytFXZPEep
	x8uIbEzBdbOdxlL2iqeZWgwvVElj/IMj+j1kHMyWea+SVTCx3o4iuA+eT9rbdCRON2M67ZzD4oa
	Dvlho4pTiu61G2YN4uhZzB+jQmPWY1L1XkxdDrTpGGYE5tR/CIjwPAAkv//Dr+D6Y+FPwvIqaap
	rto8=
X-Received: by 2002:ac8:5e46:0:b0:4a9:f582:dc03 with SMTP id d75a77b69052e-4a9f582dfcemr10046901cf.9.1752162318260;
        Thu, 10 Jul 2025 08:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGMNtJ4drdObgcfuSdkFknAQN4Odw7/i1HjVhwWIis053P28UmmNK+qrTjCWD2/caZ4V7w5g==
X-Received: by 2002:ac8:5e46:0:b0:4a9:f582:dc03 with SMTP id d75a77b69052e-4a9f582dfcemr10046111cf.9.1752162317396;
        Thu, 10 Jul 2025 08:45:17 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee44basm152828266b.42.2025.07.10.08.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 08:45:16 -0700 (PDT)
Message-ID: <4ca0df4e-7697-4cfe-ada4-6eee8224938f@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 17:45:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/10] firmware: psci: Implement vendor-specific
 reset-types as reboot-mode
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
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <elliotb317@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Andre Draszik <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        linux-rockchip@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-5-b2d3b882be85@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710-arm-psci-system_reset2-vendor-reboots-v10-5-b2d3b882be85@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=686fe00f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=GLYJuuS3cqMp142eAlYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: mZ12YBuVLJLqdmIE9MuUzHvMUJVlixuo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNiBTYWx0ZWRfX6EDcgs5kxGa6
 +tXRMPfwQG5y2Q6gLJMY3TGGypsRvsuUA9qZVhTu+Fvpb1HBhLC51N1TS6J29BWsbDJ2zeX6Yr4
 KvLJqey/cGp/Irrt6oIK1zr5GjJY7ZJ6qS84zlfrhhcGM8UPOQVlHerUXD3qWmjfdsxabuSQI+2
 y7bIfLGs7rvYmBZRX5Pz7H1N3I7ZYmflfYx4gTsK7PFGp4i50wozUoA80oFhz2HBuufbMU6INC/
 Y+3cq0S7XHV7kj2JHVd/5towdp3qNpYVz6+P5gsovey3tThCVELxSQvpN6sV09rXPi7RwAnEL06
 C9ECkV//li2555A3QhsOmshDdxCXJnssybIuJ50vNgS/zbdI6syMi5VhNwlFIz5Cie7DqG/Nlik
 qjDiC1YeBwhFQ66L81BCRVQYuHuvdFtv3U9e52DbL6whfU79L36hidekI52iv5+GfT8TdC0c
X-Proofpoint-GUID: mZ12YBuVLJLqdmIE9MuUzHvMUJVlixuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100136

On 7/10/25 11:15 AM, Shivendra Pratap wrote:
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
> Introduce a late_initcall to register PSCI vendor-specific resets
> as reboot-mode arguments like reset_type and cookie. For a SoC
> where, PSCI vendor-specific system_reset2 is supported, the
> appropriate value gets filled to reset_type and cookie during
> this reboot-mode hook registration. If the secure firmware
> supports PSCI system_reset2, restart notifier will make secure
> call to trigger appropriate requested reset type.
> 
> By using the above implementation, usespace will be able to issue
> such resets using the reboot() system call with the "*arg"
> parameter as a string based command. The commands can be defined
> in PSCI device tree node as “reset-types” and are based on the
> reboot-mode based commands.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/firmware/psci/Kconfig |  1 +
>  drivers/firmware/psci/psci.c  | 53 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
> index 97944168b5e66aea1e38a7eb2d4ced8348fce64b..9d65fe7b06a6429de8a26d06f9384e5c93f36e5f 100644
> --- a/drivers/firmware/psci/Kconfig
> +++ b/drivers/firmware/psci/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config ARM_PSCI_FW
>  	bool
> +	select REBOOT_MODE
>  
>  config ARM_PSCI_CHECKER
>  	bool "ARM PSCI checker"
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..87293f78ed83eb33ba67ded73728729811693ea3 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -13,10 +13,13 @@
>  #include <linux/errno.h>
>  #include <linux/linkage.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/printk.h>
>  #include <linux/psci.h>
>  #include <linux/reboot.h>
> +#include <linux/reboot-mode.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>  
> @@ -51,6 +54,14 @@ static int resident_cpu = -1;
>  struct psci_operations psci_ops;
>  static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
>  
> +struct psci_vendor_sysreset2 {
> +	u32 reset_type;
> +	u32 cookie;
> +	bool valid;
> +};
> +
> +static struct psci_vendor_sysreset2 vendor_reset;
> +
>  bool psci_tos_resident_on(int cpu)
>  {
>  	return cpu == resident_cpu;
> @@ -309,7 +320,14 @@ static int get_set_conduit_method(const struct device_node *np)
>  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
>  			  void *data)
>  {
> -	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
> +	if (vendor_reset.valid && psci_system_reset2_supported) {
> +		/*
> +		 * if vendor_reset.valid is true call sys reset2 with
> +		 * the vendor_reset(reset_type and cookie).
> +		 */

This comment repeats the line above and below it without
bringing additional value

Konrad

> +		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), vendor_reset.reset_type,
> +			       vendor_reset.cookie, 0);
> +	} else if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>  	    psci_system_reset2_supported) {
>  		/*
>  		 * reset_type[31] = 0 (architectural)
> @@ -547,6 +565,39 @@ static const struct platform_suspend_ops psci_suspend_ops = {
>  	.enter          = psci_system_suspend_enter,
>  };
>  
> +static int psci_set_vendor_sys_reset2(struct reboot_mode_driver *reboot,
> +				      u32 reset_type, u32 cookie)
> +{
> +	if (psci_system_reset2_supported) {
> +		vendor_reset.reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | reset_type;
> +		vendor_reset.cookie = cookie;
> +		vendor_reset.valid = true;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int __init psci_init_vendor_reset(void)
> +{
> +	struct reboot_mode_driver *reboot;
> +	struct device_node *np;
> +
> +	np = of_find_node_by_name(NULL, "reset-types");
> +	if (!np)
> +		return -ENODEV;
> +
> +	reboot = kzalloc(sizeof(*reboot), GFP_KERNEL);
> +	if (!reboot) {
> +		of_node_put(np);
> +		return -ENOMEM;
> +	}
> +
> +	reboot->write_with_cookie = psci_set_vendor_sys_reset2;
> +
> +	return reboot_mode_register(reboot, np);
> +}
> +late_initcall(psci_init_vendor_reset)
> +
>  static void __init psci_init_system_reset2(void)
>  {
>  	int ret;
> 

