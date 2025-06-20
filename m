Return-Path: <linux-pm+bounces-29163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A48AE1DD7
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 16:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CE71608E0
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2123E2BD587;
	Fri, 20 Jun 2025 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZAJtHpAg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E4D86334
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750431165; cv=none; b=ue1dKj32AAwJVTYjfANy3CzxdfVg4cTPiNeIh6J1rbk6LdTvTtpo9tqpigkTW8nJUpFA+zqouDDycHA8dlfsMsdiN2F5Lc1xctmzvdi8QUQyPA6LswevdXARvle6AP6vRxmR9PfVQaEFAgDr/WmMCdG/Z1buLE4tStDe8Yd60gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750431165; c=relaxed/simple;
	bh=+81yvo31v7QMHWZeaNt1CEAELQelIHwFryFAymk9iSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aymW7pWbpgo0VGnrCAeYmq/46q6xWDTZOc07o2L/zT/3Qbn7Ys1Y7Y8sCttIWpP6ET8hsQQd9ULaI0ZjlT7fM4McI3WI1NJsVvHjEMO5zZ5zV4sK/TmolZELTD/JlnQhYuxBVLXn+ALgD5Hw0C2cR4gt9oxIMbshoaL+dxatyjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZAJtHpAg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K7HhVV010669
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 14:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bAvY378g9pdTybx5+IbpDJkH/ia0/TW9evSfILpWJuo=; b=ZAJtHpAg5TytFv3W
	kvuEP7MlYXk08pMf7BPEgfge3rI6e1pJiKr99ASdea9Wguhu2WqaLVwo/hjsVtL6
	3dgUGZpz/CmqkHIg007vyaJ7HlUJ6R/Bo/Df7i0zzmZgjH2LHc8yzNCo+GdNTkny
	mn0iLXTk5buYeTmE5nZpfKBmadFdmNILbOOEp8XNX3eEEd1w64JjX5vndaZrlLlV
	UQInlFPbKPV1t+Nc2WT+3Dz7TAjHCoiZpzHzR1tTtT0xetNlcDAPOxVuQG2iJGyk
	RzcHwfFAGdEqnujpE0OrkBPgJQkxfSCd49PTSZwf0l6ZaXuDRJXwaqGntp6tRXIy
	igOgSw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47d34017ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 14:52:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d094e04aa4so55704485a.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 07:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750431161; x=1751035961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAvY378g9pdTybx5+IbpDJkH/ia0/TW9evSfILpWJuo=;
        b=ffOSG1DjHmcY1lkPeKpcb55ZeoeqONqRcIPDYCTPpMaPlzsfzbG9PA7r54a2w0f18G
         EYRe5mrhCkBzWNEuWK9fmmyMea51R5mPENhmGVZgpN9Qp4PahXRvgAr/HNu8SadDpmhL
         s3j9Tii1P57QKb26E5hvH/3FJ2Olxm1Cd4VjOxF4LGwx7TQRRbrTVAmg3toXQ1NDOu45
         DGsRl/rlE3ZwilSISDxzvYTqibUbEWWqezWooVEbf7t5BAgUTYmjTP8dhVGVjz3mL/ST
         /YNd3pWCKJgsFAOBvdEM6tkR1zYBb7QVW4WzOyr1Y/+XnakrcsQHt5/WAfvdupQYlUzK
         E/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9wNc27huLDQH54OEiIqdydf4wLMrOP8koTUWu/3KYFeG8kEAK/LZQxZ16ckGTCx66etpPzzNhog==@vger.kernel.org
X-Gm-Message-State: AOJu0YysCIq6JFDUuPummFm3YmrN/oD/rFLTUhV4vSTd4XDrzDK/Gaiw
	5IsYkBfvSyoH+IPhq61MVogz6AlEvdxnRxbz+gBVSmuf1iNSDBmwDPqnELhLfeL5i3u1+0/Z53L
	Wx6sTqg2VCusioF+s7XIMWBeBVeSNmXHdkUxFm1tspYoiRWCnFEAwH9edkRgplw==
