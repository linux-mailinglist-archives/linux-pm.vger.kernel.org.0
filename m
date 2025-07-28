Return-Path: <linux-pm+bounces-31477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 106B8B13A32
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 14:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C389188E64A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 12:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5409526158D;
	Mon, 28 Jul 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXmc+B86"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91361B412A
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753704249; cv=none; b=qpAevwKaD6lLlN83bVzHHPHF5TgUgMqxMpiVXLJcCX84nO8Je65dmL9wRJUZhtzRJrHXHhesSfkRjHOpF+eU+8dY0w65xXJm3V6+SYzBT9ELvz9fds/ir4wr9ujv9OoQYxS8wWgZpdMinNtdRJu/bDJ4d8vOUtRMjOsqjNSDwgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753704249; c=relaxed/simple;
	bh=5rAvbVGtB7lFEOgjNCztAzaQGPyJ6cuIh1BF+HOX/d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZiUHZWR2Wp+TS3JO8Y8/JRfBX+NZnvLE8h6Zk5Y0Mc9j8Nl+PBg0mnA0f1TeHTwyDI4RRdUP+2bF1AhBCYEdk3Y+MIFXjxAm3h49EKbnF4uU1PagFmoS572V1lWEnsadZH0V6aUtqttulVMtQwdCb6W3Wubpx74YUJ79E6Cuwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oXmc+B86; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlKLe027687
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 12:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	66vOC3/qlK+MyX1ZwSFINvuQl7YeMvvNbUSCtqoe2Dw=; b=oXmc+B86PKUWLJVm
	QmOpYEtQ3X4JsvXSyBAVaGeN1yGLf7GeUn5xEjkuzpWAWLaO6HyuZWPubGDWatMF
	2RtLNtrcea4FUlk1nFQ29VO9pWFmUWWeypasRwXZtoIhJS+bP26mbjzM/fdYObcD
	EsZ6QMmFwGbS3EwxC6tXisZM+cPgtOJWcPaNpmngAI4t+5ysoc1LjuSvHUHtsdci
	hpC7bRxWV27vCsWKzkEnxaAy3l4RpZP2QOoH5Ke1xtRHgmxceUPBPkoUby8J2MG+
	GPeER5xrSghPrUu2Z4HhXPbu2ZZE5wekUZ/5S9xfcCOR2v7Y09zGMwSg0CV3X1Ux
	JSf9xg==
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860enspnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 12:04:06 +0000 (GMT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e29aabc9cbso41765625ab.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 05:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753704246; x=1754309046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66vOC3/qlK+MyX1ZwSFINvuQl7YeMvvNbUSCtqoe2Dw=;
        b=AQNK7r6iC0b7vjHUAKYNqJecHXuzsfEy9YHIJrFpSGPE6fexh3fFj41TM4PND/54zm
         nrxjAglYh1j+WeE4rlFCP9YnP2GPgEXDBkj9BGz2GGAd73RA8ukOdtSQhp8jaVcRUp6k
         jw5IuGATcqiXsQftSVFlMPTZu5CcX2EADFKceA3SMeCkmBbCCQdrpOPgnK5cS+AJ0TkB
         8gjiRd/8gvCvkgbFXIoq2Ck/uzZwOY/cw+ThdJvMXjSJyNUtf3LCJoH+SULyCH9AYam7
         TzaK6DzxW8EuDrQZcGhwLB4gTvp1QC1yiFzCf99yqx/hvMhcB2yQAtI/3uHBBWyDpo4U
         NcIA==
X-Forwarded-Encrypted: i=1; AJvYcCXiGvFNNf2qgcNzxbah8OcmugVMfMYs7SapVs5nokSSPsw3y7D+9WdyFvQh7BW7x7DdLOStQoNX+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu0rPWbj2+8U9DprcOjh7e20NjKqmTOcVgiJVyobb9RS6gCWUM
	xfNKz0BXvm1rVhv3lGo2VLzXdTWyvqx3mfbUSNwHbAoZrC/rmsnI0lXrJ039ADurxu+4bDPROz1
	ADNUGaBM4weDJ64aSt/yvZQOlv9iEpfzRyAxt40ppRWQ0jwf6Y6crgqXU9ntfwg==
X-Gm-Gg: ASbGnctVUhHj/s6KmV011aMPt3hfSXm6fD7+5rbdfyNRD3MVYyzN0Qrc4lCnVaMvkRF
	Hm/xbav1NCS6XsDRt2HWwLcrnCYsVIJ8KVG7qdbOeIyEgxRTZeeY7ybB9nFpJMj2jKw+Xse1h6w
	nDHDKOrBbKd9fHt30nuMYTKrZE80fn5Dlb+EiypmcViFSPhSrzrrJwK4R9hkTD+DE79bUIebjsd
	3NCg4d//9z7r+QMWc0E/P4lvX6ENzArQIO2hAEWP9Ih72KguhhnOjJfhsLlHOmvd8lCiiLDJnUw
	uZeELQLn7nRQ/kO1SHeYtnaJtZJjBLOMPIlr6hP5U7EAnRe2Wg6IRFu0UA8iPM83fC0w1KdRjbM
	+mYVUmQdizdjZt/kHn3DHKb9XB2RIlngdIct0JGaTGLNh/mT7Tpv7/cMqbxqmIxjCaRQoa8XzsQ
	OkwFZjX/msqnyHkxDkLQ==
X-Received: by 2002:a05:6e02:3707:b0:3e2:8a58:7f67 with SMTP id e9e14a558f8ab-3e3c52e6ac4mr173518185ab.11.1753704245656;
        Mon, 28 Jul 2025 05:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+zIpMz+L3rJ5NWcaLcGYendd5twzo270GnZHovgracNvGxzH2qdsYSFiW1xnhFedlu22Z8Q==
X-Received: by 2002:a05:6e02:3707:b0:3e2:8a58:7f67 with SMTP id e9e14a558f8ab-3e3c52e6ac4mr173514325ab.11.1753704241592;
        Mon, 28 Jul 2025 05:04:01 -0700 (PDT)
Received: from ?IPV6:2001:14bb:cc:47df:318b:ca77:b793:45a5? (2001-14bb-cc-47df-318b-ca77-b793-45a5.rev.dnainternet.fi. [2001:14bb:cc:47df:318b:ca77:b793:45a5])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f42b6edbsm12086391fa.98.2025.07.28.05.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 05:03:59 -0700 (PDT)
Message-ID: <5e2caeb7-360a-4590-a36f-ff1ec4c20d31@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 15:03:57 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 07/10] firmware: psci: Implement vendor-specific
 resets as reboot-mode
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <bcef34c3-98b4-454c-8138-c73729e17081@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7L6YBaTlCx_UFazSRJZvfHtomVcLLJQc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA4NyBTYWx0ZWRfX4VrF9eOU5ulv
 XipLdPKULCAwjQumftdKOFYR+o2fRLEWfTQPfSyLRUCXe89secZGO3xb97MRqaD+dPDt1V3izC/
 wpUqZdE0rMt8Zyf82ihvcPI6fW+Iq/6S6pIMCsQU92rtLmuFWSqXqOJpLJ+2ifTjAxhjKIchDuR
 ejilh9IILsSHbj5r6F17qBfGdJio7MIIBgoJGAKbsLUgWL2d04XsyFpv5gbsCmKfmfps7WJASAU
 fRKTQGQsq2MUei6BTgbGcTOAXcgF1EiFfAAo7tlhVkBsU28C3QI/W0AML68gacFyMfUR1vZq5mW
 9JeqIug04HP5bigwVZ44smkWHy8TfTB/kI5ricalNkAjPK3wdQN3ujrKtdN9tH+0YSTQ9olyddZ
 CzhjWmnSc8RjvLHKG6VRjNqU4nmLBdRJJj5O931NeO4fKWgq7Ng4CDqGK503jargHwZycty5
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=68876736 cx=c_pps
 a=i7ujPs/ZFudY1OxzqguLDw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=jG_yPd5o3CEIpo8lzG8A:9 a=QEXdDO2ut3YA:10
 a=Ti5FldxQo0BAkOmdeC3H:22
