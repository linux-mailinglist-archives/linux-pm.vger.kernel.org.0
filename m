Return-Path: <linux-pm+bounces-40351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61657CFC98E
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 09:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63817300AB1C
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B27A285C9F;
	Wed,  7 Jan 2026 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kCD1TXpe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U1o8eF1K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B35276049
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774486; cv=none; b=jNQUdkWI21sQlckJJtnGQpRuzWylkx0Gdn2geY6kuomAG3KD8XiyTEi4nDTinxELqOmF0EoQD0NtJ2s0YExVJ3VjSWe0s1logJs1uhgKpbuS29L0nZ/z0i/4iWSeynhtQ6+QMBbEXAHuYN8TbSFJLAYMkmQ7qm/RRbDiIWDiaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774486; c=relaxed/simple;
	bh=5EQAhD0R1x9zp5Xf8bGMcf3odb9gCgMKccpVh1R6FEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdS3SHzAWFeq+wxEhbc2/sQ+2es9Q4sHdNMwv0XT9r1oPqHImXINJC7O4ME6C6aw2PoRJH8xxQWKGeIvNRk1716IbMiENpEEsamU/lqW4w4k7Vc+XNMGJ0TGmmkSeWdTD4EVX1DzV0zIOmyd3Z7/E5j/xVwWiTuOczqWU+/2YNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kCD1TXpe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U1o8eF1K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60736D31364729
	for <linux-pm@vger.kernel.org>; Wed, 7 Jan 2026 08:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oSHUyuOv/8c9FHMSjhs9APZdrHA58O25brmXAIAaU3M=; b=kCD1TXpejvSlDaBa
	uif6+s44iIGBYjP+6LBKoSIzYeZC0NumMxw/5nJFoqMt2NqrIkj4S8KmZ8SNykOd
	4XjoTDgESnlJ7tWCJYq65bJBMVxLJCGUC0m+Bf/zMPvUDFiinjJBtj6AEMKQfin2
	HxI+Ac049L4Bj0zKcj42hyC8fxsOOq2i6164nAXxsmUh2Tl46zKo7kxhms2bknfi
	IDceXoOKkDp7dZEoGL8YOuk+Puj7CqFZFJz3eEXk8HsEV6XgyLIraPwslrQSFYtp
	cxdMp4b5eWJ5qHpvcObARvwmxlM9YXXWhOkocP0TAafWDqdME+zsniXvU4EwJl3M
	y4r1dg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh660tgb0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 08:28:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f1d7ac8339so77456511cf.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 00:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767774483; x=1768379283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSHUyuOv/8c9FHMSjhs9APZdrHA58O25brmXAIAaU3M=;
        b=U1o8eF1KFliNjZvMgUY5f7GclRx7WE11rWjqbvw6NYs7GTNcGnCmaKgekxtUiraChj
         iaw23ByMCGobBsc6MMjW5gxr7s5TByIT3+CaKqEgv+p2RSapEwEruwiwEd9A7Kk1nwHO
         53yratTnspu/a99pRV/YZXwwbIpluTc7FAdfLiIpDwZL+8JXBr6GO/HcSqVKM/EchGfs
         u/AtfffoT9EKBZJkejB1wwFhG0UZxvdrwAyFm/emsNmsxMNlu29xvGLgAV6PPKTWFNGu
         xXjVoGyXKNILvUseM8+D8cJ0AsLbIqcwgNuv/YSFpalZ9p/AUfuE0tZs/5t6tUs/XCXO
         3JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767774483; x=1768379283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oSHUyuOv/8c9FHMSjhs9APZdrHA58O25brmXAIAaU3M=;
        b=Gs0A7epN69GkxvbEXXacK3OMJFCqaVG9eKMSnlP4R94M6rYTPYQtmc+XVp6xw3G6TG
         BXD5td4CPN6CEOVEG9EKxVTqB1mw8G531vqmUaiNkMZ18T5UaDZzkDQBXe4PsZBFuUlC
         7owvDipiDgizslcOqak/2OfpVm/sDBLbgL2ylJskvKpgzTlnVA/rl6sVzHmgem+42uGA
         w/RHGMQPGMfr+D8i4IQ4u3odmKIFe/S0tWYm/t+RoCVmfVdRebiDrj1viIeHyk7B0E9s
         ghDgoBDToGAnt6PE9AuFVsjv+VJYcX4DAYqJQwcnO+eXfYPP9cddj2MU4PIRK5EDb3Wa
         sG1w==
