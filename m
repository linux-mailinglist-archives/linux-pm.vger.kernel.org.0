Return-Path: <linux-pm+bounces-36743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BE2C0241C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 17:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66CAD4E4B13
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BC723F429;
	Thu, 23 Oct 2025 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W7/7ZX0k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC6246762
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234858; cv=none; b=MQNvpEAFnlZELBoCQl4rV1N9E+7+MUt+Clq6oJy792tbTcUu+ui860h8kgJnLElbU03l94wO6r4tjXUxIGLeNgG7bK1mMjWRSk1UaPQhZT4kbUY4FyifGEq7GA9jClJY05jTQD0UMY9PNdEmKbo964d/jK15++kPTEYiN6CP1So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234858; c=relaxed/simple;
	bh=L6ZUAf2g56f0pbLijFNIC533CJWAt9IDFeMaFeWyyhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmD5c+ECf9ZWZruRTPf2c3xxBFnw+laQWjH9T2+8LI+q4G4dhYGQVlzWi9j5oSMAPI6mJ8aK5ETT/JVX7hnC99FB0wm3VXvbXrfurhg0grHh0L8QwDmuQqXMIyYAGvn6u4MsRsA02UhFbIBvUldPyFcDwj81U7xAHn0U1514urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W7/7ZX0k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEVJmL004635
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 15:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OIzxKAenz0uP2vnqlUCHL0UbaGItN6WBFXym1N/6m4k=; b=W7/7ZX0k6LVGb9pB
	LqR4H1OtSyiHJV3mKcQQBzX26/ZWmosBILOrtFI4XViImHT0v4bPwI7DePKHlM7a
	Iywgt3+/tnQzmvheeGLE0ygsjSemUxtPM8o1wh/Avk8TzLzM9YJ/l0oWJy2fL8nc
	C8hamxjPe4QUlaq/SVbFPmX7oLuVsDz6gTcLSKqle1pRA6PCnG/C9kRcDqabUaZ/
	Aibr/eWJaEw0Fpe0A1gGfka4zxmo76a++DgnUs/MT2DlvBVyrimbl5k01VQ8WZJY
	y+3k3ZCkBukTY7TI5vLT27pp3pT2hM0ljjw34JF2025ydv4hBl2DJMBQee7Oo+QW
	JgBpLQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49yp6k08yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 15:54:15 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-783c3400b5dso649622b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 08:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761234855; x=1761839655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIzxKAenz0uP2vnqlUCHL0UbaGItN6WBFXym1N/6m4k=;
        b=le0xgFe3yzP9F8iw2EvmNnW6I7+dqoHXdAE7f/SichYunRikSPEt+eEvXlvqnIP7Nb
         fDyoh4YRjl8aXnQpbjst0mWTT4m9ClPBVId82h0tkxYE0pYJ9xXIrFUb9G3YHLK0wNqq
         mTmkr/BTEb1Xoxh/XxVK/uXHdMZsouS8I/VbQePAaeiX2i+5b38DW/hNE1UoxkSNu03x
         7ueD0XHqt0EDv/lExcZbAQU71NPV+B/b1XguYElTW/qguJq8INaDuUthP7h4PGH23J3/
         NGNBgOMB7AV0yipzne8eKrEd/UeEeLDT9XqY0SvXwsZwQF+zBH+bLfhQkGRjqY3d3NXs
         RGYA==
X-Forwarded-Encrypted: i=1; AJvYcCVhT+q5GntEYxZe0+b5BO55fhCxXa77zj6s10NukEQ95EA9BFElDhk0znbvl7FEo2AYRMV8BfniiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3mwDuIFfjg7ZHs4FI3JPcMPdQBr9rTnVb4Z/tgMpDtz6PBmau
	fHO/poQKqZfQWStQ1kyblujwr5XyFvKfxSxoSMCf/QuGU7rSvdJc7F2igAeEBGCCmaWy17788pq
	TfLgcuTSRUdPxDbpzO/4Amc+AzFsWIntNgpn7HkOETpXV0BcqleNGhfjFurEC2A==
X-Gm-Gg: ASbGncvye9qBRj3M9kr4oQ+A45+qwuOuI9Uniw9i/auA3RblucLIYMA+nWWP3X7LaCQ
	o35w9AznWcaLOz2cbRb5eVAJCup3GVlmA3ZyI9MDT5aqq7B9M++//RLZUeh9YTSJhT/25wgWn2V
	s/li+kM9ykSqs8AExFOxo2GeXn//pU6+3dJwnhDi6I8wV/XM45rM3gk3LZYhvkFbyvgSx+LtCCC
	vr57a7yN/eVpqdGDLX5yhb2/yMRaD3TqZojbfH8MMfDNP0C7n8o0eoyVx9I9ThnW6D1e2bwHjx1
	Vn/92SKkbDyvbTb+uZ1CCEDZoo+eMMLF0BSQRPBBqGAj87ivTlYsosAuGafNwJsYVx5g+sf7QJj
	UDw25AfuaKZke+rij8f9ZjlNawlE7+e4n
X-Received: by 2002:a05:6a00:22d4:b0:774:1f59:89de with SMTP id d2e1a72fcca58-7a274ba902amr3397227b3a.11.1761234855020;
        Thu, 23 Oct 2025 08:54:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+RNZjlAZ/HGhfeZvjXwH2L38Bx85+VCX5eW1fEPyVsXUTievo9QBpW0YYKx7Ywmq/s0eAjw==
