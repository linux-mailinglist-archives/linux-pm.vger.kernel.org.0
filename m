Return-Path: <linux-pm+bounces-28874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC6DADC5BD
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 11:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE943B7782
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 09:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB0293C79;
	Tue, 17 Jun 2025 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFsRawMu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBBE293C71
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151239; cv=none; b=jr3Y9ikO0yvUkwvZ08zAcxqOP1VPa42M9Pxg1zh3F79TQEmWGk+X5NlLLz1vYkU+MwSR4Qjapa5GkGlBKa5t/QW3+KbsVdi0pRm2zeHguTo2PokcJIcQfwBtAu2b/KXmfI6Ny4ZjxLetELzxCY25wMDj56L87KrdaNuEcXdPh2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151239; c=relaxed/simple;
	bh=I+wt0YP4rxgHnKOC40/aM4YftA0E1MwAjBk+q7eSAFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D32a9PxNVlxih/mtwneoug912WHsr7WoBNiMHpBUBZIquSas0gIzcoqy81QOV7L6ffzivj7jEzIjo+/XxFKCPy23XtQs59vNTvlRVkKCZVNx4ujGSuR40kOhHMhBiM2FoAY757hg9qqUgAWlWNEZbQyURCeZZvI/1FgjvQ/wdwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IFsRawMu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H6HihI003184
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 09:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pC+/Jc/xnvj
	uhS/vhXW0LK87Vtyf3CLSWvcyQpqNldk=; b=IFsRawMu58dMwT/uAZjGcZnfzqg
	hq3bfIUs6UWgVcW4biNKvPCtTskkifaV+0iJ8zK9JzDZ24v2JL2fkUrT3d+qt2+4
	u1GrsWbn7InCpjsrH0iWiorIAspSJkyYZK0aTPPBGa9cdzTI/M9Qvsvo1lF14LOZ
	iwxkNozNhTC8LqTh3Mo6Zv3QdfN3lFsP4y1TImIYK47oaViVCjznvMw+Z7cYeMDG
	IxShuK7wvCNaq3elMPDKeDwWiYiE7BGBRC8YUZThQKct5agzkgkYX7Y4TD6DV5nC
	LT8e6Sg18OKTrWduYCEspVeELNenTdhn6qur0l+p5I3GUHGu0EMgSNWhjwQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ag233ryn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 09:07:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-311e98ee3fcso5554643a91.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 02:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750151236; x=1750756036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pC+/Jc/xnvjuhS/vhXW0LK87Vtyf3CLSWvcyQpqNldk=;
        b=SgrjKrqrb4aTBdPGgAI+UAlWzCVZymfv37VexoZHhvDrOC8etlDZQYYjcXXabL9RUX
         UF4bgVGskdsCJxbkvgAaym77N2J72vNf5BTUkHbToVUkuHlPS4KM/e96A7HlmY96GrLt
         tB2tsrwjNTFA+r2oLIuPTbVPrXV8QBCIyHE8MCLurWQ4IdDP55/pAJip8t02tIqPRCMt
         03SjSnqCJDcN5bTuJCtB6Y/5V1JSYwZsdHgVI8qukzLEB/Oj+KX6iagcwzZ0p/M0vkem
         PldhBllcwcYJA4wB3iR70n4mSDbmVm5zBheaaZMjnLeQjh/7TnaYYVNYCr1Nx8rOXYYq
         AaLw==
X-Forwarded-Encrypted: i=1; AJvYcCXxsiTZ3BFfslcwIoRwZrdx9qaypHh/QpzU8gBezcLyeszRM4VVKgmc09IA6zm7m9U/UhWecCCU8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+M67ljJh/qWfBzr5W4T+j4IwPZu5PXcRAP7DVOTSELmLjTDnK
	BSrV01yOXh4bo+ZdqOSrCtKm+pdd4DCLBOg+9VCgS5qaoEQWKIz5MsYyRC5AYP7DVXHUBFUOwpv
	wTazlik3HNOG+ezwNwXJE3MxbmmHT6MwrHv3dgdXPduieLpV2Zavdj5NGGMOxug==