X-Gm-Message-State: AOJu0YzMS4t2HEy/UYqhNf3K2rH8pQNt4Jcc2auIIjoGbyipBzT5rNhi
	z50uSvYTNAHFJIyIIvePVVKo9YcqTwd+2glBxh+eqEnqUtMVv3Hc9/hCTUltNF46/nIkMhdvWf2
	ufO4ZOenFgOXRRg+0UEVDLBS1bC4stcvRBEh2pKdC2eXcdpSRVO/KflSA0ipnKsMYxUHwWA==
X-Gm-Gg: AY/fxX6xUcCxcOMFw008uAiB1jrCqKfw7y7urB9flAHgbfHDOYEO7LvWRdEJYarSedC
	hf5f50ga7Af/32n9hK3IrvpFnJpsLG6cU0N1nuLpq+boIBqlu+HWLe1Ao9qohNRa/rKBSAXkpnp
	zMkI+OG9mA00wJmGTmn1HNyQHsQsb1yfowFLbZtENwgQPioAM2TzdKMJFqXBlU9kRMw7h35M7eR
	1aGEAeti30uQPRPIP58FD7F6/tQ8E/kd7hW5mS3+CgIaQw/rM4ySEeCugve5AzBoxlWHL7sA+iv
	Zdfg/pDw9E83To2LgDagrKLCfJYIcb0C/RQ/ccx37or6iNvRs7IFESZfzWasnIUUmmNNGvSxHmU
	+mFPgFUKiubO+GrvRVnby4uIu2YKO1Sj6EtF3
X-Received: by 2002:a05:622a:4896:b0:4ee:210d:32c9 with SMTP id d75a77b69052e-4ffb4a581cfmr20181161cf.68.1767774482946;
        Wed, 07 Jan 2026 00:28:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL2gYqYDgQg/l2LlNGo6nH0aiPJzQBXUPKM56V0zjDGkoO75+fJkL2HR8j1rOQFzdRZuOuQQ==
X-Received: by 2002:a05:622a:4896:b0:4ee:210d:32c9 with SMTP id d75a77b69052e-4ffb4a581cfmr20180981cf.68.1767774482578;
        Wed, 07 Jan 2026 00:28:02 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:b90b:ec1:e402:4249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865f84besm8276575e9.1.2026.01.07.00.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 00:28:02 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] power: sequencing: qcom-wcn: use device_get_match_data()
Date: Wed,  7 Jan 2026 09:27:59 +0100
Message-ID: <176777447699.14370.12849866331696485197.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251125134700.29135-1-brgl@bgdev.pl>
References: <20251125134700.29135-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MNptWcZl c=1 sm=1 tr=0 ts=695e1913 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=wIHoBH7yr-rKGB28I1MA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: EOfcBoyl1vw7FhNWTbXsubqAyINTZV6F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA2NyBTYWx0ZWRfXzOviJdXMhEYt
 UURLQ1YbQptRsOY0H4LU/S7m+ZCtzfJyeBSIcK8DOHR9GURsiWw3A1+XItLobMT3CCOrM9PrNNt
 9Otb+e2FK34ojK+hiTl5OaGutQfoRzW8P+2OONFKigTSD4kHwYk8x5ZAivuBFbD58aQQLTjCmlE
 r9QVR0nBM4NTEIPfLoSaOhj+YOyVoOrAT2HE8noCpE3SXISExbWFP5waAZ7tRFEITbOdLRtKQVS
 AFBP4LGqQrQNuCJAj8pvCxR042fkOXm4ZFB5hJ03GaFfO2fUWLHTWcl50J/UwJbi9lm4JNIpwFK
 6+YJv2l2hlNYy2G06fYU3wc5EahX4RLqFAEj5GO80PmP2eCvxmzweMFRMetXiczwB0VT6Fw8KhP
 13X3SEKizpqCZ68Qnzyxz2xJIEP1HTjkZaHf9I9CsaFiJwMkPiG6pQt9Eqyfn/JCu/KszmsfeA7
 LC7d4odIfpKncCpzQ0Q==
X-Proofpoint-GUID: EOfcBoyl1vw7FhNWTbXsubqAyINTZV6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070067


On Tue, 25 Nov 2025 14:47:00 +0100, Bartosz Golaszewski wrote:
> Use the generic fwnode interface for retrieving device match data
> instead of the OF-specific one.
> 
> 

Applied, thanks!

[1/1] power: sequencing: qcom-wcn: use device_get_match_data()
      commit: b1857911d845136cdf627501070dd1b2dc7d0bbe

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