X-Gm-Gg: ASbGncsD5XQOLasBXBde9BN+5w3ty8dksg1Q5P47/LsDjXdOcs1MSale8CTrXHLjdr1
	Vo+iGCKHcLlkWJY0+nsLphmuGg1SUbc24wnkGB2gxawu8KdpCg1ZSD60jIJAElRAHSh8X9HIOEy
	DBWbGxcR1fXyvtMj2IYQ9201/b8VijKQekuj/EabFt8L5b5Cg9gCw+qCMJNVtxaDn2v4AD9oeQe
	XRrStIzcH03/h53E0xh+Qr255sbXWIPH9q1O+sOr+zuE/TRuFB+1/vpFtFTOE0VdvtTLjUKpxaP
	aHUoRbWhb3ytTd34Ih51IQpnOI/bC7wRcPbAbnlJd28oQ87Aka+X45PzhcAMWI6fmG5Hsy/qzlD
	e/gA=
X-Received: by 2002:a05:620a:448a:b0:7d0:aafd:fb7a with SMTP id af79cd13be357-7d3f98d9073mr155711985a.4.1750431161598;
        Fri, 20 Jun 2025 07:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWSbj3zLVYKtfz8K+lKDPK0MngK/y7uQ3TDDGuLOc5VoymNZIeGKtQmf1ZbkgF7OimM7IZMA==
X-Received: by 2002:a05:620a:448a:b0:7d0:aafd:fb7a with SMTP id af79cd13be357-7d3f98d9073mr155710185a.4.1750431161098;
        Fri, 20 Jun 2025 07:52:41 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ee4ccbsm173800966b.70.2025.06.20.07.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 07:52:40 -0700 (PDT)
Message-ID: <e1b552c1-de9e-4c6d-9340-232427442620@oss.qualcomm.com>
Date: Fri, 20 Jun 2025 16:52:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: Add GPU support to X1P42100 SoC
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>
References: <20250620-x1p-adreno-v3-0-56398c078c15@oss.qualcomm.com>
 <20250620-x1p-adreno-v3-4-56398c078c15@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250620-x1p-adreno-v3-4-56398c078c15@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HOTQoyItmpIAcGCem-Fofn9tSBsPTQaR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEwNCBTYWx0ZWRfX4jVxBVQrIVnX
 Jagft6PTXERFGjobSuKPqTE9ZjPRRUAdP719lvq4Pzzb4KbNscCSm7TABZPtnAtSF4Ny+PA63mx
 oVKxeg56nqdEwppJDqS6KhLr7v8+ZFG+KwYzrZ3AnzBWvC6oVIs2jR59QIvT3+z4xTGLMGKr3mv
 mLSx3XSr9o2RTfsshENSneIr/B6/+tRTylzhV/Lr3bUCc0pA+A8voDSZqYS02ifnZYBEFfsWtQT
 cIu88Yeye34lv8DxqChesQvNx8vSR+onB4k7YyyehYKiIv57Im5cxHstS1xNoXEdkeCW23pvClG
 HzEZA9GwJDSesT7UznuQZLw0BE17txbzQemvGuXn9Xh/dR6yJYhY9Y2ATjxUmUuZBCrqAAUlHZP
 z1UmMlCS77/xdXbPNDZcOzk55Wtzni+zBCkam3uecZ1B6GdTnwKpaufQ/kj6pJD9nbL3jj+a
X-Authority-Analysis: v=2.4 cv=JLE7s9Kb c=1 sm=1 tr=0 ts=685575ba cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gxl3bz0cAAAA:8 a=EUspDBNiAAAA:8
 a=5RVeKMBEKdVlAG-YRsMA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-GUID: HOTQoyItmpIAcGCem-Fofn9tSBsPTQaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_05,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=819 adultscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200104

On 6/20/25 8:54 AM, Akhil P Oommen wrote:
> X1P42100 SoC has a new GPU called Adreno X1-45 which is a smaller
> version of Adreno X1-85 GPU. Describe this new GPU and also add
> the secure gpu firmware path that should used for X1P42100 CRD.
> 
> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

