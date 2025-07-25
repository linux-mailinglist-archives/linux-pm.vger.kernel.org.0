Return-Path: <linux-pm+bounces-31424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA36B11FAA
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 15:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD25D7B745E
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 13:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0861DF26B;
	Fri, 25 Jul 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+zCz3MJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203051D63C7
	for <linux-pm@vger.kernel.org>; Fri, 25 Jul 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753451719; cv=none; b=DgNmAZnsAljmF8fd42fJ/dmqL3kj9b+xi+TNJFsnJPJUmjZf5E8ARwoaOCJYClc02hNAc8qn5xEnjPYSfr0jvkVlVTGfLff/A6qgThQqF/e9p5NPOTiUhCD7ObQ0bNGbG0w0nFqKfJmUnVJ+6FAuwU1HDnSvuilkmcyBUMoqP+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753451719; c=relaxed/simple;
	bh=7NO/5PDwCUtGR/xRI+RAWOPjqGGaa959C9g1gdCteZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gYVms24YhmYCnVqnCHzMORjnemMxZ/hMvoSRxEpqPv77OrEoZuyNibi3l/mXC04tanq5MjKQWiC4zG+bS/MfG3C3K5aGsnW/EjpfBG6BvzWgF8Hc7Cr9QV/ZJFcHrsOFA4RlpfQ0Dc/owq7h7TEveNSGQndOEtCHdq+2OxLj/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H+zCz3MJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8gCGW024424
	for <linux-pm@vger.kernel.org>; Fri, 25 Jul 2025 13:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4oMvR3Y0JNp+Q/I4A+Vinq
	4Xdx0BZl2sdYxQYmHG2dI=; b=H+zCz3MJMeq4RHkdpqjyve9zaCKMPCTGeFv9cp
	nrfRFDVfX84ejLK4ivFn6B9SP2ec7FrBvrJoRWJmZgU155Ax0vaSOrRrFDA6O3qG
	yOyTO/4A9Vg3jOnH6GmKr9K+FtsEul+32WQheGNrjxun8TMd9FTUiDBUaU9dHU0y
	E/mbgljJZfJGXKxnSFXCjGT+ArPOegE1Wi2RJjpittjTXnys9535iKEucUzzY1oY
	LGa5LBd4W4NsuicKPpmad3I1muimx7PqLxAEmn5QBQMDRknjlcJxWQckL60JEi7+
	RnYt6trpGOPMgttKmw1TyrY9Z4AxGn1Qw6vcExcRk3LSBVjQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2ra9j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 25 Jul 2025 13:55:16 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-707205f0405so15221236d6.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Jul 2025 06:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753451715; x=1754056515;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oMvR3Y0JNp+Q/I4A+Vinq4Xdx0BZl2sdYxQYmHG2dI=;
        b=YC8DwNOZXNDN1sb/GXXkso7psoo/3cK+DwQwNolyXrK8MnKzJEp+7brQqHcvbGZFjS
         Ij4SG2PaaOGecvExiHywSKZFohDOEzc0f1w3UJ89sfP9pGPj0K3Wtt3i6omDtEMM/JGc
         eYQV0a8XU11VYYcw7MfLPJv6f4GesROqX6ut7TJjm7BT+o1IYZ+DGqEFt5OyyPtHLu8N
         9z1ev+gkEGMKaEx+JrxhKNR1ffkhzqU3uI29KURNW2L9qk7VcQEYT4xO9rBQAukaaqHK
         dumpFk/KvZ3A8VelGuC2FUlTtolQJJgelaIcRfgmE5UPuJBAoi0FlKl8cFHHzXv+lF7X
         szAw==
X-Forwarded-Encrypted: i=1; AJvYcCWtcqjg/Bwz82mEogoPFT6fkx3PX6iL/Fv9ylITMaBxXzvkVJ8czThKroZCdr8DkhuBrSLRE0gIyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzPaQGA+cnrsDx75z4ARVj32IfFU27BEj6MM20dGoqRJNZ8tCO
	RtcODuHuq2ZoRlzxJlnKrExH+uqZTn9Z/seOjtXFNUvHcFKPwPSfL3c52wIs4bZ1VrwEtDNfL7M
	emlZFytfu0b1T7RoOQLYyseFEYI7q86G9MAAYcoM0kRmj/zCqov8qDZ0mVBoPtA==
X-Gm-Gg: ASbGncsV3o3QlH1hbZid/QZUnQ7C29peE8CAE8bFYt82kzEgToSJIFIc65CT25M7cuA
	tMjPeI+n3PioMxtVcSoNT80GVMSFNazSS/00h9bqoblIuzsI/lVIMKozlB/CGWY5hIJHskMVlIh
	3IMj5Wl4WRCeobYpXOPjwshGbMngOeSJQ1E5Ky3WMQGhb6D1mcQzEb7Pe/Oc0DtR1pgBdzb6New
	qWuvAqKbpXClD9FF2ME0m8WXYPB2gRq8+9r7T5RnwRPD9kCEhW5nq+mK+QCUkVszF/58L2XwUhE
	LFYiwZsn9KjAlxGqY77FTN1Yq6rauhiS8nLbX0UCFIa2nJlF4iHEFrbvv2fOGxLjvcUPqMkP+4/
	WRXSiVt42sG7DBp3OA+LRbnX8o2IbFxzzJJ7Ey90uwASIALshJbyq
