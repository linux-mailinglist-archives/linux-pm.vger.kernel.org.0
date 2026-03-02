Return-Path: <linux-pm+bounces-43402-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +APxDdWGpWkeDAYAu9opvQ
	(envelope-from <linux-pm+bounces-43402-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 13:47:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2011D9027
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 13:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CB37308384A
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99EC375AA0;
	Mon,  2 Mar 2026 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cryyzL6J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KzfXG4fr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F7374197
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455169; cv=none; b=Wvetj972wivMQO2yT/OazMrm7W2iOojfeIIu46dYqniEyq2Wbo0lcoJQIOC5TH9KArLEHlM2N32c/6tuuPBH6Qh6Y9eC7MfK7Rxs9PzWRw/N7MQmbjIc2H9G0MkeVbj0vbh0TvbXTpEFaTh1dZMp85Ht4ULykJJoJpWZJ0Wj+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455169; c=relaxed/simple;
	bh=sgSw6uvz5TkF6fAter8Gcyz6f1Qegkklbw6CY016QSA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZkJ/5X/3ruUU2IKhrOTwTof8bInGEAJchoRsVk5lCadBfGgB2/C/hARb8p1+gWA+VK5jhMegaGNZ7Ar+vTcrcmMZ21qoE+nB1R3nanNTHW3Wz2DKyAUjnYlOYey8wBhRIXWzVdvrfeWalBGlbmCI3uoDzrVhINH7qNeGd7dTyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cryyzL6J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KzfXG4fr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62285b7f662344
	for <linux-pm@vger.kernel.org>; Mon, 2 Mar 2026 12:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ww8449eIn2bp2zLGxyNJVG6ROnNNqCtapX2um7IMARc=; b=cryyzL6J+aCfMbmN
	zGRKsJrhKW0FA+ShER+4QxbPAqdq33JlPqP1YwZLBbBPpIfkMdEQENwpmjEe8UO+
	QUSywtocX3cKo/pwZXKy55772Sdlp2SLSoAzLQ3KTZT8vFfgnctQxlBusjUVpziw
	Yb3C6AgupT9eSE34lTz22u6FcmJZ65Tp/miaMHfkkjvaIBga2lbDFV2L3/FcrwYc
	2Vy7u+eE/0dllQWHOQxbfsfYyMoFPvIwGx2ZzaPRMIp9aPJ90M/VwtyLbWSYyw7e
	X8JiKKKew4WRoGXaMjw0yViFIFk9TlpYm+BTs+c4P8fi57Yq+88nIcaAcUoJVkbG
	hbHNAQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn6r2s0ds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 12:39:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3597f559e70so1259306a91.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 04:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772455167; x=1773059967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ww8449eIn2bp2zLGxyNJVG6ROnNNqCtapX2um7IMARc=;
        b=KzfXG4frL2BV6+81Zi/5Ork3A+/cXZ6WOKUgnaQ1GGp1zj4eQHhp7Ue3SUcLH8DsdE
         pH2yWOz2NRmDJSYmet0gTaFunBN+IOF30H170gaygttqcA5NCSaHWbLN8RX6DNqGsSJh
         kj65w1nrn5V8lrgAILKzWzOhdbkqa9sbUrZG7XiR1S8RkU/t+IH5UYrDOJuifatwrEs5
         lKaci/kQubkPkxz4sQtF1FNaM4LIoHmlaCQxhtTWOXNSIWh1fofoTZs2KMwhRJEYQEkv
         37uANg2G/qEXPA3s5rK0rKs2XBQ5fkbDKEQvEvoAWjQDuad1wJ0ic6mu3+GY86PY/Y0O
         TjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772455167; x=1773059967;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ww8449eIn2bp2zLGxyNJVG6ROnNNqCtapX2um7IMARc=;
        b=kWu1ehsGO4jqMreCfeVClkd+2SOs5ZB8vtt90a0IVKVKy1uNyru4NPSn2ACTDkAYO+
         ckr+QGgJfPk1zbneEQ201LtpSjDNJxbE3uMzfCUQ5cqzthd/ww5Bu8m9cUNfqQClS9ow
         rsZhDW7wabW4yAhyefFhZp1obM1ic/Z+Q77W3nJb0P2/txleJRJnEnyDTQH45Zby1UPU
         fwV/ES9hZBsMEjIUGjLL4IIHyiY3exyhHh0yQ5quN45es+Ku5/c/0g31Unp+WVQHrRgO
         U/2dg4j56B+bW7z+RVeE1PmBk0QhLGLvJGFNONJDMIOvltrRu7sWcOAP7HdRkOMUwYOD
         4sJg==
X-Forwarded-Encrypted: i=1; AJvYcCWWfLsNyW9AGYdWh+VZEMNHPlOqy3zWb6FwGLpqoVY65EdE+9p4lKZbaxm8E4RMvFfdgye54Dxj5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxru9hoClupDbTOPX9dhreTbmmQGaq3bqVHQVObtnOHbZga9X1L
	9N4DxqS4aRu/kYzkRVeUeuP8Jxhyi/rjpmOpPsw3Tpy3OvnOpc2S1bu+MLo6vjMlBaqOaRn/jBo
	Ue4RICJtXC2UXYVEiGqPM9aAq2n2AJauYFJAPd2NgqLUSr+FqSM6lZ4rsUfN6nA==
X-Gm-Gg: ATEYQzzGqWTKwF7ugyhJrqMZnBleCaFnUbzgc03Nt3jzcLdQvu6uIZrYWjQD5EfmtC1
	s3xSgsnZUPurDyulZbBxTum6smx4ti63Tc0a+CuZ/u21qSEK5S6suPPF3TQqSqpceQZtLLnG5ly
	BFydcUyC9LfyBCNXnuP8D+RG8Qem+h93BfCnQIVteavqDD1KW8wI3L1PWewRLwSJn0lpnIhWT2o
	Y0UGhNU7tGBl7iKI4hkArdomfoBirqpt65lCym0G/lLxOlkRmy1hPJbb26maofR7qOuYbpugRPl
	9ngZEjOvz+SRIl99v/QS50tOmOufV46P0vvgVRxvTmnilGAGbc4GAbmFFbiT4fRHnZstIp1xOD2
	kiEwIcKMY0j491Ceb/DlBEuHEeAZ9Go4lLoh8UVQMoKIdxWLy+l1k5Bd7
X-Received: by 2002:a17:90b:1f8f:b0:354:a57c:65db with SMTP id 98e67ed59e1d1-35965c926a7mr9003707a91.20.1772455166974;
        Mon, 02 Mar 2026 04:39:26 -0800 (PST)
X-Received: by 2002:a17:90b:1f8f:b0:354:a57c:65db with SMTP id 98e67ed59e1d1-35965c926a7mr9003661a91.20.1772455166462;
        Mon, 02 Mar 2026 04:39:26 -0800 (PST)
Received: from [10.218.41.175] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35994b0ae60sm2048878a91.2.2026.03.02.04.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 04:39:26 -0800 (PST)
Message-ID: <8271eafe-ec8c-4d9f-9eb1-1bc115efcbff@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 18:09:15 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 00/10] Implement PSCI reboot mode driver for PSCI
 resets
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
 <2dcd9e3a-0a40-0dfb-29b8-99b70b73a59a@oss.qualcomm.com>
 <9e9b9faf-7c5d-2e83-a8ac-37afeffd81d4@oss.qualcomm.com>
 <aXduTklGm6AOeaGG@lpieralisi>
 <61f166a0-44b6-a917-66e4-1e1230fa1115@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <61f166a0-44b6-a917-66e4-1e1230fa1115@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZXVxdxdpR6hYolV57ued7lH0tZK2y-rl
