Return-Path: <linux-pm+bounces-31495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C6FB13F97
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713ED16A34E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9286E273D7C;
	Mon, 28 Jul 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IefhWrKl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C831B4223
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718897; cv=none; b=m/n+/v0g/jh4S3CV9XC4/eMJpJ7mQxbVlCBVO+VGqm0ggtM3hNNaCcCHHDGAr27BtkvTb7Y9N9K6hnD69ydW6XRRQJhCzAVjEVcAYp8kDMRPs9pQ7lxz4lr8t7VFWJvo0GE2xxa4zG9Lh+xwsmiGmmGV2Go+PcAhaFUEzf/PN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718897; c=relaxed/simple;
	bh=Zzx5ymIWUOo8rnDAmxJ0+FyVd+R0IXJxbDDNfuUz5lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKlp2bbQnbPIpYVVU99J+hPC03DIOZGi2JaiOn1N9fjq58ND1i1E75xDga/D61KPc4+bs+LjPUD1vVOJgpqzjpTFCuQl42A75qYDM5gMZEcDsc9samI3EzXgIySQZLKs0YurnsLk4Z0wsPRIpPvBvUqVMkcAq3Y+wm9sgpLGthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IefhWrKl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlMPD014628
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 16:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nn6sa08jrce+SrXB4mT8Tl+55LBGQlikiUQGmI3nyYY=; b=IefhWrKlB6nwWDNl
	TYQrgeN8mN/bUA+p8NXEabI65ZA3nD0vYV21+12VQDKlTEBxEWfuNGyxbI8YK0Z9
	vUv95DIGylToYjexSMCeGWoR2NtcMbtxL5lIQ3+v2SO792To//malVkDSuEybKxm
	9B7jkDsx4usbVsC4Zr6YLKwCWAIsCoPiYfqRB01gummBqpnuJzzgaY/QGTJQdzu6
	gs23oKaFZTWZ4xeBIXk7cf19j6Zi/qQ5vkDe/xk86tP1HYzTAhmqGG0XHI0rArD+
	O3mC6ZQvKQDeqklhejlG5dWuhgqm5MSScxDIUF7CZqu+z7ksOgP0coO0rpLZ3Zdt
	Hpm2BQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xn4vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 16:08:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31f030b1cb9so1238063a91.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 09:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753718893; x=1754323693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nn6sa08jrce+SrXB4mT8Tl+55LBGQlikiUQGmI3nyYY=;
        b=mFQwk02AfzGHUSeTsCtQl/IB7bQX0XaxUc2ZbNOXU61mSfYdxSW35hUErlXcxNugHG
         jNPirL80o3YlqAkXDiUI45vMr1j4XAJbj9b/MBtVvtoplD4HygWkf7F13J/VJtQgngye
         ELgeCggV7XrCKRoFj+qZLclONnF6uSaaCm0++CgqyTnQ2bIKZrV0T98+fCWoR6ctEB1y
         vS19hrOlYCSDFHL7Vl43C8bZn8wZdo7kIeUqWObk5jujSKS4FfcucRmVYzv7lwSZkunk
         8TiVhA6zeg/roEkdYysPq6sKMsXODP5FA1QWjSWqUlGTPjLe25wp0mjfJjCIGNkxjNjd
         QVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxBROuPSxzqYBjilhyifOnfsWg7j6LTDU48UNkAp1bfpV6ZMjaKikxHbS7Lcx3Y20hGXE3VEq0LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeR78Fu4NTtIKdSFEoESvkS4puDYgbh+jujrhADYrKoDF9leTe
	ymBertHVYrBx8oQFZicvaKfdBi7z2Vt0zx+frwvGKn9yEf6If1UoGjitMSY4owAS4Rmnn2yi9gp
	DXXjpOPOKxzwskCTPZfUd0Wr7rmDv7PqoH1wtDb3fMqcolmCmYbGFbat6Tp69ug==
X-Gm-Gg: ASbGncu80FlcccytW6k3ok5SnkWo/CoAeALXCbPApDfW2zImbspCriKCdKgZhjtNOze
	puIwN0xTPN60v6NgwrmzMmUvR1CXZAnNn1IoNKFA39+bZgdjPtyd7nRgIgD2juGcqomQ4EJzl9f
	GrDCG+zAKSZu5nF0R8xLYebZ1apQ4ncvJ4et8nnrBQ+KJQzH7Lk7ayDzcW/MzfFb6nBi7nsIG40
	Cyg08xyqQA04VwCmuqSie6jY522qhN7q3b5QY4lwwdveS8u0boctV9BAUcGa+8aYVx6S2j6IVy7
	puoblmXvqJ9p+lDaw75XTEzD4di9QSUAHYTp+jxJMRH9ARZ3Sgj1Cj2v/2nPiICVeIvD0FoPfcq
	d
X-Received: by 2002:a17:90b:58ee:b0:31e:1311:2033 with SMTP id 98e67ed59e1d1-31e77a1a541mr16647235a91.29.1753718893341;
        Mon, 28 Jul 2025 09:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdgFqQRwLc4WbeRsTRyBtIJODCU+0G/vz7UTUiQVGLbmbQjHXF2a2GFm/CzGuJHOKwTFW5Lw==
