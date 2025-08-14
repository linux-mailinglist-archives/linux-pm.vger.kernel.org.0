Return-Path: <linux-pm+bounces-32407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44529B26A6B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 17:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7DEA04D93
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30277215766;
	Thu, 14 Aug 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DpLLQwSC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D3D21256D
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183282; cv=none; b=MHfEDr1EQ0m8p2XV9J4Lwz0k+A8bAazg0DJg33WDspryD58XYeR3Q+29FA/tanq24bPwd13HNwaUH0f62mW/8pSZlBbznyRXS8hfCu1t+CcQBX6Ef17JNo9XUQCrcPN8gIHU2Rl3jwkcYuPijVKpUUjTezjMq2b4cBhBlE83c9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183282; c=relaxed/simple;
	bh=7Ao2rWjQ/ojqXztz4wSXnsU3LKOpkyHAtipVC883xJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9gbfTDmrAiy4CG54uk0vEw9xRWx/V3tQBVLISVcWERzlI1YWTsT6s7U1YGSE3sB0QMMYccg9oHkdjMGjdi2L2oHWFPUZ5dgy4E9i9giOMZwuErimsYRVM1kfnh62OLHnYBy4N/AwRo7lraGbXbQI5z5mNl6TVGBO3g09+3FRko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DpLLQwSC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8xFS9020600
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 14:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tglaKq5MwHPkzJhC/F7WN2IWUMXxho8xACm5J/TZbM0=; b=DpLLQwSCX9cBMEKl
	FWx3GxQQmpTJ6U7GnqyCSmtWxr+KYEDZilKjeIWCCAOLStZxJi+Q/AxZCcjmkalw
	tEjT5tHZh2YzBSCzbKwBiMe5Ii8LT23XztdUzvyiTHPCva+wEj8XyOZHLuWacR4v
	OrLY0q0FQX+dNOZ+OaC2AYxniKOUhqp2WR0HRtLVcAK4PFn8cWMVh3B/YO7Nn1bA
	/xkPpDlhpY/0nt04RsuNT7Yd6awn8eTxL4moR/t7A9xQnJZHE3wKEVS/QNubNczP
	cwWqlRpkmPlB6nPASKPltr4/7NOMGimpW3JsU6Dg7LOS4Sh4yfyKYeHar7JEN/ur
	VsvKEg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmg2ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 14:54:39 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2eab5baaso876486b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 07:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183278; x=1755788078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tglaKq5MwHPkzJhC/F7WN2IWUMXxho8xACm5J/TZbM0=;
        b=htIoRbkN5swoKPCBrvKxm117B8hYV4sm1j8I2k0mfYNz+jjtUekC3W3NBCPyRGXHgx
         IMpqQPInLnLwyyTeiwpy+qGsvpyVv5LTaFhLNBMqkIOPL37EP+SqoZ5oMbA7TslVfsA2
         LcnrCyIycEQWY3KsqkvDxF/wvnac5hvDEbXtgujCHVFgOP7lQSwNGei0RqwXwMv3aKbx
         jRIT5KW/Woouk7h7+dE16auCrbGs0EtY5PgqRGlLTDkuJgnynrswm2sRONnfjyCiTg0g
         CTwfkCATpiuaXH9+iW6wNLiZ6qeUnEygVKzMZyapkxL8fL1FuE8tsOJFzTkeyC2cqZEQ
         sCfg==
X-Forwarded-Encrypted: i=1; AJvYcCXE2jzRP4URtShzD/Uue/qb/1TmI3z2Z9jzhX2SMCs1QIMH26gFpwcueGhU/YaXAd+pQ5SydhIAXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtnQBiWMxy5PGHlnN6hMO34pLLJ9iW9oalGlFZoENFTaNMrF1
	lUvHrUoIWVPUtgF2bNQOrHbW0xTsDcv9A8khWSTqEdgqfuWcHV8fIe0nDfxjhI24fYXVIqzdJh7
	IuKRcFV3DrWbf8qdTVsiuOynvADplo6k0Mk+fB7ZIdK/wtXaUeGvX1XZ4zxhd9A==
