Return-Path: <linux-pm+bounces-11904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3450C947334
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 03:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CEE1C20D9E
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 01:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D4A3BBD7;
	Mon,  5 Aug 2024 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NnTschHZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20982B9BB;
	Mon,  5 Aug 2024 01:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722822706; cv=none; b=GxizoAp/9KKD7Gt5ylU79SQNYHZaZ1pZFJxqhJ/H4YoU8brcAeRxBiVm10R30PqRW9IpFFWMIDU9caAn0Mm+OeFrEQZEWoE8HnorP6bBDskrlB2QskWuUKZF/IIAclwYClc+OEKfKG8oV+3OLDnFn1+ws7yFP/n6mgwfU564UUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722822706; c=relaxed/simple;
	bh=fzzi38TEv3uZmUUEiLmNdTQXDBUdygTdFPcr4Hb+Igk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ly25T1arTVgGZEy62l1kXK77oMGXJxLHmOtm3MINICs6L+eTpS94rJsI5I34V/43IRfd6gwsmnky2OhQ5g7YhJvx6lzOKBquAzBlB0VmA9WNMFkoH7FSYb0PTv//PUBZuL2xz6wLS18nxUcGB+qntmIlVecCUW+7NMeoq5uB5P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NnTschHZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4750WHCA021197;
	Mon, 5 Aug 2024 01:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zG5v+zpozCaoOLhCrLuC7vaMI7L7GfteQK+VhLPBe7k=; b=NnTschHZvs+ywtci
	DRnRXK1VlR8hyzTJlqwt7O/tshWxIivp4G0PsVOMG9mq2nbWcqn0FJmmQlvJ8LyV
	LB4ovdXaHjvu6cYU959Ho7T5TQd10cuYgndG6CZ3ipJze7NQpsV86FMAyjCFdNRi
	XqnySrUq84gAghX6UnOZeIC1AF8wyO+C4zqqtcC1hXNJA83MTZ1MlTNecZduc+ar
	8Wtb+DbzEACXQlS0FoRRSXsQZx94LKBEYwJhGFWhWe9cwkw4qTPWsMtaBfyptKT5
	sACmCTxnOf8KegvBs+38xPN7I1tfAqrwqCP2YVFPISwtVwStGay6RyoD0tDz5YMI
	E9YZzw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scmtth3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 01:51:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4751pO9N016985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 01:51:24 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 4 Aug 2024
 18:51:18 -0700
Message-ID: <3d3bd0be-5b8a-4a3f-bc82-cb1b72fc1899@quicinc.com>
Date: Mon, 5 Aug 2024 09:51:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: defconfig: Enable interconnect for SM4450
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240801-sm4450_interconnect-v3-0-8e364d0faa99@quicinc.com>
 <20240801-sm4450_interconnect-v3-3-8e364d0faa99@quicinc.com>
 <0bc3c40d-f6ec-4db2-ba7d-ad6d3a0c6d38@kernel.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <0bc3c40d-f6ec-4db2-ba7d-ad6d3a0c6d38@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fGE0689bDTbYlYOovzNMIAhFvfdbbozo
X-Proofpoint-GUID: fGE0689bDTbYlYOovzNMIAhFvfdbbozo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050012



On 8/2/2024 3:20 PM, Krzysztof Kozlowski wrote:
> On 01/08/2024 10:54, Tengfei Fan wrote:
>> Add the SM4450 interconnect driver as built-in.
> 
> This we see from the diff. Tell us instead: why?
> 
> That's a standard requirement for every defconfig change. Damn, for
> every change. Don't say what the diff is saying, unless it is
> non-trivial. Say why you are doing things.
> 
> Best regards,
> Krzysztof
> 

In the next version of the patch series, I will describe in the comment 
message why this config needs to be enabled.

-- 
Thx and BRs,
Tengfei Fan