X-Proofpoint-ORIG-GUID: ZXVxdxdpR6hYolV57ued7lH0tZK2y-rl
X-Authority-Analysis: v=2.4 cv=Hpp72kTS c=1 sm=1 tr=0 ts=69a584ff cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=1ilHWjMHOYMdorrszqcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEwNiBTYWx0ZWRfX99sYyErX3J84
 lhgQNLiOWpSKZnZeqOfR1ln56QKRcNn/HlJhghQN48/5agRaMvk6aTf4vr8C5sBGn78vk/PE/pK
 ryFQ5DEF7+MeL+Vi1N7TVOzX+jKFuNY74ljGrYmNl6hhEpC/iQPnn2TlY0lvvlk9Cn85sgH7bu1
 TbJGzCGqHYDtqizdZgAZT8EvdN2ILgqIIjHGSHO01LQrjjfVGTKZZowlQ2/f9ZHdOaeHm+lbpxP
 KaF5f4X2lhbVi83yC5YC5ZAjw1O6IPRRfRSy9Ekx/W5TjrQvJlorlsMwwFzAaoDpnSPTVWWJtrK
 aoy5EmvGKTam44esb9I3x9I2LI1zg4JT4hMP/7tnshI3/f1jgCXHVa4rUmFupYOIklDgw3DSBqv
 ABlQN72688XTQe212wkkhkEmKwEgxBGAzQ3XfrZZ669qdrn3FokzkXHnpHjAffS9/W5BMmDohYP
 zs4nvSYVlX2iziAYnMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,oss.qualcomm.com,linaro.org,vger.kernel.org,lists.infradead.org,quicinc.com,arndb.de,arm.com,rock-chips.com,gmail.com,ettus.com];
	TAGGED_FROM(0.00)[bounces-43402-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivendra.pratap@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AF2011D9027
X-Rspamd-Action: no action



On 10-02-2026 19:35, Shivendra Pratap wrote:
> 
> 
> On 1/26/2026 7:08 PM, Lorenzo Pieralisi wrote:
>> On Sat, Jan 24, 2026 at 04:08:11PM +0530, Shivendra Pratap wrote:
>>>
>>>
>>> On 1/6/2026 4:38 PM, Shivendra Pratap wrote:
>>>>
>>>>
>>>> On 12/28/2025 10:50 PM, Shivendra Pratap wrote:
>>>>> Userspace should be able to initiate device reboots using the various
>>>>> PSCI SYSTEM_RESET and SYSTEM_RESET2 types defined by PSCI spec. This
>>>>> patch series introduces psci-reboot-mode driver that registers with
>>>>> reboot-mode framework to provide this functionality.
>>>>>
>>>>> The PSCI system reset calls takes two arguments: reset_type and cookie.
>>>>> It defines predefined reset types, such as warm and cold reset, and
>>>>> vendor-specific reset types which are SoC vendor specific. To support
>>>>> these requirements, the reboot-mode framework is enhanced in two key
>>>>> ways:
>>>>> 1. 64-bit magic support: Extend reboot-mode to handle two 32-bit
>>>>> arguments (reset_type and cookie) by encoding them into a single 64-bit
>>>>> magic value.
>>>>> 2. Predefined modes: Add support for predefined reboot modes in the
>>>>> framework.
>>>>>
>>>>> With these enhancements, the patch series enables:
>>>>>   - Warm reset and cold reset as predefined reboot modes.
>>>>>   - Vendor-specific resets exposed as tunables, configurable via the
>>>>>     SoC-specific device tree.
>>>>>
>>>>> Together, these changes allow userspace to trigger all above PSCI resets
>>>>> from userspace.
>>>>>
>>>>
>>>> Hi Lorenzo,
>>>>
>>>> Is this patch series now converging towards the design changes you
>>>> proposed in v17? We’d like to conclude the design so we can move it
>>>> towards closure.
>>>
>>> Hi Lorenzo,
>>>
>>> Can you please review if the design aligns with your proposed changes?
>>
>> I will try to do it this week.
> 
> Hi Lorenzo,
> 
> Any pointers, if the change aligns towards your suggestions about the
> psci_sys_resets?

Hi Lorenzo,

Was planning to address the current reviews to send the next version, 
wanted to check if you could check this approach towards psci-reboot-modes?

thanks,
Shivendra

