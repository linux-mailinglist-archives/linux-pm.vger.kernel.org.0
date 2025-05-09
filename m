Return-Path: <linux-pm+bounces-26972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80944AB1B42
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 19:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED50A077B7
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 17:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64432238166;
	Fri,  9 May 2025 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fa8OpSNk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF5623373D
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810356; cv=none; b=DRFpLrL1Mvs/xPeZfTGBi6xWxIwItK7m7IHwUswQyxozbLOtZRZI0b83z4bUvIcArqAyFQp61vFhMEegZE4AFJWSijkBqsizEKAtmXWaHTWqvt9h5upp9dCzyt6Zy3Tr0MHil+g+kFsatup9bBs1zDkRsaBcH5NO6NSWJpPjXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810356; c=relaxed/simple;
	bh=r0m0UW+PEU5BgL2NqVdok8cHtVoDL41wqAjRR1VyHgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzN4di8043SQKAQaebhWNTT2Blo2NF+wSQ6u0NO/514Qdh9Z2hJLJt2s4v1Fq6NnUWkQNxwmEYudDTm2jviruyEqRcIdoH8YbL+LBmKVgiYTSrGQalH6YdZ3R3JJdW4IAZy4MG/buyfXRp/Mcn+thdiXAG0hYoBKy+SML1ECHQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fa8OpSNk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549AaUas014401
	for <linux-pm@vger.kernel.org>; Fri, 9 May 2025 17:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bYZFtTpQ2K5+1pV5SB83yilhOw8IrH8U9j0WoHmd6qg=; b=fa8OpSNk2ZXlXsKe
	XASyk+9t77O0nPWWfpPX3oIH7QD4tWzx26SShdjm5jDHdirNDGKgzJqmfEr3Isiy
	Vo87v3AxkR2wmD1BbYTEuiktxnDvYUgWXgBRV1PwvKAQPyxHm4hypCLiVYqkHJb6
	fQnt/jEAwyp4+RFheRMt1ILP/TMGXv3MADpwe+pPYtmMpmBHc0pzNmu4S7FkZeiY
	vv971hbuON/33iCIixZ4nFFrfomtPm8nHtfYdP+hftVFWELlHR4d9H2knvSCF3zb
	akgC3CkRgqn49bAEh2RRmujymXT3k1iHaDrLR6eMyOCBxFCSxL1WaG9JFGMjrXP6
	fy61Mg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp4ncg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 May 2025 17:05:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5ad42d6bcso56782785a.2
        for <linux-pm@vger.kernel.org>; Fri, 09 May 2025 10:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810352; x=1747415152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bYZFtTpQ2K5+1pV5SB83yilhOw8IrH8U9j0WoHmd6qg=;
        b=SWa0ydksWI7tU5foA+bROqrEXG5idgPKWKSPbmSLpTrvaimJfzKI2fEU9p7CQQ3UnO
         H5ZIXDq2oklgsi2wcKuYh7BnDi/11M1hI+4Z/JBSvq54f7ByXvKOpbgH98zA2/AYSKTe
         HkcTovsTDkGEacbxL81oGDGcpZ5PGVY23gL4GA8j0+Vq3W1kr0q/hJwkleibF8SiFEku
         RKe3uhLASu4mROm1e5Tw8Q1neLPhCT/FAGSo+9H+nrCVd/gHZ00tJ9ZDxECK+leUEUuf
         mmWpPMqGAbD4vbNSExOcfAXhoi/0Lav8+0tdVpd8q969OO+8JgmLWSamQdP29BsH3el8
         mEvg==
X-Forwarded-Encrypted: i=1; AJvYcCXidYMNhVR43OZZ6bfvIbZJE2X2k+seVv2KqfTq4Ix98CjFQedAnMJ4FyOZLNUPJpmnBWg0AGz7zA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNu1hQYWXwa5UcWyMHxD1ZKrURXf8EJHiwNeLtPb/ZJMZewNoA
	wQYvEujbI0NC5Sp/lMoirzZN1lnvmKmEjFN4PcAPNGTPtCvo7CKpjMwYaDplzY5dO01LqFCLn9H
	ovRQ2z/QoOeQj5yUBXIgVCxBjTgSWqpHeaSi3YQWq8BVU3g1rssAVohi+GA==
