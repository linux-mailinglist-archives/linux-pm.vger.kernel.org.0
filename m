Return-Path: <linux-pm+bounces-35600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F27ECBACB9F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 13:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6AF23AAF45
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C5F26461F;
	Tue, 30 Sep 2025 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="duebPmOW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C97725782D
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232696; cv=none; b=hBlAYFed8zdVdYiWCErWkYVJgvlOHr+vbXFLUXIt1nODTnp2ymfPnMfNthvIgEhSnDOIbwO1bgrRc6F0vsdi3cGTVJ4C+tPJeUvzVj4CHqDXu8cTevFsq/MigtZeNMA5rNaAvoF4StBew6kQsBb3bLZ1ExWh14LUGebuEZtokxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232696; c=relaxed/simple;
	bh=WZFp1ztP+iQAiNPILwtflJS8o6GJ5M/F6YQtJ1K8MrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnVvr5q9AuVkoh+2BijlCEDR8XyqZ60nJ4CaXYeqROxL0WKTBMHbKwdBChQzfzvQceBhF0NcUAg/IZ8avSyaR+LS5m1xz1VhcEy10oA6cEGCTGV/7UerMwCWrJXrCPoGxZPjnM0gaOwMsT8ITwCFroq83jqCHR4CQhWfhOeu0Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=duebPmOW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HO1U014790
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 11:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l0BzqZ/4sw53r69E6XghJy873Mwyh6QyOXwyOoGLze0=; b=duebPmOWUOAADAgx
	Xb6oWB0SKfqaSemGSxG17Y6Vs2+ilBdL7yyen//7uO8d362HGEtd2/074EkDd+SS
	IsVxX9WI0eWeoss4SC8xRguh4eoaRufAUQdrAIJUfe+YfcBKWwMvQy21/GZW/FMk
	FyWRo4ZT2jiKA3mBZiUDE+Y8NcqHZi7sKVmWKttOntkBLsA1+H1insTqwZRxDXQZ
	E8rTmxsVTg/vWiXfNlhT1uCwfR0/PunLFoTRUuwqJ+rjDOAkYG0Ijsipx7khbAk6
	Ddluj2BFftVtdj9SyiVHD4cfvvidjAMEUj2a0IPpE3nKZsLnj9Zkx3AOqNL6newM
	4SVmgg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr0ta1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 11:44:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-25d21fddb85so105998975ad.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 04:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759232693; x=1759837493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0BzqZ/4sw53r69E6XghJy873Mwyh6QyOXwyOoGLze0=;
        b=m96XMzvHB1nxWzBaAaGsSsX6C0kQcml9ICWrEZt9GK44Zxp2rw3/1MD4xA/PxjRVpl
         kzjrLsysjRwTNRw5ftPR2PJqJwLVgTclXrx/Zte9dt8xPM0fteyLMUW7YY2j/fFauY82
         SJ7FJo4GpbFXyHu2PfTJVeg0HDfpYZTgJ07xnuTCaHrVtDc3LgPoU4MoFmP2SSUy5Qwu
         E3548dbY5p2cUvecpw7pWHWzkwTZTohaRLtABHaPqmYJA6QjlXF+xddkD4ydt039EzBe
         v6dOdlfcopV13Lna24+Nk5OgZc2fwUdpER6RYmbp4P7gMgh7SzmGoJHe3zNYDqSqs9CA
         B05w==
X-Forwarded-Encrypted: i=1; AJvYcCXvsZFf6DwHRuBZMVpnPEOjVH0SB0YDQLC2nWmSQTM75ORMN4QzrAgUrcFxqPI0nyACOyy3dxqKnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNp4YO4PRyn1E5FoczZEXgnk9L+dwoSY9kY0ibqDzsKzFqszhb
	2uP1279gMq1e9y94OJROrm5bOCN6UNPGJbVYmTb+0cW0ga6/r/ywBFAPlROmm8ixbCU+ehqypql
	DK5Rp+KpC/Ccf6JQpSN0ZE5etCrHDX7JYAkV22ZPhPZYXS3MnClh7GAeqSCI9/A==
