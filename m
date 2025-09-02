Return-Path: <linux-pm+bounces-33651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1F4B4069B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 16:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B0C54213D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 14:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E11C3093B6;
	Tue,  2 Sep 2025 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SWE+h9ba"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9FC307ACE
	for <linux-pm@vger.kernel.org>; Tue,  2 Sep 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822875; cv=none; b=NtIw07xj12GpLRR7rjK2LVu9Fw+7b8EJO2v3FKcUSDbYasn7oqQAeERoqSxyS211Ajz9B/rBRanTqKZR3KcWWXMahErhIwnTqtCASflGroJRFykdHrhpyRHm+qo4usxXn/c9vxrpr8Bc8HjsjdcLtksJjncdyfpooUkUZJA5NRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822875; c=relaxed/simple;
	bh=Mo3fvh+zcipnakizUINPMwCYdgGPfGwVYd3T2yXE6PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sM1XrlnnL6VGjbDqaaW8Wy4bgTUqxfrYYj1yQq12NtADEMCuWqLizI/PH/SR68kXnIVjo2IJyBIJW8PFIjdQqNTeU7eiHMjqdmuRk+t+cWsrYeHUxvIFKIiMBBnzDP0KaeYFCyx9yBjA0/GQYrFaKbcmvi0Ac68cnz7YOngWmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SWE+h9ba; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582AxxoE015204
	for <linux-pm@vger.kernel.org>; Tue, 2 Sep 2025 14:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cFH5cDNds5B5T/pje3FPEuPlO2hxs24Eot+U2AM5tl8=; b=SWE+h9baJZPg0zr+
	h1VZBwnEPUP82cZ9ImIy24Jh4zgzo/2qILVaNrT21iAph2NMju2XB3jE5iQxS7uG
	Iwl1soq01wpYlpscMNpjn3haYm3gzIyvm6XWOYT7tfCemR+a7OkbNsCEwJBsCYVj
	gOdLUGnVpCtqtLB/Q4Z5j9NgLmA3R8J/wshkDR2wcPJ2EEMN+7WDwr6ta/UvVMJa
	+4z1oo9rg4lSxeIwSBHqFAk5fJMlsDGwRd5BuNxcy77ZMn4TxnhUw22EDCyS3UvR
	hTdD+MpQOgivxSlhDw6JFyTADU0xanIEsPOSM5PBMWUz02c0xzvKuM3oT7InLn3Z
	1fs5Ng==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw003e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2025 14:21:11 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7724046c346so2699273b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2025 07:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756822869; x=1757427669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFH5cDNds5B5T/pje3FPEuPlO2hxs24Eot+U2AM5tl8=;
        b=NCuPqHRDupOrAu5ryYzXHqH6d2G/i1NH1L7wdCR6vqQUjaOtDFMsZEjcadEFoU5rtJ
         VhA6vfFMNoYHP3N3+X2gnslCqaoVfaI9LMyL+VmN4Tl4gSn+8GYGUAVIKiGKMGBlL1cp
         cdhBuig6pm9+Duy7m558TcNNAlQa3E6ZORPAD+BZR1eLxOLPPMB0oBZEDPSeti8YezVP
         4THS9SCxBOgqzNenI/HDrWCeXXlq6zq67eH1teL6jv0OdMfSrKoa9UtwVoBI6S5erI3n
         cWlNuUHMpLQKYPhXAKSqd+sg3ZpMQdfV3Cg6wKCVefsQlEvFY0+tuJSn1EehQ0bc2b18
         km6A==
X-Forwarded-Encrypted: i=1; AJvYcCXHsliXVwDBAJsyGfAXP1RMXAeUE25ulZEvmrQWrH1KP9in6ilrggEQ3qr53E72gNa6suhGJ77oSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx41sNBvEAq7Q1jKIz9xz0E3Gz7RLKa4aED8mAGO3B+8ew574Bi
	UZDvc7VTGpo19YH4QDrdzS4URjprc1Jglcgl4OHGys7mBQmI1nAmDDdWCBp3kfYcJlqIzS0Cq6V
	tCE4r0E+Bp9en5ZzeJU1G2RY7zdBmX/Am114BmYYGKF3tjNFPydSUjIE20F0nlA==
