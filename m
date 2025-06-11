Return-Path: <linux-pm+bounces-28477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60137AD538B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 13:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB697ADCB3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65D7267B71;
	Wed, 11 Jun 2025 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q28xpXfR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FAF239E72
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640572; cv=none; b=dzyaN7UcZsVv6vUmSYcdf55gxnFpRCe3wphlKuj9yyyaAIAaIzDjEMe/rFNa/GJ2gxzVXdneL6QYdo34G8gYrCfGFHIEj/Q/nxp2DrQ8jz4PhtB48DO2boW+Ny7mvLcFFcDKK5Bn/KTJxwdEAsAGNcXDuxy7YQ1JzuSvgWgN6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640572; c=relaxed/simple;
	bh=nMF9K7Auph9cWiGh0kXvvupbMizZQhoAr4irrlKWwzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qq4BAoPMoHI+6QKKhsmH669ITYKqFhUpxnDsXnGp/l/RgNJiL8G2rugItrJnGflcF8/b3zlsjxZp2gB/l3p4kzrZdrLHiTxy8eZmac/LZeDxX+gj7Me5fW6SnEbLqJm2+nkdCOx/2bxlJZs7at+gdQVm0F7O+/qkhyslYNk3FWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q28xpXfR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DEF3009032
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 11:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kptoO2Aza1llV+rVNxYt5GCzthVJqYhfomZaXMsN2c8=; b=Q28xpXfRIXoriJML
	Pq8K026dk+buY4vrjTM7ND/qPGRZkUVeQUMmmN8KUd7+V1NWxuBzgALPEDv+Qj0c
	mHDvxjax79lLC7M4JMXkpMJT5+GkCT1DA0JNV5wHbhwbVfP4km5SCnr9JDYjLC2A
	vAXtuVnUczmrWgP5k6P04mpxaR9TeCpTMxfaDdbDA2gnCtJ2p1Vq3Wae2QKJwEOt
	XSva5CT4tHh7X6CWxENiqepWGq3qDbpDw8yVYroLxeyoS3LefwlbbMVcMbGRGdDQ
	90nYCx2olBY4aOrQuyv9q4+Lw7E60wmPgYCEUQ3E6PGo0dDtKOBBadp4cR0iJTRh
	tKd7DQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47753brphs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 11:16:10 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74620e98ec8so791851b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 04:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749640569; x=1750245369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kptoO2Aza1llV+rVNxYt5GCzthVJqYhfomZaXMsN2c8=;
        b=HuwNAf8mqiA2VMgwvqzHlWN1Gyg2ToOnW+RyCEFeRVEcJVkzwepzJHmyoGYxFlUsnW
         6a8JWi7MFbl0rLseB3HedF7kvVC7+ViQkNBIDUBuJ0I+Nvv5TvlrEyLtPdOlFoPv6ekT
         XxBAQrMHyyzxAD2UMR4ummg6p4TOmanBFYu/PUNHyuC4II96Yx1q9J9LnQRVa5RSVeF1
         YE8rWLgmSJKST2Jpl7I0b2lyE+nrPqdN558xptqfo3bONR5aOSm73HGfNWSLaMtziJbA
         W4ysy8c4RpL3Wa/Uqk5trygZMj7aX+SNK11uwnFF/Iq52oAR7pMKL8rOOxfSy8D4ByK0
         7hng==
X-Forwarded-Encrypted: i=1; AJvYcCWi1gVHRurMNOiJTuonhC95xfKzKPar5sB4DSomOSFeUJWuV6SAIBKAM2Db5kDOlCa52FUykgOvag==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNWCbkPhKrR6ZtJ/DTBgVY2JpWJVB4zh3Q6uuzDEXntotf6YRb
	fRn+s3HJEgLaFpj/l4T2Hxk167tHOgPPCl52Fap1vJz81Yq7/7mtBUXnsil6IiPdvkS5haysyBL
	vekJr8PWwmjV4k6EvnKUw3rboK8KNiCb2/EQgrijtE7jhVf8bnrhnje/qUy2P/g==