X-Gm-Gg: ASbGnctHivad2BoWL97D610EgP0O+uIcLdiDLFpGMtDzNdqSih1KrSjsg0Cjm0f5P+L
	MePZfTV6KJsS4V7ZgNAk3/dd2ehj87zuzo0a/FlgwYpDzkmEdaFESBn9Pcc7whCK2j9zI2Feo/d
	u61J/hDUxjZm/awb9hkzJ5FBzQHKThDqWIDlJiR5MzcyAetSt3hasbiYZlwqxdIhNKU+Ck174mH
	lKWTh+xFADidgnDg3mCMnAvvkW2TemYQIwEeImmPiw6cYozrEavmmDctNZfeD590iO7JToSP5GJ
	UlVLG8pKwfy54vqRUmo4/xA5MhyDBcX0tpJmwTsGf3FOeB+s23Hrd/Mudf/AS4Qxg3O5Q545GZx
	FEikZ
X-Received: by 2002:a17:902:e54f:b0:267:9c2f:4655 with SMTP id d9443c01a7336-27ed4a49254mr215223205ad.41.1759232692531;
        Tue, 30 Sep 2025 04:44:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEve1eD+dd1r1YsJpk9PlBGwIyu3HmOFMAgn0RGL0ZK0pja/BCi89UoErtpan0WzMlLpeewzQ==
X-Received: by 2002:a17:902:e54f:b0:267:9c2f:4655 with SMTP id d9443c01a7336-27ed4a49254mr215222655ad.41.1759232691985;
        Tue, 30 Sep 2025 04:44:51 -0700 (PDT)
Received: from [10.219.56.238] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ad1fd9sm156376915ad.142.2025.09.30.04.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 04:44:51 -0700 (PDT)
Message-ID: <2a428158-551c-0da5-17c0-b47098aecad9@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 17:08:51 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v15 07/14] firmware: psci: Implement vendor-specific
 resets as reboot-mode
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
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
 <4276eeea-5877-4420-98da-a5f2eb5c0505@oss.qualcomm.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <4276eeea-5877-4420-98da-a5f2eb5c0505@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LiSan-T7LpPKNPtdq-XDeakTa8oHPNDf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX3diZHfrkOYkE
 Vrf3ifwDzCGXqbbgSaYeU620dXtvuH9w5PN9zo1KnKUw1bnMzIUqIdgva3UrnHKQnPZzChQLebh
 6BAtxub+NotOYGe8lGQP2zBaDo/axMvB4Nmc+9NCDQPWz6rIKFBJQ8r1RlcbrII+Q3goQbNLeul
 32/LFv4Yl9D9cZ/AnVnzYwDgogKELaCKfv3W2NyPKvn8Ke7OKKNH5NDjzMcs5ScF+ekmiy7ujez
 KEiHGw98tm0iQwqwj+WLY1RkCd001W2+KFI5uCtzl5/TeQo8WOgMU9hY0R1sXsZixIyr55NOuuL
 z2HTaH+6vNW/IoicdJer40Es0DldtDBAmSGoUAsfRFaFF263LD3bw4yUs6yZcZD7e+TYtK9uoJH
 EwHJXFzM8kfWr3fdrECaDshdSYdESQ==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68dbc2b6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=m9_P3jxxV_FW9xONvJ8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: LiSan-T7LpPKNPtdq-XDeakTa8oHPNDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017