X-Gm-Gg: ASbGnctF4hou7OwIS8inRPS+M7oPeQ2wg/r+R8GQeLjfinJsswRkTJbRM5MwGhCbFUo
	iZMRXcDm5Zv8kOwm2pnG0DtfGmwBE+ANl6E7zXU/9HwHNXpPaDNk06dauXNexEo3bPh6AsO8UAU
	xI1/0WsG7FHQjKeTzrnkVpyF5H2birSt04C8jwIU2DoQiPL6ml+7IsgcdAqKNSqunMXGID3Ne9x
	HUDIGxtRRIuMok9PNU0TwIHSgqcjAzW+xiQksS+nDquAj+H30jQGxqvpJIurTQgyQHo9rgPS3PU
	LqL7So6QJMglStFTKOinN3YyS/Vu0Ksz5FyVhzbr6sdEXaf9ajPCNkUJvGji7yqIl1zzxmNk
X-Received: by 2002:a05:6a20:3949:b0:243:25b0:2321 with SMTP id adf61e73a8af0-243d6f7e6d2mr17559825637.52.1756822869354;
        Tue, 02 Sep 2025 07:21:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqXouN6x5NC3Ff1ESu4awUlD3wgjdZZfk9g/KwRyDmJBn/xJVqTV3xHk+1W13vbBTuHhuaMw==
X-Received: by 2002:a05:6a20:3949:b0:243:25b0:2321 with SMTP id adf61e73a8af0-243d6f7e6d2mr17559757637.52.1756822868877;
        Tue, 02 Sep 2025 07:21:08 -0700 (PDT)
Received: from [10.216.7.97] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2dbcsm11499176b3a.50.2025.09.02.07.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 07:21:08 -0700 (PDT)
Message-ID: <f7394b06-d51a-cdbc-7990-13209b478398@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 19:50:58 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v14 03/10] power: reset: reboot-mode: Add support for 64
 bit magic
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
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
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
 <20250815-arm-psci-system_reset2-vendor-reboots-v14-3-37d29f59ac9a@oss.qualcomm.com>
 <88ee0a26-8d64-4060-b703-40156cd011a7@linaro.org>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <88ee0a26-8d64-4060-b703-40156cd011a7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eG5x0JJRsGLZRGOymqa7XxTmKtgDXCWA
X-Proofpoint-ORIG-GUID: eG5x0JJRsGLZRGOymqa7XxTmKtgDXCWA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX7Tbc8nplL733
 KmdLm+I6uH2p+ikGcDFb6iNbkdxN7gK0emkOL1yLBLRH2dkL3PxW3thKpAXrDYlqRh99n//tOEY
 4XpfHjEeKcdyCJcmP3Gtoi1yeuDxKxkfcr2oIyfBD3XPj/5jPZHiWWAsa+9OnESgP5iQSq34ND7
 ptD82aqHnVPDSr3IZWSSzOWneTeA+EgUJ+k4iRUDhXH+otn5/pFaMhqmwmhIPwnxsqkCAR0x2sM
 t/BRrygordu1tbSl4SFC9yPedC2X6osh36UOWaDfWpXcbgVRLVOQaaXgBHSZ1KJLjHZ7G8XISoy
 LAdk3YabiD+nsDt0HTB6PVxNNh5dJSmGmzYj5JtkV5mz6H56IfyRp1YGB8VCSi71zMHdAN1zwej
 qLpFyS4V
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b6fd57 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=FBzynz1gJkPyhc2EhIcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027



On 8/28/2025 6:52 PM, Casey Connolly wrote:
> Hi Shivendra,
> 
> On 15/08/2025 16:35, Shivendra Pratap wrote:
>> Current reboot-mode supports a single 32-bit argument for any
>> supported mode. Some reboot-mode based drivers may require
>> passing two independent 32-bit arguments during a reboot
>> sequence, for uses-cases, where a mode requires an additional
>> argument. Such drivers may not be able to use the reboot-mode
>> driver. For example, ARM PSCI vendor-specific resets, need two
>> arguments for its operation – reset_type and cookie, to complete
>> the reset operation. If a driver wants to implement this
>> firmware-based reset, it cannot use reboot-mode framework.
>>
>> Introduce 64-bit magic values in reboot-mode driver to
>> accommodate dual 32-bit arguments when specified via device tree.
>> In cases, where no second argument is passed from device tree,
>> keep the upper 32-bit of magic un-changed(0) to maintain backward
>> compatibility.
> 
> How about adding a n_magic_args property to struct reboot_mode_driver?
> Then in struct mode_info change magic to be a u32 array of a fixed
> length (currently two in-keeping with the DT bindings).

Arnd/Rob,

As per previous discussion on patch v10, magic and cookie were implemented
as a 64 bit number (64 bit magic).

Need you thoughts that if we should change the magic to 32bit array, as being
suggested in the above comments.

thanks,
Shivendra

