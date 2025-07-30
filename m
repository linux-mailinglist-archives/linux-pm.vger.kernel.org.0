Return-Path: <linux-pm+bounces-31634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41727B1644A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 18:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A617B4C6B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D262DEA77;
	Wed, 30 Jul 2025 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hWdheP60"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2762DEA7B
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891819; cv=none; b=U57CDzCgzSaIqzJPrepApqSCvQJPWJEYERdbRQHKk56OdSBrvK019j6LQY0d9LhWbTa74jbatVdc7AijAS43lEefhGtt27adeGozHE/+4b5C0jwlLVFlOgdL1RYLvF9KVdvUa7HTRYQaWkyWOxit/3rs7/fAchQw7Xq8Lp6Mglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891819; c=relaxed/simple;
	bh=AQ6vuDxhEytlekZaYlH8XfS4ZO3JTfZECFeATrSwhLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGFGabi0GnT+fjuv2WXJlJ6CadLsULS6mZa7ns8ysGCLRQWqAvEslJCQqrxcfCXIYCiHfRAVWjgYroLwQOztD3ysyG6dmjvDmxznd5L/JvEWxFE0MqeRrXSEtLajD/thiO0HdpONrtZkm6TjgJfYFfvoWGTByHqZBLyUM8bNwX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hWdheP60; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCb9Wi009745
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 16:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tIHRX0L2loDM3GRbyCm/tSaU7Q+F+UpeXTABbm/Giv8=; b=hWdheP60guVymOht
	8iShteoXLTmdJa8ln29N8pPLihRsAJphbTJ/nwWoFJxWtYt0RAK89NkDMRuIZn2m
	mIXG37LYpBEMFRxsqYsqVinHJVGDWHIekGqXlaLggE5jjpz9OsrrBSZWswTE03dq
	FSnkrnpWMWnDEZ0E2JdA21D3nTJlS8/p6stJUkbhh4Q/zjFbA6JaQuvf7eAdN5rB
	NaBsl1ZhQUanyg97QEO0DF4Qwz8qdjzvA6NMxKDfg1VqWxSACIVn+eSVOYX2n7M6
	LkgAhN/qil3GZycj1qLJ5z6UXVKPjucjwljpBDRRrJRiRcYSCVHKrIRzArKGh/ep
	UCQJ5A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860ep1t4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 16:10:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b31f112c90aso1005993a12.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 09:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753891816; x=1754496616;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIHRX0L2loDM3GRbyCm/tSaU7Q+F+UpeXTABbm/Giv8=;
        b=dTsIKmosA8zWLvLXnAYd2SD9QRzGte560f1k+gtX9eMcWnb+eJTknRbAwgCuAasiZV
         0CyNaT8f9qq0JksNQeOWJ0IV295JJV6td5A3itVva2CmuFSLSW4ig4Z5ZWqbNbnGW8HL
         BtW3TKi5dlechl06yvbZICP6R9cXKc2/eWULplkZdDKjWgYmBxHYDiDw//GzDmgTdAjX
         yeqin1Hfnn5TLE1BVsWQ6ixDyDlvVYuJBLEsQOOAeU9oiM03PKyk5p3VxH3MSdW5edYg
         tWA0ohsL3rMy4zmriGgd20KfNA58pCpuItHlzlDrFdx8CtbeLWqpl3CW9byaHH1Y892d
         35OA==
X-Forwarded-Encrypted: i=1; AJvYcCVjxhJJ40yfYN4alz0RaLn2NoDYnpBU264amGVns2ixmTpUzqROi2CU5iXOOgXpr2jRXGdg3YC9YA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhHwrvSxb+KxaojybMViZN8wt7SawNDatVYzc61Qtio29pSVx
	OwB5T3fXoaY41p1LyRbX6H5FS8An4n6ncz+NwP2kd8QOzsKXMrzp/EhLQ1z0srPzGNcYwG0b/he
	M4jjhvzhEpmZbz1XSI7bqdiv1K30kIF0avdckCtKTLU0IUsjwCMO1A+W2PPlgQQ==
