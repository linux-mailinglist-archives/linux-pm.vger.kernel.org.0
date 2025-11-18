Return-Path: <linux-pm+bounces-38189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE22BC6B0A5
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 18:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED732347B9E
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CE4346FA8;
	Tue, 18 Nov 2025 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l4sbzGXc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R0tTGaAg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04129BD8E
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487710; cv=none; b=XJsZ0ZSn1qoF2NeS9Keh4JfseD6ONi3O10Amg6ofiJZGYMHleJeke65X4/1pSQrrCe9T5C6KTPF0/XH8/LP2/hu0wHlb0wj/HyRC9Uj+FNVG0DWhE4io+KqWKOxiqb7Pjy0ri9jEQ8D8Wfsm2dAgKZ9pXd4artuj7/O67GUZh1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487710; c=relaxed/simple;
	bh=qEj3PgwwkP5m6gVhj1M9EJ2OU6b/eiDdnay+L5GPOuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J57h3FQYI2U6lAzWDYEXN+aWcW8TztPpaEvBmITA7afmdLAcPXiQeL0hyHVvqY1iAt2SwY+Sq1j1f3Sq5dLOpjsbzYRTwAUfL27V7uG7UU3U5p1EWiodbhzdIlnnlaS2S7Ub60Kyf4J2LdfkClmCSU9qV4cpqf7vfteNyX32hW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l4sbzGXc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R0tTGaAg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AIGrYbD3165141
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 17:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AUj57zYEcFEZpI0Zq0dX35LVWJ3m0jhrfC9zNduSnmU=; b=l4sbzGXclEZAqM9l
	Xd5Hry1dthRkQA+er5NH8EJ8BiAI2mlOtQgjRffvaI9Iha4MhCldUv3EUqxH+pAQ
	CClJ4nbNu8X3B464MjJWP1Gk3wYXbu5UVeOtrhZtl9rWJfx+VfT5/nT9Dn8tuSaY
	sv8/u1Sawf+rohXe0BrmHBbRcJ7L4F5Int/FqjD4Qjf7K5dJcBuaomsXgymcZR1g
	7Xko+RhNzs9kl1KkYIm3VdsEuQ89PvSWkadmhHvSX6G7XWXgyPVqgaliLJpW679l
	Gkk/lHZiPaciKvrfmlhgkNjSszwJ11ycVfaONHQ/KmIceKdTSHX844XL6JxNWlx+
	C7aY2w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agvqgr5f6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 17:41:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297f8a2ba9eso150618945ad.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 09:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763487707; x=1764092507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AUj57zYEcFEZpI0Zq0dX35LVWJ3m0jhrfC9zNduSnmU=;
        b=R0tTGaAgCID9ff/AyHM13CUHHLEKOwJQhl1vcY4ShMQ/RyhB4pqNk3P1Q+VAgYgeKs
         uvg5b1up0zpuB/jINGXAxmxo7UGe1zsGHdA0K+zKGCxwjwZnCuZpM87MIlRFIrdrWoT4
         TpY1CUaxZw+ShaeMWOp78/D+Dokxy0wgXmMGlhnX2zoyB/Iypl40iOudIdg/3TeGzp3A
         M7wNAlNSHxPtDNTVzPe9KCMU+8lsG1FQqzpc0VLzNA2xRZ+KZjuDY3kPJB9mKMKJUntV
         zGbLlfsn0qaikcqmp1ZQa2K+XZXscWcUD+bxRqk/sgP1nTppTRUtBJxg4k6biSn180MU
         WDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763487707; x=1764092507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUj57zYEcFEZpI0Zq0dX35LVWJ3m0jhrfC9zNduSnmU=;
        b=ZykB7SoMis9aLMWEMGKzgDN2P5Y9oLvUwLMYy7AGma6Z6R2rTR9f0ERm3AmzrshX8f
         hsvatoFWRnXezJvS+W661gVZuEYbUVmlUHkbzFG2dcyxv8Z3XrTmzHzfELVw7wIetdzV
         fR/7DV4wm65/krCapLV34LA9Ly9ADcLDoCd//Znr6MCob4bjptcEbKBJtm8bq4HwMvui
         aMjEWb0w2BQPOja5vwDei5p73Ie9o+QYxq/OrOMJacCXJNO1m0PY3WX2Z/53qwI4NsVh
         maPCb3OFwGjuYNWR3oUNET2qTNLrRAwMuO4tmLvu+E8K0HZS+1thS9IqbNzSQUKKNz7G
         HjjA==