X-Proofpoint-ORIG-GUID: 7L6YBaTlCx_UFazSRJZvfHtomVcLLJQc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280087

On 28/07/2025 14:52, Krzysztof Kozlowski wrote:
> On 28/07/2025 11:44, Dmitry Baryshkov wrote:
>> On Mon, Jul 28, 2025 at 06:53:14AM +0200, Krzysztof Kozlowski wrote:
>>> On 27/07/2025 18:24, Shivendra Pratap wrote:
>>>> +
>>>> +static int __init psci_init_vendor_reset(void)
>>>> +{
>>>> +	struct reboot_mode_driver *reboot;
>>>> +	struct device_node *np;
>>>> +	int ret;
>>>> +
>>>> +	np = of_find_node_by_path("/psci/reboot-mode");
>>>
>>>
>>> Why are you looking by full path, not by compatible? Is the ABI - above
>>> path - expressed anywhere?
>>
>> PSCI node is required to have a node name of psci, it doesn't have MMIO,
> 
> This is true
> 
>> so it resides in the root node
> 
> This might be or not might be true. It is not defined by ABI. Anyway,
> you answered where the ABI would be documented, even though as I said it
> is not (/psci is not), but does not answer to first part: why you are
> not using compatibles which is always the preferred method?

That's a good question, I've added one from my side: why do we need an 
extra late_init call.

> 
> 
>> and the reboot-mode is defined in the
>> previous patch. So, I'd assume, the path is defined.
> 
> As I said, path is not. only psci/reboot-mode is.

Do we have an _actual_ use case where PSCI node is not at at root node? 
If not, it's obviously a deficiency of the schema. Could you please 
provide suggestions on how to describe that in DT schema?


-- 
With best wishes
Dmitry

