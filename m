Return-Path: <linux-pm+bounces-19941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 712EEA0096B
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 13:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4943A3E6F
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425A81FA15C;
	Fri,  3 Jan 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nnRMaVB8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C621CA8D
	for <linux-pm@vger.kernel.org>; Fri,  3 Jan 2025 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735908163; cv=none; b=AcNWIpJB1+DEM/rp6A3brtD5Z14eeBs4xXb/NtUcHtJ5Y236XYiSovgo96T2A71G6NCxD4pZvgpkiymADFGhmOG0dmFGgrdE99iuZ3xbg27M9slWaMpAmOmrtisN2d7WE8cX8HqFl8wza+lM6eiesldLIEBn2U9iQ+hqic5cGro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735908163; c=relaxed/simple;
	bh=6z2Cj9z11DNrLUU7p25gMTU2IDw5wEC3O9INArUUsuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdKuK0t0hYP8Lr+h0ZCfyWIIOjpj4YkeBOeVQ+MPbLVsGQaNjJRyCeVGuNFftlE33kV7vsd9YJJ7yP0ynB71YqjcgbBEph1WenINq5guXiX+6FTyG2w0Zs5EMOTFTLLnq0G4INy9ukT+NysnmaIiPGS+ilKeSt34Y4t/hpr0z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nnRMaVB8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503CAWs3010377
	for <linux-pm@vger.kernel.org>; Fri, 3 Jan 2025 12:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TZARMRNqfJJBSi0ZuqSgSannpryoCZUFZtAwwKozzXI=; b=nnRMaVB8anTGzIqz
	Z/SV7YYBtvPCSwx+azpasLMav06W23ogMLE8zV0C4njs/pYmJ48Ker3/HAmLb/JG
	q5u5uOfXelWitjaizImhNyKYHrSGBkP2yf/5M/B4VCAGsv80cJTZXeqdyULd2wZK
	vzfR4OHtp6JkfgRU03rsKxHwZQEINku3b/ZTo2PFxOg2a3SbrZlIdT/3g+k8s81u
	owpnsWZDssYTJkB0Jm8oRLvxa7pofQHY9p4DcdWNhEud219evO6s67WppPX5D8kC
	X5+uox+vguhsiTdYQeT/f8MCMnIQSR3rTfMYLua1ovIaWQeLf0veDi5OXhieXpQv
	YGrRqA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43xfnfr1u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jan 2025 12:42:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46a32c5cdbdso8046861cf.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Jan 2025 04:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735908160; x=1736512960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZARMRNqfJJBSi0ZuqSgSannpryoCZUFZtAwwKozzXI=;
        b=gq3MxbnysDMkKKDHTLqt1Lrbfh7fT/2uMp31Mwz5kxnsxK3J3+ZH1/aix+gqged56y
         CSh6JZnaP/VxqZyGakybPuRsUcKC/xxxbROkNv5/2KYu8/sIQ/nIxX6rSn4vmEONLsI4
         avWcQzwUCOBJ+uJqZ7qfTQgNrRVBTl5hntTtcInODvFg+KVGBmnkV2i77WHOx9PM5Syv
         vLU6KyvaRNVFf+o235V03PZi05jKBJk/yLJtwp7Ve+U0rRl8EaGntQD7lvTDdDu/PSbV
         myUOBxxVAwGHNvwlG9EXxMNQrraSiUIY4HD05Pg+xmWM3dtw3CYVeymr7ALF9KHlbtRq
         u19g==
X-Forwarded-Encrypted: i=1; AJvYcCXgqsB4YWCMoOzhdYR9rmxomODGFaX5aGKlL8reFIteZUmn1IDj9xvv5k1jJkXj3d8rmNPwgm6WeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiDt0kURlENvl7RfUObVhHqDwUtT66+Buq7NPvUSVzYvQ/Mkt2
	ELK5TaZhz1EouhzdatGD5qe2MItOxP1c2S8BuLP0H46MB6mAo5Pc+A2xnuQjJDGJTWG8xwowrlk
	8cjSsMIy610ZXbEtclztu3+EuG3jQx7/6f3XNBEr/Fs0qURmodDINUSbZRQ==
X-Gm-Gg: ASbGnct/BtK4pQFSkVz2hI+I5EFbtYOFtnF203D2yqnMgQ0+KoaqlD8qWuzTo8zYUaA
	qoXvV4nz9YwfukbsAoqrKPn5lmcOkCze2ZtcXqAbNvCNxLxTVcSJo9D86FU7I+8grBhFAoD3/PX
	JIqNxhbhzX6g5P3sAK5/WYvw5ENQILu1dBvTmovIIkMWXYZuELeh1B4NcrxHtuQzJziemkCgODv
	F42GZC39wZyNDroWNEYZpmk/il3/a2DjPOBm6L0INkMtr8Z1TpBdyJeqgwjUocsQqr/PReUnt0d
	yn+X60yco9rkFCp9D1PGQMWc7YcuMs2XC0w=
X-Received: by 2002:a05:622a:1183:b0:460:900d:6052 with SMTP id d75a77b69052e-46a4a9a34c7mr310086151cf.14.1735908159808;
        Fri, 03 Jan 2025 04:42:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcALt0LJyqknH0pa/OzeBKOkJJU1g2a9f/TCjCM+WwWX2eXlLse+id4suQvcMJE43uhj1+Eg==
X-Received: by 2002:a05:622a:1183:b0:460:900d:6052 with SMTP id d75a77b69052e-46a4a9a34c7mr310085941cf.14.1735908159459;
        Fri, 03 Jan 2025 04:42:39 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fedaf9sm20087153a12.56.2025.01.03.04.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 04:42:38 -0800 (PST)
Message-ID: <78979ab6-0ce6-47c4-abe2-d4d2d9d50480@oss.qualcomm.com>
Date: Fri, 3 Jan 2025 13:42:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] arm64: dts: qcom: x1e80100: Add OPPs up to Turbo
 L3 for GPU
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com>
 <20241231-gpu-acd-v3-6-3ba73660e9ca@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241231-gpu-acd-v3-6-3ba73660e9ca@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xmVZB2q428JRfMg0WtEa4D30AjkScKiR
X-Proofpoint-ORIG-GUID: xmVZB2q428JRfMg0WtEa4D30AjkScKiR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=809 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030112

On 30.12.2024 10:11 PM, Akhil P Oommen wrote:
> Now that we have ACD support for GPU, add additional OPPs up to
> Turbo L3 which are supported across all existing SKUs.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

