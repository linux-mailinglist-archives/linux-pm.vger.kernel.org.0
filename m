Return-Path: <linux-pm+bounces-28736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE17ADA4EA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 02:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2177A237E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 00:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E80D12DDA1;
	Mon, 16 Jun 2025 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g89+fnln"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77866A31
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033709; cv=none; b=kz8cuvhFsmCH2Q9O/gfc7QVe40P8TzO+NkK9RWc/MdDKv1pDyvCT9Af4pA1ejL7lo3ivodqLFPZI5428asNoaI1miA/PHv7uWxAfdAuZVMSPasn3XOSlhANdX2ON1gRAxx++fmIuBWFT7xhdlzqsa/fbjUEVDkZu/KSeoK93edA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033709; c=relaxed/simple;
	bh=tTkONwaTKNs5Th90Uob+QQKWh4KxfwIU+Ne+iEv3Fu8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iWmXrlGjXc1XlruSHeK1Z1VvMeosSRZig9LdQLLy46ofPR+USzVuTzpsaoht9mRYIktTIBdnf65LpaANYU0TZvVqPhLObpJelgBMVELSm9sHKV9dw6ugadNhEHJjU8zBt1/SNV22ZsyO0mv+zFSB8V7VZZX2qq2o9pCqKFqdRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g89+fnln; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FMv3Ua010383
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PvOfpKcTPNY/T+XF/EuQGK
	wrKoT6J0q2a3ZDB8OoQGs=; b=g89+fnlnKrClToJ9Ma/kmuqgzvURLz37oVXtA6
	kPCvfyxXXRSCbyGkG9jv5xb8AeIPrZJfWoYT/KUdBNlDUWSgTqDOrkxVIuZqbi+L
	0/V6k4YE7YkFWAPDCTY9DpGiaiNtBM4uSKJaGe5nJIWviyzzUJ1gAP3Y3P0oELpG
	feAmG0wTiB+jAtOy/LRQtIkhUNtWmNh4Vd0E6EQs0jrMlB28zlch8vTodLFNiZqV
	LgMS7sju2fb9pgYDARxSdCGj4nhmK1bl2FSoZr0QriISXzg3bKIRY9b+x/d2NYWQ
	1JDSDEteHvTLfR7mNE6BoaGuMp3xso6RZKzWuOeFlMW/TuPw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4792c9thmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb5720eb48so2537986d6.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 17:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750033705; x=1750638505;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvOfpKcTPNY/T+XF/EuQGKwrKoT6J0q2a3ZDB8OoQGs=;
        b=VUW5YJa9lV8EjYZ16/i0m48pEh2R6HYwHsnwtBmNUn3uuTSLeNuOxjHgy23VxgGbh/
         diEILU+mBr9lC+lhnC3FS6ND88EvAVKP2BoPrQEwb7HplriFcV5CP390si+zd4b57jhV
         HaPniCpLAQ259mpMFX6Wjy1vWiB81qoj+ZgZ/+/4kzqvy1fV28LJ/SHyy/u8uacK55kB
         FFshLJ9vRdil8IuqvuAYPOh+DYvC9XaoDjVMcc2Rn3IH4MniLtRJkSAb1YuqD7XEyG5O
         g/6QgI9hEybLyeG/4CMcvBdKLWd2jVZhuZqU9zlGHDLPQD8jq1Prf3vctg/p8XPjpCJ2
         CVGA==
X-Forwarded-Encrypted: i=1; AJvYcCX3Wpsi7+t0/cdcxi4apQNYU1CNE3U2pYIeBeVo8tdYRTsePfcX9ZoXoVd7Vduk0bIv4eaBTYOT7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDAIyNTERp7sKV8hauZPJnkqnShJczCEwfJXC057C/ovqWBuC3
	BOIvhVTbaIjK++lvcuGnlR8NjImO6IEqlx3K8zm0EGDAYkmekbs5b+AeEaozx9GUP29XzuxYhmP
	0Z/l4/U47/v6noZNwTTuXT3KVjwzzyIaNmjqCPeWy6nSXsDXfKQKISkkf96GrOg==
