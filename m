Return-Path: <linux-pm+bounces-29682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C370AEBD2C
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 18:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1272C16F4B1
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0462E9EDF;
	Fri, 27 Jun 2025 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WSO9h00m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23EE2D9787
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041516; cv=none; b=ZXHxTZzqGxFYDH/2oT+dgEv/jP88al6JcltJItcZMGFafhT0r2JbuOg8ysyB1sltIUAIfdKZzspcO4bjL/U6t4LquPk7ckiele6gwQ+02LH0N44Bf3wswJ0a/WFHoTtG91WFOj5e+5FWGHuFg2fBT/Z7pQd721vyWQXj4T+ZTZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041516; c=relaxed/simple;
	bh=C4i+82VCqawXzba10UfgLVMnLpSjEvh/T1+KBY4EWZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IopGeMkTKUBk0pr9BEodht2tFlz6KudYzt5O4/QWBf0oHiRZNPcFlvpn29f23nEgH29Yr0Y8jRLzgDUCZ4/S0JgFJHhugAtqo50PmkRA0ky+LbcnFZ9N0I6UNNfav/9czqzUuGE5UjFlcBN+zx2AoIIHe4zryEMkiDPj28d9qpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WSO9h00m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RBgZdt029158
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 16:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3K3ulOM8/2gxiv3n1FZOLEDC6VhxDRLLFSUlDuxiVZ0=; b=WSO9h00muASik1PG
	hgjJUhe/Z5R9kzOcFzfY0VkTeXu//fkoP+y+ArJjBq8XqZGBmWanNftm6dETR3WK
	lwsl4p0ShctmgOsBSaRDTYA8yHarihKHhgjcEPLJCnKBirw39trtgV2nq1Kbaf51
	VekktYj86D8jrAcpKE5f+6Nj3sPc87YAR7pzC0Y0t4kQxSbpUXkOILS2WI8ocyQT
	LHWfJC2OxUlSyDUq8kNQHOWPmTMkHlfor2tCPzTO5+OOiT8kk8wFWCiQzwIP/FgX
	4kgAd7OTfUr5gXUH3kUZm2vddnj6PIVdbr/p04B8/LiMWbtl+2hlR6lpfC2Iv64L
	P45v3g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47hkpbj4rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 16:25:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d3ea727700so29806185a.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 09:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041512; x=1751646312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3K3ulOM8/2gxiv3n1FZOLEDC6VhxDRLLFSUlDuxiVZ0=;
        b=Ym2Gb4h+JVi1cBG6/rArXMAlEiGneFjTydStr6PYWjDZYG/T+JZ5xgbP6/AT0Vkx5J
         W/0fhAlqIqBFHBsgkfNlS9ENXGpRd7N6LULqKLU1qpYy/jwRdW4/Mz7Z/10QqnJ5OUov
         JyYv291T+gdSKT8Fg5ccpRmI78Wz957uTywxG8K2HgIOg+VLdKJSpl8w/sONZ92i1+eX
         72uiAKJ1B6BhVnJZj4eIMnUJ1VRuOm1HrNGJp9Tm068z5TEJHoPAV10R3bIfpIPkJV8K
         0dDp6n7vAyLbVr+ZbfsXmuCsr459P1sMTYDEsNQt5disOLSJ3gP8Vce+8z9mlz3EqpyH
         w3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUyeWEtOq4dNI4iCw8VKfdUvTdoHFILOIER46U+XxII/Hq11/dsw+CJVIxx/XYMUfnTWjB4a/1FHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ytmnjN/SR6SbIUFfqroqp2PLOGGwJ39b0d4b1OCdkuw8f/fV
	MDcvlvAKTAb69cHCKsgg2ztOO8Gjnh62TMJXuZNQiSZIxkLRFB3UOAMpqUBhsuqC6LTA6Eahy8m
	qAfsEclrtMOXHKWshw85BfR3ugE15Zh/X7Sjr6n74zwiGIIx+8gyQl6VvGWEaIw==