X-Gm-Gg: ASbGncuVwvzjQmuMUHTgrZ0PzFIcOWNHO6+0TI6qnzwHR/Af9L5IvcS5Lfbs8mYFMUi
	7GrmDrLYkZkqcjDNoYGira7Zo1uXIFaBJbWzdue0PNR+TGRoiyb3sO1SqW6DzoYqjPv/89joa6D
	2bz2Qrcl0FdtVhvfI3tXkx7fjZ/uhziKvP69U4hXZ6lS9uSRinIJYDDQkxUiUfEIPEDlyui2zST
	Q6hwQK/dEoLHFM555YMjUSUWeKbOerboYS5X0Q+ygI1s40Lr1b7jkXvCYIYMP/R185mzgr2b2FQ
	Q1k7YJEE1RTMpPl6SDuXm55iTcJ3olrEybCF2WgqmVvukS0uV3JaRK2yb2YyZKA=
X-Received: by 2002:a05:6a00:4650:b0:76b:ef69:1543 with SMTP id d2e1a72fcca58-76e2fc0c9b8mr5979290b3a.8.1755183277999;
        Thu, 14 Aug 2025 07:54:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNVdJy1vrWmBYvpmA2uQhEm7g+HPzTdliF9g3hxn/kU1f8cBwtjX4rjsL1kAtrkg1z9pZ0jg==
X-Received: by 2002:a05:6a00:4650:b0:76b:ef69:1543 with SMTP id d2e1a72fcca58-76e2fc0c9b8mr5979243b3a.8.1755183277479;
        Thu, 14 Aug 2025 07:54:37 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76be718b2d6sm30715274b3a.56.2025.08.14.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:54:36 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 14:54:20 +0000
Subject: [PATCH v2 2/3] interconnect: qcom: icc-rpmh: increase MAX_PORTS to
 support four QoS ports
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-glymur-icc-v2-2-596cca6b6015@oss.qualcomm.com>
References: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
In-Reply-To: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Mike Tipton <mike.tipton@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX7k7waIZsfrja
 kJIXK4uqmjLw1zsT6uM1W/GUKMdDeXlZAt/f1UWMrFhJ3hqFB8yQTz2qKZFdCwwqteXInPkvQeH
 5oC5pBqmpE0EGEDWakisowCqemxiRoZ10GBA+Htd5S+4Vbd+WGoeNim2/3bs4YLTmOlHO5p3wg1
 d+Gs+IWsw/P6CwsE5oT+LbQM6I+Hkf94HsTbTJKHhBIhkll8qPx1MOhktuBw95wY0wF9fo6kFGl
 gU8NHnk37crRjbbARQPdhiNFDZEyAeu0O7BEsF3gxSvuF5I3AEgAUnrDSCLMmKbAFGFQJ/Ev9ik
 nPMg/LyUxldwVpR9AOu3fA3TLt7aNsXZOPEUvnVZK+ExeTxdOtfEDdkTj39OCOqXc49O0n6USAe
 +O0VMRpY
X-Proofpoint-GUID: _P2_VTP5MavRi5y2SrkxV_6PXPKZWGZK
X-Proofpoint-ORIG-GUID: _P2_VTP5MavRi5y2SrkxV_6PXPKZWGZK
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689df8af cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KQ-1iU-oSatw-PdDDDcA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

Update the MAX_PORTS value to 4 to program four QoS ports
available on the Glymur SoC's interconnect master node.

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpmh.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index bd8d730249b1c9e5b37afbee485b9500a8028c2e..307f48412563690049e944907bd80500f263f738 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -53,7 +53,7 @@ struct bcm_db {
 	u8 reserved;
 };
 
-#define MAX_PORTS		2
+#define MAX_PORTS		4
 
 /**
  * struct qcom_icc_qosbox - Qualcomm specific QoS config

-- 
2.43.0


