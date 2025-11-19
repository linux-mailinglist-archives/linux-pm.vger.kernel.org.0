Return-Path: <linux-pm+bounces-38216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8721AC6E5DD
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 13:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05795380EDE
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 12:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2234E743;
	Wed, 19 Nov 2025 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qqqv2tTv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DylH5T1o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16932325724
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763553777; cv=none; b=hEhXRg/4/ipEKfOZh2Xta0ehGZH1ljhJsrtm3JKb6ivcJOVLThEDKz7TkmScY9aLZA4y9bkFwiev8GBFpK8xpC6+uoADSHV9by/PuFE0ZKNM4Yqh0R9lmW+X3TIMt2pIt2E0hiMmeIk/pejq/urYJoLSNPVrow2KQHwo+K+UxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763553777; c=relaxed/simple;
	bh=JHhdnwMtP4xdq2SpFsW6LkDjsL7vF6RBdqpnmVXkz8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUo+SWypZcYQDoM+exwbo0/PHI1ci8iuh6osCqN2usqHIxgxpjLmGKLqvpH22qvyTKJKqxBMeYxU51VGevLH8fn+p5YN2LRxwq53G9xngAZK1YnSqIJbhW2Houn7lVqYyXqJUG1aCmSK9lseZXZVQbgrEJ/lPCf/jD+w3EKYyUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qqqv2tTv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DylH5T1o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ7OWwK971354
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 12:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TjIW02mFO0A6VGZGfOH2io2QOGdWVsO8GYlNGpyrH5c=; b=Qqqv2tTv/DtFrkg3
	1YpcLnS8VMCN8V/UcMglE+p8moZrX9vEd5DvTkVNSHSgNGkIy1dk3F9k4sG4bIu9
	GapzFJeZ9oF6pxuP7Lum3Gd0hdhjMt8zDdP+L3tujq2VCxyxlKe5ykdW/cr8+OYd
	MDNLb4k8v8FGjuR+mCtF9NP3VC/5vWH0GVa9Bh+8ncrSLy3q665pWykZy7/Jx6/S
	+fmHhF/BPoO4SuUpPj6Y2jXGt4Uy1wHerKSo+x7NO80iGRhHKLXTWzwJe1HHXprj
	IvmE/fT2IuU+EO6bgl9jvZBknD6zMaQK+BETBFYBur+5jzYC6VyjrAq8Iw7WXTfa
	HHuk6A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah9fu8u95-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 12:02:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7bf15b82042so5305707b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 04:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763553774; x=1764158574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TjIW02mFO0A6VGZGfOH2io2QOGdWVsO8GYlNGpyrH5c=;
        b=DylH5T1opt2K9RtQYwL9jNbMaiMy6DC6gO9b7uWoHDz3OCY7gK8NmXP+17EAnosevs
         nJR6ZAZCogWk0cOo4avGxNlHr6t01Ddakod5S9EEFlwYtGGDgrrbNgpwH8v1cIUkBdgM
         irh7GU+/V7SLvXPYfyNOqGFTWdBXntQNRzOjbSw/UgaEAVXt+r0KFk7/dUfPinwd3jTX
         r0HI6WKRFd2nmls0PgdcKik3KDyPdWGCQ6raiNN2uvSL02j2dD0BEA/a5CQeYx+5yzZy
         prO6AnNUJslW509YrniHnSxwewqIA6/7XJccKCKQD4r3z6YSzeTmHLPQrkbetzlt6OFw
         YIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763553774; x=1764158574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjIW02mFO0A6VGZGfOH2io2QOGdWVsO8GYlNGpyrH5c=;
        b=Os5Ry4wers/OWRZchyo4ZA/Wh752TyIsR8s6Y9RhB4bvGUIR5y2080gM7K3eX6F8xk
         pCBDv6LZnYUIgHRqYnEyF4NQr6DqZ6eUDHdsowe11Y1D915Mwb82PL2dbeHX8DZvuq3j
         Yk4SCUUhbm+CH2+otZl5b5INH/xNmgjO0Aja9nA4y4SXWKTJ/TciZdLMSDmYhKAcPRpc
         mZbvxFy+ZWyeCKSlWes8I0Yswe0FR8xukQ4RARrqwgNLyEKGBf5pKGNa+BIso1ZtZIRf
         ZgsSjFctUocB83YKWdbBpQWPJA4lzqcTH2+BJ/eefO7XOepQ7MMqLSK1lmjdFHoUnk0q
         FUtg==
X-Forwarded-Encrypted: i=1; AJvYcCWh7xsRGiHvPucKVXTjwh2jeTvMvD41aQlipdpWmCYSCooNpJYpEeACjGSiGnkoBY9krdhe+XDrLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmwm0EAOKDPuJ34ue0z02wXIyrbzkVJh7FxoHUOiD03svY2a5x
	4TEaMXPyqrnvNCWxo3tINGxQa/uCmjaInX3t+8/QFIfPkX6N4jgneN6eSBeG2XBGleViFXCkHcu
	PUFdw/+x4+nIZZqwwm93I80mEgfPeOC6fKRvcIJoDm7O5IgR+27yy/vuyl4KgSA==
X-Gm-Gg: ASbGncvrXw2S7Ltd8G0L70guXqRj/m9PfMcw29jVMkkVgyoaEQanCIRjNm+PseAYXHO
	yngz26uScxLg/J9zth1HOTcOpDmhReqzvgb/wJXXfYvHSwdb6UGKvQAgLIhT7++V40pLKPftQ8z
	50Jqqk3V+Y8K+3PiiTIGxirsg1t+F4VZs/POw5mwsg7eoYbiyezMa1U91aIsuoBY++wwlDDJ1w7
	cKHcI0KXf1Ns64HcXeqLFTEedddnBcLKPl6VGrsqYKWO266rcTv6JNrS4iwOngVUGwYaYc5Su82
	HwXqQymrCqjj+kX5T3s/ai9JEScnBlkcIDVR58p08fwDNkBi8HcuZ/IINRUXJklgs/9ilLVsVfs
	7XOHREuZcN5WCL5XKWY9Uzwrvi5zHsaYWIsmiIX6WfQ4=
