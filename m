Return-Path: <linux-pm+bounces-37738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCDCC46D95
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 14:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B513A6A6E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 13:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CAF30FC2D;
	Mon, 10 Nov 2025 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ngCIZ6IZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gx4To2D2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E7303A22
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780932; cv=none; b=HFm0m19vVbGaFuY7x3qqPkDPVujpUrLvj/0PdjkPQDBplvvHS4a3eTIwbgxxe1swDyyvN5Gx0nJGKY5Vjitzom3XsebamZyKv1bNqgwf5P6MNzk/8z+E1tmE8rKmMSeBliJC6gt7MVOQQTmGMRqGCBaO0zpe9UkvuffWLeX1C9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780932; c=relaxed/simple;
	bh=MEnR2zX5puAIQkCSZiqLDP7yLlxvkF3Pzrw0yu66dDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4WgiSxMbQO7e9X+3PQPfBX8YVxvzQ+8DRGKKaZFEbzfp1O/DS93kcgzRgLoKPp3n6WDrQy3kot6WHvtyIAhAbOPeAlZjEZwwDi3N2RE7HhyNpWGAt1qW2swnt2bTDzXfEQjSw2Agd1A4Kt+zJnvP5hx/iea/DzjjvdYV/AQPHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ngCIZ6IZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gx4To2D2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA7hJAa2861333
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dNQmS4jbwpplws3/GqBzTBGZxk17z/yI06N48KACXEA=; b=ngCIZ6IZdux4pNlz
	vnryMk3sbvEMOZU+reWLrD08JqPXu386diZPJEfB1xchGD9A33BxUYO1BxZv8o1N
	es8kr9DT/kR14PP+xXdiTP7VatdTVhSRes8TdhdGw3zdJtwjIE81sjHQokc4XGP1
	9aKjSTr5Nivon5u57+4oVoni6XZK2lmgYraKBEjCpEmHcXIZaiDWiDf581NFc0R5
	7mdQuob/QQ4dJuzgzS/GLHLe3sAUzkoGsDM14mWp0rUyOfStBJmMxBjjo8etwJt5
	gCZxjg8zYubR6SqaVoC/XUsDbhSe8GtsT4jYQvZ05RoKcATavjUmeGMAvne6LzIz
	H24phQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abbwe1313-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 13:22:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297ddb3c707so20871095ad.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 05:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762780929; x=1763385729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNQmS4jbwpplws3/GqBzTBGZxk17z/yI06N48KACXEA=;
        b=Gx4To2D2VND/9Medu+PqGz2EqOBryFypFfgLi/xEMI7fjye6VWRaqsL046x3jFuZCJ
         aKhlmDGqr+KztLoZ35KHoOBt3MYLx9s1pMk9jUGmKcW3fHoabO2XdmwA1iB74WJaqEwu
         /o1fd3YG9d5Nnmai0sH2tqZQseY/EKHVseLK6djPjz87gAOrUHpy1YKTX4M2T8o57P0O
         aHZmIo/0CRtmpGGKHE3lJjgLARZYAgANCEEsbD6V2ig6ujHbBDdg4BqXmN58e8rdafZf
         zbepqFFXsDLC0r6KTnm3c2uxreZFe4RN5EV4J1mRon/r+3ZNvRPKYn2lWakCsBJH+m6v
         Tegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780929; x=1763385729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNQmS4jbwpplws3/GqBzTBGZxk17z/yI06N48KACXEA=;
        b=Y2PpE8x/sBROmWjeMsDYBbwHkza+hB5+JxJV+DtglX6WHlXmZh6mNMBHsHO5K4cfp7
         Ca0jX4VYE6YsBc6M2pVgzEA9GYBHIOC2STRadpyBMp3iZS7qFDNJ3by94WekeNkWv6Ed
         IGtlkEzNSDrri4BfbiNnwPOwo6FyZph4YphtaoKk9q4QxupNOfKl0xi4YErRHMXEYHqY
         VeU+rVcVupzPE9bv5ODAp5WnfwV/E8YQhWCBBX5i7jTVF7R95RoqORcw7YAKwiV/O0TC
         bkREdhK6CysZNTAJamanzOp4rX1z6jLmmn8DLU31bSK1tbE3IHu9Wi/MRgfAnmIqSlQa
         sKoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNcoGscHbj/aSTtSVkoYNpB7tl+MVnYED3d315ZyyQybjtn6d5/uz8wXzN7VLTX9BDW3QkxLaysw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfnoQtSCqVPIjN99WBvwzSgFrI9GKmickjM+6q2h6ae5k90x9N
	J4QPd1Qpkx9HJqvXGKYED+nE6THkJBVnQ8FE50iYw7u4saagof5MiDYKAOb7duP/xzpM6KRIm6P
	LLvCiDeRODKnHnMagL/K0Lkgz3+/TTjpkI1gBcUqJ/lognnml4OTb/piMbmwc5A==
