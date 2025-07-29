Return-Path: <linux-pm+bounces-31529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77C5B146AC
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 05:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CB63BEDD6
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 03:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71AA1FF1C4;
	Tue, 29 Jul 2025 03:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dPz6W0iB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5286621770C
	for <linux-pm@vger.kernel.org>; Tue, 29 Jul 2025 03:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753758906; cv=none; b=rL4e8i8u6ikqUMJ/4KayMdv1cAkHsxhrFhTryGwaqDEIJwNPL4h+W0dR5BNvV0LTuGcwxdUAgILom4jhjafftWZhhfajyNfkTunNJ5eGBwdBffp+E3Av0zrwJ1pDlTXXVQxVqKymCd7mMyO7thAkQaU89dcSpX5VgTw3ERmWHow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753758906; c=relaxed/simple;
	bh=GHmdw+LZq3sxJY62O+sHbuH790EMm8iBdrTDQg+YAkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhbIej6oJyQh7TkkFPaMcx43e677B8+EA87aq8OWVM/ZPS9gQqvPL75irdPgD2/nmUAgD4Vr7xYZqAfh56aAdjUraujtSrbpGjocfgV+olZiFyKlyhIxDZui9cDvChwIKKg02yQcjdqInqcZbYox2+xwvECR7WbbQnO5aAi3k8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dPz6W0iB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SLTGpG012109
	for <linux-pm@vger.kernel.org>; Tue, 29 Jul 2025 03:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+KxXIkqbzjBGr5vRnRk2sdhKE3MD5Ak/KadxWElxQAI=; b=dPz6W0iBPnAWNh0X
	289xMEPISgZerETop/Q3bva5xdQODTGleBgzGdpB5Y8lIbHh2UbKy4SXYbHCNUfu
	OWXPP3T5OVTuE63q8qsloEyDTydSteFO+nNgYrrdhhwLPTldHk5Kdt5tqzklrQWp
	eou+l1tj1tk3qRfr6lX9we7eftZx8q4SOhRVds+anP4NzNBJhRTldCAvBxMie3Qj
	JFh8ZP89+w/3fHqH306nfecyr2elObnqcPuqtfBtQhTneBsRxQI5yJsBLM0tx60J
	3Zx8uDPSQK0nXktZVMsAfWPaTFhYjLoNDLM/u3wN01DdDkBUDUnyCCWTtEJNCwX1
	KLECBA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qsk6jt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Jul 2025 03:15:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23fe26e5a33so31482895ad.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 20:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753758904; x=1754363704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KxXIkqbzjBGr5vRnRk2sdhKE3MD5Ak/KadxWElxQAI=;
        b=VcYnDZ/I+ObifdiXCS79XLPc3zEXnfIB+M7nXrBdPjIPwlyMDHmO/FZoizISM3iXa5
         52gIofATb4lkzSuekPCnFIyjr+HOmOlF0fHV99JXxUg/kc6fsW6eHHwJ6JV6rx0OIdX+
         GGkdB1N47EF6Clv7jvlass/Oev+3VgftnjI+eLv0GHLBHf2yG0dHo2L7mGDAL2dLM2gd
         8ZA0L59atzON80rP6rzEMs1f0OTBHVZ0N/ZbLF4CHPhjzk0Nbl9mEDQIljLVIL/aw5WF
         iflvbdqgCzIjgjqbc/z5epkfgZmMtwUawjF8A0c63kqqptoXc6nwTBx0idz8MuDyOfM8
         A00Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUpZrsh+s6OzpoDMLhLfKkBROQwocgs7Dp2M4Bf1ShAVN8Khp1ih3EbdXi8E1etj9oFI0ThCPzcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0htVJ4acsVTZMEu+QRRmAWkbjAfujt18jzEXzLt/C7OZ52Sv4
	k6i/wkRrCCOAXPg095m+zujb5+mItmx3lZVlo+MC/299Ke8nrSGD9lxHN+YxOgen7m/unwcZx/p
	BMpajpQicuMTJ2VOozld+O33gyi2o3eMNGNxpXf/OLBPNt4vEksLIPg3JggbnyA==
X-Gm-Gg: ASbGncuU9kOBBd5fI7fq+u5ByRWpIpIHI7ll8+xwq/raprfLVQPN7fjq8z6GLvbNCMj
	qqR0Wdj+zqagCgnVTecYh1nhMs8gdT0xHRjGrAkAKlWkJtaFV2jhnUdEQIHsh2U1eOrcwBXRdv7
	ayUHgWAwF3cbN9QKMnMCSgL9Sv1ND/FCRTc5GZADa7vn0sS9n92WIMbKB7BdFOuKon4OkoSdbwK
	dldGzEkrD7rKZd3vKVmY1FnFTxYqsPNcvoYPm2Uf7Zc+kTOJWE4IxNCAJQk1MZFu9U3xMdEL/PK
	/MxqqFAdMEX95dKCn0z8DSKBS4r7Rw6CoWOTQExoT2QOBiLnye/rlmWNIH782WexXD30ePm4PhK
	ciQ==
