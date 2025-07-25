Return-Path: <linux-pm+bounces-31411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51935B1171C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 05:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F8B3B7180
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 03:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7D3236431;
	Fri, 25 Jul 2025 03:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PcIdVf1s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F131EDA1A
	for <linux-pm@vger.kernel.org>; Fri, 25 Jul 2025 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753414481; cv=none; b=buGwQZdEzQlhGypVfH4FcLsLUxke/Me1Fxg5/VzgAJHkPaV67ZGZr/RhI3QcjwzWq+nfga2rYIoYLJ3JDQvnnSWmmgM2uVbsIX01RNLCsw8VxuhyEnvra2TDwwoJwrLIP9grXtJgzeMJB//l7wVj2JDrCfvB8f2DuKYjApk7W/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753414481; c=relaxed/simple;
	bh=pNFws1W7AcIvycMkP7lCSf0KZ/SAmmCR9WGXbQMNxlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ha5qen57zU5zS3yqDCy5Ad08MbEE32bpv6hFTgoZC2KcxGOMFpsdpFbyA2QyNnTNKT7uXWTVzKnJSX1lGhUSl9U46NrBaw6/3zBZ0pzSCu5fqvhb0y8Yyywv/vX+hmH4nFAX75mzTmuxP9cOKCijAOFqKlKcnbqrrQPdRmUqs2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PcIdVf1s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLmoAU001094
	for <linux-pm@vger.kernel.org>; Fri, 25 Jul 2025 03:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2TGAJHVkDaQILMrgf+9DsRvtoYw89TydpErL2J0/xE4=; b=PcIdVf1s9lDk8cjm
	V5/LNzY52BUGwXgLmmu+DhrVeFlqtIzVow5g/Y0QInr0aO/9tBPORLJMyOYE4pdu
	HIndr3qsx5OcIU7xYdjkEDmcasHPHHDfwwfzAImjajH7aYAv7FESonfRUylz6sLW
	yWRxypUYBqaLMhCNCOjk6C9BCK5Un34sR9i99Y1qsVwQozVHI8/7mUeIyMaQGuZh
	CFduZqi65q7f9+4GA/F3ZacPzx+ILGDSLkyHMfFocJvkPjveY6IJmCxDlj4wl7db
	SK4YKvlnYOQX3zCSfcujDwcVAJdH4Gb+iMMx8SG028DXEtwO5KBvZXIGHR/BwL7u
	3XxvNA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2xgncn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 25 Jul 2025 03:34:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235c897d378so18100935ad.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 20:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753414477; x=1754019277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TGAJHVkDaQILMrgf+9DsRvtoYw89TydpErL2J0/xE4=;
        b=IHtm4bZQVxZ/1bzPeRkdGO186AgErhCLVf8OyfKgfnuGDx5jzm5cu8Lrf7BnsChaI1
         k13x5hzozMmu/nHLBuveQ7MsZ/Ry4L4icrnBRKVotYyz/tnTLmNQoeVANl8Bizvt0WUm
         IychmmRyrZ+xAr2ughys98nwHtbBffKcd7Ev8s5HEDQunogaIwKLxmRD+Kd/PZLhHxWb
         tSw4x7igLLdnhsuPdBeDxtwgJsGQ4l7FwFqj2Z8O26O1fSRRSwiFq4HBWQD0bLaUujTb
         nsMsh4i/L7TmGZTA7MhuqbB8DBhaMpdzAtDpHUDT6pl8FdwAujlKKtIJnSTj/cctnRZc
         k3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdAqBzmcfeCFDwUHRar/eCmjPbMbhOi7vYi8nMPmYGA6RaI3ZXnIfGKtKN1Do9yBM4vI4paAJdmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd4RuPiEwmFGiX7rDtrfniAx7j4Gl9+46iPu4n/KEYqZam9iQZ
	eLGyLS63tK1iBvSho7IMZQcd6gULZzTy0AM/Rp9iw96YTnfVgZfGqzjYkgcWJJblX8oSdr3W/Md
	rUzrmXAXyJOGHmvk3rcKPmPgGhVEJTYzuuDd1uBm2JHRjOvZ7VR2y5+Rukkoe2g==
X-Gm-Gg: ASbGncvfREvArOl4frwB+66hSMTOSOKU/DIZ2zbmNXeBTwjL6Qnh6wqgOyXekfX2Ouc
	K++kHBFReroKL2lUoaiUctL15BzWaa0ELHiF35kibYbP052jQYzqqB/HinNLcM/tk5zqW8aGSGQ
	P1S731+VO6ZuXDqEhkODUiRUGmkp6OEch2ornnsaYlYC+6uhrt019ISJbMkAV9WCEObxpeHHCR/
	GZ4Jrk5tb3Ezo9cZvy1lqAJ2WlMjhwOVxS3qBn8+vEDUyDdF8DuFsCIiHKFaoEg8+pq1lQ0uhdj
	vtaBUVuA1b0EGLlyO2V6caOVNAnzvNoLR+p9X3KLGElPLPplItYw716b14AM3xCvlJngUzbWzFV
	O
X-Received: by 2002:a17:902:db0e:b0:235:c973:ba20 with SMTP id d9443c01a7336-23fb314746cmr6199975ad.49.1753414476853;
        Thu, 24 Jul 2025 20:34:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLeBuELUTdTQTY6HForrjFnof9GXWAfPhpnlGKHjmaYsVexcryNti/gt9bdOpBOUMNUqlyPA==
