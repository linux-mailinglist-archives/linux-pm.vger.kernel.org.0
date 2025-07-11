Return-Path: <linux-pm+bounces-30706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CA3B02261
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 19:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2014A5BA8
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 17:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330EE2F004B;
	Fri, 11 Jul 2025 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dEa/dwq+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC42EFD81
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254044; cv=none; b=WqwyLav/7tabbL2b6GYuLXSzsWeprFUpmpsleCyIoPDbB4j/HPSxCrvGjHgmiwbTHiLEaGM7WkU4yyoxYOgpeP/Vb9t6SGmQet9tHJnq0Rh9YL0Rl8oTEqQ7TDMbOvXAXQQuKz8Z730WXDjCyHkhXwbhvwr7ElggRYxbK1hwRiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254044; c=relaxed/simple;
	bh=IfkgkvwrICiY1PpPvpmdoJ/Llw9dqsyr42ryaHPpX6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2bobZSST4Sgzf9IOvr+jV/Sk/xL0KBGeu8HMbiQRngGXJedj/UKxDa6GHt+n3k7Sw0PfnfZ7o+5JFEXqNNnDd0nTh6ha3klMCALmzMfFvPjmkcT1PUuxNYNJxoufD3iQIq7eYgtaS8/2iEWIFtq3qZMqk6vWsxR81StgzCAUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dEa/dwq+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAefJg016260
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 17:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+yUxiWOGlCs35rCfqD4oAy1uFpwrIW5gk0AdeeQDOzs=; b=dEa/dwq+qpYCp9ov
	IwRHGfEsQXTn43yLpCT4+xX/3a7ltSkZSMokDMIE38v3evpbApnArv+9rfpFfgv+
	sE8M3YGTtI0B0kJnQ4glXiPL0ahgiGk2cyyzjmpWf7U//T312lcmwB0uANxwwqAm
	Y/g7DfZWTHTbPgzXBsnwKI3tFzsWH3uVx7Ve2i1N66S4qY0wA4WBV+vSIKFEaBbj
	SE93RvPCIUB4+go9Kd3WeUOSWupWlAiXk6YPp20rUFRTrbo+DkG9Bl0a4r3rLJ6W
	CHTF5zkuY7PP4Mbcx8HQ+ccxeHvsKOefhJkmsimVzEOQ4cjo//lOTj3+pajpdLda
	6PzSHg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47t83u5nq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 17:14:01 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso2472719a91.1
        for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 10:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752254041; x=1752858841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yUxiWOGlCs35rCfqD4oAy1uFpwrIW5gk0AdeeQDOzs=;
        b=N6nQuabUqLCjmP9j0z+PDIDgYtxdth+TOHmscZsQ3FRXa4xe2pmj/BY2mdbfwSf++l
         3X3G3huuI/VbKPmNL084Jk8BqHkqCB7G1fVbnsNjeCGaKYKpOS7Fw6NOxUAuL5OPZwSL
         KislRlKMptgmeM4g0z86bLZfP1sBmvcEaPKOPcJiRNVHX2t1Pr6ptDToTVDWNLZniGaR
         8yjRy9LOM9qnJnnevgj60hid2DgOUjfbC36ruvf+Q4R1QS9qjq+0UMO4OlxGt0OWT54D
         5Ynl+qZ9Jqdjlcwl+mJyzVJDVWCqqYBjJJeNnn+tIvg+XbgfteHArRe3d5yhth4q83s4
         efKA==
X-Forwarded-Encrypted: i=1; AJvYcCXWFDPAn9O790j1dbUPl1dvCZD6gijGIh8u/CPoIrnqWdxh7xJHyJaNIoN92o7fbBFZJpAn0FvY8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX8D9U5wCF94nWCx3NNUMr/RUJRTqMkvOs25XDf+go4QPaRqTq
	3jmEyE43AnZsgbPl1Pc3LcgcotVYffGA6gdlbaoAwbVKrbAzmRX+b6/vLysC9XW6qdxgcnmABAA
	GuVtFsgB+wQyR6IoYo8EKvdYRatXK0RU7IKoORLYtU5Nycx62pRYfRCBAYL1mPg==
X-Gm-Gg: ASbGncu/G+PvwGoZR9DMYusUMmfhagLKHcYMpfCB+2l4e4htNvlVF1isBqQ2ikiMhB4
	GL7GLS4Iv41hOgZfZUw5fozBvtgrcTv+3T3wB+zqKzOfXYGzmN5HhD3Sm9tMrQYPSEjib1nTAuW
	KN5kX8MBZRQofVvDFs6BbpPvlPaWsG0j0uDXENg+HlJ2/LKTx/4HTgYGv40Fh9nWPIIIuAyD/D/
	+rm6hTP79KftRkiuLUqqrGkTbKyB5D01DIJhCvle97q7346GBHafEELWvaN6BKvbIJbOdGiuUaj
	PHb/HnE1WcgdJdAm7rDLphQHWcTFLsTp3sZ1w/qpbc3FS3fGwr+O+WUYSOOp89ErFE5C5LCfBA=
	=