X-Received: by 2002:a05:6a20:734a:b0:35f:aa1b:bc00 with SMTP id adf61e73a8af0-3612f31b05bmr2773375637.59.1763553774405;
        Wed, 19 Nov 2025 04:02:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNbO4ggiX+mrclow8f9c4D5FHCa9+vVlDZ9B1otcOfIurjoU+/vUjVkaZn/JfwG7EJs2K2WQ==
X-Received: by 2002:a05:6a20:734a:b0:35f:aa1b:bc00 with SMTP id adf61e73a8af0-3612f31b05bmr2773313637.59.1763553773847;
        Wed, 19 Nov 2025 04:02:53 -0800 (PST)
Received: from [10.219.57.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37517864asm17995503a12.17.2025.11.19.04.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 04:02:53 -0800 (PST)
Message-ID: <682b1a0c-644f-2aff-1860-cbf9a53bc62b@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 17:32:42 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v17 07/12] firmware: psci: Implement vendor-specific
 resets as reboot-mode
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-7-46e085bca4cc@oss.qualcomm.com>
 <aRIfc9iuC2b9DqI+@lpieralisi>
 <80e68e44-a8e0-464a-056e-9f087ad40d51@oss.qualcomm.com>
 <aRxmWrAkD0Vu4pF+@lpieralisi>
 <1da024e7-efb1-3a1c-cc13-0ae5212ed8bd@oss.qualcomm.com>
 <aR2P4CxQNebac6oU@lpieralisi>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <aR2P4CxQNebac6oU@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA5NSBTYWx0ZWRfXwJrNwsmYMUKQ
 nAwcEC17vj+QK+wfaTQf711+iYvbW0WUcf50ti3OJ7gNsPeWh+HqVSIRX0aNWacfB6z0QTCTQD4
 qvZAtpXeI5Eo6ATfDWW0podgIJkMxRn7A7pwyXk3Ing6j5hngFh/+FZfjbSXs5e4PSmuNLiE/kI
 fQYtMJXWePt85dTNjrp0ncGNv0AM9hFZOqoWDwKwbkmq3Wemr02N/NGzGa3XA/HOD8k5L0qwRVs
 8ygP/16uIKILqBTkw/rrRv/x+RZbIl9kyU3+AsUpjN5ma7Gmdd8NxjyGSJi7C1vnN1x8LY1h/fl
 v6rLBGOXa+TU2S1AEp9lNgASIrZkuPaFtBK8RNjirk1eYkJIWIC/HTVKEEKWX/X9XMEQ0rEczxm
 aMnSDZL2koEAORCE1jvhoQKYIMuk9w==
X-Authority-Analysis: v=2.4 cv=KZTfcAYD c=1 sm=1 tr=0 ts=691db1ef cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ZSC80-7iYZ4hBk_6gz0A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: oWdCsIrx4BnR8Ll1TcoLykdC7h3lUpYS
X-Proofpoint-GUID: oWdCsIrx4BnR8Ll1TcoLykdC7h3lUpYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190095



On 11/19/2025 3:07 PM, Lorenzo Pieralisi wrote:
> On Tue, Nov 18, 2025 at 11:11:33PM +0530, Shivendra Pratap wrote:
> 
> [...]
> 
>>> Yes this could be a potential way forward but that's decoupled from the
>>> options below. If we take this route PSCI maintainers should be added
>>> as maintainers for this reboot mode driver.
>>
>> you mean the new psci_reset driver? yes. Maintainer would be PSCI maintainer,
>> if we create a new  psci_reset reboot mode driver.
> 
> Yes.
> 
>>>> - struct with pre-built psci reset_types - (warm, soft, cold). Currently
>>>>   only two modes supported, anything other than warm/soft defaults to cold.
>>>> - vendor resets to be added as per vendor choice, inside psci device tree(SOC specific).
>>>> - psci_reset registers with reboot-mode for registering  vendor resets. Here, we
>>>>   have a problem, the pre-built psci reset_types - (warm, soft, cold) cannot be added via
>>>>   reboot-mode framework.
>>>
>>> Why ?
>>
>> If we want the new psci_reset to take the reboot-mode framework route, is it ok to
>> add default modes (warm, cold) in the device tree?
>> If not, then the design of reboot-mode framework(power:reset:reboot-mode.c) needs to be
>> further changed to equip this new feature. 
> 
> Well, yes, all it needs to do is allowing prepopulated reboot modes on top
> of which DT based ones are added.

The mode-cold , adds a third variable to reboot-modes as the first parameter for 
invoke_psci_fn is different for cold vs warm/vendor.

cold reset call       : invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
vendor/warm reset call: invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), vendor, cookiee, 0);

Each mode will have 3 argument - like:
_ _ _ _ _ _ _ _ _ _ _ _ _  _ _ _ _ _ _ 
MODE   , cold reset, reset_type, cookie
_ _ _ _ _ _ _ _ _ _ _ _ _  _ _ _ _ _ _ - 
COLD   ,   1       ,    0      ,     0
WARM   ,   0       ,    0      ,     0
vendor1,   0       ,0x80000000 ,     1
vendor2,   0       ,0x80000010 ,     0

So reboot-mode framework will now define and support upto three 32 bit arguments for each mode?

thanks,
Shivendra

