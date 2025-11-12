Return-Path: <linux-pm+bounces-37865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B290BC53C66
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 18:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DB53BFD49
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 17:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB419345CBA;
	Wed, 12 Nov 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QsGiCItF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BjkvbOxN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915FF3446AD
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968599; cv=none; b=faiyvG8pyESfKi3FQX8OaNfUpQjBKe9HeUUhm0NmbnjH6GSwFGPv9JrV4ipK+NC0aMNd6RNM19sA44CIEbtrsEl8sZWnRQg//G1fVwdtma0H/aPs5ZeftWVNQQ+OjXmSjRRopNmrfhG0W3nKK2+dUuhVSbfiNseeo+qtMPZQHjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968599; c=relaxed/simple;
	bh=xqPVcranU4xmlvFEDnu1TmacOpsOaBbCn1NOFJMmDWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqJ86qVenKiiy6KLZWK21MDO2Vad42j6hwR6RCaCTJ2D+dDowVV2Vc7q/8ARAdJzdwIMdqlRMCPc6JFZvpHM7q0eVk78JP3y2OjeWFiC+LpLhLCNV9/LCXrUvN+2WJHx4uEvNdhbto+TbhTreuDo5kMRU3pNeLNKhLshD26nW1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QsGiCItF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BjkvbOxN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACGZVaV722118
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 17:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e08UAvHE3HwHNhFXMb9zeUVXGG109BSK5gKH53JPKPI=; b=QsGiCItFKl9i1/1T
	pJ1HGJCr56iP305Q4gOaPjrzG9V/x9SeOvbr7KsTAFso6WUG96K4SDJrprm9+ccA
	dCvNn0xK5lvOfTsx+pW7UhmnCDRTfQpfW7ZWG13akTzS76gvnnsOSwh9NqNpcg/e
	DyZl7nptP2i3tQ4JVK8fZ7ws7eT4aTKmI9X5y9ACTJVoOoYgqLQi5yfEu4qvxvNo
	c2mpyl1eIIUe9Aabs+vXHBOQtkmNtADiDaZjePpQjbXipRvRz1rg561LXYZ3EUvq
	+OeC+7tATnBTWPvQvilFLhPEerYD4mAfyRWwNB67a+EH7MmBs5RglTrIIFwF/Two
	JO5hyg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqu1sh8v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 17:29:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29846a9efa5so23975295ad.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 09:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762968593; x=1763573393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e08UAvHE3HwHNhFXMb9zeUVXGG109BSK5gKH53JPKPI=;
        b=BjkvbOxNSA6qTUcyczOIKqh5gr2YcLvAAUg5GTSZnj580NuEnp3Ocf5CAlWfZEotVX
         FvRuBBrVDbBLbKQv02KM4FNz9/MOJDM9VRblANjS5VYqWgDPSrfEpPoy3JERw94rpyoD
         0FPSlponXd6scKezoZKqj5dKNOnoR/WWXWSnIeXc5W2wVAuJ2no3u1IcACIMzKl8rBjR
         g58y2kHKCMGBUN9XmMBM37cacNN+DNfPWLP6nxqPCabC6IpQsiSiS+Pj7uhOt4AsYY6y
         xmWfSh44xVd7toAS5fuxzOv0n2ARfJ7cNVyhs0Gqp8uIF9nszV2F8ZJhHarZ9ro/uKuc
         E2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762968593; x=1763573393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e08UAvHE3HwHNhFXMb9zeUVXGG109BSK5gKH53JPKPI=;
        b=kt8Pk72SLuu9+d1d7zsgWJAbLZi/C9ObiVcXCqBN7pHDhQEzTan5iwJXdLm5cxcG7d
         C3Rtt4xpGgOBFcOY2OcyQylu13OMdPZMY9Ad/8MR9PxMpEdKUs+Vi8Ly2AA9YJQ78CY9
         NlDC5POWysSDEgdorVdUfgUg7zyqyxkLzFlhaWUS0AzYH4CPpa6My4aYKt8/LpYiN619
         yXSw+GxNLLhyMMpc/I0q6Etys0nY3GFl5kf3VOl/eS63mqpphuUUOsOgOFWORW7q9feF
         WSFu7zxiLlI/PzYd0S0wRr8K2+vfzE1pMaD72V5Fi2x6b4xIKGSPRMj1ShbKsyRPUYoY
         GPvw==
X-Forwarded-Encrypted: i=1; AJvYcCUV+EZaFbGWvgbDjVGYmdwplIbZkqvvgvDAVWXrqyaKf/hrBVbLzutGIKdqv8oNj/uME28f9FqvUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Ndqf32IQAEDDd2jwYWYVvk8/Lnfz3wE5RQ5zKawvmGjDeGJh
	40TbA2pvnYo1xIk16XJeKnJupeAMZH8cGims3YMjRBTu3b+kiSeSdDAZlnU0QwTwLlC+SGQwP/D
	j0e7UxSp0TnBeW/JYQkQBXuTZ+Oj/yQfwih7SkTDeiyju5ujq/IqCxryRbmRPotryb7bGFg==