X-Gm-Gg: ASbGncvHYyBDNYtorNlSDkem6veW+/835P/l7jgWL6ABm8BjL8V4fLBrbtDHxkRJBs8
	HrG4DLCSfhFa2TseIF9yw71D5fps0Zdmr+fTOeodTjEvqd5zoA5guaX60egwPEqElqHoTRf+rLw
	95bH94pww92ivftnY11Mj075IEGgpHks0xz65gX5g0JuUHGucvvsZzp5mHPC9+QCRZVRUr8FCC0
	C/I3DhhQenj6CzLULvrHZZ3GcpsxuKfHZzgTfezfgnYT23wJtFJ3A9Q830t0CjpTJetkWWrcW5n
	fQbvBQaS01YoMujw2PsazFJlSb8Wt6MaHR5HYy+P6ls2h4rB5WBfU8tMdCfCEExY3v+DFoDAWel
	1a0DrBbnlbzghqbGA+BgYxFdY2RqHQM5mf/o=
X-Received: by 2002:a05:6214:e61:b0:6fa:edb8:b343 with SMTP id 6a1803df08f44-6fb45afe68emr133413496d6.2.1750033705110;
        Sun, 15 Jun 2025 17:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmGu2GYdq2W+SCMEcx1ePbAUyOpvMBtExb1SkBXqC5Dpe4fxzjvdP5hMCJmzgCnUMKQLYdiw==
X-Received: by 2002:a05:6214:e61:b0:6fa:edb8:b343 with SMTP id 6a1803df08f44-6fb45afe68emr133413256d6.2.1750033704653;
        Sun, 15 Jun 2025 17:28:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac136104sm1334990e87.77.2025.06.15.17.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:28:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 00/28] interconnect: qcom: icc-rpmh: use NULL-terminated
 arrays and drop static IDs
Date: Mon, 16 Jun 2025 03:28:12 +0300
Message-Id: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1lT2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0Nj3aLU8vyibN3M5GRdgxTjJHMjc7NEc0sLJaCGgqLUtMwKsGHRsbW
 1AGSy6+BcAAAA
X-Change-ID: 20250613-rework-icc-0d3b7276a798
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5425;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=tTkONwaTKNs5Th90Uob+QQKWh4KxfwIU+Ne+iEv3Fu8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoT2UhujIdU8ZiDZPCRTfol/v1s4RujRBQ41cbr
 oFGcgp5fQ2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaE9lIQAKCRCLPIo+Aiko
 1WvAB/9hKGAcqZ1WCq0hiRlwkcv7lXVVfO30f0+Azc6Dk6xMQoZQiIPKFt1GWKzj0yJ0BUGl5o9
 mnnl7hjrOFbcZKimAqrIbz9pJeJGF/TjRwrkL6Kykc9p9FKWEqlD7VNH5gpGFURQOWZhE7wqux/
 dhofSr2ePRrqDa2FtIozGxtgyWMGqzC0WMqpiHeMAy2vESvzTGhL/XWgI9axbW+JxVz4006oiLl
 XzdoTN7rNDJnz28fKqk7UeUpXli9e796cgBeKqrfSmKf32BpG2We/2KT6XbRmqUvppLJtNFa52t
 i5i/z/nmKd+0oiO9rTE+T41GF4L03UJPdoBPml3uSief1QIr
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: _YY6ShWSol4gB1pKfOnKaDsxzzR1r1rt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMSBTYWx0ZWRfX6QOLpYCA/ldo
 TqePcnlMJkYh42SksePvF5Zz6VXoF5hoysxYHSK80xJQFyrQUr2zNUqXMK50eG4NxVdR9eLPdkA
 zQ9DJkv0QKC7u3NMDP4UYFdJ/uwU37nbw2naTivcZFe76bO3Cmm8CLE/Qm/0DtDGKtq39KpqQ3k
 o5JtvhDIZ4xd68XKkbVQWCFhhrO5wzkRw7fDXZtEGqj8HF1lmTjr6wienunw4rZPCfZINoNdY/a
 YUmYUt5jRjZ4Ai3KnqZ2+kEuyBr4IZTxODkPrt88LQPhX2qGzlwZaelbLjp1+mnQ7DOHttmkWz4
 eY9EdqlMWYcb/hmIPeqYwE5DVkx1R2v0wAarHEE/VsH9STNw6GZlyVuliFzgmvGNXDeSIkrK2NO
 6z75ec091DdKHWWwOxfip0A1Ad7iUHDSLWuMpEqq1rMNvsfJp1B95caTmuvtPv3mvqn6B9uk