X-Forwarded-Encrypted: i=1; AJvYcCVFsLNA2QAS8y2oH7nf/vny0+ZZDwznZBsm++ZED0N/UgG32TkI1gElrNcOsfWpfFdL6GKolKZX3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMKbyM1Th0u/iHsQXmdrrMoybY7H+npSQqCyaOZzsjkVeX9CGG
	Bvczubm8wFcJb0hy615354SRvGS+zfHppm+VemBKfHeXttUj4m+mdYYZPU+Ut4m5XXN/4w/KjSV
	3bV6l7MF/cJ+dyJuhN4l8Sm2KymVF8522xaDWvRAgYrU2rzqJyn6WfEfCCOFxoA==
X-Gm-Gg: ASbGncs3niYtdH1JpJiF823b1Zakh/hOPkD/GKb+PRCga9Z0N7zJp+eIfu7Z+9XDy10
	9uBOHTY3Pm4Bj6khAPvHm1Sp5lyULswu5ozmwkmIwuFzZh9NkcnZXZ5WWIPY5kkaFFzHbM5SutU
	nccQvT+yrllIdNGmk6+lcWiRxKJ1s2LVm5cQnNgJamOFDPaGQQh/I777Lyg3rFRohFHK/QqAhBe
	Jlhy5ewiQJ3bGwR37HXCt8ms7obC+Xda4lLKSNIcENdLmy7hWSgG/XyCQYblXiG3D/U/CcogQZt
	Wmg8a5r7Sd1/XXlKRH5BR68qzTnL/kuxt+YlKJ0w2VgsGAEubpU04vOYQvMwcMZf7iaXmyW1TtK
	RJhZRZOKon1AGjPaga5EHA7cUp7imEOqm
X-Received: by 2002:a17:903:3d05:b0:297:f7fb:7b66 with SMTP id d9443c01a7336-2986a758fbamr191604165ad.57.1763487706682;
        Tue, 18 Nov 2025 09:41:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzqZj+I7Y3HdGaluSFQOp5N1DCarh1c7GonVm96vROqcjJXe2nOCPrRlpd7cetvGi+V4mVYg==
X-Received: by 2002:a17:903:3d05:b0:297:f7fb:7b66 with SMTP id d9443c01a7336-2986a758fbamr191603555ad.57.1763487706100;
        Tue, 18 Nov 2025 09:41:46 -0800 (PST)
Received: from [10.216.27.76] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985ce19a20sm176895315ad.84.2025.11.18.09.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 09:41:45 -0800 (PST)
Message-ID: <1da024e7-efb1-3a1c-cc13-0ae5212ed8bd@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 23:11:33 +0530
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
Content-Language: en-US
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
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <aRxmWrAkD0Vu4pF+@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CKJGrkL7TjM9MVkotlyl4Lqh3-vQGgDS
X-Proofpoint-GUID: CKJGrkL7TjM9MVkotlyl4Lqh3-vQGgDS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDE0MyBTYWx0ZWRfX+JRetq0z9sE+
 NZwQg93E4bc1kNszENcuB9P8XgHks52+DR03690T+TUTaI4O629FfPj3qyPZdjTjeQnH0EgnIm4
 uUCbWSnpZKhgjXKs1NSPh19zaxDuhLvO+3MYcl9mf5Vk6pkUPDhaH2crn8d3nMDO0QsW8LOcLXz
 Fg0RGLBW0EC5hGVqbcMtkWmjRSVkLZIKHGNCBIGnrY4koV141CQTlc2gvSWHcunr/KTGOk4BH3U
 yPLZzcLFjMNdVejtBLWxrIiRr/mU7YWJzeT78bT1Oumhz3OFjMySFCsgg2h77YTIPDU1MkCAo/4
 XEWvdy9+A9OHwQEnWfB438i9jEXZ3Qar3KEoPz/uxEMkuOtXm4kDYosFuhXQxjzN1AmjnDWLQk6
 08zoM2A5OqwCcSZu0BMWpNXs832iNQ==
X-Authority-Analysis: v=2.4 cv=LMJrgZW9 c=1 sm=1 tr=0 ts=691cafdb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=xv1uSN6w8Po24_-fgokA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180143