X-Gm-Gg: ASbGncveSmKpklxB1nmE5XPpzZuC6hZKAT+YtdEiwSVxbTpMs0UO4MGd0eREd7OrqU2
	sYHDyafqA1c12AjLvUq02ZWRf5KvsAYZEP1RVmStzA33hSs9TROoUYEsjQeJ+ItzH3PhmeLVH9w
	xtRVEVmLgp3moYE312MDSxueQkhytdhexGuOd91ZB0pJgicsa1Ve15RNYmkp+ox5wsbK9PWF//e
	XP3fCUoUpMgHc3sykxbD83Qo5Jv83jlldkBFVWRZpnktFE6qO2i7LubAk5NhEnl1kS0jpQWOhQl
	LGvV92qTHEclMdLvwY6nerAfplMiq6Yf7Y8zL6sUz+kng06b4LgCZNGu+4OZ6OvZZfU5XNGZKoF
	1NUmigVc8Byy8s/ajCBH8D3Frpmh5RYm0
X-Received: by 2002:a17:903:1211:b0:295:a1a5:bae9 with SMTP id d9443c01a7336-2984ed2594dmr36215615ad.8.1762968592841;
        Wed, 12 Nov 2025 09:29:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ2HzLkIezdF965YJswc0FqGVDKJyjtb+WQ6A5da9sGC1VvOWAJVcFOByW6f1oWaWQ3aYZ5w==
X-Received: by 2002:a17:903:1211:b0:295:a1a5:bae9 with SMTP id d9443c01a7336-2984ed2594dmr36215185ad.8.1762968592289;
        Wed, 12 Nov 2025 09:29:52 -0800 (PST)
Received: from [10.216.19.73] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dc9ff68sm36244955ad.56.2025.11.12.09.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 09:29:52 -0800 (PST)
Message-ID: <4d344e64-ed4f-eb9f-60e4-1267ee53b839@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 22:59:39 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v17 09/12] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
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
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-9-46e085bca4cc@oss.qualcomm.com>
 <3gvxaeun4i3ajoo3perjvdsohmtzgstsctdilorr65eexesxfh@hyoinhvkgi3c>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <3gvxaeun4i3ajoo3perjvdsohmtzgstsctdilorr65eexesxfh@hyoinhvkgi3c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pO6B6ups7q2t5k2Aa17beR0a8kT3p7Ve
X-Authority-Analysis: v=2.4 cv=Hpl72kTS c=1 sm=1 tr=0 ts=6914c411 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=H7Ky-y1aa2JJ90q3J4YA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: pO6B6ups7q2t5k2Aa17beR0a8kT3p7Ve
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfX7A/lWUlqkCK+
 CN8CoyT0UFhYczBJMvT9P3oB/R8eQAKvohJ1MUDmPnxLwd9IY08ImAZMqqrO3wc3XhwY5zFqhb9
 k4GHXfTp/vz65xFFBk+FNQO7WAmhhdEPvV+58g8zHt3MzkMpc3pIqM0F7kuN2dRrXycjRPM6Kt2
 MO87y8f1Yp+ErG0fhER3Ws5a6X2hpHk2IAfxoLo9lBiTzrSsLo+jmh6GPXy5oRt+uqmDKrHcad2
 qtyElgyLXBCaPSs3rOqFMdRn3owyOc8rZWr+DkqaoQGJRpKX/hzuREIx3BQV/SLL/LuofMRR2Mg
 Q2NayowXvqvsLrcDlk5M98bae7ykeTYh5QsFzlkX4Sx25B/yqZKXnA1gjaVnjGBwLBgluSGocJL
 F4vXinC9uiuXqfhNp5Yi1eaTDC6wsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120141



On 11/11/2025 10:29 PM, Bjorn Andersson wrote:
> On Sun, Nov 09, 2025 at 08:07:22PM +0530, Shivendra Pratap wrote:
>> From: Elliot Berman <elliot.berman@oss.qualcomm.com>
>>
>> Add support for SYSTEM_RESET2 vendor-specific resets in
> 
> Please rewrite this to start with the purpose of the patch, introduce
> the fact that we can use SYSTEM_RESET2 to affect the reboot mode.
>
> Make sure you include the information that this isn't broadly available
> on all sc7280 devices.

ok.

> 
> Please line break at 72 characters, not less.

Ack. will keep note. thanks.

> 
>> qcs6490-rb3gen2 as reboot-modes.  Describe the resets:
> 
> This looks like the header for a list, that documents "bootloader" and
> "edl", but it's just one lump of text. Please improve the formatting. If
> it is a list, then make it look like a list.

Ack. will update this commit message.

thanks,
Shivendra

