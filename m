Return-Path: <linux-pm+bounces-31394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB787B110C5
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 20:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A55A3A92A6
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2241C2ECE8A;
	Thu, 24 Jul 2025 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n61+6JW9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720C52EBBAC
	for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381299; cv=none; b=eOT4OiLPFJL1ErDr23k6rfJwTEJwnevksZejqjKYUKu2c3vUsTb8Sz/M1iTxuCOReYN2TfvaqhqpUCldw8/abijTFrHJPPfG/i58srGtvPvu43IagrPBLcbzPNQQfqFB/Dzg38GHBuBicntyXVnG7reCxOGBwrz6695epBz1NGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381299; c=relaxed/simple;
	bh=P86RZxhcq4luBoxFp9K2glu21mVN0rpUAcG12WeywIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlQ5owyKdthsetcV9wuMYZhAA2yxeK+VEWtm3ppOZBeV3Qv0pEIZ/OoWiOQprtxHuJM1GfDZqmtWSR62jngmkikX0ax7NKX5JQoMCR1z1DafdWMDMd1AvSMWDOXh9DiXn+aIqn6xpaV8Zz6J4e0Y2ySKkia55FQP+QKDUShvTqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n61+6JW9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9e2mg006593
	for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 18:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	myhiipaB/wUQijkyOLcZiWvOTEGJM1xVMQUaHld2irI=; b=n61+6JW9drxJ9pZk
	mpHo1EtIQ54t5WHCJo5diIH0sfmKMIWNMl41XGSJatRpsPVdOWEg0FafriPhEcdG
	lHULAguO3Ek6P9J/OES3MH//8IZbbCD8oL/6Mq6L5bT6udmeW56Q4HO7U+CStDLj
	BWi3Nboqc269o2k7EGPuB3gP7QQ+W3uDNIH8XjfQXZ8cJrVL/qZieu0pBAhtg3oz
	Pr/h4FFYm9sei22HZ6/SQwOmY9SH8EArdvycm3uBQ6cmLCHxw7cMTaEXStUoy7Z8
	7voQuGnAcKoae86ATFRS9yvk4uHQOdd6by6RLw7RKvrv/4wcIyjU5mWso/CKlc/9
	NyQO7g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qhqfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 18:21:36 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748fd21468cso1241362b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2025 11:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753381295; x=1753986095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myhiipaB/wUQijkyOLcZiWvOTEGJM1xVMQUaHld2irI=;
        b=a6BG/lq6A1+cjft00OwAJZ4giTnrMw/7dAWsnwXy4pKYibRKkpYesc+/7ITtzpzBtT
         a3+j7o8I4vYjcZSXOnRQuNlOht9EvNIzJHmr72gg+nf9ZynJMzOSnj5a9/+HxMTNKNzP
         5LigDpx8pf+22CxEWhQKbzTCm/c+4mXWqpU/N6zThFh8sOBljRK++/+HCi0NT5rU+8vy
         FTMgoe4Mk5UlfvhGbuUC7kPyMXqGwWvLskAa8xtzipOnNWHUAuVCx7nb8mzw3YqxyNH7
         tokIXZF4vXdASLzVmooiz3xZ8Exo9hEBnjE9nlnos9qfoMeAMT2X5Cb/onEfeRhPf1gJ
         C0wA==
X-Forwarded-Encrypted: i=1; AJvYcCVNG+ORMn7r28vlXRspCujohY7Wmgmk+MQNk2g94mnbtwahsJf7c9dJkahb0EvYEXvsB2P5//aeRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZSwSzInebQ6GjkjW78M33E1BTnqKOKR1F90OUbJzJQY7QoAvF
	WGYpH2u26oInkRr/3jhtSamcBbWJsfLTRZSPJ7MQd+hmtjMhdySr0Ve6oo3KvMGMBeN2mMBTK2m
	HjdSu9XqP1562FkXVvHoPNFlyQN1o6DKL0F3ip/+iIsEQaBw3Pw7QIqLu7xloiw==
X-Gm-Gg: ASbGncsHwAIHO/NAfBt9vKR104StIhNT6dZQKxfaPicxS69NAkI48TtdfjSF2Mdln64
	loO0/pHh29oIG0Db4whElYD2akiP4oIxWFlF0qYU2npy7p/7uOE/VGDRESquELe41kkw2BgN4AN
	3KKMdSOzgmZnNbW6fX9u3arOYiUAXm6KLJhpf4iWFwtC8B6f8CoHKFDK7/YRof/nlvV1Z5UDvUW
	0hisVWK1NxL4Z+FG5Ois4qGMECE2qIep7RMcI/oqVDr8rjSB9zT6Yt/pC/qqv+WWBrets9zXjqX
	d7LjxA15ailmEa4Rl/uChMjcAiy1SpIqf0Tqcc5rwPSSeMfA2s6TGrOV55j+WBePuRTlkIW9Ga2
	i
