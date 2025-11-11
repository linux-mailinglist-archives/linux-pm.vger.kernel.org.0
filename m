Return-Path: <linux-pm+bounces-37792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787C2C4E9D6
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 15:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3979189B9BD
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA133123E;
	Tue, 11 Nov 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QWUrGr+k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="htdqpTPJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C943112C1
	for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872661; cv=none; b=dIqf9YXhs4i+xqKYXDO3wDhbNA5HUvzndmWScYLD57NRSGEeqm1OoTf33ByE13E0oU3IE9NbRocxI6UkWiV4aPfX3i+uf1MkFAy/zbnsNrR09Yl4PDl3nG4O03+G+9FjKHwmZYczdTktXAC7PYF2lGQ4ClXRU08vkvDPpf4G0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872661; c=relaxed/simple;
	bh=/DjHAnZy4MYKYeTjY29Wdb3h/RmMQ58/dPEUxj/w2VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYySqOHgqgKUxYyA7DeIiWNdaruIwA0rPDUkbfDVwOEGwlmz46V+Kiwk3fy8aW/bgjNce1/dOMeZLQlOcgLn348y3GJD69W0aMgmIPIzHU6hei5JHmUFj4JH56lpAXJc6Cv0rC/tR7dbTzw0T/YxYiT5qQgMiaoAk2EmDhHQpO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QWUrGr+k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=htdqpTPJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABCpi472320822
	for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 14:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VQKfOoNTKGaeq2MEhQshMbwKg2l1HZ5ShY4DsqQAqqc=; b=QWUrGr+kybBXpAqZ
	eVFNu7En4AnnweMfH0ZrlAKNOIic0TGodp3EwaWpsweDNv8p6nvuCr2+OMNuoi4S
	UDbyqqWNpC7buLR2zqI0WZtdLTnINWPYwCE+KroPuQvc1E3UOOxPGfPQhGERM0eB
	gFvvj0O1hiuPyFi6v8BTeejolbBVamqusa/i5b14m2NWYGO6UAm0mcjn5+QQPWLG
	BBDOVmx8Ihi3BBO8ZVUGnHEAwSKEZ+IGxfd2u6As4IH/wcTMV3o5mL3bVwwA2OEG
	uA1B5gpDOluLxJaQqqj40x/lgsoUaYzyc3w95onaLmBSbqwREosztjQRdi8SgCWa
	QN+GNw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abpy8jr85-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 14:50:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b62da7602a0so3869038a12.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 06:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762872658; x=1763477458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQKfOoNTKGaeq2MEhQshMbwKg2l1HZ5ShY4DsqQAqqc=;
        b=htdqpTPJGQvUnEGfbjzuaPrCSozt/d2Hg3dEUngvfYPZ14qInWcvOEZYFi21U5K+Cu
         P5pVBp4FOWteUwckDvExa0JKeFrC8fWjeLgJYjDEejWkRqhcyof4lf6+kItql0Yz5D0E
         pbzVWtYRgCOwHIGXlCKhMuwn0Emqu2oNoZXlqZcWOuNY2EKfeAQ2g7Zje3UT6bF8IKCR
         qjzDc8Qn3fmrEYpKmVhc84rY3MnLMcIYGwo9KiICcWuM3aNZ94xtcV5L2DMrGW9wC8aN
         eVE6CcIv4fSus0Jwp7/oQwSl9VSBnIwB0t1+8UXzM3NXpCHJvEjrnLNTuntB1ZTOs2lm
         f/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762872658; x=1763477458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQKfOoNTKGaeq2MEhQshMbwKg2l1HZ5ShY4DsqQAqqc=;
        b=C69rdNOPYu3xzjpz6Y39x593Aj7zgtHa6ICW0jXeWTj70FIqQUketupW/3hJ8SSHRp
         WmCcsMn0NMw3CcxZo8u3FIHjHGv7vH9Tco79aYVzst3rKTwy0gtdsTTLrCGttXHHVBDV
         KZXRpncv1jykbszxKe5RqYK0DVO8OCINC5L/HzRIX32o7V9e9qDIdHnl5vVJSkL5q9ql
         tk5nyzCWtbrMGZt58ePxwMu4SaSad9QN+dZrPi8V5w4RebhTokFcdrppT6m5y34TYQpS
         /9dqL7yycVT2oL/loUbhwHszuIunkidA4vk8RhAEYYNeGYlY1QAljMusqCUClAJpMg21
         PToA==
