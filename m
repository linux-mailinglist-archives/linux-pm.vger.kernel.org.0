Return-Path: <linux-pm+bounces-40352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F06F2CFC9DC
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 09:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E8F33046425
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 08:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C78299A84;
	Wed,  7 Jan 2026 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IjIzlr1R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hqdFp7ny"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FEB2868B2
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774488; cv=none; b=byMcCM3Nm7+WpzHMorD6oVFi3kQjhuYZ0RxjJpp0YjD6Wa3q4rJoETs0ytmnmPT3bAZPTcmMJCS0aCrnvMNTQxJkiQZFG0kD+u5yktglg5tDG5BiUPLKIg4/ZkXr42g5WWOqLnP+ucByFpAaRrwDptBzGBT846hR8SEZsfuE/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774488; c=relaxed/simple;
	bh=YuO01J5cCWly3QRXJK2VwnsCcUL+EAOlhGOT+tPLkLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBjFhMCT8raxoeJNtbOlzFmNc2UEj0lgmxageyV2IbJscZiifkCTr9P5aRZxF1Cz6gtub3OILKgUn75ylserldIzDfzbYb2cbRpahpR2GzcAm8x/s1O8Uic+pGM0acHl92816JWpIuU9SrGUkgFLvpCSNGDenRd6Zwkt9PrHSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IjIzlr1R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hqdFp7ny; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607466MN4090701
	for <linux-pm@vger.kernel.org>; Wed, 7 Jan 2026 08:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k43xa4VOrmCN2BiW8MUJUfR8Y0vRZWMZ5hz8NjvOgRc=; b=IjIzlr1R3KKnDL48
	B4snHTjz6SONqjd29mx4uQZ3AvJlUhmn02XRlKxkp+RwDNmsJVBv9/es/IYnZcl0
	B94OoR6+JlMDnB3ABDSZCR4N4Sah3Eb0y5lyz0D04hjVx6VmV/XEubFket4cuE17
	CY46JeOZ1m5HwWTsCfA8dirRd5Xxf7Gq/kNq1YJU+8fVNDW+B4+K4iY/QryDH6/P
	edEe7CYGA4XR0peZ2whHfhBmUklhHzZK21BqVg4DccdxFDHnuMtjTwSbi1Fx2pnw
	hsUUL06lkeVTpphXAMXEio6Mhc54SPQhWZYGUGA17WP+P3TY/lSYNDCgRWQM40Gy
	VNqjKQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgyunbpkt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 08:28:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f1b39d7ed2so37915591cf.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 00:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767774484; x=1768379284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k43xa4VOrmCN2BiW8MUJUfR8Y0vRZWMZ5hz8NjvOgRc=;
        b=hqdFp7nyW05SypdofsnhU2PsD7DYelj7kJ96jlfB/Cw8GxNgRi0qtaky+Gfq8/8H6g
         Wk3dp+QuOU3qwbY4WDn8IzAIkUL7ex+vBNd+8dBcUS04hJYH1DaoY2nqx3wIb/XtF4oG
         sns64KwVwwqdlKNOBuP1BNGrKlzvM+cWIwJVabExT4QlpttjXDGcq2EtKRe39iM66awy
         VbCPrdgwuT+2qXulzXRsIJ8hukXnMb3iWEfr3V9q9Kj7gRnDoIStuUT7nOsB9KM9tYOB
         iF9IkmGySxdMeGIhFwA3yK5V4yqNINTP/xyz8O5V+KXydOd7WIdTX50bUXFVlsR3Dacb
         Mrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767774484; x=1768379284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k43xa4VOrmCN2BiW8MUJUfR8Y0vRZWMZ5hz8NjvOgRc=;
        b=cqc5wBc2YQ7I2agXJpoFmDv+1kA58Asx1cRx9cTJRq835cmMJox2omEE/AFYLN4oJ3
         H62jeIhr+LQlBc5KUpLXhdqLM2PCO4LDnBMH0YpY07J6sdOwp+76IfiautqIoMJ6t5+6
         98Us+JAapUfiDGCu+wg7BV/hty+AiHGAi6rQLh8tlw6q1fk2lUApvF08R3Jr4nOAtRSw
         dSPXCNYs0H3aURzrFIxHnBRI2TLZmHdnvkbvnHXC8UME+pgSL6nrLMpcO3vY2OI532af
         G1oIgq0xcN4FQtKwSl0vrw8euKgqKjmVQ5VUo6SYp5Is5Gi7w3a0PzKCA8eLG426sfHY
         WSTA==
X-Forwarded-Encrypted: i=1; AJvYcCVKAhQUjwtSqxycf22HjtSWw02gZCPV8bzr8TvmcpVAoC3IFB0eNSQLSHkBo0kFbMk6hzqZojyuFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9qELO6iSz2++7d+WXVFA1qDem05eM3fnOPBzzwxTQyUfJR8o/
	tOPJKB+DCn4GKcTa9OtwosWmHBojKnFD1FosQug+PDEAmN7ZAaPfWsFQperszjfjHE1Jg2WbAFU
	9jIsd5aHgp7ALhz9Nnjw2SimJIwbsrrgAAZb9io1U2NTF5rKAlrkVw5ZpH0IFJA==