X-Gm-Gg: ASbGncuJQUfPDKkrLneRRoka4hZ7FbaxMfRgbDbfQvgz9WcXoMPY+kGSSg6vdZQ6Ppn
	JlnhTYzoQ6uSHJSXK1eFRl84JjY++qDU+yPdjddzcePmtbeY+1aB8kL1W2W1+sv1rv5B+gnOFrx
	eLCdx2vTUv2atJgNtTmx9HnqhlclHhV+vkkmiU2AWM5E7a1qj7jvHa2tt6kLqsc8hlhLHZ/F7jh
	brpiELXVcstyOfRDmKFaxwI0mMK4pgHimUkhhLFPZrcSHfPfzi1u4lHPXkbvV7jmWlCJIZOq4AS
	fhnYFb1rAcJR5NmMSJAmCGslQNam6oDaqMBf94B/Dw8DC/VEHtISDqPG22YuYE/3aFBF1YYfvGM
	mLuY=
X-Received: by 2002:a05:620a:24cf:b0:7c0:b106:94ba with SMTP id af79cd13be357-7d44393cb0emr186172585a.7.1751041512170;
        Fri, 27 Jun 2025 09:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF07xy/DeRmmmedPMJULYDxGN/26ma8lCZYySazHvEfgzdLyxgZdrRzYmMNDCeah7SlE5mBqA==
X-Received: by 2002:a05:620a:24cf:b0:7c0:b106:94ba with SMTP id af79cd13be357-7d44393cb0emr186170585a.7.1751041511671;
        Fri, 27 Jun 2025 09:25:11 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bdafsm148417266b.143.2025.06.27.09.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:25:11 -0700 (PDT)
Message-ID: <cee7bd5b-2c7e-4abc-8810-4c650207b4e7@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 18:25:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] clk: qcom: Add NSS clock controller driver for
 IPQ5424
To: Luo Jie <quic_luoj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
        quic_suruchia@quicinc.com, quic_pavir@quicinc.com
References: <20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com>
 <20250627-qcom_ipq5424_nsscc-v2-6-8d392f65102a@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250627-qcom_ipq5424_nsscc-v2-6-8d392f65102a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEzMyBTYWx0ZWRfXzO6/jMWOa4so
 Mi5/81Kjta3RAeF6C/uzsDi3jx4NbnCqje9gcdmSNGJ0Df26WRUoCMDYBHO1HwyKsbrgSGGT/7b
 DuXP2zdhmM9cBP7YIKHRdfmiXAjogFJ6JQP4Qw+bU1HxhULxPpxL+ZEQvYueYMIMHNSO0O1CSxk
 MidmMzU1JmEWyJdbaqZBE+iXviY/FS8RSvriu2eiMPouhjBd5+1V5O/oDoCofp5RvVG2ff2ruOH
 jaWluTDuW2kCTlDM63yM+0P0e4WmPMf8qQvhoaffAGUKLF/jAaYgqCYy53nuBePXwwkayQZQ+jA
 NqQtBGSwjPBjX+gSoiL4YUvq0RfCTC2W0oo7jKjfbsYVkUF/GNY/mAkn+h9+9FesS2ITHZZcM0k
 EtNuBIyxBRZB47gyryQkX8Rxt2whIKJjsB6flI2HXjezDTuk39Hxxj8vwcHQ1mgAcZv2deaA
X-Proofpoint-GUID: m_hJUcX5FzIcPrxUfZUnprNVnJP4Pjge
X-Authority-Analysis: v=2.4 cv=AY2xH2XG c=1 sm=1 tr=0 ts=685ec5e9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=bcbUkqnWQ8Yi_cfyv-MA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: m_hJUcX5FzIcPrxUfZUnprNVnJP4Pjge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=777 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270133

On 6/27/25 2:09 PM, Luo Jie wrote:
> NSS (Network Subsystem) clock controller provides the clocks and resets
> to the networking hardware blocks of the IPQ5424 SoC.
> 
> The icc-clk framework is used to enable NoC related clocks to create
> paths so that the networking blocks can connect to these NoCs.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