X-Forwarded-Encrypted: i=1; AJvYcCWweQauk8LXbj8oHstZl1y+EPmK0IiQnqSTAgWQxip74Tbj+kGAnHdqeGDSdx5cVqoTxs+AtijTbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfTTjtojb6En1CEf2FSk6sBxT+phIkL2KksFY4u3Fec1BSbiBD
	V87GyqKXVcuRNUSk2qsPDKJTNjqLwvM5C1U432FaXffXFbgPeU29RTCcXIQwlDd+hHytTaB3EtR
	28FN5MvBdB97iGFEg/vdhcLdpZVW9wZn0ccTzXRnsgZuvQuimj5lVi8Oz6CDPBg==
X-Gm-Gg: ASbGncuAM522B9x2+iEP8lSo2M7rGXXsBvZrjcOH+OAoji1hwquLERMS/LWAxeTa2ks
	GxKu1uSX1Kt2MI2iImpKIHVr1YcizG/N8vBleq5cR8dQavCGcpET0YaUdStX/kQnjSfePcN1Xil
	9fCFnZnEkz+R4VV0acnrEvMC4uns48oSE6y3XnAk4fgACpXbu7/oisQJ1CcwVQHeE/phrnmKxWj
	4rKHVYcqyWN1LGHHGPJi9b23VfdnFK75ZZ7/Q679DYYrxOqMMXBuxexNvPSLt427TDfsg7iNfV9
	ziZJUi6xa1o/z+erd4kxjXcJduq946oVTFArVclX2SBjm5hBtwPipLda3jmoXmlCQB2X5u/FSRt
	dvchf1Pk+Flv6BMIddDy0npkXzxGejhdu
X-Received: by 2002:a17:902:f791:b0:295:9e4e:4090 with SMTP id d9443c01a7336-297e5712c4amr144629085ad.52.1762872658241;
        Tue, 11 Nov 2025 06:50:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeUjej48jQjUKrbDfpu/j0dgTD8cgD0cCmhW/5bvBfjdYMThBsF6L1pVJDVnEci/p3XVNrpg==
X-Received: by 2002:a17:902:f791:b0:295:9e4e:4090 with SMTP id d9443c01a7336-297e5712c4amr144628625ad.52.1762872657520;
        Tue, 11 Nov 2025 06:50:57 -0800 (PST)
Received: from [10.92.180.19] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179e7esm15787230b3a.46.2025.11.11.06.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:50:57 -0800 (PST)
Message-ID: <5c83c9a1-e123-95bb-1434-588ee8c52b25@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 20:20:43 +0530
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
To: Bjorn Andersson <andersson@kernel.org>
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
 <681a72ba-d8fb-bfc2-d2bb-d80ac667bc5c@oss.qualcomm.com>
 <zejaqakbtufwzlzs7xc7xzxezcylqjkmu4nne2mro4riuhgbkc@hlgu3u2w36bb>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <zejaqakbtufwzlzs7xc7xzxezcylqjkmu4nne2mro4riuhgbkc@hlgu3u2w36bb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PVB1YW4_H_vTyVO6HiZZhPs7FzibKyjj
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=69134d53 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=WYJ1fy7EX9OiPUot37EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExOSBTYWx0ZWRfXw3X+dKhB07IJ
 LHthm59V1b+2BI56X/9Q/E9Fi7z199exMRp841ROKVgd+yUiWEx9YQjg9+FLKPFNy7UYxXmrIT7
 IhoELIjN6GIpdgdd0JGr2QkDI3IQSu6FggKGZwnxBJxIi4RoKoNcZCYd964aA/x5of3rRCoPjIT
 X0J5Km3pkyem23Ji30kW8T+JKkkho0oXIgqyrRzF1mKApK5b6rDOaVKMwEFiafcSgBvoie4LIYG
 Z9J6A/dQMLOXUXOij67+4a6cAlruxKfJqwysMh/i0app7Vx+QTM7iMbKMxN/xW6G7wQ3J7Sdj0t
 OVkEZPWrz0mitFWV4CSrHl5tRMkgNNg6U+sflO1+koxQsuTTUkmRYZ1A3/8Qh3TnP+QN8pn89S3
 yvgJaVNA1FlnFC/mNnZgmTCyYUYNiQ==
