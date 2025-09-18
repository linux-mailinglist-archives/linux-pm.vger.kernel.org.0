Return-Path: <linux-pm+bounces-34988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F68B862FB
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA6C1CC1485
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FBC262FD7;
	Thu, 18 Sep 2025 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BQF0SKKq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B5325B301
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215955; cv=none; b=XtmnSV0v+i4CZ4tY8O3q8s0S6eZXXPcvFYZnnESIfJLGvFoS58p0XyP7ibb/tNfjYofiCeLbWTweGEWQ3Oc9GBM9E8oiXlYOVZdNNq/j1+6PVuUjWY5CbPJaY9yr6qpPySXCje3KgK7mgqvLtB0CLwhRwaHrlfYeOY/Ap7EiFa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215955; c=relaxed/simple;
	bh=1+ind6rGCdruwDgn7XLF01eUlmn+p2mmIsi+L595scY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JN1rTF3P7v4eJwB1S6S3rrSuR/dRvSEryk8fPUABzxdPKJ1lEmyiooah2QyQ8UlGGBY4zp7jF9NWsp43/cmr8mT3UIlVtQkmaLLIfw/R67Yj+P6B6xSPwXC9vigu82rnX1XH7C2cGXESrveuvY2hsnMXaBBo8I9QaFEOWTrlLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BQF0SKKq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ICw9pc017934
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 17:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mU7QcDD/4KUFVfZ3NXnJmqqwSKLMzRc76z+XyB4Tl4A=; b=BQF0SKKqAC1Xz0Ji
	BUADepm4SFg/relLpL2mKf7T7ik8hS2N/4cyIddnVhwEtTYEuAImAjStzUNuxXtm
	oO4w0DI2FLCrj9oYi4i2cC6Cj6oQ4Fh7aUtV0+KbxJIk9GB1Knew8C5XqDY/IUG/
	JsPfg5zE6EkinCHPDnTNxK5W70SY3nKbs6eugMM5j8Gaki7rryq20d8doQWDyoN8
	0nPUzekGr0YVElMvHAHntWcmROduGWjwr8W1sl1OHyCv88XX7Ov4Cmv0DGIxYgHW
	MIwBdLjdF3x8JtObzz5rEbtgXq8WhRL/ZK5bWq+nmUW6lxNDf/Z9ALiio1OTzUM1
	DitoAQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982debuya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 17:19:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so1739867a91.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 10:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215950; x=1758820750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mU7QcDD/4KUFVfZ3NXnJmqqwSKLMzRc76z+XyB4Tl4A=;
        b=KWG9kGRVCG8lg+uI2QmmrZMWKg6Y8dKTir0enyTU8xc332VcY+lOs4ydkE2BOb08u2
         E8gRn0DzcUwr8J4/+em+Jbr4R3b5EIBXtz8P1pA86SSutlRo9rTAQPWlLGOzET/w22m1
         mnt1ZRm47PF5OMR1tL8mxK00tDkWFZMQy+LtbeZ0UCKB3HSLpTbv7+Z3qcI1qDCUlQl4
         t8QX8JOUAjfvKK9zGMYWStCBd4P8Qe+112tNkl+ZFK1FD/fZE9xKWMoyZ+5DNpEi+RFD
         qKTZGcttCCKwz7y80AmNNlxLciq9tAZhdU5FBE2XoVjAWEKB0H4hokV176wDc2XCYi9r
         9A2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrFMlr6XR1x3wT5aZ1Kvkt0adH4HaWh6V0tABzDjDS8TFKD1gbnG7W7DfSyXza/yLS4hVavBUKuw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb3ubnsjAy2K0FkEO5qt3vl8zFxlFjzIc9gBX77OHsaBMnJChZ
	cvPuX6gT4iXIlUHd+OGjqM7GwQ7P1Infhkcl9SZodsDlMyG9F65C7DCGxmECeKveyIvDufnvUgi
	3tV5axsOKLglcBIRXfvMR8bxKC7WJWX/93E6WxaKIJXet33DCPhHU8p7Y+ui1Kg==
X-Gm-Gg: ASbGnctBYH8YtbU6UFQ88K2QGRzo3d9P8iIuiwPtreNOISIoHPRZiytTJ7TpoQNFT9s
	VzxddNMiC6Zzt3fH5/IZQYvPKCyZW61EDDHKNi6G0MVQ77RMG2lwB0T+FVos1BRFxTrN1Ls3xUk
	Io+H9/u2LreMaFYmebIswbgggG080DtxctKSKZezZlg/rix8XXl7WGhK+sXF8Jx3S8F5VXQVgEl
	g/+7O2BiiXPHONUHEwj4kjskWowdlj386EaMrxpuX7M2TPr0iPxUtdWe/5mvmZTbH7A5jLsnqXf
	tTKR6vnRpbIgu+UsjYWG/wmghuuaBQUnf++wbKcDUPmNVRrxU9u7HivxSr3nxFgQXwwEk305