X-Gm-Gg: ASbGncvqEl89sCL71XMKF5w5RBUEgEBisLTT+qRDoZukF/77eO8n3eWxm9Q4FI9UYoU
	QLHRTZ39Ia7NKFanrefeZ0LA8jaqg7JkjZ1LB4/dG+k2yty0symdMG3zkKA3hhMSQHWbO4/UnNu
	PjzsBMFtf4oeLeN3GOmS2Pf0ipcVYpCqYJWUoC5VhVArTany33mFEvzVbyJ41fF1ApPG+PtXWbO
	S3sWalNFSiwJf69HmRe+53yNfk1q/t7r/sNqWdeiFYw3HJzyA/7BFM5ko3q8yeiULqFuhbNz4XM
	W5MKWNbnAVp4W5a9gcgeenrf9guIiaw5
X-Received: by 2002:a05:6a00:4642:b0:73b:ac3d:9d6b with SMTP id d2e1a72fcca58-7486d2bfd99mr4480460b3a.4.1749640568961;
        Wed, 11 Jun 2025 04:16:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQv2oR9AKeWi6BvBwm3nl0UvCjpE79XpYL9hXCh5jA1F6NZ0xrqYz3otpm2s5qxPpHx5fcxA==
X-Received: by 2002:a05:6a00:4642:b0:73b:ac3d:9d6b with SMTP id d2e1a72fcca58-7486d2bfd99mr4480395b3a.4.1749640568511;
        Wed, 11 Jun 2025 04:16:08 -0700 (PDT)
Received: from [10.213.111.143] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0e9d57sm8820772b3a.160.2025.06.11.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 04:16:08 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 16:45:32 +0530
Subject: [PATCH v2 2/4] arm64: defconfig: Enable X1P42100_GPUCC driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-x1p-adreno-v2-2-5074907bebbd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749640547; l=821;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=nMF9K7Auph9cWiGh0kXvvupbMizZQhoAr4irrlKWwzA=;
 b=agOSO7dfGn8dIa7XVbLlt4oDG1hgwGxcPdJ+VerIynmrzAOr5Zglz547UxQuM47URqq26uh55
 1s+Uje4N5aqC8m4jFOukj8M61J+FVNVu7dbTpIXOsh6xEwxxDjWEE5g
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA5NiBTYWx0ZWRfX9wkd9RTiaG37
 nradO7LNqhNO4K4l+1LgJZMfz6OhgpsPNWuJiwXdxQrzS5HuOyo7HIr40w33vtztZCw7xXRPs0X
 aGPw2zD9HD4O5oPcq4tXmjhIT76GCC1xFRPZljqUKiXCtAkJPjJ2jMz6kXL7m27Ykv8y7XRxhfp
 5O7JuxDtiQTU/lFk0Iv9IB7YMfLBDyruEa6BBoNbsvbbUa65cWWuZRyyrb2pvn4klBu90tE6MrL
 5UGZuV9cPZk1EKlHiKXHQyqwsv8YIbyi7mYfPUayJ6FZFQrW6zMzxr7K697KyC3VFsOb6JvMPS7
 orxFQUHIiNz3eZsxcPqDYkuadX+FSM3uucHDAZy8xl6fDKFAqHKV1zCKt1oDEiUXbrO4Sng36ls
 kbo+BPDMAWrOG5M2cUsG+h4QVEXEl+VF/Mn7r/TrEuIIRgQejP/rn7Mp2XMXj0PDYMBJeT3Z
X-Proofpoint-GUID: RbnlHiqKqzyAxkpb28NkmLovO1RcKJMO
X-Proofpoint-ORIG-GUID: RbnlHiqKqzyAxkpb28NkmLovO1RcKJMO
X-Authority-Analysis: v=2.4 cv=SqOQ6OO0 c=1 sm=1 tr=0 ts=6849657a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=-EtVc9J5eg0rhuNXUfoA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=709 bulkscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110096

In order to enable GPU support in Snapdragon X1P42100
(8 CPU core version found on Asus Zenbook A14 and other
similar laptops), enable X1P42100 GPUCC driver as a module.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 62d3c87858e1817bac291780dff3823dacd72510..9cc473fd0d3308f7869d00425e17b114c87093b2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1350,6 +1350,7 @@ CONFIG_CLK_X1E80100_CAMCC=m
 CONFIG_CLK_X1E80100_DISPCC=m
 CONFIG_CLK_X1E80100_GCC=y
 CONFIG_CLK_X1E80100_GPUCC=m
+CONFIG_CLK_X1P42100_GPUCC=m
 CONFIG_CLK_X1E80100_TCSRCC=y
 CONFIG_CLK_QCM2290_GPUCC=m
 CONFIG_QCOM_A53PLL=y

-- 
2.48.1