X-Gm-Gg: AY/fxX6XpN8SHOXBJfuQSp9EaknIqVW2LsACMM29McVUcd7jpfFbelDI9UoOvuP+RaO
	zM4/8jUW6MskRi6bS2G/RofAfyr0AT1qJhXuhRU/1mVwuTm/Q7J+lhoQ8SCOVIDA+JCdh3ArR3V
	7eLGNzSfLCQP/flzZEro6OUpvjc2hTfsh0CDdiv1Wrb2kOCx4fJOlwmKkZOeHkiUV5bN3AJ9k9J
	WW60XMj5kLqlpetjOLNCD131tfuZPwxCVzDvvI/doSb8N++GRMTtS/2AgXcZeiWY4GZX9//Hxap
	br0FSjJmqFEYl3RpQBJCgYzXbqFMu7EwFIEuZr/AMVaEyQmo+ND931FKk0Ab9P3BfTQDo4/MK1V
	35qMFtJ4nCPzXE4aUciGfWU/KvOBTfGk8FXkj
X-Received: by 2002:a05:622a:1b9f:b0:4ff:a40d:d2b2 with SMTP id d75a77b69052e-4ffb48636f5mr24099521cf.16.1767774484660;
        Wed, 07 Jan 2026 00:28:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1MiIvYcTnGKSlwitEUnDPbVgoa6OjhOX+6gyCQTwvT+xhiYWDPGcJ1+Nnrt4tdoBe4eljtA==
X-Received: by 2002:a05:622a:1b9f:b0:4ff:a40d:d2b2 with SMTP id d75a77b69052e-4ffb48636f5mr24099151cf.16.1767774484256;
        Wed, 07 Jan 2026 00:28:04 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:b90b:ec1:e402:4249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865f84besm8276575e9.1.2026.01.07.00.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 00:28:03 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 00/14] power: sequencing: extend WCN driver to support WCN399x device
Date: Wed,  7 Jan 2026 09:28:00 +0100
Message-ID: <176777447710.14370.7888531422852179019.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA2NyBTYWx0ZWRfX/MizQxnqMXuj
 7ijOazUPml1xVtaVs1hTZ46RfNOa+dp8AcUXW7qSxIhLtf42peq9l3JYrBhlOPANHodHxbGKluR
 SVM3AKwcfk81fEQ+lZEcICWKXNBF99gzfgj1kaNPr2sbt9C08DmfkciIe9eUByv+XgDqqw6eHvC
 r1jxMUVru0a2B0MG4tk6+UNlCkI26UVQOyoU2pu6kaUMKBVHKwqKoQL/ReO51k1wcGkmjAm7UgJ
 EZVYpm3nV2q02EiETDWcVEA20RL+gv7X9hcDE5SPAykVC3vS1pHEoBkFT5ZK0OeJT3BEPwFpJCu
 LFFZ6ZWiX5X4ouJuAMppHwrqiNZz+L+JE47SVxyvmjdior6qTOzY42naBcDMuZOkox3l/D8QNDi
 SWTYCgPgDoQclM+SbtDW/xBZduRPaVjI+hFeqKhEWHuiJicbjJ4egK1pCEcX2OnBvjIYsM6j03E
 jAmYMKlfVpmiNFyhSng==
X-Authority-Analysis: v=2.4 cv=YqIChoYX c=1 sm=1 tr=0 ts=695e1915 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=f4exIScRoNMJIANslhQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: g-utbY13M2aH1WRz0hF__11xm7JcoSZ7
X-Proofpoint-ORIG-GUID: g-utbY13M2aH1WRz0hF__11xm7JcoSZ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070067


On Tue, 06 Jan 2026 03:01:10 +0200, Dmitry Baryshkov wrote:
> Qualcomm WCN3950, WCN3988 and WCN399x families of WiFi/BT chips preceed
> the later WCN / QCA devices, but they still incorporate a very simple
> PMU on die. It controls internal on-chip power networks, but, most
> importantly, it also requires a certain start-up procedure (first bring
> up VDD_IO, then bring up other voltages). In order to further unify code
> supporting different families of QCA / WCN chips and in order to
> maintain the required power up sequence, properly represent these chips
> in DTs and modify drivers to use power sequencing for these chips.
> 
> [...]

Applied, thanks!

[01/14] regulator: dt-bindings: qcom,wcn3990-pmu: describe PMUs on WCN39xx
        commit: a5fae429ec2ac72372bc874a0334a7fb9eadee83
[05/14] power: sequencing: qcom-wcn: add support for WCN39xx
        commit: 0eb85f468ef515fbd2538375ef3884f6dd376382

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

