Return-Path: <linux-pm+bounces-36356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5BDBE92F3
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 16:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33478565766
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 14:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D649C33971A;
	Fri, 17 Oct 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V9pErdmI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5F339714
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711121; cv=none; b=ZX3ugQ0m5pbafMXJm46E8ikHjjSyBTmrihhgZTsqVE/6hvQYHC6j+E8Q6RM6Of4LG90OW/K5fgWZ3ZPJqD/wxmoLNpBDg89XWYuwMRf46gv5o6+fFeFK6LmaBeMaBgR57/eBru3yUEb20Bvi7VMJvAIT7cU9BTnM9HusQ/HwAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711121; c=relaxed/simple;
	bh=WvPiwTls8EwkUxiAY19dvsorF4ZCWBhUHbOY89tSmC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFnygRfnF5zpfoa8Fe2fdCtz1Bjl6IkZii+iISDkHUyz60xr/uLl7qxd1c4fPfmHDRWXAp7g430/hcDRuG7xMbiBzvPKKzEWcWZy4upOYJW+1Fz453bmpB+ErkDuN4DZu3r/uIUa4taiqf4r5EGa0R3Gs4f773PrJZXcaXm+oPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V9pErdmI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7psqk017062
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 14:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X6I4YOibOxnI0AMuF9jQqhBPQ7jDc9rITl8QqtHTs9g=; b=V9pErdmIvPeRmzT8
	Fo9QxijlwjOsM/Tl3rHj8cXNaN4ElNURNUB9PNqCurg1wp6PgVRfhZoMOh7ohSB9
	ciz518YlXJjgB5jyj/bWOor02A7aQZurvS4YTPzsY+r9Tu5oczy2q/3xPZctY/1C
	adSCpm9pQU5xAdbuQ8OG2AA5q5QUap0EHmo8sRIMS8e/2vDSe2I3MChYFMbnrRcj
	0pW9Hhl4u2oyBu7QkDidC/eNg5kHGvSBRe5sTWqA2uHy2tD0eazWN+vf0kullEVu
	BYihnVk2HjBjeIWuO+d8aV57ns5OsDa6Pj4EF6gDuLaxQcPyG2K634F4fFPM3N33
	iWbU0Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5vnh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 14:25:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33ba9047881so2754252a91.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 07:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760711112; x=1761315912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6I4YOibOxnI0AMuF9jQqhBPQ7jDc9rITl8QqtHTs9g=;
        b=eXcO8FKySfsqYA39uRFtmJqryFKGkDSVJhEE473Sk0LYwas4QeGBh5bmbAAOWn8DCN
         +Zh5Vem22U0VoXHuYjlovUnJ9vzqxqQKi88Zc8vKpXjfLYou82PaieXY+CN/mPoWIVbk
         iCyjzfqZRp6poRQDPmL2mH3olW46DAReC4KjFb0MUpD2nMnYXmx8gkloTqEN6SMdhDnd
         Pj6B+4ktxT1EBxefzpu2opDCL+S/72vWPvy3LPdQvYfTwVgZ2IWzcrHnEtbPhkTtOKGD
         nPBbQy2kWZ4cobrAHK/Md8wdCUL+jvYhIvHkAXy7Cp4PBzPh/hLhZIdTnugnAgGp+FJB
         s9GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI/aDNhNz3ChsDo2I5C+AiA0ep8Ke3KYMa7VQwRJAXbZpJPjl2e4cIfO2epIz1zmn8eRPxT7S4UQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuZoJLrbk0KUsNTOk4/kxdtPrr128tbNLEbqSOCUIy5d3Piv/G
	XJAkgvgSGTfzgiDcBk9kDcpjO7nzR8GjntZPwdAgC4GrTjj8hw16DqTawwNK8jZl3mqwTUExsdx
	cXzaQU2sbsYjSsFwtnS4GTCoKTi6Z8FpXtxGmfzr602uu3+gJjybn/TLLxMaYwQ==
X-Gm-Gg: ASbGncv4++p2Nkn+HSqyuJ01aCHHbQScJj86F3JtDj33pLisFjUdwYsEj8NHqVTOpS5
	20qi1rQh/6JngsOChJCWnhrSXxioZ7gmeigV/CXQ2g5ldRHm+gHyl635PILRQxlA6dsJ79mdrOj
	s+UwkM6Evpd7dMcBHYnUz2LihL37ph1Dht/Qm9B9uHje0xdm86Acweq+fGQDRdiuPo07mQy6idL
	Hh7w+nLIGj2p5MhS2Mp70SheXVIEBuTB6GcYo2AjysUE8brIZO9qevWQDAFjVuKIQFlIoXbEL+V
	p6hhyWY4CNaxOP1nxuOwXHSZBDGO6Dqdah14N36A4wrKaorBSCQi8ziS9ZmFSsHxgexcEkf5+um
	96IVmu0XVnZQJVJFPyxJRTIwsdMXJ+mrnDA==