X-Received: by 2002:a17:90b:2fce:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-33097feff9fmr162718a91.13.1758215950439;
        Thu, 18 Sep 2025 10:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPOgKeMpHla0VYJIoWjFrtXclKqTLsIHw8mI7e9lZC/kTHucViucsRapr9e8tJfJPP/dPo0g==
X-Received: by 2002:a17:90b:2fce:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-33097feff9fmr162683a91.13.1758215949962;
        Thu, 18 Sep 2025 10:19:09 -0700 (PDT)
Received: from [10.216.2.73] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306064f420sm3148650a91.11.2025.09.18.10.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 10:19:09 -0700 (PDT)
Message-ID: <145281f4-9df1-4b24-3676-26823dd01c60@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 22:49:00 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v14 02/10] power: reset: reboot-mode: Add device tree
 node-based registration
Content-Language: en-US
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
 <20250815-arm-psci-system_reset2-vendor-reboots-v14-2-37d29f59ac9a@oss.qualcomm.com>
 <in6bqvemnscvuxbumpxogxiiav7odmsc3iazktifninh6iqen7@qwhrhdidcx7y>
 <3c56cd00-770f-019a-d93b-5ebaa6b9374d@oss.qualcomm.com>
 <wsig6dm7jbnx2pzt5l3uhhgywsa4jsdyunmd5aqn43bbciqiov@4y6mnd25pbeg>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <wsig6dm7jbnx2pzt5l3uhhgywsa4jsdyunmd5aqn43bbciqiov@4y6mnd25pbeg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cc3f0f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_oUffHqFanK6T7gqflIA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 7bPPr_F0-AuOpEcKdeqOm7iHrGOKnMVT
X-Proofpoint-ORIG-GUID: 7bPPr_F0-AuOpEcKdeqOm7iHrGOKnMVT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfX6siB7e9DrnV4
 bV7K4jZyhdR66xqHhd+R3IoUMnZxeYxsATP9LwmueB0OFZSJZ6PZlgBuZVKOOvR2px+tCgRINdD
 +qFMqksZz7graSmzYf2ZUMJViMyZRrIo9b1eI29daM45EA/ki16u3Wjedjue/1HMtEe8NpmRRyc
 tlRWt/96JWy2dbrtSG79KHnt7JKaM/1xq5ZT4MzIL8g1805/olBwy6G4KDH7K5m+Cmal1UIPWzO
 Ol2BMvB9pplvQ0U2cfopkyiKpEb3Mkw6OAMukiuF0OCo+Cx0UvBtkCP7rXHBHg0dUmWenWHoAOU
 hOy/kLBQTjJjIxG2aqe9F/Zoul0KKMMTGVYPpp9PMnm/J0r+vivTiBPmywu6QBggwqJ+VgE7q4h
 Mm+Chsji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182



On 9/18/2025 4:02 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Sep 17, 2025 at 09:59:44PM +0530, Shivendra Pratap wrote:
>> On 9/17/2025 12:18 AM, Sebastian Reichel wrote:
>>> On Fri, Aug 15, 2025 at 08:05:07PM +0530, Shivendra Pratap wrote:
>>>> The reboot-mode driver does not have a strict requirement for
>>>> device-based registration. It primarily uses the device's of_node
>>>> to read mode-<cmd> properties and the device pointer for logging.
>>>>
>>>> Remove the dependency on struct device and introduce support for
>>>> Device Tree (DT) node-based registration. This enables drivers
>>>> that are not associated with a struct device to leverage the
>>>> reboot-mode framework.
>>>>
>>>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>>>> ---
>>>
>>> Please use fwnode instead of device_node, so that the same thing
>>> can be used with non DT setups, if that becomes necessary. Otherwise
>>> LGTM.
>>
>> To be more clear on this, have one question: the current unmodified
>> design of reboot-mode is dt based:
>>
>> struct device_node *np = reboot->dev->of_node;
>> and then parses the node using for_each_property_of_node(np, prop).
>>
>> We want to refactor reboot-mode to support non-DT setups by adding
>> support for fwnode-based approach (struct fwnode_handle *fwnode)?
>>
>> Can you please explain a bit? Some more details would be helpful to
>> make the change.
> 
> It's fine to keep using of_node internally. But the external API
> (include/linux/reboot-mode.h) should use fwnode. Just like the
> current external API is not DT specific as it just gets a struct
> device. This keeps the external API somewhat ready for non-DT users
> and avoids having to change all API users again in the future.
> 

sure. Will check and try to make this change.

thanks,
Shivendra