X-Received: by 2002:a05:6214:f66:b0:707:765:4041 with SMTP id 6a1803df08f44-707205a6f6cmr32579306d6.23.1753451714724;
        Fri, 25 Jul 2025 06:55:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8BZQvp5AoylRAE5PFekGXAMMw2A8WcJZlsJwh5r1hgEVz+02C+qt0QeQkSdMwmhRk2brAaw==
X-Received: by 2002:a05:6214:f66:b0:707:765:4041 with SMTP id 6a1803df08f44-707205a6f6cmr32578866d6.23.1753451714226;
        Fri, 25 Jul 2025 06:55:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f42357e6sm37481fa.54.2025.07.25.06.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 06:55:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 16:55:11 +0300
Subject: [PATCH] thermal: qcom: make LMH select QCOM_SCM
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-lmh-scm-v1-1-84246981f435@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAL6Mg2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyNT3ZzcDN3i5Fxd09TkREPjVAPzRCMDJaDqgqLUtMwKsEnRsbW1APC
 WJa5ZAAAA
X-Change-ID: 20250725-lmh-scm-5eca13e07a20
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7NO/5PDwCUtGR/xRI+RAWOPjqGGaa959C9g1gdCteZ8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBog4y/Xm6i4BloCVqP/p2bHSyO+YKW3dwJLmrW2
 smAYQol2pKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIOMvwAKCRCLPIo+Aiko
 1e1FB/9OG9rRASczPPlIvMlLvOjBiZfirMZ8cLkDk4ZKDgcWDjHlZuyb7HRgLv4AzXYHed9dI6M
 eMTbm+EHLvL7sZBKppjP2LohP+K2T7rNPqkY/HVxs1iCebRegTqvLmdxX/dDoPnjkNykQnAAqub
 XTZCbADcZHze+QmKWyZtm5KYhaGkATvL9UhCxncv98IVzPvFNRJYOMcomdvsDzlWcW1toTpQjAZ
 2LUaY/zK5GCcc7/u2VivmRQgdCnDViuG4s/7FqhuV2pVrQHcpRLY0DCvjTqzr2FHMZ8bAKZkKcU
 rLOy0rWy++qFDw7NzfWD1MDajTi8rZ28ZU9fFHCzvj39u6jD
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=NfTm13D4 c=1 sm=1 tr=0 ts=68838cc4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=_a-utCDu36pnI6q6VeAA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: 61XYjLGcVQ61Q2zGx77Hv0z3n6FktxkI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDExOSBTYWx0ZWRfXwe7Us1l4poh3
 CJnHtDoolRwaDPjSU2t0g73WKgOSMjqWNPr0tMOKyH7Xv/ATII2MvwYqsvslzlYAw7cUISZZmxC
 e3IBCmPPL6YUZmrmVNkgFTP1hEbVCprQnpdUWDGzqa1Zlp8kZPQyyibcH1MiQNserTNe5tCfEiB
 TkO2z6/wZG4xClUSQpmo3Nlk9z4jzz/rw4RLfbAhESASFvN9hWxoQgxh0WQ90riRbUPrZXkoxa7
 LFgDsg6F1gBS4j1SJBam9O/06xhMkgsNO8CgFQqKz78UjGDQT7O8SOTjFChuxbRmNiq2IoyajO2
 0Ojn28vDja6qhv/t6E6nRa6Gu2r7S1tSuwdHp0/o8JbvW4KUy18Hk5g3Re7/+LPdFIySxLE/3zo
 kHcHKkpaclt8QOTV8tz9dVztFRd87oY48SMtzI52cX4xh102C7qLCtMspEXvLlsrfFyHyW4Z
X-Proofpoint-GUID: 61XYjLGcVQ61Q2zGx77Hv0z3n6FktxkI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 mlxlogscore=954 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250119

The QCOM_SCM symbol is not user-visible, so it makes little sense to
depend on it. Make LMH driver select QCOM_SCM as all other drivers do
and, as the dependecy is now correctly handled, enable || COMPILE_TEST
in order to include the driver into broader set of build tests.

Fixes: 9e5a4fb84230 ("thermal/drivers/qcom/lmh: make QCOM_LMH depends on QCOM_SCM")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/thermal/qcom/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index 2c7f3f9a26ebbba41b89c8aa5d310048e8d6c792..a6bb01082ec6978afb5df32464cf591e4670549e 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -34,7 +34,8 @@ config QCOM_SPMI_TEMP_ALARM
 
 config QCOM_LMH
 	tristate "Qualcomm Limits Management Hardware"
-	depends on ARCH_QCOM && QCOM_SCM
+	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_SCM
 	help
 	  This enables initialization of Qualcomm limits management
 	  hardware(LMh). LMh allows for hardware-enforced mitigation for cpus based on

---
base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
change-id: 20250725-lmh-scm-5eca13e07a20

Best regards,
-- 
With best wishes
Dmitry


