Return-Path: <linux-pm+bounces-23679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495F2A57CA5
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 19:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300C63B1156
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B9E1E8356;
	Sat,  8 Mar 2025 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yi+fIxYa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B331B6CEF
	for <linux-pm@vger.kernel.org>; Sat,  8 Mar 2025 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741457713; cv=none; b=IwIDMkIUAa296JY52X56Z2eI6f5zq6Ra8GswCR1wFml6OCxtXa/z45jprIpCYTwxFuV84UglCpWasS8Z1OqFtfSpuP6Q74EfzRksjWa3qDkFQqUyQt+zf6EPPU+UieWkFoFz3hxOxf7mXFCYW9hm6noZbnNDlf120jvcNnMliuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741457713; c=relaxed/simple;
	bh=YasUI7eo6rzu0KP0RdsLeKIWeZp+g4SwWBK7Bb3jdzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CR+Vme5FUeFkQSbQIySrSBtmTdR5LAu+OsC5BbcC5GFPTMrMyFuAwhffRSPy900ZDNWyTZAQPu1gbFmKxZNcTKTQvbphiu/7pEPC0nMF8JEgJo4nmqBnqokl5QRqjIrfcqY+Nj+w7hp+CqzYJGEy+zzZ5fQVjisKbYg5bruJXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yi+fIxYa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5284Y0xE012286
	for <linux-pm@vger.kernel.org>; Sat, 8 Mar 2025 18:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zP0cIH8IXd4ECeHaQ2piBoXegEjDr1q+VWstaDqq8zw=; b=Yi+fIxYaEXprQGgG
	VN/UyU+lK3tVBENdNAJK+J4fNsjWi7F4FW05IsDTh/cKDibBghzOnxnk3z9tjMrf
	6pYaKg77D1X3fU3wNbxYj/q4ZfQvsnB0RRxfD6RDjytqksYEUN90UrvAmo/XX5u2
	UW2UNSxZxe8Bpj8Egk8JWioBzbs+lwZOLISG0M7GVsU+6IWgXuUsqwR01EbUImcC
	HfOjTqEHRVPNfaHMYQ2OzRY383DAV3p6HWCRctN9XVKplXyP0W5U13Lipe/PofzJ
	r/7zmDzlfBPzPcJeEj/eD1IqFYJNOUx19aMb6NMw+FiNDsuIKnuaYjCnwAaDZoUX
	oRSdgQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyu8xek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 08 Mar 2025 18:15:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-476695e930bso1020581cf.2
        for <linux-pm@vger.kernel.org>; Sat, 08 Mar 2025 10:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741457710; x=1742062510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zP0cIH8IXd4ECeHaQ2piBoXegEjDr1q+VWstaDqq8zw=;
        b=rxBvS//CFTYcGUj6j/q2rStdIIGwXSchIZKj2gMqPr73B0w+XPcuZxAwAFCu/fCMoG
         Ul7ra47OOQZq04Zj4BDQ8jZQRQ/a4cOomaOG6aNDzPg1Not8lmFWD945p6WoINhbFQAi
         A1IBn4aL8jExbNqCB6d8RqS2ER3vVPD0USPPUO1+PDV3/1AiTtkrz3mC8nzIO43kYVE2
         4dDiBoFGX/qGrbzdjHL40e4NhZGzZC0l7xjJ4r+IjidEWztPOk0BRKyOsY2rSd+ZvNjr
         fOBEa0rOm38bUiw7EzDpxt0Yi32Im6tQlGfI3FnlK9CF1M7UkbL/Km96h8ly8u+MlrdR
         XR0g==
X-Forwarded-Encrypted: i=1; AJvYcCU1JoFe0/dvbL9K1LKxfdd8Ewc9MORLiGTumTs99h9Aer2As69urntm0HcyjbxVs2SECR1DXkgWQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7/JYJEBOk8rQJc6nllW1v2FHgHt4Ix034SY5qYR+jiFQfcD4h
	3kd9k8gcudr1D8zS/Fnq8l16KOeGLzR9XcTBBTD0+SFtJEiQinbfwH+5IPAEKWbKXEvRIaFkyqk
	yZqXDMICq77LcglMyYuo30WUO5PP5q0etuvRdFO0FGK+DoLvyF9u/THJo2A==
X-Gm-Gg: ASbGncsQBr8IAw4Sw3dSmgsTN6gA19MwlTGZDtVUgZINErlrh8/sztSLzP0SLef/PFZ
	TuUTnv4BKuT8rsbTBaP3FNy1bLX+gEvkTur3Llrppx0dBjl+Ay+I3C7cV6RdvX7ZXSDRKcBzPI6
	t/u1s7dR8tglTfLQMMuSsldEgE/syihB3l9DCi9IdjX4ZPArqCnVlu+eK0htQkkvMiLdV2QpKeG
	V63yvofJJwGz4rYlEF35ZCa2alYvtom/vZ3IQtZoqbU4MbQNco5jJJnWEd1GaaKO5xFVB2dSX24
	EIkHijB3OaqGWHuyyxFSCe7oJoTFuiGTcEc5cZKxnjve7oRSpXHW5LF1JdIwT8qHJdJE/Q==
X-Received: by 2002:a05:620a:1d03:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7c53e065222mr230799685a.6.1741457710287;
        Sat, 08 Mar 2025 10:15:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGne6xG5DU1bp+SuDI9vkw910TDxmiQikAQdubeuCx8ETOWW5ViWZDdFGXPUz6RsEI6/1CkEg==
X-Received: by 2002:a05:620a:1d03:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7c53e065222mr230798285a.6.1741457709923;
        Sat, 08 Mar 2025 10:15:09 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac287653e64sm30659166b.136.2025.03.08.10.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 10:15:09 -0800 (PST)
Message-ID: <d2640b21-41f7-4bb4-a616-42b6bd9cab0b@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 19:15:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: sm8750: Add BWMONs
To: Melody Olvera <quic_molvera@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shivnandan Kumar <quic_kshivnan@quicinc.com>
References: <20250304-sm8750_bwmon_master-v3-1-01a5cb330dd9@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250304-sm8750_bwmon_master-v3-1-01a5cb330dd9@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cbIormDM c=1 sm=1 tr=0 ts=67cc892f cx=c_pps a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=KFxGp1uTjiazv6v418gA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: uM3VTmFmUYkseLXoNrhdSkOij-FevPFy
X-Proofpoint-GUID: uM3VTmFmUYkseLXoNrhdSkOij-FevPFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080140

On 5.03.2025 1:33 AM, Melody Olvera wrote:
> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> 
> Add the CPU BWMONs for SM8750 SoCs.
> 
> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
> Changes in v3:
> - Change cluster 1 destination interconnect to tag active only from tag
>   always
> - Link to v2: https://lore.kernel.org/r/20250304-sm8750_bwmon_master-v2-1-ead16909397d@quicinc.com
> 
> Changes in v2:
> - Change destination interconnect to tag active only from tag always
> - Link to v1: https://lore.kernel.org/r/20250113-sm8750_bwmon_master-v1-0-f082da3a3308@quicinc.com
> ---

This looks good, but I found that this platform may require some more
changes for bwmon, we're investigating that

Konrad

