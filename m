Return-Path: <linux-pm+bounces-31660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A342B16BBB
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 07:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC643582CFB
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 05:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3AF2459DD;
	Thu, 31 Jul 2025 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nLLXgXqS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2662405E5;
	Thu, 31 Jul 2025 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940909; cv=none; b=W0XnJxn/VIZD5VaMGhsnxbpdNu60KlGlGFn3RkNKgiSmEv19wHlVAmUtf9hNZl8nYFJvWrSiYjkYcoZTtmqRMg7zZ8bgHv28vtE6Y9wDajfb/u3dCLnFIiYD4C+IiiiFzz3P/ni0r+I8ErXjeAJfGjzVpsN2dqQDtT4g+LyGKr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940909; c=relaxed/simple;
	bh=4Idy+HBLmQ3TDil0Qxqh6SHBhSLKdNMC6NY4c98JpEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AsAFtzYBjQDaJ8IAqZSzlExNxhQ/pFNnjkbXFWoBCYntlpjXrZdUkbDkCPTet0/jHMNtj9eLx2nGsiKilmJGiFLtvQYSk3NNOcTSnHrhlUnyLTrIuKOSVYtsJjYdb787BLKB1tulykRrFis/0/UftkZyH0RaZKDdjYeLIladEPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nLLXgXqS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V1fVSA013548;
	Thu, 31 Jul 2025 05:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cJBqHHsqB51W9sZ0EFoOQ/FKZMMv7iYgRN738zveaT8=; b=nLLXgXqS9jLX4hS7
	YPbvTBrPjfHpQaTOXI1XeZ9OHostBme36b5D1wUNnWH0cVB5EPQxdnnvB9MZWoIa
	WZa7w079t1QY2+PTvLUPvHZBPixw5VntKHZadlJDL6zjxKY026wBX1gDYsOGutVt
	pnIBzD8r3h2I13QRusk8pYXCZMuTrQVt286RlzGnUqxPJQ1N/okN2gzJWxYpai24
	FbKsDWz8v1XccnlHmWyBw9ZnTzAiZR2gr9mnUq7/S90ADNuSuuiwoLhAzYg1bdF5
	ocyOPPo0RsR1M3SAeC2viimYWQtVFKCVBGWBQ+Udvq/JpT1D/m9PscdHuKWF+fkh
	YbZSOA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6qxh7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 05:48:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56V5mCv8022972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 05:48:12 GMT
Received: from [10.217.216.26] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 30 Jul
 2025 22:48:07 -0700
Message-ID: <21f58a8a-b378-46d8-9372-ed63ecc7cf91@quicinc.com>
Date: Thu, 31 Jul 2025 11:18:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: qcs615: Add clock nodes for
 multimedia clock
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>
 <ff6eee04-d191-4dfb-82e5-7e3a6c896025@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <ff6eee04-d191-4dfb-82e5-7e3a6c896025@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAzOCBTYWx0ZWRfX0LC/ij0b0qyZ
 MeW9DPXEX5mWM9y6JPS5dnqkvThmIut+bWWkLOFIKlOHCE3TSHJCdgGh1NDSFFmZzocOfF0xUxB
 +Afl4ZcynAQT4oncYDudMiG7RzVpW9Vy3sQZFou2unruRRM3h0gmNf2UwcmGYa2OvqbjCvLZF2x
 KslCbY48EjQ/3vTT+tI78QOQ/T0EwAfcKc/HELeRnxo19tUupJySlzs4835lA7mWZ4EeZsAyDo4
 UL8P8QNvtOGhPED5CuwsGhP7p7Shshxf5RvnAGiBNLICIeyYzm8aCOL7uTbMU9orZdrxvd2k+c9
 XFMAB5pPpb+EbMhft/FXIBYIeKFI5IXZpPzRYUannnchmHj52Jq6LPr3dCPzGEGFU9ldYC2DymU
 PUbvJKGweL/L2Z46JssnghyuRczqXRwzOPOa1wVfgWVuvB53Pcr66czkCefBmKNNUmm+lAYc
X-Proofpoint-ORIG-GUID: u7SMI2TEB9gDavcCu91JMY2MjfJ6dAkO
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=688b039d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=aPS8biwweSijTyKDNQcA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: u7SMI2TEB9gDavcCu91JMY2MjfJ6dAkO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=990 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310038



On 7/30/2025 7:07 PM, Konrad Dybcio wrote:
> On 7/2/25 11:13 AM, Taniya Das wrote:
>> Add support for video, camera, display and gpu clock controller nodes
>> for QCS615 platform.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
> 
> Bjorn mentioned offline that these controllers should
> probably have power-domains attached to them (perhaps bar
> GPU_CC, that's under discussion..)
> 
The GPU_CC on QCS615 is all on CX and we do not require any power-domain
to be attached.

-- Taniya.



