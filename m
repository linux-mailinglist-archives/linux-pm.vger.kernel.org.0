Return-Path: <linux-pm+bounces-35572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CD6BAB18C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 04:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDB51924AE5
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 02:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAFA19AD89;
	Tue, 30 Sep 2025 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V3iTXAvH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85782153BE9
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200805; cv=none; b=FaI0TUhI193uecyCOGcn0TK3TFEaN5cliy/eM9RUalKw00kETPgAffwuigZogawxPPCmWUU++iT31hev0tyhg5lNzNmqhznPn7M602V6PrI0hFKmtDJj193pTyxcRKMB8kCprn4njFRkpXgXgLXlcOeH/nYMMaAsP7YiVdNd7Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200805; c=relaxed/simple;
	bh=vx+f1fQY2Uwueq3Jx9VQNWKhSt/AYmYcmnwfYaVLCf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9rSiOjikAT0KqSJ0+0Ss2/031qXvD1y2Mxm7ao39bcablZAHJvRH8hgl/8CZaTGriYeUuboMGFQ9K/4xFYzByoDG+8d1IAeZuMGlE4QZgQEisK8N442Wgp2IwnD56qCVJ7qDrGZ4i4+7tm1LbfXmHA/J4IPzplfjQMvnjJzpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V3iTXAvH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TJCebR012892
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 02:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ptmEaaTCFgclY0orIxraWd4bdye2B8I3nhnkuntUSC4=; b=V3iTXAvHQu716hMu
	lFlOXMFOLM7FRNpoWINAQOmdXf3hKtyIk+xH6+Gzn5FfR1fFQfa90OodMziHt2Wd
	K3uXTkpB05uEHm8Pr1GTZLdBZZ2kBlXUhw9QIJpNgI4HRrQGi6eXEEauG+lMjgoB
	07/tLRos6R2ifnwv2reoBEnqLOEdePEVWGz2fmlOUt8d/3lzO9QnKXqXyF8TvSQe
	5fEs2m/xpacJs47Fe91l6vuUnrGF9LEmh54ueL8zNeC8xSAtNHn0KLv4zrxPnFvK
	EeJyw2LsCcaTZIkaSaTnRZ2A6Lht6M9p79wf50tK///JrPfLB/TYMlSPdusInv/a
	qgy3ag==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vqydrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2025 02:53:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2699ebc0319so54244925ad.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 19:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200802; x=1759805602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptmEaaTCFgclY0orIxraWd4bdye2B8I3nhnkuntUSC4=;
        b=ZNUnX0b6t0DpgJtw9xqnb1ffN+BoEXJ2K+c1NvC4isMfH+1nV9daxzGCGflhoTzCbD
         QXx5qBULH0o9nxW8cZRQux4l4FS1bTpfcmfgvFA2Hid6WeV6A72kXM2NHozJJN+qA/7B
         1X0gwYIdf/jhomXuJngZcGMPKjihmB7piRA6bBgmQdcthxdINjOxutaKIm/9LeM7vIcx
         gJS4gpAFtDMgfavIU1flNwGCL9M3D9/eXErVQbF1gHn3TFbidUouXyISLT11MthXzsB7
         LYWHzRGkUGa5jSQumW5RoE5IEJO0MzNd44nxf++inHRPZA3B+tITFgZlDZ8QXvU1Q3Ae
         ZuGA==
X-Forwarded-Encrypted: i=1; AJvYcCVhzYtTgh4GFmE2y6h8Zn5koDuci8wsS+DCN4yEcGkdXxlnQ/mbyTp92pY5aIf7KAudwp3z1u9ABw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4HbfupXO7bswWMIqxkf6fcseRj2B8e0mcCmBUz1tbUhv9b218
	sMEEgWmCMnj5lDoyaSqIw9z4MLNIF3+WSllTnaYUZwP1yf7PlSdxqtgcjM9ETjdD2E9QmMW++4q
	UJ/1DjHcKq9jNvCijCCKaJNgT2EpE8e65HFlv7frV4O2rBPjuinmx12ZNbt6rhg==
