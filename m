Return-Path: <linux-pm+bounces-37610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E449C3F470
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 10:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14492343934
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 09:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0A62C1580;
	Fri,  7 Nov 2025 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JlvjTBkr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NPrRT8Pt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00682D2497
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509338; cv=none; b=ESjJXvagDIiczKpFfugZWs9gCsLFgFrpnK6dTg8KhgHjM5NDlSuIm/Wqrh9zAedlRBKzVrndMjdZaWau4krpXFJxxwPUuHuZ+F7pAZ+a3iyiRt0XkUiH7/oHDyb5LRkdA+kH0oW8joSW5yBKGNtLuGHg6asP4u9LHm+U10uXxGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509338; c=relaxed/simple;
	bh=AA4GvAUxG5NmI5Ah/Q03bqp8XQ+LpmzDglQJlTKGmx0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=N5mhvMPZvAzczp88KC80Hlh0TAV3KLvFcQxeBNtfX30f8FQ6Z1EkqBdrKwnVV3mWyDaPlt1Z34QjDKRp1pm2AgbIEPB8hyBQy/nIdBj+3p9MMq6Zu1uIjft8UylOrP2yeo92mn3nd4HztSYJQZZnLlTMeTQc6MBn73ioNvmCPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JlvjTBkr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NPrRT8Pt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A74kf16584022
	for <linux-pm@vger.kernel.org>; Fri, 7 Nov 2025 09:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=C1UlincikuK9zot9j7llv9
	oNhy3LkT99kGDQ+bZ0yK8=; b=JlvjTBkryFSb6YbPrum/xqByG7GLgXfrgWoJOq
	zpZCkOG4fZAAWwSUVXGHTfj37hXRmRBqNN2HbTJQLQZMBofF8p85Lr8dWqJZQeeA
	Katq2yKQSuP6bOEGHXlYrPi20C+Ajf4ikeSIHQprzR+HO2NmR2d3It+73sPzu9Oi
	nGCSzQNjrV8yh4WNqIwtSvNtxKlLpaIWpm5izQPvdhR949STNNZQg9QPBoIBwPAo
	DKHIvU9n8fw9aACpGqJKqLjXB53apaEvURLiRmxUGiHZR95ATQ4+zAT32/HzpB2j
	TKouEn46FOuoptapENae1pxdEXO9+0HrQhWL9MQGhf7bFCfA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8yktjmkj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 09:55:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3418ada9e6cso806562a91.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 01:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762509335; x=1763114135; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1UlincikuK9zot9j7llv9oNhy3LkT99kGDQ+bZ0yK8=;
        b=NPrRT8PtfqTYcc1Irl6QBdyCcadTCs5g3Hav76sFkmhZqfaMgmFmgcAEERRZFifoeB
         bSwzqNn3B1hO4O/zdwsop1qwRmdlOePcwD+dj0H+OAS6liswIaCLhmA8WrqAzicDd7wu
         AOit0sPvdcRsN4uxebovSFhHVqcJjNoM3CFHwdPc3uP1jfQKp3UTORY5BCWFZYp5Ou8a
         ZJzWWboReDUdLML/anodXTSZeUNj697NVy+Oxm/zRdA5OkBCKQ2XJSq7CCn9zNz1B7Gf
         NUqkwr5fUO5J/EtedDuZzrRnpsyCCjr12/5KwNVo5DPiiLihZi2/MRZstY3mUFpw2SOK
         44Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762509335; x=1763114135;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1UlincikuK9zot9j7llv9oNhy3LkT99kGDQ+bZ0yK8=;
        b=QV5fC61DvzoE2+Ez5zLMqjpgCbCqyywg58gYcZdjvulxJOpuPhsHSWeT/crPmm0Hpq
         8oUhzcfo5jXSX4bB2CeTwjA7GEaXk/56kZciPJcjTaoj8pa+kD4jEI3ayZkli5+Bgkbs
         DQuPHTglOZOYDnLOP4DbpmU9Ob6eR1cg9rGAQ7BQZbtaffoK3PgrgV+uaWEoGxPj5Y9L
         JYlfWdgowVZLlbadSKgRr0dA4kZrY9MdkKh+dAu5+ZDAN5XJUtxOmELOYRMbW5RxcgHB
         Pd+fqsmPYLvV8qwr3AywpHx7yyeWe3ao+0PYMRjIp+xYvEFwyAWYBNVSQNCXiYXGfilK
         9Lvw==
X-Gm-Message-State: AOJu0Ywxgd7Kpe9JcrTN/ebwglFHoqwxL4n7uFhcewRz/OOafMkEXlqD
	nix9RnZ3eLMaE/TckHP+605lNe0rblFykvNjOxwUfqSHLqjJXmtgBYn0DdMTuZRZm6/INjMdEWt
	NaI2nIrP85NWecnq1iDxIWOsyy+BCRp5EFse6s1j11aIVia+nSmofdjqqEtMsoQ==
