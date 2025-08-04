Return-Path: <linux-pm+bounces-31891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33927B1A177
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 14:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA9317C7C0
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8450C25B309;
	Mon,  4 Aug 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WqxekJlN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1147F25A640
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310800; cv=none; b=f9JfgIEC/Sku04tNOa2mJc62ejY49h0SuOgiXrbzsWNrz4zDDDNab31DpMCUxCnesNaLglhc1KNtj36WGrACWlf3qm3l37BqX/B/QBrbRSUoZh8POth/j/7AIaVgmc7+F46cxKnee1j8D00BZbZyL03iXf0T0EXSw7ZUgGtzqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310800; c=relaxed/simple;
	bh=ANVmw6AeR0GHHCK/HKaHO5w+extSI4H+i3GF9Iz3jdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmOE+87QDvRGpDkSRw+RMfi4//N2IisgmTV9ZjBbAKhfsrD8fzi60gSXwxXecLWnxoP5qTBvAHPbmMcvyFYK2Hl6/MBlXujiqjlWDAWDQD98XvmxjI7PXAlm92rnQ0G4qlZzTLK+om83u0jbL8LrcyBFnE8tUA3zic/4nRXDh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WqxekJlN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5749GoWU030010
	for <linux-pm@vger.kernel.org>; Mon, 4 Aug 2025 12:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	46HAWgvv2MxgQgdpENwkPzAKGo1621//AEpZFMkCwFU=; b=WqxekJlNtED++Z3q
	iLHSuYwBGbF7pe7KzYohu6uNqSSJYYbYzafcZWS9UQXLPbpqIRg/Tc7xsa26i3zr
	MArzxNX5otzPpYwrdZu0CvGzPCra9Nwghji3mVvVBlfxXtXjL+t55zNZT2TrVavr
	7hkdUuvOfjDPaml7shA/N1BaOvBzIfFD0zB9uKVUHHM37RuJmvR13MOFzPhnGYAT
	Nhkj8XB1hA09ET1Cs+55oeJA6o01LO0mgWTFqIjSxwbp6wqKOd0N9x11cNoRTrti
	X/26e3/xsywbzRjx0lUTi51IKv80JSGs9d8/j+7LSu1NLeO0OeDFzQdsUEcaD6Tq
	oRkp1w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48981rn76n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 12:33:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e33e133f42so93870285a.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 05:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754310797; x=1754915597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46HAWgvv2MxgQgdpENwkPzAKGo1621//AEpZFMkCwFU=;
        b=rISaWa5FOhsiOWfLP6pRGHv+IrVoWgBMYFQI450a2hFu3pv1PD1mpXgvDp2ZRO7hYr
         zv/eDR6dPttTx3c9zciXdZ+jn42r4WNlO16psOUaEabvvoyq2lupamKeEfL/7Enfcg5D
         TeJsWa3xb9dYHUnBbMOPzTYwfDhQ8KWAIEthkEwtdf3gzQ9DL9jf59yDFFOTfv3Oa9Fo
         Si4I5mwQUXnjyJkz7zylfzKcDqV6vjlNIqgk16hgIkFQgFzU1KqIy7V3xAjXmoVYf7yw
         9ydLcUHWnZ1O70siFjfU9V7PDzL+iBSXrPKOPlWjR4EqKOcaHFUhpqnCWMyUe2p/0r1K
         f7xw==
X-Forwarded-Encrypted: i=1; AJvYcCWhn2jTPgoAXamqqcz1FKirZZkjsesegNnaZJKGMFxULgyageLf04AiRrR6YkQbk9uzwObtc0S5pA==@vger.kernel.org
X-Gm-Message-State: AOJu0YznWlG9GzSwBpxOT7ti3tUVDzV5OI9VzSsFV0OCgg7GGoa1UrJr
	3z6g0Ws+ya5BfMkqGEolFwE6jeF4VhZskRv+UqwRvfrs3Wwsl4aHXhjSpbBargv4x05HIEEtkoM
	IUvKDWJiwfTn8/O1mQj/xgsvsBVQ4Fr97IsSr5+ZnJrPok5pObSexArksepspWg==