X-Gm-Gg: ASbGnctI6vsINt0UHdbj3t1b3rU1u9O3VVKYXZaVvXpvNefuqPEoucoKv3/IOyx9SuN
	U6dGa8BP1qZTSJu1ewnpeTxEWhRrtBpkQ1K1IdkeDpr3Gxi5ZHXymILrcBSDZ4q6kOrrdzTCPxR
	zgK/2I4W2MJXvyX4D7ifgjmugm5l0VpOgENlHP9a0LNpeYWJfgqjSYRRfO1rSVQ8E25mfp22KF6
	kakMuv11HIcy5bHy2194v83QUqUs/xI8FZtmJ78ZcyINOTf+MtQg1L6YscByo9DjLNQol2C1uHD
	iZYoK31zXRnxURmB0CLifi+LcrmdEu5h4sDCujrb9ar5D8PFBXzaGYZAVOQmcg==
X-Received: by 2002:a17:90a:e7c6:b0:311:a5ab:3d47 with SMTP id 98e67ed59e1d1-313f1be18c8mr19885661a91.1.1750151235688;
        Tue, 17 Jun 2025 02:07:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYtJl9iERnvAsYVcp7IsNfFfm03vWEkJgaCuPvHhgljsPO4XBA+fuCm40CFdv2tSyTdm0tsw==
X-Received: by 2002:a17:90a:e7c6:b0:311:a5ab:3d47 with SMTP id 98e67ed59e1d1-313f1be18c8mr19885615a91.1.1750151235176;
        Tue, 17 Jun 2025 02:07:15 -0700 (PDT)
Received: from cb9a88ed5d41.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1bdb39bsm10017370a91.20.2025.06.17.02.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:07:14 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Mike Tiption <mdtipton@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] interconnect: qcom: Add EPSS L3 support on QCS8300 SoC
Date: Tue, 17 Jun 2025 09:06:50 +0000
Message-ID: <20250617090651.55-3-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617090651.55-1-raviteja.laggyshetty@oss.qualcomm.com>
References: <20250617090651.55-1-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3dCfgcphhrXHMvUch9LnYgZAD5BgMyi4
X-Authority-Analysis: v=2.4 cv=edY9f6EH c=1 sm=1 tr=0 ts=68513045 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=jqyGqifOumdqABPgMEcA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA3MyBTYWx0ZWRfXzGEkSmsYDjzl
 MJtui2Z5UlJJgsYjBdP4lajKd8fzakWczWfxA1E/9NfQ6sxYgObYUGGGxmq0QbBeq5DqWLchVIs
 HvwEkTuN8CXLsxTOmdHtI2sIidas8BsOHoyKlYlw8ZiNoB1J3KkHAflhhkRDfGYRXfoTaE9aVn4
 3SHEjcvUdRmL3RS23W8Ns72AFYTPT3YBKzr3kHbNYehGoFePMHXsiWOpkyVYMLoxmNbxYgHh2qf
 Dt1M3QkOeiWC1wLbEWwKI1t2JSKqEkx2voUgrLTckx8hg7oceG2rgCJXvasHE2Prw2LQlvqxTG7
 qj0vQ5eQKIeEUsayPyvluI7OjFVtB8s6a1rCfxrTVZW8ba/xu37FkGMLMvA13xXcJRnc+FcqQZq
 vYmWKgzwOqtMz0TO1Wn9RVasu3xpy+nq3pVjdmvw1kHrPJXPSdsRlpJGOjPrkLcSy7KkJrrS
X-Proofpoint-GUID: 3dCfgcphhrXHMvUch9LnYgZAD5BgMyi4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170073

Add Epoch Subsystem (EPSS) L3 interconnect provider support on
QCS8300 SoC.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 drivers/interconnect/qcom/osm-l3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index baecbf2533f7..d8f1e0a4617b 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -270,6 +270,7 @@ static const struct of_device_id osm_l3_of_match[] = {
 	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3_perf_state },
+	{ .compatible = "qcom,qcs8300-epss-l3", .data = &epss_l3_perf_state },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, osm_l3_of_match);
-- 
2.43.0