X-Gm-Gg: ASbGnctWHi4aGJYd/HOt2lHAZLAhuuy+4H3Xg1ZYbdk2HcfghxXgkFSwRjoKSJaXMXu
	QXUzdiIaBOT2TXLD6skn/D/qYKIJOMmh/92vVAC3tpENl3SCy3duIqaczK2LPrujzyGz7l6Ogs/
	B6usVRDR+EwuRqcWrifcB+yNrR9x5nk+jUh7j6kztPSBomxDXD8zNRlpL/rtCg+SxIajYU7YAMz
	oXeO1T/6avu14QO71FvX7H3DoCe+DWGODhvwGOsvV1PZZ7Ku3qkErU300AUzTDQuUBYxgsoKrSg
	Gil5LQLQ05ymNSwWaBOqGgqkYncKY1eskvNLsmZczL3CjuGB+uKhgNNOEv68gvk8sL6v6DDCYR4
	ry6KArElXmFRfBZeUV7lx5Hxso8lCM14=
X-Received: by 2002:a17:90b:4c03:b0:340:d1b5:bfda with SMTP id 98e67ed59e1d1-3434c4dc527mr2872318a91.3.1762509335359;
        Fri, 07 Nov 2025 01:55:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPgao8WCT219+Rl6ZeGkPUmiLBfMV+4DJHZlRaTl4PgtufgzbryrZdxx19c0zqo88eKEDKBA==
X-Received: by 2002:a17:90b:4c03:b0:340:d1b5:bfda with SMTP id 98e67ed59e1d1-3434c4dc527mr2872294a91.3.1762509334801;
        Fri, 07 Nov 2025 01:55:34 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c300173sm2119631a91.4.2025.11.07.01.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 01:55:34 -0800 (PST)
Message-ID: <8e542a9d-132d-45c3-b17f-1dcea4bdf337@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 15:25:30 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: vireshk@kernel.org, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-pm@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
        ulf.hansson@linaro.org
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Queries on required-opps on calling dev_pm_opp_set_opp()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bOgb4f+Z c=1 sm=1 tr=0 ts=690dc218 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8
 a=z55VWBr64nYxIy90qn4A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: mDhYmMuRF08xgBrmIRsorw4iQTrRRN7V
X-Proofpoint-GUID: mDhYmMuRF08xgBrmIRsorw4iQTrRRN7V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA3OSBTYWx0ZWRfX1mCVlqfhKsRx
 DL4i4KlUZW943/XJY7GR76Zs2Wqge1/QACYmT4M3iNqjjO8NVxTQz2t+qo1ByigbSJvBgvjc2Vb
 89u3VkvBi++c16qNuWGM+cY/yobZllaypXRKL3rLXx+Ff6Ka2vsa+gI/mKSKGhemD2GSAJbW4Mg
 lO4F6GQzlUhCTX+kmVfBL6QAlx610Gt6I0+/mP3gWhCidESq7+o2tYDM/vkTaIwOltMTk8SI/Pp
 kknXdDqr82XXHg/600Xozubi3ZvSOBUsyJk8WoEvivK+yMB7R5AK7N40ijiKVaOY+xSnQWW3wTn
 Y00cRM5icsdHft2Z6+va80S0khXjmhrY5TrvpUeRwPY8j9OELbSxN0Her/Iwt6LCNEZnuPsDDo5
 +Cs8Wt8HjhC+KB0rmgg3lVsXdqIvfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070079

Hi Viresh,

As you are aware that we had OPP enabled for PCIe[1].
We plan to introduce a OPP table for phy node also where we want to 
change the frequency of the clock based on
PCIe data rate it operates. we planned to have the reference of OPP 
table of phy in the controller node so that
when ever controller node sets a opp then corresponding phy opp also 
will get set.

But currently we see calling dev_pm_opp_set_opp() for required opps is 
removed with this patch[2]

Can you tell us if it is ok to call dev_pm_opp_set_opp() for required 
opps if level is OPP_LEVEL_UNSET
or is there a way to know that opp is for PM domain (maybe 
dev->pm_domain)? if know that we can call dev_pm_opp_set_opp() for 
remaining devs.

[1] sm8450.dtsi - arch/arm64/boot/dts/qcom/sm8450.dtsi - Linux source 
code v6.18-rc4 - Bootlin Elixir Cross Referencer
<https://elixir.bootlin.com/linux/v6.18-rc4/source/arch/arm64/boot/dts/qcom/sm8450.dtsi#L2047>[2] 
OPP: Fix support for required OPPs for multiple PM domains - 
kernel/git/torvalds/linux.git - Linux kernel source tree 
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9ec87c5957ea9bf68d36f5e098605b585b2571e4>

- Krishna Chaitanya.


