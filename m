Return-Path: <linux-pm+bounces-28476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CB2AD5389
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 13:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D551701FD
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7E625BF1A;
	Wed, 11 Jun 2025 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C0RsGiU/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BC725BEF9
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640565; cv=none; b=DyMljSiGjq2WE9MVfn4fMuphHmSJ+Gz1vUpZUl/q9KZH10j4SFDyfvfng6hVrdrV/eM/MxIYfKAv72uWMQYShSe0wXpjq2uxS+bgwgDaOq6ecghxyUBfrzBOJG7nEUlEJlDDlwnCWT0uuFqXowtbHbXu16yusjmnsKHcfACcvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640565; c=relaxed/simple;
	bh=lHxIg8z3r4MYFlwLi2deHZy4r/sg9/34BnWytVOD0js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=chZcw80QtW1nkF3EZPzQrG/tn8gxeerwcW7MIrmNmRx/UtAt0qn5YpZ7qkHvhgzhURr9pv4DjxDEbuLit04fc0Y7flI6HUjYUG6vFSFmEreSGPbQsBYi0HcPCtg7boZjNclpvcWzi6F9ZOa2wqXxI9tANsGxblh9RPXaWoxtCsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C0RsGiU/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DEi4009059
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 11:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oaAMiIVJgXHtfHES7X7LLIIzOL/6mPXxYGS9Xfa5ANk=; b=C0RsGiU/UHg7iW0p
	svVWXkU0RudSs9AO5l1NmCI7crNwyH2hWulQoF5yVRPLU6Mk/cf1sutTnEBNBlfN
	8vp0rUukMbBibpHBnVWJof2ELlPAWbMYV7Gzl1Xw+aHQMu3A3KW08zVCrj19JWtH
	PcVLqZqq29NMMKHEoStPP27WhjyvClIOI59gF0su8zTychqWCIgDWW/fAFV+F1Yn
	8bmjzOGSzucXTq9bwnNNldkyRkuqeSt/9DxSarOUaYi/lhZkfRjr9ngVPuLyyTwx
	30fXizmPwOi11Ue4ZnJOe+08ZYVVTDYvlJIIab9Ty9+ULKPC1Y19hwOGoLM2JoAA
	E8WQoQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47753brphd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 11:16:03 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-742cf6f6a10so9076715b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 04:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749640562; x=1750245362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaAMiIVJgXHtfHES7X7LLIIzOL/6mPXxYGS9Xfa5ANk=;
        b=UtgGs+jT8/cMTapNo/fLzAonMeTSsJ68ImDsatu0W5q+nTwzlj1gRTfIbc2mCCJj4Z
         Iva4tLD/pQbpb4wI9kHnXuGOP/4vZae9mbjcLgHEDZh/4+5SN1upIRdtx9xRxkmTUbMR
         AgcNFUhqyXOpef/TX0UZcZBkB7+t2YHDlIrp4SZiRXTogH01emG5awODg5ZVV/TGdOOg
         wbbM45NKlxygbLH3bvZPVOQpKXnAWtLhASEZsizCVZqZcwyMRUdfDJfII+tSk9EmRIM+
         38QixM7D1IgGMP3GPUC+kv7+Fk4QRkI8GN3G+0RpDSOCGhO1xEtvIMd8wXgOg0F5x62g
         KOmg==
X-Forwarded-Encrypted: i=1; AJvYcCWxzG+eohi3g0SI2tI2yTe//vnHnnedZZkZpbYv/Xkck22j5xPq1gsrPprH1sboPkR+MHzJkZD2Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3wbUWvDZFfz2CFLaZgv9yfF6V7pOy0rNKlUia7D73J2k859z
	oGp//pM1Gbz6yk3OHgodA3qz1clbRFZSvQKvG9ZkRzO3FcYqdcM5gm6uxOXydw0iaJxvP0VNiUV
	iUS3SS56c/OYAz/Ui4+smOmixWZnchXIDwbueSxaKEhZfIJWNZo9lUZ0aFEHP6g==