X-Gm-Gg: ASbGncvYhSfT4adl91+8wAjdwBh/Ti9RD2Cs+tG1hzr7J3Z27ikc5qoZ8/zmv9rMTU2
	n82yIzpF26hYa8xsRMNxFWtadya0hfP3vs0LbwMLkZIWrSmyPml0hXZtCFUeo2W6YMHXOsagMaD
	euYka7wZEPqM5m+uGTfiK98hc/Hu14zmlt0fEljBv3XrEFH7iF/dksqJHkn/ZlNFAkuMs9kUy0V
	fur+ndnqE5wuM6hNLdPmkZ2B6vnWC9t7GfBvgUeDF2ujfOVzZ+QlfS8mk99q7g8lOwVPHv0vx1v
	BOVGLPBbf8pcPNTYkBb16/e3s3qXG+iGevqVfIC+CTlw7eFsNnLrfV0XZTpqkrpDedU=
X-Received: by 2002:a05:620a:318e:b0:7c0:9dc9:754b with SMTP id af79cd13be357-7cd01138c43mr237839185a.0.1746810352547;
        Fri, 09 May 2025 10:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbRp4cqQeIx22c94yzN7HcBSLTFgM40PIl1UVIm+gxSUeSDFOZOAzyxFmgxbh2fxCrwm5SDQ==
X-Received: by 2002:a05:620a:318e:b0:7c0:9dc9:754b with SMTP id af79cd13be357-7cd01138c43mr237836785a.0.1746810351945;
        Fri, 09 May 2025 10:05:51 -0700 (PDT)
Received: from [192.168.65.105] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2192c8ac2sm176736566b.27.2025.05.09.10.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 10:05:50 -0700 (PDT)
Message-ID: <249fa3ea-4b0d-475d-8851-5a31795f3b11@oss.qualcomm.com>
Date: Fri, 9 May 2025 19:05:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] drm/msm/a6xx: Increase HFI response timeout
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Anthony Ruhier <aruhier@mailbox.org>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250503-gpu-acd-v6-0-ab1b52866c64@quicinc.com>
 <20250503-gpu-acd-v6-2-ab1b52866c64@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250503-gpu-acd-v6-2-ab1b52866c64@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HO-uNGbArTluZHrchxRKlc_37cVjHn1E
X-Authority-Analysis: v=2.4 cv=E5XNpbdl c=1 sm=1 tr=0 ts=681e35f1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=b3CbU_ItAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=qaMJGrL2tkxVvb42h3kA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Rv2g8BkzVjQTVhhssdqe:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE2OSBTYWx0ZWRfX0kLFU7npgbwH
 g8MZddat/xWxTzBOmNYhJ1res/NCuMR2tuCUpatK185nZQ3fmPYa5g4ujTPIKIsh+skQuZpdOAU
 m6j695AJlIDUNl5vMYdqBnAXNxrofnjsK7GaUC9Uci4X9x2t+Q3KPvf2vtys/qeuaTqBblMahEm
 h3VTpiEcnLa9feY28DCZMEjzSx6fAVg+XMC6pMSHNEMxHI+SK6Tu8b+ad0ZB43Te/Q0bHWCpsLW
 /K45COX31aIfQkejnLQhjM8l9abDonof6CxffQ5WapZzq2FVoVa/r2BWPaAw38ThjVaRAGr70uH
 UZCiRJF2Lc0wLyXLSnDiUqbFBoTTyqOk9TW0LgU8JJj9vyVD/nbE6w4ZC0RKjFGn7rkmnCA+nQ9
 GherBZ1UpJMBdrsEugy+Rsnd3aCmCBeUAgD/FtSjPlf8mPt8fKL8WxNenXz5LfpixKZJqCmx
X-Proofpoint-ORIG-GUID: HO-uNGbArTluZHrchxRKlc_37cVjHn1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090169

On 5/3/25 9:03 AM, Akhil P Oommen wrote:
> When ACD feature is enabled, it triggers some internal calibrations
> which result in a pretty long delay during the first HFI perf vote.
> So, increase the HFI response timeout to match the downstream driver.
> 
> Tested-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Tested-by: Anthony Ruhier <aruhier@mailbox.org>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