X-Received: by 2002:a05:6a00:2e16:b0:74d:247f:faf1 with SMTP id d2e1a72fcca58-76034c566cfmr10997087b3a.6.1753381294716;
        Thu, 24 Jul 2025 11:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8aaK+IvK/ni16DihbKGYP8ABP6VWfHjhJIfPMM3TuuE2gI7iQAOgMEB1kec1nuMpOExdHcg==
X-Received: by 2002:a05:6a00:2e16:b0:74d:247f:faf1 with SMTP id d2e1a72fcca58-76034c566cfmr10997035b3a.6.1753381294245;
        Thu, 24 Jul 2025 11:21:34 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.231.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761adc70302sm2162883b3a.27.2025.07.24.11.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 11:21:33 -0700 (PDT)
Message-ID: <58eb8f0e-a029-cb7f-e63a-9eac6a6444df@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 23:51:23 +0530
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
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <36f62026-9517-42bd-8f9a-92f39fcdc136@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDE0MCBTYWx0ZWRfX1StAqyNDPw12
 /k/auFC2X7b340PEo6/7arzJY5ORqrUHOBWWxr3xONocWPuFiQNspyPiNLSK4XwOZbBP82RNzEi
 wZjWnHLG1z7pwipN9V2d4WNNxJqtWUnJ709r9aqJwSlw+LgbJYkc9QFmcJ22qsqSJyAPZwrlEPE
 akbIUS9Jk0l5bkBmAaVOQRX0PE4/ZPd8JOwp/Q3S1Srx1V7zcoCDbmbebx8TzUBi/uvI3RWeL5z
 M6nPFL0f2SIYnM1X5wv4+8mBAmoXIPIp0Eb2IxctloGzyeg3m7UicS8x2FTfvwjUmMPtuWZ7dVj
 4a5K2AA6bOY8/iRK1RMa69xdk8p2ZYCWxy2OdfEh9N47iWWMNoxRIjR/PRTYDJhN8exr2B0Z2tR
 1tMXl5NZZ1pddJ0fUONXkF3CiepdAhOCWOAZWNAQMoB85HRivi3N0mkNFHSerAN4m50h1tUo
X-Proofpoint-ORIG-GUID: tEgCHYMpCmqZUSrCN0QGIxgEuGBApj_h
X-Proofpoint-GUID: tEgCHYMpCmqZUSrCN0QGIxgEuGBApj_h
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=688279b0 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=EAZcAn6cL6OfK3FglxxoPA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=YF7pu-sQtpgReH5imSgA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240140



On 7/24/2025 8:13 PM, Arnd Bergmann wrote:
> On Thu, Jul 24, 2025, at 16:04, Shivendra Pratap wrote:
>> On 7/24/2025 6:18 PM, Krzysztof Kozlowski wrote:
>>> On 24/07/2025 14:24, Shivendra Pratap wrote:
> 
>>> I strongly insist using compatible as way to find your device, not node
>>> names.
>> It will look better to switch to compatible. Will define a compatible for
>> psci reboot-mode binding and align the patch to use the compatible for sysfs.
>> Current patch defines reboot-mode as a property to psci, hope its fine to
>> define a compatible for this property like "psci-vendor-reset" or
>> "psci-reboot-modes"?
>>
> 
> How about using the reboot driver name as the identifier in sysfs
> instead of the compatible string? That would make it independent of
> devicetree.
In current patch, psci driver registers to reboot-mode using a device-tree
node. So reboot-mode does not has a driver name for psci's reboot registration.
its like -  reboot_mode_register(reboot, <struct device_node *np>)

Now when we want to use the registering reboot driver's name for sysfs,
either we- 
1, Pass an explicit name from psci driver(say "psci") while registering
to reboot-mode.
or
2. Create a virtual device in psci driver with name say "psci" and then
register for reboot-mode.

which one is preferred? suggestions? 

> 
> I had a related idea to provide some namespacing on the actual
> reboot syscall parameter, as we have two (or more) orthogonal
> concepts here, when there is more than one reboot driver and
> drivers support multiple modes.
> 
> E.g. you could use
> 
>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>             LINUX_REBOOT_CMD_RESTART2, "watchdog");
> 
> vs
> 
>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>             LINUX_REBOOT_CMD_RESTART2, "psci");
> 
> to pick one of the drivers, or
> 
>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>             LINUX_REBOOT_CMD_RESTART2, "bootloader");
> 
>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>             LINUX_REBOOT_CMD_RESTART2, "recovery");
> 
> to ask for a reboot from any driver that supports a mode, or
> combine the two and ask a specific mode in a specific driver like
> 
>     syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 
>             LINUX_REBOOT_CMD_RESTART2, "psci:bootloader");
This will introduce an additional feature in the reboot-mode driver.
If a colon is present in the command like "<driver name>:bootloader",
Call the "<driver name>" specific writes only. 
We want to add this feature? 
> 
>    Arnd