X-Gm-Gg: ASbGncuEiwnH2yQBn3cyDZEEQwzlWY98Vi7gYE0qftLxoWSMMHcCzt3LEBCjV4tsb/i
	JMXzxIiahk0m3yyz5cHXLX88oRiwDNeMIOD+a1K5qehCtr72PhmsOSQWBpcamHycQlpXWGMHeQB
	tmd63rta2UEQ6Gt3TbZpo/tzF0tvYJkFFT6DXbefOUzmdmLZUneBXxa3VDFHwLFQ1JMDjcDJUZO
	pCOSP6xD4HOLx566nwdgTST6l2EeF/rXDmhQ6+EJOsO0c6gRFSfh0V6dk4LhHzRR2rEzdf6jo4l
	My/b0Ihanl9EPZRvFKTMEOPIQ+j8X7rbkkxyuJxv/wNDRyUmXQCH2ops1+Rb6/w7LrLWZbX2jl2
	lpZbprqNYlXz5m1D9vWICISS0IlfgI26z
X-Received: by 2002:a17:903:32cd:b0:295:2d76:72fe with SMTP id d9443c01a7336-297e56f9b16mr106607365ad.45.1762780928934;
        Mon, 10 Nov 2025 05:22:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3AZW8cePcCTipuquggBDwoFS11PQj8F9mPSOHc6aFTo8bPEdW1wKw0g++4ar8sj+Ro+Qf8A==
X-Received: by 2002:a17:903:32cd:b0:295:2d76:72fe with SMTP id d9443c01a7336-297e56f9b16mr106606915ad.45.1762780928388;
        Mon, 10 Nov 2025 05:22:08 -0800 (PST)
Received: from [10.219.57.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297e2484bfbsm82037535ad.26.2025.11.10.05.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:22:07 -0800 (PST)
Message-ID: <dfcd8bb5-7278-4345-6d17-1903aea3966a@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 18:51:57 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v17 02/12] power: reset: reboot-mode: Add firmware node
 based registration
Content-Language: en-US
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-2-46e085bca4cc@oss.qualcomm.com>
 <20251110131306.tkrsfqeh6oa7ql2c@hu-mojha-hyd.qualcomm.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <20251110131306.tkrsfqeh6oa7ql2c@hu-mojha-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: j8nZYtucr8b6FfSAuIIMdJg-HYXTtHRk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExNyBTYWx0ZWRfXx33vV6bjSJis
 12QsTpsxGDbcGEGBBzKL87PEGNJofsN9FRCZT91uobe4q9P80ahHZjgvWMDdvR82x0Ih7i2KCaY
 smGSmM0HXRnmz3cy3zpsLNmr/9rLaMFLQTIlIz/5KmwtaIKIlJAz4TZisWN9cIIZSU53zvnQ5EZ
 vngZve/ZF5RuIgrPpiOGN2IbiOF9Li/5ZAR772Hsjya3BEslzac/y9ftl36l7cUvSMcGHEbVyaA
 GCKJ2YLmiNr5EBUVeEzCS80MLZOhZs04qIg9M47VaNNDenx1yfQhIO0GPxP9w3b5a+nGe3akH0h
 eyAws7IKnW/PVE5wla+XQBhumXZwd8xSPG4r6uTT6zH5I7enS/EYsHt0LUvcESkjIIcMdXCcLHr
 WrHYwardxIBEcM1SabfsGO/KKv07Sw==
X-Authority-Analysis: v=2.4 cv=GbEaXAXL c=1 sm=1 tr=0 ts=6911e701 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=O8xs1vKCwhjr2-LdiPMA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: j8nZYtucr8b6FfSAuIIMdJg-HYXTtHRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100117



On 11/10/2025 6:43 PM, Mukesh Ojha wrote:
> On Sun, Nov 09, 2025 at 08:07:15PM +0530, Shivendra Pratap wrote:
>> The reboot-mode driver does not have a strict requirement for
>> device-based registration. It primarily uses the device's of_node
>> to read mode-<cmd> properties.
>>
>> Remove the dependency on struct device and introduce support for
>> firmware node (fwnode) based registration. This enables drivers
>> that are not associated with a struct device to leverage the
>> reboot-mode framework.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  drivers/power/reset/reboot-mode.c | 19 ++++++++++++++++---
>>  include/linux/reboot-mode.h       |  4 +++-
>>  2 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
>> index ac4223794083f36960b2bd37a601b7e1f1872de5..eff60d6e04df2cb84ba59d38512654336f272f8a 100644
>> --- a/drivers/power/reset/reboot-mode.c
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -8,10 +8,12 @@
>>  #include <linux/device.h>
>>  #include <linux/init.h>
>>  #include <linux/kernel.h>
>> +#include <linux/list.h>
> 
> nit: Looks like stray change and belongs to other patch

Ack.

thanks,
Shivendra

