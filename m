Return-Path: <linux-pm+bounces-10807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9795B92AF03
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 06:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE421F22BA9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 04:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A977A15C;
	Tue,  9 Jul 2024 04:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V2syuKe+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E89620;
	Tue,  9 Jul 2024 04:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720498768; cv=none; b=DbqbEDSQVAon8gzGqKQeyy3wUO6nkqG9uiI/zAstUoly2YhGzt8cGCj4sF8k4KLm1YrbcUpGRBdaoVf22EBuyDC5cOWhoajS//zCizvu/J15VInjGQGvX3fFGR6UTPe8xiq6phi5aucvlAv+mg2zuTS/ygde9m2xZHsVtbj960M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720498768; c=relaxed/simple;
	bh=30xitU9m3pbC38fhFhR2exRe8dNHDVsbQb29IhiB1lg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=txK8vLge5uG3LoP5VREEwAdM7BUa3HwbtXnHztUL7jvl7CbgstFydhcEm18D3nQWwzJcPfOoBil8DUGdyzGCyClHH+gieCPQfAWaz2GnjHULVoW8C4EcqktRVjS9pvplcDqKiRtQh5AHZAzbIUlfTLZ5+4VX1Br7tbOkSAvT0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V2syuKe+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468Mo2QK015544;
	Tue, 9 Jul 2024 03:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zet6s/oJP3P7PB+e0PNHbJL8LTPKBRrFKa+rhqJU4Qk=; b=V2syuKe+AVDrV5TW
	gp75/7tAZ8uXVjLjfKCvLJqqe7Qj/ZGjHqS2ngEklwsSxqH3RI3EkBphDdQStSuQ
	NV6avtp5mdRaAHEmW8lpRrT1o+08SWnB7/9Twl+dbj1nZLQenGmwJfMR7dv3OEKL
	y9IcTEPDyp9dQn7Onh5Jl2XU1LRXHj8nIfOX2pPVJghA/jEobu1S0dpoz3RMrmb8
	G8ZeP4AHGV57XZTcsKZcpq8RnDDoap83Aq+IXsr0Oh290v9hL/xQQQ4MRW72etbo
	rmVbuBax29XuOwyC1S+XgcgZBwecypM6sKTzZzcnKTIeVoaUssfGYQ5VUYyk2JHE
	P/VzGQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406we8w6tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 03:51:01 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4693p0GM025417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 03:51:00 GMT
Received: from [10.110.80.193] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 20:50:58 -0700
Message-ID: <fadca811-fabd-92b0-0482-c317344de2d7@quicinc.com>
Date: Mon, 8 Jul 2024 20:50:58 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/4] firmware: psci: Read and use vendor reset types
Content-Language: en-US
From: Trilok Soni <quic_tsoni@quicinc.com>
To: Elliot Berman <quic_eberman@quicinc.com>,
        Sudeep Holla
	<sudeep.holla@arm.com>
CC: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>
 <20240619135143.kr2tx4ynxayc5v3a@bogus>
 <20240619080933071-0700.eberman@hu-eberman-lv.qualcomm.com>
 <20240620162547309-0700.eberman@hu-eberman-lv.qualcomm.com>
 <ZnmTtmZB8epgbUTN@bogus>
 <20240702155630416-0700.eberman@hu-eberman-lv.qualcomm.com>
 <1bdc4d4c-9cf1-a8bd-80de-7463cecd2c78@quicinc.com>
In-Reply-To: <1bdc4d4c-9cf1-a8bd-80de-7463cecd2c78@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: np-jJaWPBl7FoRWLTFcEOK4UClUtoSca
X-Proofpoint-GUID: np-jJaWPBl7FoRWLTFcEOK4UClUtoSca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090023

On 7/2/2024 4:42 PM, Trilok Soni wrote:
> On 7/2/2024 4:06 PM, Elliot Berman wrote:
>> Hi Sudeep,
>>
>> On Mon, Jun 24, 2024 at 04:41:42PM +0100, Sudeep Holla wrote:
>>> Sorry, I completely missed to see that you had already answered those
>>> in your commit message. As mentioned earlier I haven't looked at the
>>> reboot mode framework completely yet, so I can't comment on it yet.
>>>
>>> I don't want to be blocker though if others are happy with this.
>>
>> I think folks are satisfied with the other parts of the series and now
>> looking for your conclusion on the PSCI driver part.
> 
> I will be nice to get these patches picked up before 4th July holiday in US :).

Sorry to bug you again Sudeep - but I need confirmation that these patches looks good to you
and you will pick them up. Thanks. 
 

-- 
---Trilok Soni