X-Gm-Gg: ASbGnctZqaqgx+F3JzuK4ec3gk1XN/1iPoXF+O8Y/WunF29ad2weu2rF5ZLZObYb3EO
	pKlB9dA4YMIjB1aCjEWnl9NUIq6DxKWMXzBR/tAKxtkshEj8zf6gUOkRch9+k0/TO1P9UhSjwWk
	AqQEJ7Ji42DnqAj9R8Qaj1kPrRL2+F4e/+2ldQ8yLRio6POEArXQ0kGqXRXnYYQv7Yx2L3iYbiI
	dqdIXehLmgAH8UtjSGV4HdaL4tgGmPcWizWndg4Jv1ZeO/PBvsJy46yN4NbU3s2H7r0CL4KDwfh
	vdhsPnKRtL+euaWm6OI8qQcYjzwNbs6KINgXHQ8j686A6uN6wjxJxJ8nLZ4feohP
X-Received: by 2002:a17:903:2f87:b0:240:b630:e600 with SMTP id d9443c01a7336-240b630e7admr27941615ad.11.1753891815786;
        Wed, 30 Jul 2025 09:10:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESpaWOxmNYWoJxFhgXCazhVQZS2S0Iu1Mkn/tVp0EPP8Wf9SOkPH5bbEOsVSgOrIyQZIT8Lg==
X-Received: by 2002:a17:903:2f87:b0:240:b630:e600 with SMTP id d9443c01a7336-240b630e7admr27941245ad.11.1753891815298;
        Wed, 30 Jul 2025 09:10:15 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401a335b37sm77767365ad.124.2025.07.30.09.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 09:10:14 -0700 (PDT)
Message-ID: <d11496a2-5a43-4b6b-9a8a-d8e05a89587a@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 21:40:08 +0530
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
        Taniya Das <quic_tdas@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>
 <ff6eee04-d191-4dfb-82e5-7e3a6c896025@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ff6eee04-d191-4dfb-82e5-7e3a6c896025@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -wDkZUTHHmx4wclPKx3Fc2JUQVUgGtXO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDExNyBTYWx0ZWRfXzEIFU/9FgcN/
 4vc/c2E/XkAdtZ49s6G1UTqA1WYIr8xcU8IKSHsxxejMrDr8FyKFxTsozXXCvcPyGpRtXOupGrd
 38oBXtcnkWuyhFHH+rhoXo+0WMRQGxnHm4lRR6xTOdsbSfYwfrQrogT4lcxV+W6+z2Lfd7KXwJ/
 6YUoml/p5fUdyBk5MVuI75E4RO8dHXPCaEGoV3K90djQtKdlzae8Akkm99VxGeKTAeDCxhodLON
 BUXusfFMY1YHMm4mLUOcMAED6aEpqKAhhjkUetdaecaagqaRZS0L82dS9Ac7OfffQtLjn896GgE
 d5fncrlpsQtYocGujS99TIQCXsN01Fw+4tRfNZDBKuuNvztDJlZ16y+tpKi2AtX8txhLn95kAR9
 gSo1WaW+OFwQ2vvPguh4z5nkOKo9fqqGRIfAW1e4mIqa4mv6WmRiX8ZpMdVHTmpys23ijeO5
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=688a43e8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=HRpvt/FSzHA3SJMKks594A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=J94FwCPnZ0hQmDvvoVYA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -wDkZUTHHmx4wclPKx3Fc2JUQVUgGtXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300117

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

QCS615 has an rgmu which doesn't manage gpucc. So this is a different
case from the other discussion. Are we talking about scaling mx and cx
rail while setting clk rate? Downstream clk driver does that on behalf
of the clients. I suppose you are not talking about that here.

-Akhil.

> 
> Konrad
> 