X-Received: by 2002:a17:90b:2287:b0:31a:9004:8d36 with SMTP id 98e67ed59e1d1-31c4f512a2emr3401804a91.20.1752254040864;
        Fri, 11 Jul 2025 10:14:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8jwEw4xKzZ2Gauazi95OMMWknYXW3kdStTOkWdXT5CV0YXjXLaabiJCMU/29GPhFaCVApJA==
X-Received: by 2002:a17:90b:2287:b0:31a:9004:8d36 with SMTP id 98e67ed59e1d1-31c4f512a2emr3401777a91.20.1752254040270;
        Fri, 11 Jul 2025 10:14:00 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.229.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e973e80sm5633493a91.15.2025.07.11.10.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:13:59 -0700 (PDT)
Message-ID: <b6f4819e-462d-7a59-eb19-bfb65ec27229@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 22:43:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v10 04/10] dt-bindings: arm: Document reboot mode magic
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>,
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
        Olof Johansson <olof@lixom.net>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <elliotb317@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        =?UTF-8?Q?Andr=c3=a9_Draszik?= <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        linux-rockchip@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-4-b2d3b882be85@oss.qualcomm.com>
 <2d8e17ad-6bd6-47a9-b5ab-0a91689684ee@app.fastmail.com>
 <9bd63c0b-cf14-d00b-c600-9582061e3afc@oss.qualcomm.com>
 <23e0f0d5-c0f6-4fc5-9775-c0ae73681d31@app.fastmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <23e0f0d5-c0f6-4fc5-9775-c0ae73681d31@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QdWfaYzEKe5feDKmQODGVB2DJRXr-fts
X-Authority-Analysis: v=2.4 cv=OotPyz/t c=1 sm=1 tr=0 ts=68714659 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=8g6h00HoWaIZ3EdQG8aEvw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=rM0-y_1GYM4-gDGtagQA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEyNiBTYWx0ZWRfX0V/OJ/XXQw0y
 2KLRcWUN02XNr4wb6kYx5jkP1BpnzPod8Y82dWkc9pZK/BcFdEYS+3EkOXx5Lmob9lL6eN7fJI6
 AOVlOrT3w6NiOHTEY8FWZPCU5RH1ix7CoHdMzTbG47v9xmnaUh+c0YrjyJha7skh0ibj8oVsGP7
 Dxlk5VdATPZOmctPrX78qHa2RVsOEl6eJoMpFitudmP0jV8VMS0NCLhdWYKXlBDU+KrIDoG3ajj
 pxcogEi3GMNPcLkNYaWcWfN1/4Ud6hBj5A/3LQsjZMHGiOF6M0BUTQvQbWX2IpaSTVb5JBnnv22
 DH8GF9W8CUxDsnZwLbdht2BA4gbNguhAH7PxaKkO5KqaL0rQtuesu2JL1SEL0kFHiFxMIm5YQ4l
 oLIZlgmwLrYtoy0SO17vmWJaez6baCTHtGSRBUtGNnILFZ3MRCGrRUCnh2tPe51AB7uWy7mC
X-Proofpoint-GUID: QdWfaYzEKe5feDKmQODGVB2DJRXr-fts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=932 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110126



On 7/11/2025 11:10 AM, Arnd Bergmann wrote:
> On Thu, Jul 10, 2025, at 18:53, Shivendra Pratap wrote:
>> On 7/10/2025 9:00 PM, Arnd Bergmann wrote:
>>> On Thu, Jul 10, 2025, at 11:15, Shivendra Pratap wrote:
>>>
>>>> +  reset-types:
>>>> +    type: object
>>>> +    $ref: /schemas/power/reset/reboot-mode.yaml#
>>>
>>> The other users of the reboot-mode.yaml binding all call this
>>> node 'reboot-mode' instead of 'reset-types', can you change that
>>> here for consistency?
>> nvmem-reboot-mode and syscon-reboot-mode use reboot-mode in the
>> device tree node name.
>> qcom-pon does not uses reboot-mode at its device tree node name, it
>> uses pon.
>> Kept it reset-types as this patch was already reviewed earlier and
>> the name makes it closer to vendor-specific reset-type.
>> Should we make it reboot-mode? Please suggest.
> 
> Yes, I would still change that. At least all the platform-independent
> drivers are consistent that way.
Ack. will change this to reboot-mode.
> 
>       Arnd

