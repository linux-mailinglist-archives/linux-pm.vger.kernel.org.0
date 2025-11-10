Return-Path: <linux-pm+bounces-37756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3198EC486ED
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 18:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF7864E5686
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241DF2E6CC9;
	Mon, 10 Nov 2025 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SushDV2z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fe2TTn7C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8904E2E62CF
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797177; cv=none; b=bIhdLHCHZXHjz2Yc+kZdedio7VIyffwm1WGmSmw/jIAmv/2Poy8W7pmjdOp6cFhdzDJOcoynOq4J2W/0HiBcX/BoOLfTNGNNtuLUCHn0tiX3uafjpmvTafY63ZU6G/VWkKisvF5ahFoaHcp5O1EWGXmS8kLNroQPP7y46SNpbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797177; c=relaxed/simple;
	bh=8j7tUqcQC0NOALl7nuGaoJBSLbWsnB+qj64xTFUZLIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/6xhl4Q62t9uxxgzD7r5RMUxir9WaE2CfggvdpbJKqjSsW35UYzBvh4ksvMF8+korEUqVenrULaZxqSTCBYjO/Vf7gdH3UVSHX9llMIUsYp1DYWimVG6/Tg2+UpE3yedDDDell5g2zimYlDT/mxq6Rdo+3+/8GUQ+WKfBA6Lwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SushDV2z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fe2TTn7C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAFQ9MS4071538
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 17:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AgMBChGiCDCek3D0eI0cnkwInN+pZ/u+vK64wiBFkcU=; b=SushDV2znLtqfXqb
	nh+ugkN5DYK2Eg8W15KefcagK5QpMf/eMu1PqttnHV1IeA6eZ2TJwsbLXrmCKc8V
	y7RxVXiSfJVwL6QiIrAXb9ytKh6ENdoXsS4eTlBh8317+Jum/KwJ3aiud2byu/ZL
	yDGyWsvbaMhtOH7zkERIumC4kIwH9D6R4gjpFjWOGsboWEMOA+tCh9iUOw9sI1hc
	FFHkJyhoCB2huBf1WGc16OXmaiSw7A3QRDDv7q+D63smMzOHxR3UmhYhq6j6Nwke
	DxUHi8jK7NgGPyNT2rmHjhFodZpMTd4bBfOXHqwwDLNAD4Q2wnwA7yrhxa2Fcfny
	p1BuXA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abjpgrgsk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 17:52:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-343823be748so1998643a91.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 09:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762797173; x=1763401973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgMBChGiCDCek3D0eI0cnkwInN+pZ/u+vK64wiBFkcU=;
        b=Fe2TTn7C1Aai7Fnp0V083mLcrzfS1HtyaeUaZQWWbgSc6IdIGVUy2Y1HFi1EionV58
         9ROk9zLDVfbIJG/ZhBhExuQKFvWImvGAQQQ2cKx+Cg3/l2N0XTmQARnZOm5M4htpRo5g
         7KeHvEG15u45Q0hTskI7Ca1Lo4CwkstRz3RtEJzshWUDGbefdS+bvciogLK1gklRztdl
         94QTV/1iRkLrEZRfNuheIvZLiLU4WFg/kbZtpJ/zgzg2BpicEpHkC45FFZa8wmGT1M38
         pDcYeG0sQuezot3/MfQ0nCrvb+3u8TW4BYwvEk6uXPyCupP0cAu6lwjMhW+OyQgnhTS8
         Px8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762797173; x=1763401973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgMBChGiCDCek3D0eI0cnkwInN+pZ/u+vK64wiBFkcU=;
        b=na+fLCg9E9cjm0JUzsblMaLEFm3Xigz4RAxJEQICE8onEhZlul3AKjUL8+/wTrPTTv
         S9COkOH3nyM9RWlkRNVReubJywQL3/RTEO4rEJmdyjREGDoedEifL5kOc1fR9IdzPXzU
         odgE0ynTMzplwe4YDhyseOLdlmSi3nw0Uc66AEzFaxeNDgu3/KGhQBZ0ACXgc+48VN0X
         r77yn4y3O8vSI41NZK5gVjzZ5S4j7xYD7VyOTNtOVA5JtfstlfWsaqAgvfH4+CYlmPd5
         Zwv5thcOJNMekJQhVIGDPrQ5hPTHm9LW073YOrp9pvVlalSu6ptyCrKF5qqwFcC1pMfs
         caog==
X-Forwarded-Encrypted: i=1; AJvYcCXxmncomLxgQZ7X+1WfKT7jY5Qx1okgjMQbnhElgAccY8/ipIU0LzuJEXQaLlqFH6qBVy+nf9CtQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRV5grLSXKLU4KfnAqDzOSS2H0eJ5KCPs2sXxbt2EhLv/JWHh
	GzWoiXojKA4cc0fNTChJ9xKKMQPrNQWOioZKijO+8XdMcpJtMVLYb0nFYtyZRhJxNsBvyWGE6K3
	yiFG/TQDqtleYWKP7R95lkEm3wJLwgZ34D3P9YmNJFXOrlai3zJU2k+jpfVC3CA==
X-Gm-Gg: ASbGnctfsp4l8wnMJXd9I2wU22KIeRbSaiVCNDvG8512zr1dzjgLTnGNoJLMkMT43jX
	GPNxAa0bja3fMfzqc6CpD3kzhEYd5zBXBHPRoHV7kesezhXNWRlhPqb7UUPLuiJfDOZvi12qIiT
	ewZ8Hi48UYLmd8R/kQvvfUxoc9XX5NVsDxnUHRAXEbR7gwOaC/JQfIc78Bfexu6tgMkruJg6hf7
	CL9ISvZ+crTiJdl8sHka6IHqp8tJxP5bZ/Lvk/GAuuMMp1b7FSpEeV7ZQ0H7kk+WUXZ/xAXUjiC
	pXi0/E4UhbyYReZ1sdhsLN5diH1llGUM+/sNLrfNCYSrwjsYNEMMqZcHjgle0VQ2dqIpnNS9yby
	XN6xI5ec+G4v+eqbyMC4SXKQKAc8kso33