X-Gm-Gg: ASbGncsNBQGlVvz/xs5e8oueGGuJUh4/umd1+ak9mfSosOcESAuKjk4parqr+ydjThn
	2wxSZ1gUbQtxnFQR6C6m3FyIDkW80kYDX4qfh+t35D8VIzMZgszjoJW7RAwNutN9VRBB9ZVCkAR
	9VgVhlG7xSR7NnDf5xCY88UPmwXStRw5XJTyJ5yymL2cf+jhdO7Ph5Ju1WsZ5xAk+X4oEP61gGr
	YrdundakqaFQ7s2TAnfndtUgy4jxeMQU/HEGTz9I4zYF90jU/r0JOz3ls/fOoEZ7KAzCudUy/QF
	RukO5A5k3wSunc+HzXtNT78rujq8SkYY52WbXad5qbIuPJYhug+MdZkXOPweZZcmMnEonsbQEdF
	bB6Caz/ynUwfHl+S+zg==
X-Received: by 2002:a05:620a:6087:b0:7e6:9e1a:1d with SMTP id af79cd13be357-7e69e1a0795mr468467785a.0.1754310796933;
        Mon, 04 Aug 2025 05:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIA4r05fZXfrH3ID5bH6u1l2Cc6ps0sG9WuleJWFvPFQHdK+8Dza/BZE8ttrEeY9KjyY/9Qg==
X-Received: by 2002:a05:620a:6087:b0:7e6:9e1a:1d with SMTP id af79cd13be357-7e69e1a0795mr468464085a.0.1754310796438;
        Mon, 04 Aug 2025 05:33:16 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af919e96050sm731035466b.0.2025.08.04.05.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 05:33:15 -0700 (PDT)
Message-ID: <4890c832-3b78-4294-aaba-b62735f7934e@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 14:33:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: ipq5424: Enable cpufreq
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        djakov@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sricharan Ramabadhran <quic_srichara@quicinc.com>
References: <20250804112041.845135-1-quic_varada@quicinc.com>
 <20250804112041.845135-5-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250804112041.845135-5-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HZtZSYbQhJjc5Cx16Vio9Tcp9MZ_ydR4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2OCBTYWx0ZWRfX+3wsMarLPbs3
 t3o+xspUEtoLYwM1PP9GAKmFPqkEcNRIA7DVBHIXJsc72LjxegozI+dwPTii7bGJaNl5R50Dmcs
 9BIRkk7QUq6VNuCc4yBO6Pyu2bSJF8BlzfOgZJLAsjlySuKy8HrGz9MWp/QFXH9Tqci/a3NkUfP
 z4G1+qKSrxEQNtaRtDeSUPr98SNv7YfTDZuXYgj5ZnnFp/Gpc/OQBfWUQuMsXJ8hDp0rnoL/rEb
 i+KfEeFFPYo8HmBXfQwVCYGzLmcFqWCrQ36EegsgZ/dlxbWgp7YEJMcISK7m8PdUUFd8aFerT9k
 c8lHM1c4gAbGNYB0lJg7Pc8vFswzqin/jx0JG9ArABE3vPG2jFKwGJsbBgs7VpM3LtHF0+/bgLF
 prEM9CdJGyAaavwBfdbSLfixYhVWCjHwlA+xNCXycdCeumXbueFwKnRiWI9osXBdpo1Wj6Te
X-Proofpoint-GUID: HZtZSYbQhJjc5Cx16Vio9Tcp9MZ_ydR4
X-Authority-Analysis: v=2.4 cv=a8Mw9VSF c=1 sm=1 tr=0 ts=6890a88d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=vuI4R3Do2uEHNfh2jzQA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040068

On 8/4/25 1:20 PM, Varadarajan Narayanan wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> Add the qfprom, cpu clocks, A53 PLL and cpu-opp-table required for
> CPU clock scaling.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> [ Added interconnect related entries, fix dt-bindings errors ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

[...]

> +	cpu_opp_table: opp-table-cpu {
> +		compatible = "operating-points-v2-kryo-cpu";
> +		opp-shared;
> +		nvmem-cells = <&cpu_speed_bin>;
> +
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <1>;

I just noticed this.. I don't think we have CPUs this efficient just yet

Do we know some real values for these?

Konrad

