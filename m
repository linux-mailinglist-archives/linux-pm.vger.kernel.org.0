Return-Path: <linux-pm+bounces-41032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D01D33887
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 17:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EF6C314338F
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F707395258;
	Fri, 16 Jan 2026 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BlklGxgX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wx5Y/UfI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038CB279DB4
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581257; cv=none; b=q2gppBT6sgbuIkEg+BeU4R911tJeeCLx5WWF6eTjxkseupP2OBPIk4bpYv6lxeCrSmAVsthRnBeqt26qTdoWFKs3r70r+CCyhQqcSFSG3l4Hdy1wkj6CwamYORuMGtvlNInGK1bqldUTWfIzKj71wx0a70HZzZwkRyQ0myi9feU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581257; c=relaxed/simple;
	bh=q74+5ZnUwcdx1btcAy2zqzv4xpPqKeKYliKs8FQFcvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPwmTRVv/2wrED+JQ30NnRkxoI7ByIbfye8YHPc6Z6VpRP5nKpCJN9Kj1vuC11L7V6njxYEBQRkwzoYlPpgPyWlmKxwqkB6YOR5NxzJa2B70XoXO7fdQpRb+dCSvfliXnj2l7S1Ghw+iRixKj36pg+3Fk4LWBPXFlF8WYJ+Iuco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BlklGxgX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wx5Y/UfI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GFt0Hc3582836
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 16:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ibXM/IJs9WDuZYSVdiNej6sR
	HQ0vHmfue7ThjW1H/ok=; b=BlklGxgXzEpdrHjixzkmtBz5qOh0KAbcMtdkXqLf
	thqtFeDPUY0ZsYsz821bAIawLyT6WN1MZRD6cwJUzSCgC/YzTYAWUJegDG4iVnIC
	17fuY/iUtlI7EObiMSOGcKL9MR+QsGeSj7toXEv3WOscKFWmtzTeo5trtJ2IPcav
	KR7l5iQ3y2tpMdJqgaNGAZkj66Sed19vhNQ+1Omm1Yr7Ydb2T0Lw+XRmMDmRQE2i
	h4L1mwgYQyCnH3w6WfXfHyySci90LAuxZCuuq+12j7wJOladCRbvxGhDEhY/EEYp
	8hkXxzPYoJqk0oh87VMPfvI4p/a1WbLAVl3i1HjVLb+7Ng==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq9ayttec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 16:34:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52fd47227so412404885a.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 08:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768581252; x=1769186052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibXM/IJs9WDuZYSVdiNej6sRHQ0vHmfue7ThjW1H/ok=;
        b=Wx5Y/UfIFLTOoi32qYscrXw75WFj1apllJFzinR1rTEojY6eKrNAZyVPfk2S8pHuU+
         mq5oq6UEOyilijxVgpL7PzIwkoXDjt8dczU54NMQFEMn8fqRM4ZIFT7zWlDf88ocKVSO
         VgQurAG30zDL2L0hr/lJqAl/WtuE/2pca8qldLqer5ajIuJdKJujKfQyX7ODIF2+WD4a
         KPXj/Mbuiymay83paXpcWDSus77uZ85inlP+W9rBLeBQWz28odgu/HH5/Wu5SPgkhNbi
         Woa/eg4adycSLd9V5y+lTsrjbkipwmA70r0NjY/ktIzxx+3Iq5Q2QScVfyeDZEDpFhZR
         Ptqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768581252; x=1769186052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibXM/IJs9WDuZYSVdiNej6sRHQ0vHmfue7ThjW1H/ok=;
        b=dTGlbN2+50yxAE42LG6Mt29MLFzF5/xaYDPa4aVcGuZpawyLKv074NOP54KuDunzEP
         jM15OQIzdqjhX0QH9pjbF3Ne/SaySOt07JlvRXqY897e8UMuvTVvxZ3sNob+JkEK7Q0t
         WVwobRHnWVKZc2AKfU1v/ySe3ozpcsKs7JdL75mS5N07ql9vb5lRYeEy8jEes6kjrCVf
         8ldC0TcyfAUryTubADTw1FL3IlMDbikPMvniX2XtiB+HtzC9UBX2cVZCYuprV3W0OkXV
         Co1Vpl2lTcfNh9Jy+rOy2sDm9omAql6v3KzKLV6dt7rPxF0/av4FxlMV9SbM8I03QevM
         Foiw==