X-Gm-Gg: ASbGncvz/IeCIDUkHJXSPGvoF1jRkzNbD6VTGDAuRRZT99sKYSvRVuKQauMA1FMlu5J
	MwBG7TmyHMjxXlvqefwytSgHnqymg0y7035s9wJhALcf4jAMVQhOKpux6K7YlceJwMAmhT5rEtT
	HcSgj8fkNlj6YE0RUMKnwkThExFX2JKpaeeSnpmESvCByNDMCwEi6r5gi6lC2MC6mbxVmltmv+P
	P4MdN3Syu3U13Rs56xyNms/BS4sgQUuPxHaJCMaJ0fiVmTzrlG3y5AG9IPWyfCiAWjW1+X6Cyp2
	ra0yQz5W6iJ9NaGwoJDOS5PtqwvWM+DLGKXinLft7eLlzX97kFXZ7FbS9BLNfRubdhHZBVoEL64
	oxn01JkN2fQ==
X-Received: by 2002:a17:903:90d:b0:268:baa6:94ba with SMTP id d9443c01a7336-27ed4ab65b8mr164718645ad.53.1759200801562;
        Mon, 29 Sep 2025 19:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9BYMWp6hNCw9FidFOi2WDNeI5c08GRWhasex0PVEvIzKhELgPVQ9in2bgdPZSp3Wkfk1VQA==
X-Received: by 2002:a17:903:90d:b0:268:baa6:94ba with SMTP id d9443c01a7336-27ed4ab65b8mr164718445ad.53.1759200801090;
        Mon, 29 Sep 2025 19:53:21 -0700 (PDT)
Received: from [10.218.15.248] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed699ecacsm144700875ad.109.2025.09.29.19.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 19:53:20 -0700 (PDT)
Message-ID: <91821a59-d893-4807-a9da-bf7cb75a30f0@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 08:22:29 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: add Kaanapali interconnect
 provider driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
 <20250924-knp-interconnect-v1-2-4c822a72141c@oss.qualcomm.com>
 <2mq2qqrgm5x4hj2cnstzsqzfk4lmzhg223hmobrjnqu62facc4@p57wbmkys4in>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <2mq2qqrgm5x4hj2cnstzsqzfk4lmzhg223hmobrjnqu62facc4@p57wbmkys4in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PYDPJtssT91vF7pnLD9ezeHsQTzmt-SA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX8fBtFLAOWu3a
 0ftA1SicLhv9GlM4oqPYZG5HF+wc4+Gh01N9QfmUchlYJ64UVG0G6A9vRKjzokJtdMIjUI357lS
 5oeJhMp9hdpIwa7qPorS7xYHpxV8G4NbLpm5e14GtMwlarNAL6/aaCJ6k0Y9UlqTlQbIbwzQ0w5
 neXVxGKA0BVCUnjZZOwrWAkgSaf8sGw51kDgVnuUXsmfmgIDD1zJgkIoldlTsqFqm0j2CEiw5ql
 2dMo316sK7fALUbg2UyhRbRC911N8NBVnA6CM5ZmUuv1Z1Av3e51YI1XkqhcXWq7ZhikbbxMZeb
 ila2s9iBVRyPZvMZjX9gHRSFNyalcQoaIXenit6qbZug+SJZRJiSF0tLLeWcU++jPN2+XBBVcrf
 b/xZwspOmMSpneMGnDxmkaroHtl5zQ==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68db4622 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=U-4vxhJDZ8N_SHWVoUYA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: PYDPJtssT91vF7pnLD9ezeHsQTzmt-SA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017



On 9/25/2025 8:17 AM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 04:02:45PM -0700, Jingyi Wang wrote:
>> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>>
>> Add driver for the Qualcomm interconnect buses found in Kaanapali
>> based platforms. The topology consists of several NoCs that are
>> controlled by a remote processor that collects the aggregated
>> bandwidth for each master-slave pairs.
>>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  drivers/interconnect/qcom/Kconfig     |    9 +
>>  drivers/interconnect/qcom/Makefile    |    2 +
>>  drivers/interconnect/qcom/kaanapali.c | 1868 +++++++++++++++++++++++++++++++++
>>  3 files changed, 1879 insertions(+)
>>
>> +
>> +MODULE_DESCRIPTION("Kaanapali NoC driver");
> 
> Qualcomm Kaanapali ...

Will be addressed in next patch revision, thanks for the review.

> 
>> +MODULE_LICENSE("GPL");
>>
>> -- 
>> 2.25.1
>>
> 