X-Proofpoint-ORIG-GUID: _YY6ShWSol4gB1pKfOnKaDsxzzR1r1rt
X-Authority-Analysis: v=2.4 cv=etffzppX c=1 sm=1 tr=0 ts=684f652a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=XAMh8DXI7HpmVRFZxe8A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=674
 lowpriorityscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160001

Qualcomm interconnect code has been using .num_foo fields together with
the arrays embedded in the structure, which results in hard-to-notice
mistakes if .num_foo gets omitted or incorrect.

Rework RPMh interconnect code to use NULL-terminated arrays for the
dynamic IDs case (as now all the arrays contain only pointers) and,
while we are at it, rework all the drivers to use dynamic IDs and drop
static IDs code.

This series touches only RPMh interconnect drivers. Corresponding series
for RPM drivers will follow up shortly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (28):
      interconnect: qcom: sc8280xp: specify num_links for qnm_a1noc_cfg
      interconnect: qcom: sc8180x: specify num_nodes
      interconnect: qcom: rpmh: make nodes a NULL_terminated array
      interconnect: qcom: rpmh: make link_nodes a NULL_terminated array
      interconnect: qcom: sc7280: convert to dynamic IDs
      interconnect: qcom: sc8180x: convert to dynamic IDs
      interconnect: qcom: sc8280xp: convert to dynamic IDs
      interconnect: qcom: sdm845: convert to dynamic IDs
      interconnect: qcom: sm8250: convert to dynamic IDs
      interconnect: qcom: x1e80100: convert to dynamic IDs
      interconnect: qcom: qcs615: convert to dynamic IDs
      interconnect: qcom: qcs8300: convert to dynamic IDs
      interconnect: qcom: qdu1000: convert to dynamic IDs
      interconnect: qcom: sar2130p: convert to dynamic IDs
      interconnect: qcom: sc7180: convert to dynamic IDs
      interconnect: qcom: sdm670: convert to dynamic IDs
      interconnect: qcom: sdx55: convert to dynamic IDs
      interconnect: qcom: sdx65: convert to dynamic IDs
      interconnect: qcom: sdx75: convert to dynamic IDs
      interconnect: qcom: sm6350: convert to dynamic IDs
      interconnect: qcom: sm7150: convert to dynamic IDs
      interconnect: qcom: sm8150: convert to dynamic IDs
      interconnect: qcom: sm8350: convert to dynamic IDs
      interconnect: qcom: sm8450: convert to dynamic IDs
      interconnect: qcom: sm8550: convert to dynamic IDs
      interconnect: qcom: sm8650: convert to dynamic IDs
      interconnect: qcom: sm8750: convert to dynamic IDs
      interconnect: qcom: icc-rpmh: drop support for non-dynamic IDS

 drivers/interconnect/qcom/bcm-voter.c |    4 +-
 drivers/interconnect/qcom/icc-rpmh.c  |   20 +-
 drivers/interconnect/qcom/icc-rpmh.h  |   13 +-
 drivers/interconnect/qcom/qcs615.c    |  713 ++++++++-----------
 drivers/interconnect/qcom/qcs615.h    |  128 ----
 drivers/interconnect/qcom/qcs8300.c   |  911 +++++++++++-------------
 drivers/interconnect/qcom/qcs8300.h   |  177 -----
 drivers/interconnect/qcom/qdu1000.c   |  470 ++++++------
 drivers/interconnect/qcom/qdu1000.h   |   95 ---
 drivers/interconnect/qcom/sa8775p.c   |  493 ++++++-------
 drivers/interconnect/qcom/sar2130p.c  |  795 ++++++++-------------
 drivers/interconnect/qcom/sc7180.c    |  892 +++++++++++------------
 drivers/interconnect/qcom/sc7180.h    |  149 ----
 drivers/interconnect/qcom/sc7280.c    |  840 ++++++++++------------
 drivers/interconnect/qcom/sc7280.h    |  154 ----
 drivers/interconnect/qcom/sc8180x.c   | 1013 +++++++++++++-------------
 drivers/interconnect/qcom/sc8180x.h   |  179 -----
 drivers/interconnect/qcom/sc8280xp.c  | 1257 ++++++++++++++++-----------------
 drivers/interconnect/qcom/sc8280xp.h  |  209 ------
 drivers/interconnect/qcom/sdm670.c    |  712 +++++++++----------
 drivers/interconnect/qcom/sdm670.h    |  128 ----
 drivers/interconnect/qcom/sdm845.c    |  986 ++++++++++++--------------
 drivers/interconnect/qcom/sdm845.h    |  140 ----
 drivers/interconnect/qcom/sdx55.c     |  611 ++++++++--------
 drivers/interconnect/qcom/sdx55.h     |   70 --
 drivers/interconnect/qcom/sdx65.c     |  577 +++++++--------
 drivers/interconnect/qcom/sdx65.h     |   65 --
 drivers/interconnect/qcom/sdx75.c     |  498 ++++++-------
 drivers/interconnect/qcom/sdx75.h     |   97 ---
 drivers/interconnect/qcom/sm6350.c    |  838 +++++++++++-----------
 drivers/interconnect/qcom/sm6350.h    |  139 ----
 drivers/interconnect/qcom/sm7150.c    |  860 +++++++++++-----------
 drivers/interconnect/qcom/sm7150.h    |  140 ----
 drivers/interconnect/qcom/sm8150.c    |  930 ++++++++++++------------
 drivers/interconnect/qcom/sm8150.h    |  152 ----
 drivers/interconnect/qcom/sm8250.c    |  977 ++++++++++++-------------
 drivers/interconnect/qcom/sm8250.h    |  168 -----
 drivers/interconnect/qcom/sm8350.c    |  901 ++++++++++++-----------
 drivers/interconnect/qcom/sm8350.h    |  158 -----
 drivers/interconnect/qcom/sm8450.c    |  823 ++++++++++-----------
 drivers/interconnect/qcom/sm8450.h    |  169 -----
 drivers/interconnect/qcom/sm8550.c    |  683 ++++++++----------
 drivers/interconnect/qcom/sm8550.h    |  138 ----
 drivers/interconnect/qcom/sm8650.c    |  713 ++++++++-----------
 drivers/interconnect/qcom/sm8650.h    |  144 ----
 drivers/interconnect/qcom/sm8750.c    |  779 ++++++++------------
 drivers/interconnect/qcom/x1e80100.c  |  819 ++++++++++-----------
 drivers/interconnect/qcom/x1e80100.h  |  192 -----
 48 files changed, 8655 insertions(+), 13464 deletions(-)
---
base-commit: 410f15dcfe222c06f0d6379adec630061e88dc72
change-id: 20250613-rework-icc-0d3b7276a798

Best regards,
-- 
With best wishes
Dmitry


