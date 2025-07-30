Return-Path: <linux-pm+bounces-31617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E510DB161A6
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35CF37A604E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 13:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F191B2D6634;
	Wed, 30 Jul 2025 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BjxE+z2k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944032D6412
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753882640; cv=none; b=gjCYBBNIoP32JYMXVdbSjEvuiUkZZDqUxroLtOipMxMIgHoDZulscZp+XOafW7PobaGXpEnOge12fU8nBQJIMPQS1o87KLJT0DPBIi2VNTBMVQSSn+pcgd4GeUAyRIe67Z7dDDSyaqpcQaWxS8KKbGI90zbuEIT2QjP2ftUH3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753882640; c=relaxed/simple;
	bh=UnGEp/P/b1gtgq5NHRnGprOfMT8kawtFXgke6jFNnTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1VE0hJJlEmDJFxU1dbjfjEDqIRKTPl6UlGA+o6GK3ynzJxUfpQ4b0sM0TrWlqnLb9NIFIqAP2WZwH0BALIOo/hvCDMZw+xFHKKgwqVBLpvwUGJuXSB5tCUEMba/LJWXdauwt6hdfGdtIfKRI0rfIy8XlPkkcgUP22CTaFL+MxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BjxE+z2k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbCix006207
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 13:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eaYzJi77qoY0VmQGa6ne9vwLY2SP/8VbDbQMvWMF+cI=; b=BjxE+z2krMPHv9mC
	nZ/HdkNRxQL85QbmrzQOXo/2TpAXFokT0ecefclEGDouYYouViGAIHDi7pokR2Mi
	0LRDl5N2uBJGliTzH/CgG9QjRnrNA+ZQsy+oCnmSALfTarN03ZazfPsSSAwEv3Lu
	/xOZRAadmJzKnE16ktOY512JmbFsZADelgJpGw3RL4JtbOsi5bGMvOq1EtV3a176
	Mv2mLEJ+LHCQLq2caKw4Yg6FBNov0crdZFNOmGzgR7F/KuKx9VTGgVtBGyu7JV+b
	p1dqRTwUBUIoZKha5cQWFzfsMyWTpQYv6b7ZW+cZiQSsr45mYmAfh6pN37mZuUlY
	+Sv5DA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwg88x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 13:37:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7dfeacb6dbdso46884285a.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 06:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753882637; x=1754487437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaYzJi77qoY0VmQGa6ne9vwLY2SP/8VbDbQMvWMF+cI=;
        b=utZBhDsfX2uOyF/03BWVpJEFiJxIjWyv9uxluy1gL8wXYlbULisjCRVab9ePaNEbcG
         uYsxpoPW0MeCKQaxRbXUUUIYdhqs9tPQtgVp3ihrBk4umBr/6vG77rMHpuWp76psQKpo
         dEfcLGmn+lgckprhYBUWhM99DfvuOgqhSqtkjlxzKqygMBf6DJUPIUSlr9gv+dfcaD4P
         kBl8zoo8l5yxED7NAt8X+tsdS77a5Cg2oXzIigez5UCtn6b5LOKZIL/8LvImn+Vcsy4R
         +qXrufVwdAxVud0o46knPl9nJmzD0FYV628PFLazf5uQIimDoFHlZPLYJDwZKMrHv/XA
         XyxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVczWSQYDBf34DBw/5PR1ihN53unY4lF7D8uAtPbXoy5pI76yRSBGivanGA30e73n6wDLcZ19pmLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRwXqPSFqjj0HYyV+Lkxt/D6QtfT882OovK9EKoftzb5URDW8n
	kKHbBarn+awHaGRYnnr9z24k4gPl1EGRcPwsX/efaRgVfVTUNNHZ9BDv+cX5ar/yE53jlfVv1aC
	UzFfHxymE9x6wn4yBVFsPCj2AURUaUQ5qLk9bMYxc3uLHq1SUsNVinImPiGfEpA==
X-Gm-Gg: ASbGnct47hf5gw70mCBt9In4udQ+ccEENEkPQ4ZfrAweHdj2tSWz8RAIAmeXz9+fcp9
	7AntRuWcIp2hfLA0jv+Jma62T+QgJG5rJEGSILhMILLbRbkhTnYoxcmVlTFC2QyGru+d4OqvbMX
	jXQniNBTVdp8qTEqP+c7YFTvvUtaMG8P77YlNs3wNZuuO3Ma8vs50j3U+/Db81NzMvozW5euEjs
	pwWsXHww9uXvsD5SArb1OzcLoxpHYxw37Ab5t5qpRKQMySgaEMDR1mmILG1WGfSY1mKcubAzExI
	w0q5y2R+bOo/XkY1taXT/oQeYP53cxUB2PvL80Mhkq+eZ50BY+FHYHyuhA4C89rGTuXRU/fFNnv
	rRPdo9NChZEAi/M2hhw==
X-Received: by 2002:a05:620a:2544:b0:7e3:512b:97f4 with SMTP id af79cd13be357-7e66ef809f9mr252141985a.3.1753882637221;
        Wed, 30 Jul 2025 06:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGZha2wMgFradgQDb9BJZKrBTTWzQSZkHlvvJvibbYOb1WpJSfTIlhyvZmnFC6wRLBq3+92Q==
X-Received: by 2002:a05:620a:2544:b0:7e3:512b:97f4 with SMTP id af79cd13be357-7e66ef809f9mr252138485a.3.1753882636620;
        Wed, 30 Jul 2025 06:37:16 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6157dc6b61fsm1525857a12.3.2025.07.30.06.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 06:37:16 -0700 (PDT)
Message-ID: <ff6eee04-d191-4dfb-82e5-7e3a6c896025@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 15:37:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: qcs615: Add clock nodes for
 multimedia clock
To: Taniya Das <quic_tdas@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WvgrMcfv c=1 sm=1 tr=0 ts=688a200e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=vwtPc_hCN_QQCO2tyN8A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -p0w5XEFfIuKCDjlYYB9V_Covki_6ARF
X-Proofpoint-GUID: -p0w5XEFfIuKCDjlYYB9V_Covki_6ARF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5OCBTYWx0ZWRfXxktoYyZNMeLS
 kmTaAvtA+AnCpnmdB7ok8b3HuLDQ3QFCvxjJObZjZY2r2IDm75pYB5GC+tTyIZ4AlzCIS9p0LNL
 qpWGS5wMJMnx+PJ86LDeH4p7u9vdZZdoEj8V6oqyqcCzAva33BQ0xw1S/Aq1EEVWQhbCKSTLzr4
 ey/BQE6muFregvXwb1YV/ZyLOjfnxrcU0g0mmT7BUVrnl0qSBVtWtOFGTRRXn445c/BQyiZShWi
 fpG5ySB2RrVwCV6EyTYGCiacyFT6yentCZFhoXch6wLHSNQjahm0ACZUXpEpegCXu+e8td+sl+S
 bIHSv1aasdUe1BVDd1M002PT7+FKmsh6sRBStO2AsRdKlUQH8GfrSj97j3+lWYDHIAg0VRod7Na
 WLU3Vyl4g/3TwxR5BH/5WvP1OVftGE1GatqZVW4W90K47yPYHyVxypvtr5q72I4YCQivvz/U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300098

On 7/2/25 11:13 AM, Taniya Das wrote:
> Add support for video, camera, display and gpu clock controller nodes
> for QCS615 platform.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---

Bjorn mentioned offline that these controllers should
probably have power-domains attached to them (perhaps bar
GPU_CC, that's under discussion..)

Konrad