X-Received: by 2002:a05:6a00:22d4:b0:774:1f59:89de with SMTP id d2e1a72fcca58-7a274ba902amr3397174b3a.11.1761234854497;
        Thu, 23 Oct 2025 08:54:14 -0700 (PDT)
Received: from [10.216.6.161] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc33desm2913319b3a.71.2025.10.23.08.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 08:54:14 -0700 (PDT)
Message-ID: <0e49a6b0-276c-85b4-3ffa-39e5412db522@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 21:24:01 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v16 05/14] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Content-Language: en-US
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Srinivas Kandagatla <srini@kernel.org>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-5-b98aedaa23ee@oss.qualcomm.com>
 <CACMJSetWthCcJo8v7EuUK-aDKhf5KTNG5WQQ9aTQu62B+E=DMA@mail.gmail.com>
 <8fb6e8e0-cdca-0bd5-d0fe-56b5f6d27a5c@oss.qualcomm.com>
 <CACMJSetTrze028iXmH3i=JguJy=aNOMcnkLhO1ewYNiusvVmgA@mail.gmail.com>
 <efc84b92-43f9-ba25-1259-ae3907273af4@oss.qualcomm.com>
 <CACMJSetctEH4K58R9JvSYNzzYgE0NGMsAr5JxiZ4RH_3T08x-A@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CACMJSetctEH4K58R9JvSYNzzYgE0NGMsAr5JxiZ4RH_3T08x-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEzMSBTYWx0ZWRfX1EJAp04UUzUG
 xzsSUwFfqsnvXfWtj+ypAOcoqgX1BoDDjDSP0rdR48J7od2aFINkm0TzByBbaOUyXed7+6x//YN
 6xOEuikOM0KlHGcQscSjl6gOz/Ax3NCseM5c8ooq2oQ62c/sQRT1bm0+ZqAFvZiNULtwFTBg5vK
 s2Lf9Kn9BT/ttSWEVQUMIHgfgUnHPqvQN+/wdjO5sKro12e0/jPUXB00xRxHI4sqHUaR8RSEZC8
 op620gYOWtzv161i5O3Ta/BIvVniBKnL2feNygRfrkBUnZJYIzYhBtnJEv9A/qLcNthfhTpzvCk
 H6wzEqHwwmAfAa8wW3FHzkmRU4PVuheMdKvgiM+j7/9avV6G5LRrrx/NJtrdnnRpYKUaMjFHZdm
 H/NeAGziVTal7NrH9S0DXH1xVLVy+Q==
X-Proofpoint-GUID: _3BBX7MsZ_mpGRAZoT5LS78vOusZdxZO
X-Authority-Analysis: v=2.4 cv=bL8b4f+Z c=1 sm=1 tr=0 ts=68fa4fa8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=rypWqsooHcgQ8WysroIA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: _3BBX7MsZ_mpGRAZoT5LS78vOusZdxZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510230131



On 10/23/2025 8:32 PM, Bartosz Golaszewski wrote:
> On Wed, 22 Oct 2025 at 16:21, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 10/20/2025 1:10 PM, Bartosz Golaszewski wrote:
>>> On Fri, 17 Oct 2025 at 21:40, Shivendra Pratap
>>> <shivendra.pratap@oss.qualcomm.com> wrote:
>>>>
>>>>>
>>>>> If you're using devres here - at least make it obvious by adding the
>>>>> devm_ prefix to the function name and make it take an explicit struct
>>>>> device * parameter so that it's clear who owns the managed resource.
>>>>>
>>>>
>>>> sure. we can add devm_ prefix to the function name.
>>>> reboot->reboot_dev is an internal member of struct reboot_mode_driver *reboot.
>>>> The struct reboot_mode_driver *reboot is owned by the calling driver.
>>>> If we want to PASS reboot->reboot_dev to the devm_ prefixed function call, we
>>>> will need to kind of split create_reboot_mode_device into two calls - device_create
>>>> in a separate function and then call the devm_ prefix function where we add the devres_alloc.
>>>> Can you suggest a bit more on this?
>>>>
>>>
>>> Ah, ok I missed the broken logic here. Devres should only be used in
>>> devices already *attached* to a driver as all managed resources will
>>> get released on driver *detach*. What you have here may "work" by
>>> accident but that's not correct and is very fragile as soon as you
>>> have some non-standard behavior or error paths. Devres won't fly here,
>>> please just use regular allocation and free whatever you need in the
>>> corresponding release/free/whatever routine.
>>
>> Thanks, got the problem here. Was using devres to associate the reboot_mode struct
>> with the driver, so that it could be retrieved later when reboot_modes_show is called.
>>
>> When reboot_modes_show is invoked, there's no direct way to identify which reboot_mode
>> instance is tied to the current driver, as multiple drivers can register with the reboot-mode
>> framework at the same time. Without devres, will need to maintain a global list of mapping for
>> all device driver structs and their corresponding reboot_mode struct. Then reboot_modes_show
>> would have to look up the correct reboot_mode struct using the device driver's pointer.
>>
>> Hope its ok to maintain that separate logic here?
>>
> 
> Why can't you just do:
> 
> device_create(rb_class, NULL, 0, data reboot->driver_name);
> 
> Where data is whatever driver data you want to associate with the new
> class device? You can then retrieve it with dev_get_drvdata() in
> callbacks.

sure. thanks for the suggestion. That will make it much simpler.

thanks,
Shivendra