X-Received: by 2002:a17:903:b50:b0:240:1831:eeeb with SMTP id d9443c01a7336-2401831f1f9mr77117145ad.40.1753758903611;
        Mon, 28 Jul 2025 20:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3+knxDm31O2rClWjozM3+CecgvNZoNp+cf6nrVr5Lm6XqDELyjYKUNByBB9MayBRtK3ee3Q==
X-Received: by 2002:a17:903:b50:b0:240:1831:eeeb with SMTP id d9443c01a7336-2401831f1f9mr77116615ad.40.1753758903134;
        Mon, 28 Jul 2025 20:15:03 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.228.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffdea35d1sm44404645ad.28.2025.07.28.20.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 20:15:02 -0700 (PDT)
Message-ID: <9b9c4572-9afd-f77e-07ea-ad1673feee47@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 08:44:52 +0530
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
 <2a39c0ab-edd4-402c-95a0-a6286f03102a@kernel.org>
 <1926e6e0-70a4-67fa-5e91-cd0155af1eac@oss.qualcomm.com>
 <2d672126-ca4d-411e-89cd-f40f8d8a4f5e@oss.qualcomm.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <2d672126-ca4d-411e-89cd-f40f8d8a4f5e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KdDSsRYD c=1 sm=1 tr=0 ts=68883cb8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=URdbDvd2+uEZUUOZgz/1Vw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=jnCx6B5Jve7-ZDeCMK0A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 1ERkV84MbXsnTcAB55upgC7dqajxYqEs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAyMyBTYWx0ZWRfX85Rw09hN3Jq5
 pGmuE+bw+2hYxuOO22WdsSRQGtrbwFYTqg3gBOz+cHJfofUGD7enLHQGoL7qV5RqkmSpDBaU27k
 ftXQULUSf9b/kMA7pdPnK9IyHsTDDa3+Ahz9p9LTWu5t4YqReFO2GaJaq9fSErb4fYMwq/BMePk
 6XFnkWigHODnqB9dZv90OlXvNPbXQN3631wj8fZsATvzM4uJul5tm9K7Ib82M2UsRnLnfo16ag2
 Ksk67H/2tinbLij1zzM/8gCM1745xH8RthMVZ9LlO2qeOJeL7+crfG/cf679PbQfIzmEdGDqqL4
 Uqpr7DixwGjvOQk+ax2MT2CGIRIV/Eg7hhxxBI9S0UG8CJubqs/HyXVmX0ACM4RZlkl/6H9u+14
 sB91+iCpuB530JpEIk3WU42XObwqxMtHfqdAi8fh3KTDOGQ1H+aMhwimNiGwSPiGcWMKIgsx
X-Proofpoint-ORIG-GUID: 1ERkV84MbXsnTcAB55upgC7dqajxYqEs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=798
 lowpriorityscore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290023



On 7/28/2025 11:59 PM, Dmitry Baryshkov wrote:
> On 28/07/2025 18:54, Shivendra Pratap wrote:
>>
>>
>> On 7/28/2025 5:53 PM, Krzysztof Kozlowski wrote:
>>> On 28/07/2025 14:03, Dmitry Baryshkov wrote:
>>>>>
>>>>>> and the reboot-mode is defined in the
>>>>>> previous patch. So, I'd assume, the path is defined.
>>>>>
>>>>> As I said, path is not. only psci/reboot-mode is.
>>>>
>>>> Do we have an _actual_ use case where PSCI node is not at at root node?
>>>
>>> Yes, many cases, because it belongs as well to firmware node.
>>>
>>>> If not, it's obviously a deficiency of the schema. Could you please
>>>> provide suggestions on how to describe that in DT schema?
>>>
>>> I do not see deficiency. There is no ABI that psci must be root node, so
>>> there is no issue to fix there.
>>>
>>> If you want to add such ABI, I will answer: no, don't, because we do not
>>> want paths or node names to be the ABI.
>>>
>>> Compatible is the ABI.
>> Will define a compatible for psci->reboot-mode node and use it to find the
>> node. Hope its fine to define a compatible for reboot-mode which is defined
>> as a property inside psci?
> 
> I think it was more about finding the PSCI node.
can either find for psci node using psci compatible "arm,psci-1.0". And then
look for reboot-mode node inside psci.
or can directly define a compatible for reboot-mode and find it using compatible.
Is there any other suggestion to find this node? 
> 
>>
>> thanks.
>>>
>>> Best regards,
>>> Krzysztof
> 
> 