X-Gm-Gg: ASbGncsDdXo+pe+HRASAcs6i3/5d235bTxOIBaLhn9PkA4gKcQyHqS+CVM03K/35BH7
	7Tqm5gJ3z747XKewJNblAoBaw/JNm5zwrgwuSv5ak1DRjhWlx36w0zfejHylZKgwpVFO7X3AFps
	1go5wXRzyQuYaKai9dYBV9rlnrojHAMeMctfRFFToi5j1khODZQQeRZIgK3jNefiNXn65HOIpmT
	VLOrEcEhfqIxcO2TMmTbwQANPrSOtpXsF0SN0/sW/mOAeW57nhq8mAWMjTBuGlxc+CF/I/0Z8o+
	Zx1v/sCGnwuQGzjojOcvVucHzQn2cXs3
X-Received: by 2002:a05:6a00:84f:b0:747:cd01:9f75 with SMTP id d2e1a72fcca58-7486cba09a7mr3858950b3a.10.1749640561959;
        Wed, 11 Jun 2025 04:16:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHROg37CoLQX/gpU9C5YtRVK3WyqImgZyCmQYBDNqko/4jqswI6HbSmNXgi+XM35/6CERVSVQ==
X-Received: by 2002:a05:6a00:84f:b0:747:cd01:9f75 with SMTP id d2e1a72fcca58-7486cba09a7mr3858922b3a.10.1749640561603;
        Wed, 11 Jun 2025 04:16:01 -0700 (PDT)
Received: from [10.213.111.143] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0e9d57sm8820772b3a.160.2025.06.11.04.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 04:16:01 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 16:45:31 +0530
Subject: [PATCH v2 1/4] dt-bindings: opp: adreno: Update regex of OPP entry
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-x1p-adreno-v2-1-5074907bebbd@oss.qualcomm.com>
References: <20250611-x1p-adreno-v2-0-5074907bebbd@oss.qualcomm.com>
In-Reply-To: <20250611-x1p-adreno-v2-0-5074907bebbd@oss.qualcomm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749640547; l=826;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=lHxIg8z3r4MYFlwLi2deHZy4r/sg9/34BnWytVOD0js=;
 b=ICq0mXqikfLYi6zoSoY7dUbF11OEkSXzvry9bOOUpbQi4bPFyVr+Va+GQM0kxxwrsM2sVUL3o
 J5HOSoxdbY9CddPxQ42d6Jw8+7mjv5B7uHLuEWJY1k8LDyEMdilimZ4
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA5NiBTYWx0ZWRfX5qjZjMppASeG
 zh0C3cF092PeOeJ563xSB5s/rW6D8i0Y/kGx8JqJcr25y9p0bWSSXJcWnMfDOtYkgDVH87yANdt
 l7qgH8ejsFr9fHA7weEkY2cGgwUc2xNGt//+EMU8s0Lu0BsEjJZJ0WteXVE/Jxkmv2joVDG+dmp
 fQEWWTK6PyXBpTCC1VDbiX6Q2jcvx/VR55lRL8IbRYGPWncIxOPAlyMeZlWEbONW7JhjeP/t/kx
 4tVpjWdvTLQdnp9Ivz/v+2kg1w5R83G0jCIQSUODiNxVp5BQ9knwmn510b4eKzgVa6JL5en2Gzj
 AW1z4pRwixzWrZ94zcJJEaoArlA/wQzUV7+RT9fhkyzlGHAL5CKjVy4bPoa+FAanTjE47RQXTqL
 ejmLd6OmflFbOUnoMYJ5HifEcv4B6Pm3n8rxzI5rY1YAiXCl+ppIH+G1RQO7GdeKdf0VvoAo
X-Proofpoint-GUID: _Ig7o8ZCLXpeS1hlRnfkgog51Pc2rstf
X-Proofpoint-ORIG-GUID: _Ig7o8ZCLXpeS1hlRnfkgog51Pc2rstf
X-Authority-Analysis: v=2.4 cv=SqOQ6OO0 c=1 sm=1 tr=0 ts=68496573 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=j--r9fh2p167zETY0CYA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=948 bulkscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110096

Update regex to allow multi-worded OPP entry names.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
index a27ba7b663d456f964628a91a661b51a684de1be..bba95799919eb52d12afa42354ed909d0ef3c627 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
@@ -23,7 +23,7 @@ properties:
       const: operating-points-v2-adreno
 
 patternProperties:
-  '^opp-[0-9]+$':
+  '^opp(-?[0-9]+)*$':
     type: object
     additionalProperties: false
 

-- 
2.48.1