X-Received: by 2002:a17:90b:58ee:b0:31e:1311:2033 with SMTP id 98e67ed59e1d1-31e77a1a541mr16647145a91.29.1753718892672;
        Mon, 28 Jul 2025 09:08:12 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.229.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e66376377sm9863788a91.28.2025.07.28.09.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 09:08:12 -0700 (PDT)
Message-ID: <46261176-199b-4f6c-ceb4-14646087c814@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 21:38:01 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v13 07/10] firmware: psci: Implement vendor-specific
 resets as reboot-mode
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
 <20250727-arm-psci-system_reset2-vendor-reboots-v13-7-6b8d23315898@oss.qualcomm.com>
 <b81aa592-a66b-457b-9f42-df4505b28508@kernel.org>
 <3gtlf5txxtioa5bvo6o467jupyoam4hjhm2mdiw5izv5vbl3tz@drndgp3tcrgo>
 <bcef34c3-98b4-454c-8138-c73729e17081@kernel.org>
 <5e2caeb7-360a-4590-a36f-ff1ec4c20d31@oss.qualcomm.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <5e2caeb7-360a-4590-a36f-ff1ec4c20d31@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=6887a06e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=sFC1+cT0Mn4vjRNJ/HRkpQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=9xdhny6Toa8R1GZ1QJ8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 7HZWBhnafPlkoaQbzfk-I5mkKP_d_FMY
X-Proofpoint-GUID: 7HZWBhnafPlkoaQbzfk-I5mkKP_d_FMY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDExNyBTYWx0ZWRfX7RISvNqiL2Va
 XgjKLdeWZre3Ov5TUbO+9pafZlrggKtH2Ewo0M9vE2eV82DT6UHWO4qscH1j74JCKQfLOA6GxVv
 D0EJ6ycblpWc/z5KSHL8TZlIRyVZAjaR1SnBNbPOuwZb9XbZhe5A7k/EVmBtzQ8eyMwaBLzpjtp
 AdhtfSabM+63QdJ6XeOhPG0SHuZCB89NB09DMtWvQYeWOvtAH7ZE21dkqdpzjx7xJIi/BH7yBMR
 eBJ4m8/6/B9Pp5AfE23oMhEF2vKzSSUyApIWgc1nB2aOUNnDkg63bNBs8XzJDwKtpxAEX8+A0Xq
 JJ/YhuXRqqZzldSS/J69i2ZRs5LD96K67gcEfnLDJvB14wIa9cAOAd+R4T7ej1JEfBpsGeR2E26
 5ltAoGqgZEIglOfGQ9WmilMIS5V8jtMRY5ZTiBUYbhDRP8Qn0A4au7995YTOOHgT4uQDLXMt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280117



On 7/28/2025 5:33 PM, Dmitry Baryshkov wrote:
> On 28/07/2025 14:52, Krzysztof Kozlowski wrote:
>> On 28/07/2025 11:44, Dmitry Baryshkov wrote:
>>> On Mon, Jul 28, 2025 at 06:53:14AM +0200, Krzysztof Kozlowski wrote:
>>>> On 27/07/2025 18:24, Shivendra Pratap wrote:
>>>>> +
>>>>> +static int __init psci_init_vendor_reset(void)
>>>>> +{
>>>>> +    struct reboot_mode_driver *reboot;
>>>>> +    struct device_node *np;
>>>>> +    int ret;
>>>>> +
>>>>> +    np = of_find_node_by_path("/psci/reboot-mode");
>>>>
>>>>
>>>> Why are you looking by full path, not by compatible? Is the ABI - above
>>>> path - expressed anywhere?
>>>
>>> PSCI node is required to have a node name of psci, it doesn't have MMIO,
>>
>> This is true
>>
>>> so it resides in the root node
>>
>> This might be or not might be true. It is not defined by ABI. Anyway,
>> you answered where the ABI would be documented, even though as I said it
>> is not (/psci is not), but does not answer to first part: why you are
>> not using compatibles which is always the preferred method?
> 
> That's a good question, I've added one from my side: why do we need an extra late_init call.
"psci" registers with reboot-mode which creates a class and a device under it for exposing
the sysfs.
psci_dt_init is called very early around setup_kernel. At that stage the class creating fails,
so psci cannot register with reboot-mode at this stage.
At early_init, the class creation is success, but the created class and the sysfs does not
enumerates under /sys/class/.
So i added explicit late_init call for this where the sysfs creation seems to work fine.
> 
>>
>>
>>> and the reboot-mode is defined in the
>>> previous patch. So, I'd assume, the path is defined.
>>
>> As I said, path is not. only psci/reboot-mode is.
> 
> Do we have an _actual_ use case where PSCI node is not at at root node? If not, it's obviously a deficiency of the schema. Could you please provide suggestions on how to describe that in DT schema?
> 
> 