X-Received: by 2002:a17:902:db0e:b0:235:c973:ba20 with SMTP id d9443c01a7336-23fb314746cmr6199525ad.49.1753414476389;
        Thu, 24 Jul 2025 20:34:36 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.229.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc645sm26342695ad.90.2025.07.24.20.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 20:34:36 -0700 (PDT)
Message-ID: <a096af62-526d-2982-af49-a2ef2f62817d@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 09:04:24 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v12 0/8] Implement vendor resets for PSCI SYSTEM_RESET2
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
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
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        =?UTF-8?Q?Andr=c3=a9_Draszik?=
 <andre.draszik@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
 <beb26682-d2e4-40e6-89ac-87f18c0401d0@broadcom.com>
 <56599da9-0200-72b5-012e-942a1fc954b2@oss.qualcomm.com>
 <a1d3264f-a46a-42c4-b518-a66c8e0b70b4@kernel.org>
 <f4725f3f-1b45-ebd2-aaf4-4f986a44eb8e@oss.qualcomm.com>
 <36f62026-9517-42bd-8f9a-92f39fcdc136@app.fastmail.com>
 <58eb8f0e-a029-cb7f-e63a-9eac6a6444df@oss.qualcomm.com>
 <fd153e95-b06d-47f9-b079-566908c20df2@app.fastmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <fd153e95-b06d-47f9-b079-566908c20df2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OMq_CtD2ZQHW-yek37PUfqseZjfLBQC4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDAyNyBTYWx0ZWRfXxivKrD8YzJm8
 dT2XtSzXj40phlUOAayI4CX6IQChtl5OAmBroq5IYYNXM2TMyh/13JmUF4uZfd12IgWioElvT2s
 FVbn4znFcxMoui+HzWcwmKBrUm6XXROWYDaRP8IntEFSTaljTmcJAi3yOAnZdHXY2zXVsyjneI2
 KbZrEiGwbtGh+G3pDgc9ZEKz/8sC2p5l2q0oEtaxCb5dzKSqG06RAtyRw5TgGxtIrwJxAHgx8CX
 8nRxM6wMD/7j7YikKA98OQ4msgkI/aytytlrQCl3LhQHsjJBqdzpkP4p4f2pWLHYd29MtgEFGwj
 VZBmc5WtVEkFrkOeUnr+OKEFKZ3ZZv6pVnfJaMM2yKi0rtfDJW18QV844hCPyBiIENN3TXuKgml
 cpr0EzB5X7S/uLFYMyoRlYRFCCI9JhRCvc9VNH2HY8LJE0xzUhGTEgwCNYxoeTbMtUfd/0kG
X-Proofpoint-GUID: OMq_CtD2ZQHW-yek37PUfqseZjfLBQC4
X-Authority-Analysis: v=2.4 cv=S8bZwJsP c=1 sm=1 tr=0 ts=6882fb4e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nZGjKI7HY8pVxP4eyoJ54Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=feOGgi2hklxqG8YMet8A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250027



On 7/25/2025 1:44 AM, Arnd Bergmann wrote:
> On Thu, Jul 24, 2025, at 20:21, Shivendra Pratap wrote:
>> On 7/24/2025 8:13 PM, Arnd Bergmann wrote:
>>> On Thu, Jul 24, 2025, at 16:04, Shivendra Pratap wrote:
>>> How about using the reboot driver name as the identifier in sysfs
>>> instead of the compatible string? That would make it independent of
>>> devicetree.
>> In current patch, psci driver registers to reboot-mode using a device-tree
>> node. So reboot-mode does not has a driver name for psci's reboot registration.
>> its like -  reboot_mode_register(reboot, <struct device_node *np>)
>>
>> Now when we want to use the registering reboot driver's name for sysfs,
>> either we- 
>> 1, Pass an explicit name from psci driver(say "psci") while registering
>> to reboot-mode.
>> or
>> 2. Create a virtual device in psci driver with name say "psci" and then
>> register for reboot-mode.
>>
>> which one is preferred? suggestions? 
> 
> I would pick 1, to decouple the namespace from the device and to
> keep it simpler.
Ack. will update the patchset.
> 
>>> I had a related idea to provide some namespacing on the actual
>>> reboot syscall parameter, as we have two (or more) orthogonal
>>> concepts here, when there is more than one reboot driver and
>>> drivers support multiple modes.
>>>
>>> E.g. you could use
>>>
>>>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>>>             LINUX_REBOOT_CMD_RESTART2, "watchdog");
>>>
>>> vs
>>>
>>>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>>>             LINUX_REBOOT_CMD_RESTART2, "psci");
>>>
>>> to pick one of the drivers, or
>>>
>>>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>>>             LINUX_REBOOT_CMD_RESTART2, "bootloader");
>>>
>>>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>>>             LINUX_REBOOT_CMD_RESTART2, "recovery");
>>>
>>> to ask for a reboot from any driver that supports a mode, or
>>> combine the two and ask a specific mode in a specific driver like
>>>
>>>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>>>             LINUX_REBOOT_CMD_RESTART2, "psci:bootloader");
>> This will introduce an additional feature in the reboot-mode driver.
>> If a colon is present in the command like "<driver name>:bootloader",
>> Call the "<driver name>" specific writes only. 
>> We want to add this feature? 
> 
> I think this will require a little more rework in the reboot
> infrastructure, and I did not mean for you to do it now, we
> can always decide to do this as a follow-up, but I brought it
> up because the way we pick the namespace will limit our options
> later.
sure, thanks.
> 
>       Arnd