X-Forwarded-Encrypted: i=1; AJvYcCXYZZmuHyNfUNnUpPNZuBfjAK1Sh2TDtGAe5k+whJ0k3jfJaqyRLbfw6m6+qWwjJDHO/1FwTJkVXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFg+yLPYow+lUrs0vUOQ24c2ZC6hf9ACPi5tTzSl/RJkdRUPq/
	YKMAlYZLnnhFtKJWeOSZPcqSgOb4IkVUwRDolfyE+3vO3+bhgjSFidqpvJLoTdZXTljRoOoF9Fc
	Ue+EfYnOdeyCECCF+XJWvs5AtPhR7j1V/DNlSKU+03+h9VGyD4MzZNUwE5egK2w==
X-Gm-Gg: AY/fxX6wOp5f0MDDYFgrhzM7TdULJ3xJt3UKA5FA9oo1bV9X0C7ufKr6bx4JxTwl3UD
	cqZxLM0J8A5LGDGkv/N+apJ0YVqPm4bCbFLs0SVvTWyX/Rcm3EfsnR0B5f0B3yp0yUHFDmPQCeJ
	CEkgy7cdmzc0tPbrJTapbUF5VMGEbx9t5ZhmkaneJzysPVMe5gh8ah2NP3s2S5EsfXOerad1Qy3
	tdVSFcZ9XE74JmeUE86IF9JBwQrGCW659D/LUrTsO/YAs1QW960Mt6+Tdar0L7S+9R1IbY9SLT2
	WLxoCBX+1kIx1nZxCFEMBl6sS9T9SP/7GiZgDJrgVEy5VEfX4WReGrCHavAMgxxQDTvHihddyEt
	LMUwCWRXjsSGwCnYB1sgJ78Q+y4kPH//79V5NiY0/7DHyJFROKXEkgt8QlJkgy3n6tjr/HhvCGt
	bm1WwQ7f6N2ioyZWBpFwS0Vkg=
X-Received: by 2002:a05:620a:454d:b0:8c6:a22b:e135 with SMTP id af79cd13be357-8c6a68e828amr459906385a.36.1768581252241;
        Fri, 16 Jan 2026 08:34:12 -0800 (PST)
X-Received: by 2002:a05:620a:454d:b0:8c6:a22b:e135 with SMTP id af79cd13be357-8c6a68e828amr459900185a.36.1768581251735;
        Fri, 16 Jan 2026 08:34:11 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf33e7fcsm905003e87.20.2026.01.16.08.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 08:34:11 -0800 (PST)
Date: Fri, 16 Jan 2026 18:34:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] clk: qcom: camcc-milos: Declare icc path dependency
 for CAMSS_TOP_GDSC
Message-ID: <cdtaituwzxzhv653ahzfmrcux6emgmrnpp43xzs45e6dsy3uls@vefliexuk6vk>
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
 <20260116-milos-camcc-icc-v1-4-400b7fcd156a@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-milos-camcc-icc-v1-4-400b7fcd156a@fairphone.com>
X-Proofpoint-ORIG-GUID: tE_Ye-VYHwfwW2OFVJA54oiWvaHOrW3b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEyMCBTYWx0ZWRfX3w1kT+MgMSxU
 Kh1Qu1hJQnZvI7JSJi7bnrE8GbvPt0aBw5nP3FWYriCqHJY8m7GkRanAzHV7ckXN7Qhn/FuB5g6
 SJklU4lwARLPaMVvvGR2BVUTQzi1wPQcXhDRiPOkorVGJsIh1BZACryCwEYfPSp7VXQebCOT6fD
 bMIdzqD7Ossn09STbN+xUyN5X/mTrOWfwFLB8N8m7EHNq0OfN0kd4h0l0IdESFMizPi/0d5v4KB
 uDOUphF6cuB1EjhFxRI0lZUknd3YBhX9oGjfUKubd8M8w3ATwTTVfjqwaPef5tPhThXqu9xIJ+0
 yCT2WJujw3EgN5x1V2hv3d8uDe2IUQEMCq6S0uPI8XuxJNtEi9jLviNXF6VVRGEQLrjIVUeajaU
 TOZXiuqx8uvn7TYaBUC9ljobfYYedhp5E0Bn/an5OOw0JCXVkWWwgg0/J2WLiZ0uupc0c2H65Aj
 /gbIJrzAd9WpIVGFmNQ==
X-Proofpoint-GUID: tE_Ye-VYHwfwW2OFVJA54oiWvaHOrW3b
X-Authority-Analysis: v=2.4 cv=NfDrFmD4 c=1 sm=1 tr=0 ts=696a6884 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=uEvfv33MuhQ9VhGiz4IA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160120

On Fri, Jan 16, 2026 at 02:17:23PM +0100, Luca Weiss wrote:
> This GDSC requires an interconnect path to be enabled, otherwise the
> GDSC will be stuck on 'off' and can't be enabled.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/clk/qcom/camcc-milos.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