X-Received: by 2002:a17:90b:258c:b0:340:4abf:391d with SMTP id 98e67ed59e1d1-3436cbab15dmr11895440a91.16.1762797173319;
        Mon, 10 Nov 2025 09:52:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlFXFApx/SwnXYMQzXSDvrGq7RtHQa9Gt7XZ4Sn1voA+Wj3sOexjL3YZxb2Nlont05g8Gx2w==
X-Received: by 2002:a17:90b:258c:b0:340:4abf:391d with SMTP id 98e67ed59e1d1-3436cbab15dmr11895365a91.16.1762797172673;
        Mon, 10 Nov 2025 09:52:52 -0800 (PST)
Received: from [10.216.49.81] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c31d86esm11985909a91.8.2025.11.10.09.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 09:52:52 -0800 (PST)
Message-ID: <681a72ba-d8fb-bfc2-d2bb-d80ac667bc5c@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 23:22:40 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v17 03/12] power: reset: reboot-mode: Add support for 64
 bit magic
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-3-46e085bca4cc@oss.qualcomm.com>
 <20251110134529.uljjqzb3vhda3vya@hu-mojha-hyd.qualcomm.com>
 <gzj4r4elqewjt2gjzhuamslvobz5fgyvt672brwknoozlsplaq@wsebzmi2l6pc>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <gzj4r4elqewjt2gjzhuamslvobz5fgyvt672brwknoozlsplaq@wsebzmi2l6pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE1MSBTYWx0ZWRfX+zfmyen8L6hy
 XabhuUQUJwKT/8nzzlzsfoj/0HjvfatYkfbtjcX+0yfOg4nMFUkF+3TGpj4OAcH7vJo2rujqzFa
 2qHneIio6+mAuU+LMeugRQF4xxaWfsqc5WdcagE4ymjFCbJrTz8g0ZdYqCTJSFX3TsKMDboklv7
 qTt0BivvC9suSuB8gGcoElZNFZl4FY9g2ipCqdWxv+SPWaMR1PzQiU0A9PAv62SSduQ5KCaFbA7
 ChzHgx/8HvnhZMrHupJYqvoyjwXMWs114igGwJj2yHbFk8wXSk2gsHXLrb9UPycWV1pHbYbeS1K
 79FgC+ZUlEaD6S9QAW0X1WyPJdFMGHFGh4ELdirmYQ4ZcGMRef2PkBaWarMiAHMsSKZ4XTIFAbK
 bKEFo8gDMA+bkmcUYXTOYvY/QVYyFQ==
X-Authority-Analysis: v=2.4 cv=br5BxUai c=1 sm=1 tr=0 ts=69122676 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=LD8w3KR18lMhmnX9WsUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 3MhX4GOJbNogT2-l0dz7gvnCJTmeHMNT
X-Proofpoint-ORIG-GUID: 3MhX4GOJbNogT2-l0dz7gvnCJTmeHMNT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100151



On 11/10/2025 10:00 PM, Bjorn Andersson wrote:
> On Mon, Nov 10, 2025 at 07:15:29PM +0530, Mukesh Ojha wrote:
>> On Sun, Nov 09, 2025 at 08:07:16PM +0530, Shivendra Pratap wrote:
>>> Current reboot-mode supports a single 32-bit argument for any
>>> supported mode. Some reboot-mode based drivers may require
>>> passing two independent 32-bit arguments during a reboot
>>> sequence, for uses-cases, where a mode requires an additional
>>> argument. Such drivers may not be able to use the reboot-mode
>>> driver. For example, ARM PSCI vendor-specific resets, need two
>>> arguments for its operation – reset_type and cookie, to complete
>>> the reset operation. If a driver wants to implement this
>>> firmware-based reset, it cannot use reboot-mode framework.
>>>
>>> Introduce 64-bit magic values in reboot-mode driver to
>>> accommodate dual 32-bit arguments when specified via device tree.
>>> In cases, where no second argument is passed from device tree,
>>> keep the upper 32-bit of magic un-changed(0) to maintain backward
>>> compatibility.
>>>
>>> Update the current drivers using reboot-mode for a 64-bit magic
>>> value.

[SNIP..]

>>> +	if (magic > U32_MAX)
>>> +		return -EINVAL;
>>> +
>>> +	magic_32 = magic;
>>> +
>>>  	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
>>>  
>>>  	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
>>> -				 syscon_rbm->mask, magic);
>>> +				 syscon_rbm->mask, magic_32);
> 
> As above, if we're no longer silently discarding bits, I think we should
> compare the magic against syscon_rbm->mask.
> 
> No need for a local variable, just type cast after checking the validity.

Trying to summarize below why we added these check-

the patch in v11 used typecasting and did not have any of these checks(link below):
https://lore.kernel.org/all/20250717-arm-psci-system_reset2-vendor-reboots-v11-2-df3e2b2183c3@oss.qualcomm.com/

As per below upstream review, type cast was removed and bound checks were added all-over patchset:
"As a general rule of thumb, code with casts is poor quality code. Try
to write the code without casts." - 
https://lore.kernel.org/all/8d4a42b6-657f-4c30-8e25-4213d8d53a89@lunn.ch/

We can revert to the typecast way. Please suggest.

thanks,
Shivendra