On 9/30/2025 11:15 AM, Kathiravan Thirumoorthy wrote:
> 
> On 9/22/2025 7:10 PM, Shivendra Pratap wrote:
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
>> Implement the PSCI vendor-specific resets by registering to the
>> reboot-mode framework. As psci init is done at early kernel init,
>> reboot-mode registration cannot be done at the time of psci init.
>> This is because reboot-mode creates a “reboot-mode” class for
>> exposing sysfs, which can fail at early kernel init. To overcome
>> this, introduce a late_initcall to register PSCI vendor-specific
>> resets as reboot modes. Implement a reboot-mode write function
>> that sets reset_type and cookie values during the reboot notifier
>> callback.  Introduce a firmware-based call for SYSTEM_RESET2
>> vendor-specific reset in the psci_sys_reset path, using
>> reset_type and cookie if supported by secure firmware. Register a
>> panic notifier and clear vendor_reset valid status during panic.
>> This is needed for any kernel panic that occurs post
>> reboot_notifiers.
>>
>> By using the above implementation, userspace will be able to issue
>> such resets using the reboot() system call with the "*arg"
>> parameter as a string based command. The commands can be defined
>> in PSCI device tree node under “reboot-mode” and are based on the
>> reboot-mode based commands.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>   drivers/firmware/psci/Kconfig |  2 +
>>   drivers/firmware/psci/psci.c  | 89 ++++++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 90 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
>> index 97944168b5e66aea1e38a7eb2d4ced8348fce64b..93ff7b071a0c364a376699733e6bc5654d56a17f 100644
>> --- a/drivers/firmware/psci/Kconfig
>> +++ b/drivers/firmware/psci/Kconfig
>> @@ -1,6 +1,8 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   config ARM_PSCI_FW
>>       bool
>> +    select POWER_RESET
>> +    select REBOOT_MODE
>>     config ARM_PSCI_CHECKER
>>       bool "ARM PSCI checker"
>> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
>> index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..40a27bc2cc3a3393acc14c7b2314155540ed06c9 100644
>> --- a/drivers/firmware/psci/psci.c
>> +++ b/drivers/firmware/psci/psci.c
>> @@ -13,10 +13,12 @@
>>   #include <linux/errno.h>
>>   #include <linux/linkage.h>
>>   #include <linux/of.h>
>> +#include <linux/panic_notifier.h>
>>   #include <linux/pm.h>
>>   #include <linux/printk.h>
>>   #include <linux/psci.h>
>>   #include <linux/reboot.h>
>> +#include <linux/reboot-mode.h>
>>   #include <linux/slab.h>
>>   #include <linux/suspend.h>
>>   @@ -51,6 +53,24 @@ static int resident_cpu = -1;
>>   struct psci_operations psci_ops;
>>   static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
>>   +struct psci_vendor_sysreset2 {
>> +    u32 reset_type;
>> +    u32 cookie;
>> +    bool valid;
>> +};
>> +
>> +static struct psci_vendor_sysreset2 vendor_reset;
>> +
>> +static int psci_panic_event(struct notifier_block *nb, unsigned long v, void *p)
>> +{
>> +    vendor_reset.valid = false;
>> +    return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block psci_panic_block = {
>> +    .notifier_call = psci_panic_event
>> +};
>> +
>>   bool psci_tos_resident_on(int cpu)
>>   {
>>       return cpu == resident_cpu;
>> @@ -309,7 +329,10 @@ static int get_set_conduit_method(const struct device_node *np)
>>   static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
>>                 void *data)
>>   {
>> -    if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>> +    if (vendor_reset.valid && psci_system_reset2_supported) {
>> +        invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), vendor_reset.reset_type,
>> +                   vendor_reset.cookie, 0);
>> +    } else if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>>           psci_system_reset2_supported) {
>>           /*
>>            * reset_type[31] = 0 (architectural)
>> @@ -547,6 +570,70 @@ static const struct platform_suspend_ops psci_suspend_ops = {
>>       .enter          = psci_system_suspend_enter,
>>   };
>>   +static int psci_set_vendor_sys_reset2(struct reboot_mode_driver *reboot, u64 magic)
>> +{
>> +    u32 magic_32;
>> +
>> +    if (psci_system_reset2_supported) {
>> +        magic_32 = magic & 0xffffffff;
>> +        vendor_reset.reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic_32;
>> +        vendor_reset.cookie = (magic >> 32) & 0xffffffff;
> 
> 
> Minor Nit: Can we use GENMASK(31, 0) instead of 0xffffffff? Apart from this, change LGTM. With that,

Ack. Will update this.

> 
> Reviewed-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

thanks for review.

thanks,
Shivendra