X-Received: by 2002:a17:90a:d004:b0:32b:94a2:b0c4 with SMTP id 98e67ed59e1d1-33b9e2925e2mr10031247a91.16.1760711112023;
        Fri, 17 Oct 2025 07:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpzi1hN1yMdY6cSIJhZZaWyqTeCWz6N72ovTz031iQmmVMeTy7gJVlncPuK2idTupafEuVXw==
X-Received: by 2002:a17:90a:d004:b0:32b:94a2:b0c4 with SMTP id 98e67ed59e1d1-33b9e2925e2mr10031171a91.16.1760711111346;
        Fri, 17 Oct 2025 07:25:11 -0700 (PDT)
Received: from [10.216.52.245] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd79b344dsm3149510a91.3.2025.10.17.07.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 07:25:10 -0700 (PDT)
Message-ID: <0683413c-b447-8e3e-8bfd-3edce5a0e14f@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 19:54:58 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v16 02/14] power: reset: reboot-mode: Add device tree
 node-based registration
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
        Srinivas Kandagatla <srini@kernel.org>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-2-b98aedaa23ee@oss.qualcomm.com>
 <CACMJSesvTLe28Jz83b=zfHD2rvmf7-i_2+2DoV=dgooVqFEYbA@mail.gmail.com>
 <fa42adf0-8f15-ad4c-3788-578b1bee1c72@oss.qualcomm.com>
 <CACMJSesxazA7Nf6sAhUT16KfwtiUNjvb5JOEWkEb1B5fJtihMQ@mail.gmail.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CACMJSesxazA7Nf6sAhUT16KfwtiUNjvb5JOEWkEb1B5fJtihMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kuspZr65e0w7vHpmTN6wLy2jDjbWo3fs
X-Proofpoint-ORIG-GUID: kuspZr65e0w7vHpmTN6wLy2jDjbWo3fs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX+PMZOwf5Wlr/
 YSOtKbAQyzas1EdMD43UnUqdTQPXh44drX2d1qb4iynUvScuoAsHFnruhAnzWE5XqNqQSl8cRtL
 lBd++gtBm8ZWhH6xRoxTkXSd53VAiyaYeixiCchg5DMxuux63jDlMatwpkK6vYVMrf+2vCSsvyZ
 EW0B8XD/hhO3KuENiTOFZZljpml13q86/rPnvcgdJuqgcUs/s0CV4H/pJwqK8tKFhVcKG1yaV6X
 PthupzLuEo93LJlj8nfJjzT+Ntghezcg6Lao7sfjmGY33Bvb/N2AN6fvFNsaZ3sAolfbYFnFDrm
 lfNxQf32LFam7x/VRDFaAHIT85LrgqyZFPKny75YsI1MvPAWoEuAsbjZYcToiA6OKklb2GK+mIL
 dz/u1PvDzTU/2E1JlC41T5CBAoiwHg==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68f251cf cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=9sdP-RPgOja0Ng7vnc8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020



On 10/17/2025 2:36 PM, Bartosz Golaszewski wrote:
> On Thu, 16 Oct 2025 at 19:19, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>>>
>>>> -                       info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
>>>
>>> This change is good - devres should not be used in subsystem library
>>> code, only in drivers - but it doesn't seem to belong here, can you
>>> please separate it out and make it backportable?
>>
>> sure. Just to confirm we should separate out the devm_kzalloc part of the
>> change and add a fixes tag.
>>
> 
> And preferably put it first in the series to avoid conflicts.

Ack.

> 
>>>> @@ -123,8 +136,11 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>>>>                 return 0;
>>>>
>>>>  error:
>>>> -               list_for_each_entry(info, &reboot->head, list)
>>>> +               list_for_each_entry_safe(info, next, &reboot->head, list) {
>>>> +                       list_del(&info->list);
>>>
>>> Same here, not deleting the entries currently seems like a bug? Do we
>>> depend on the driver detach to clean up the resources on failure?
>>
>> sure, so this should also go as fixes? and should we remove the other
>> dev_err(printk) also as fixes? or that can still got with the change
>> where we add fwnode based registration?
>>
> 
> It doesn't seem to be strictly required by current code as the users
> use it "correctly" but if the API becomes used in different ways - for
> instance the structure may be reused after failure - it's a good idea
> to backport it. In general we should undo everything we did in the
> same function if we fail at some point.

sure. will update it.

thanks,
Shivendra