X-Proofpoint-GUID: PVB1YW4_H_vTyVO6HiZZhPs7FzibKyjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110119



On 11/11/2025 12:03 AM, Bjorn Andersson wrote:
> On Mon, Nov 10, 2025 at 11:22:40PM +0530, Shivendra Pratap wrote:
>>
>>
>> On 11/10/2025 10:00 PM, Bjorn Andersson wrote:
>>> On Mon, Nov 10, 2025 at 07:15:29PM +0530, Mukesh Ojha wrote:
>>>> On Sun, Nov 09, 2025 at 08:07:16PM +0530, Shivendra Pratap wrote:
>>>>> Current reboot-mode supports a single 32-bit argument for any
>>>>> supported mode. Some reboot-mode based drivers may require
>>>>> passing two independent 32-bit arguments during a reboot
>>>>> sequence, for uses-cases, where a mode requires an additional
>>>>> argument. Such drivers may not be able to use the reboot-mode
>>>>> driver. For example, ARM PSCI vendor-specific resets, need two
>>>>> arguments for its operation – reset_type and cookie, to complete
>>>>> the reset operation. If a driver wants to implement this
>>>>> firmware-based reset, it cannot use reboot-mode framework.
>>>>>
>>>>> Introduce 64-bit magic values in reboot-mode driver to
>>>>> accommodate dual 32-bit arguments when specified via device tree.
>>>>> In cases, where no second argument is passed from device tree,
>>>>> keep the upper 32-bit of magic un-changed(0) to maintain backward
>>>>> compatibility.
>>>>>
>>>>> Update the current drivers using reboot-mode for a 64-bit magic
>>>>> value.
>>
>> [SNIP..]
>>
>>>>> +	if (magic > U32_MAX)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	magic_32 = magic;
>>>>> +
>>>>>  	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
>>>>>  
>>>>>  	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
>>>>> -				 syscon_rbm->mask, magic);
>>>>> +				 syscon_rbm->mask, magic_32);
>>>
>>> As above, if we're no longer silently discarding bits, I think we should
>>> compare the magic against syscon_rbm->mask.
>>>
>>> No need for a local variable, just type cast after checking the validity.
>>
>> Trying to summarize below why we added these check-
>>
>> the patch in v11 used typecasting and did not have any of these checks(link below):
>> https://lore.kernel.org/all/20250717-arm-psci-system_reset2-vendor-reboots-v11-2-df3e2b2183c3@oss.qualcomm.com/
>>
>> As per below upstream review, type cast was removed and bound checks were added all-over patchset:
>> "As a general rule of thumb, code with casts is poor quality code. Try
>> to write the code without casts." - 
>> https://lore.kernel.org/all/8d4a42b6-657f-4c30-8e25-4213d8d53a89@lunn.ch/
>>
>> We can revert to the typecast way. Please suggest.
>>
> 
> Okay, I'm okay with Andrew's original request, stick to that for the
> nvmem case. Although I don't fancy the name "magic_32", and would prefer
> that you just call it "value" or something.

sure will make it proper wherever applicable. 

> 
> 
> For pon and syscon however, I'm wondering why you have ignored Andrew's
> other request from that same email:
> 
> """
> You might be able to go further, and validate that magic actually fits
> into the field when you consider the << pon->reason_shift.
> """
> 
> Writing "if (magic > U32_MAX)" in a snippet of code where magic isn't
> allowed to be more than either 32 or 64 is misleading.
> 
> For syscon, it's true that the parameter is an unsigned long, but the
> actual limit better be based on syscon_rbm->mask.

May be i was not able to interpret it correctly. Basically tried to
make sure that magic that now coming in a "u64 magic" should be passed
ahead only it its a 32 bit value.

So should i get rid of the checks done here for syscon and pon?

thanks,
Shivendra