On 11/18/2025 5:58 PM, Lorenzo Pieralisi wrote:
> On Mon, Nov 17, 2025 at 11:14:48PM +0530, Shivendra Pratap wrote:
>>
>>
>> On 11/10/2025 10:52 PM, Lorenzo Pieralisi wrote:
>>> On Sun, Nov 09, 2025 at 08:07:20PM +0530, Shivendra Pratap wrote:
>>>> SoC vendors have different types of resets which are controlled
>>>> through various hardware registers. For instance, Qualcomm SoC
>>>> may have a requirement that reboot with “bootloader” command
>>>> should reboot the device to bootloader flashing mode and reboot
>>>> with “edl” should reboot the device into Emergency flashing mode.
>>>> Setting up such reboots on Qualcomm devices can be inconsistent
>>>> across SoC platforms and may require setting different HW
>>>> registers, where some of these registers may not be accessible to
>>>> HLOS. These knobs evolve over product generations and require
>>>> more drivers. PSCI spec defines, SYSTEM_RESET2, vendor-specific
>>>> reset which can help align this requirement. Add support for PSCI
>>>> SYSTEM_RESET2, vendor-specific resets and align the implementation
>>>> to allow user-space initiated reboots to trigger these resets.
>>>>
>>>> Implement the PSCI vendor-specific resets by registering to the
>>>> reboot-mode framework.
>>>
>>> I think that we should expose to user space _all_ PSCI reset types,
>>> cold, warm + vendor specific - as a departure from using the reboot_mode
>>> variable (and possibly deprecate it - or at least stop using it).
>>
>> sure. We can try that. Have tried to compile it all at the end of this thread.
>>
>>>
>>>> As psci init is done at early kernel init, reboot-mode registration cannot
>>>> be done at the time of psci init.  This is because reboot-mode creates a
>>>> “reboot-mode” class for exposing sysfs, which can fail at early kernel init.
>>>> To overcome this, introduce a late_initcall to register PSCI vendor-specific
>>>> resets as reboot modes. Implement a reboot-mode write function that sets
>>>> reset_type and cookie values during the reboot notifier callback.  Introduce
>>>> a firmware-based call for SYSTEM_RESET2 vendor-specific reset in the
>>>> psci_sys_reset path, using reset_type and cookie if supported by secure
>>>> firmware. Register a panic notifier and clear vendor_reset valid status
>>>> during panic.  This is needed for any kernel panic that occurs post
>>>> reboot_notifiers.
>>>
>>> Is it because panic uses reboot_mode to determine the reset to issue ?
>>
>> Yes. As we know, currently psci supports only two resets,
>> psci_sys_reset2 (ARCH warm reset) and psci_sys_reset(COLD RESET). And kernel
>> panic path should take the path set by reboot_mode to maintain backward
>> compatibility. 
>>
>>>
>>>> By using the above implementation, userspace will be able to issue
>>>> such resets using the reboot() system call with the "*arg"
>>>> parameter as a string based command. The commands can be defined
>>>> in PSCI device tree node under “reboot-mode” and are based on the
>>>> reboot-mode based commands.
>>>
>>> IMHO - it would be nice if could add mode-cold (or mode-normal in reboot mode
>>> speak) and mode-warm by default (if PSCI supports them) so that userspace
>>
>> Default mode in current kernel is cold, until explicitly set to warm.
>> So should it be defaulted to cold?
> 
> I managed to confuse you sorry. What I wanted to say is that user space
> should be able to issue _all_ PSCI resets (inclusive of cold and warm if
> supported - ie if SYSTEM_RESET2 is supported) not just vendor resets.
> 
> I misused "by default" - I meant cold and warm PSCI resets should be part
> of the reboot-mode list.
> 
> [...]
> 
>>>>  
>>>> +struct psci_vendor_sysreset2 {
>>>> +	u32 reset_type;
>>>> +	u32 cookie;
>>>> +	bool valid;
>>>> +};
>>>> +
>>>> +static struct psci_vendor_sysreset2 vendor_reset;
>>>
>>> I think this should represent all possible PSCI reset types, not vendor only
>>> and its value is set by the reboot mode framework.
>>>
>>>> +
>>>> +static int psci_panic_event(struct notifier_block *nb, unsigned long v, void *p)
>>>> +{
>>>> +	vendor_reset.valid = false;
>>>
>>> I don't like this. Basically all you want this for is to make sure that
>>> we don't override the reboot_mode variable.
>>
>> Yes, it does not look good but as we planned to use reboot-mode framework earlier, which
>> sets the modes at the at reboot_notifiers. This needs to be taken care for any panic
>> that occurs between reboot_notifier and restart_notifier.
> 
> Isn't there a simpler way to detect whether we are in panic mode and
> consequently we just issue a reset based on reboot_mode ?
> 
> panic_in_progress() ?

Yes. panic_in_progress is added in 6.18.rc1. We can use that. Thanks. Seems i was
outdated.

> 
>>> One (hack) would consist in checking the reboot_mode variable here and
>>> set the struct I mentioned above to the value represented in reboot_mode.
>>>
>>> Good luck if reboot_mode == REBOOT_GPIO :-)
>>
>> psci supports only two modes, ARCH_WARM and cold, so anything else except WARM/SOFT
>> should default to cold? So even if REBOOT_GPIO is set in reboot_mode, we should default
>> it to cold reset.
>>
>>>
>>>> +	return NOTIFY_DONE;
>>>> +}
>>>> +
>>>> +static struct notifier_block psci_panic_block = {
>>>> +	.notifier_call = psci_panic_event
>>>> +};
>>>> +
>>>>  bool psci_tos_resident_on(int cpu)
>>>>  {
>>>>  	return cpu == resident_cpu;
>>>> @@ -309,7 +330,10 @@ static int get_set_conduit_method(const struct device_node *np)
>>>>  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
>>>>  			  void *data)
>>>>  {
>>>> -	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>>>> +	if (vendor_reset.valid && psci_system_reset2_supported) {
>>>> +		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), vendor_reset.reset_type,
>>>> +			       vendor_reset.cookie, 0);
>>>
>>> See above. Two calls here: one for resets issued using the new userspace
>>> interface you are adding and legacy below - no vendor vs reboot_mode, this
>>> is a mess.
>>
>> Are we suggesting to completely remove the reboot_mode check from here in the new
>> design and base it on reboot <CMD> param?
> 
> I am suggesting that there must be two reset options:
> 
> - based on reboot mode set by user space
> - based on reboot_mode variable (as a fallback and while panic is in progress)
> 
>>>
>>>> +	} else if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>>>>  	    psci_system_reset2_supported) {
>>>>  		/*
>>>>  		 * reset_type[31] = 0 (architectural)
>>>> @@ -547,6 +571,72 @@ static const struct platform_suspend_ops psci_suspend_ops = {
>>>>  	.enter          = psci_system_suspend_enter,
>>>>  };
>>>>  
>>>> +static int psci_set_vendor_sys_reset2(struct reboot_mode_driver *reboot, u64 magic)
>>>> +{
>>>> +	u32 magic_32;
>>>> +
>>>> +	if (psci_system_reset2_supported) {
>>>> +		magic_32 = magic & GENMASK(31, 0);
>>>> +		vendor_reset.reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic_32;
>>>> +		vendor_reset.cookie = (magic >> 32) & GENMASK(31, 0);
>>>
>>> Use FIELD_PREP/GET() please (but as mentioned above the vendor reset type
>>> bit[31] should be part of the reboot mode magic value, see above).
>>
>> sure. Will align this. thanks.
>>
>>>
>>>> +		vendor_reset.valid = true;
>>>> +	}
>>>> +
>>>> +	return NOTIFY_DONE;
>>>> +}
>>>> +
>>>> +static int __init psci_init_vendor_reset(void)
>>>> +{
>>>> +	struct reboot_mode_driver *reboot;
>>>> +	struct device_node *psci_np;
>>>> +	struct device_node *np;
>>>> +	int ret;
>>>> +
>>>> +	if (!psci_system_reset2_supported)
>>>> +		return -EINVAL;
>>>> +
>>>> +	psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
>>>> +	if (!psci_np)
>>>> +		return -ENODEV;
>>>> +
>>>> +	np = of_find_node_by_name(psci_np, "reboot-mode");
>>>> +	if (!np) {
>>>> +		of_node_put(psci_np);
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	ret = atomic_notifier_chain_register(&panic_notifier_list, &psci_panic_block);
>>>> +	if (ret)
>>>> +		goto err_notifier;
>>>> +
>>>> +	reboot = kzalloc(sizeof(*reboot), GFP_KERNEL);
>>>> +	if (!reboot) {
>>>> +		ret = -ENOMEM;
>>>> +		goto err_kzalloc;
>>>> +	}
>>>> +
>>>> +	reboot->write = psci_set_vendor_sys_reset2;
>>>> +	reboot->driver_name = "psci";
>>>> +
>>>> +	ret = reboot_mode_register(reboot, of_fwnode_handle(np));
>>>> +	if (ret)
>>>> +		goto err_register;
>>>> +
>>>> +	of_node_put(psci_np);
>>>> +	of_node_put(np);
>>>> +	return 0;
>>>> +
>>>> +err_register:
>>>> +	kfree(reboot);
>>>> +err_kzalloc:
>>>> +	atomic_notifier_chain_unregister(&panic_notifier_list, &psci_panic_block);
>>>> +err_notifier:
>>>> +	of_node_put(psci_np);
>>>> +	of_node_put(np);
>>>> +	return ret;
>>>> +}
>>>> +late_initcall(psci_init_vendor_reset)
>>>
>>> I don't like adding another initcall here.
>>>
>>> I wonder whether this code belongs in a PSCI reboot mode driver, possibly a
>>> faux device in a way similar to what we did for cpuidle-psci (that after all
>>> is a consumer of PSCI_CPU_SUSPEND in a similar way as this code is a
>>> PSCI_SYSTEM_RESET{2} consumer), that communicates with
>>> drivers/firmware/psci/psci.c with the struct mentioned above.
>>
>> sure. we can create a new driver and try it as in cpuidle: cpuidle-psci.
>> Can you suggest a bit more on the overall approach we want to take here?
>> Have tried to summarize the potential changes and few questions below.
>>
>> - new driver registers a faux device - say - power: reset: psci_reset.
> 
> Yes this could be a potential way forward but that's decoupled from the
> options below. If we take this route PSCI maintainers should be added
> as maintainers for this reboot mode driver.

you mean the new psci_reset driver? yes. Maintainer would be PSCI maintainer,
if we create a new  psci_reset reboot mode driver.

> 
>> - struct with pre-built psci reset_types - (warm, soft, cold). Currently
>>   only two modes supported, anything other than warm/soft defaults to cold.
>> - vendor resets to be added as per vendor choice, inside psci device tree(SOC specific).
>> - psci_reset registers with reboot-mode for registering  vendor resets. Here, we
>>   have a problem, the pre-built psci reset_types - (warm, soft, cold) cannot be added via
>>   reboot-mode framework.
> 
> Why ?

If we want the new psci_reset to take the reboot-mode framework route, is it ok to
add default modes (warm, cold) in the device tree?
If not, then the design of reboot-mode framework(power:reset:reboot-mode.c) needs to be
further changed to equip this new feature. 

If new psci_reset driver move away from reboot-mode framework(power:reset:reboot-mode.c), the driver
can have its own design, its own sysfs interface and maintained under psci Maintainer.

> 
>>   Should the new psci_reset driver, move away from reboot-mode
>>   framework as-well? And define its own parsing logic for psci_reset_types,
>>   and have its own restart_notifier instead of reboot_notifier?
> 
> No. As I said earlier, I think it makes sense to allow user space to
> select _all_ PSCI reset types - architected and vendor specific in
> a single reboot mode driver.
> 
> I believe that we must be able to have two well defined ways for
> issuing resets:
> 
> - one based on reboot mode driver
> - one based on reboot_mode variable interface

So may be in more details-
user space issues - reboot cold
   -> go for psci_reset (as psci_sysrest2 does not has cold reset?)
user space issues - reboot warm or a vendor_reset
   -> if psci_sysreset2 is supported - call psci_sysreset2 with required params.
   ->   else
   ->  go for psci_reset COLD

user space issues - reboot (no commands) or a panic_in_progress
   -> fallback to reboot_mode 
   ->  if (reboot_mode == WARM and psci_sysreset2 is supported )
   ->     call psci_sysreset2 (ARCH WARM RESET)
   ->  else
   ->     go for psci_reset COLD


And we want to do this in two conditional statements in firmware:psci: psci_sys_reset
function?
Or am i not getting the point here?

thanks,
Shivendra

> 
> Does this make sense everyone ? I don't know the history behind
> reboot_mode and the reboot mode driver framework I am just stating
> what I think makes sense to do for PSCI.
> 
> Thanks,
> Lorenzo
> 
>> - If new psci_reset driver move away from reboot-mode, we can get rid of the panic_notifier
>>   added in the psci code. Else, we may still need the panic_notifier for any kernel panic
>>   that occurs between reboot_notifier and restart_notifier?
>> - psci driver will export a function which will be called externally to set the current
>>   psci reset_type.
>> - psci_sys_reset in psci driver should remove the check on reboot_mode. It will default to
>>   cold reset (for the reason the current kernel defaults to cold reset in psci.)
>>   example change in psci_sys_reset:
>>     if(psci_system_reset2_supported && <psci_reset_new_struct_var> != cold)
>>        psci_sys_reset2(AS PER PARAMS FROM new psci_reset driver)
>>     else
>>        psci_sys_reset(COLD RESET)
>>
>> thanks,
>> Shivendra

