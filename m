Return-Path: <linux-pm+bounces-31063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E87D7B0A831
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 18:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43FE5A2E96
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456032E612E;
	Fri, 18 Jul 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H4JCJR3S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E55293B49
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855231; cv=none; b=BZMjphghec4XvQ2NoFHjCxFpTcgnEgpNe3mldePcoCIvmk8vZvpUjgj2MHqSoHVbPmk0rqmFog6rejkUbmwSdegnNk6LodPG4ZR94fKKmSYlFp+poNFR1O4NAiMdvqAE4i0FnSBhnUkYqwD0BxkW5T7E4DU7g4/JR57Uic/eKjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855231; c=relaxed/simple;
	bh=jnQej5os8946OtwsAYxWV5AqWfH0NVCPXeIuQ2kik1I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H3YHNunjZDM8ryU2jk/8Y5hOpVsG9v/S7kDGOr88ITpvuIG8dVycb8ZObFPMxwcGLKvgZjhfki26fn+4lFUzDm6yP/GVjjOeqWatcjm3COI7GBIlpd/5p8AHVeQ5R5qQARoFgvHt8/OIlGL0PYYtlaEmS5BYg/Q6/66gEbCUrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H4JCJR3S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IFl9eS001312
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=E2+mYONdTWwAKa/b2Dnjv7
	gT1I0AopAtzO+8co3bDc4=; b=H4JCJR3SXw9tgn0jFSQ5nadXmD0sTfvO33FeTC
	xkfh5XGBEmDujfKzTA5bMnAmG5Ulv0jyGvCevfwmHKoWpXjjAm/4ng3/dBAtlHy8
	fXnvStcAJWLpDeStFDUL5b3tZLKgJMwKj2+8EYZ9t569nddutkEkmWTjHCBQKekl
	YTPqrhSxc9uFxgvQDSZowyjcXVbjGUytVvTHk1t93YwZtV18n4CAfLQDI0ukqG02
	l2OvLbQsuhE5RDzF9Y+u3GD6qZ2vVsKZpD3jzSSEtEpoYMcN7sV7R5DWDtcK7Ejs
	+hO5ebj+NecfXcjO/nYYv91mk1VdOFt9E7xx2ChLivO8s5og==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dry8x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 16:13:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e2e237fb4eso388239885a.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 09:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855227; x=1753460027;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2+mYONdTWwAKa/b2Dnjv7gT1I0AopAtzO+8co3bDc4=;
        b=cVT19aSOYU8ie/rovcIQ7/DpaFVI3sw5Dkh6IFc2SvH4koWPkXkKZw+h4E5hOVhT0I
         PBX9uyHcLGBsQgwKQXt84TJyQdPlu+je/t9FV24U6nLB5WMUJ9uxsPTjCUHzdw18bgCV
         vwo+NZtFYv2cYEHY+9PEUkyG/V9qzwkvXdzkK5IToglTQbPZnDBzsXD15nbSWbU1zPyq
         WFbJQPv8TXQzn+SUeT1W8CN1COyQTuqWXrPl2iTg4Z0f1LYybBTQuNWvTEIt+thJq9N+
         VIOXM4q095uJSyG7I4bf2iYz472P4V0CeasJTTMcCW5zaU3zwTyOC0/F6lvXN8Z+oXU1
         V2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8jlIdDXDOSwA9RH5/PsrGCcaVvwsNLYqD7D0H03VXcBuAX2xU6PXPpqLJ3JYKKjzfiirizSzBTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhPEHq6HN9LBbfFc+tRGsjAMl4NuKwj4HEoanPUCHkQfN2PGRK
	HHdWrj+V6slw+79jLZKRe2yn9IyiHot0EW2aDhExuWW6y6sV6vzNp5PZc6FdpJ0sbgBkBQgUsMx
	FYeavDP9n2QC7qUW1E9yQE5/xg3wwnl6NSffwaiFU/Zh5IrYvaoY3Imriokl0Kg==
X-Gm-Gg: ASbGnculPDRiHgXOwqQ9VCEdLUBIBmX8iUT396l2/3Pf5hpSv3cOZW1sBAJj4QtP8cD
	UzAIFx/U7K9tuky1cnNYypFBO6BS6JS2BSLhs2eMdqr9A0eMmVb9VqapsuncQGG0Q4I/T6VjyOW
	N7prVamY7aevH1edUbBJXEU1ht1TRz9t64wWKu71a82roXihopUaYO2dMMJwS7foAEFqLE59qYz
	dyiI202m/4jjgqRoYCHeufwp6dDa+kwqeCRWlKiz5OVY0b3JjeOHXoBgDBasu4ADK2Eo4SmKbXf
	DK9/0DmiZHhu+w8b+uRB+Ptc8poXEOFnPfWup2tPZnpJMLq4uXhBYEihFgZdenKkvdbe7Qvno+p
	lbHJlSBhyLhI6/cYr5WkhSru+Se17RByM3DIz2jHBApipEDqnK/DO
X-Received: by 2002:a05:620a:8509:b0:7e3:35e3:3412 with SMTP id af79cd13be357-7e34d9ac2e5mr622296285a.34.1752855226587;
        Fri, 18 Jul 2025 09:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJFME1iu2nBdlZCEndMtUjbp0cqubsgTDnznr23GMq/CHMfz0nkUvr0ssMwdhTZk5t9cEtiA==
X-Received: by 2002:a05:620a:8509:b0:7e3:35e3:3412 with SMTP id af79cd13be357-7e34d9ac2e5mr622289885a.34.1752855225796;
        Fri, 18 Jul 2025 09:13:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/8] pmdomain: qcom: sort out RPMh and RPM power domain
 indices
Date: Fri, 18 Jul 2025 19:13:38 +0300
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALJyemgC/yWM2wqDMBBEfyXsc0OTiAj+SvEhJtu6lFy6ia0g/
 nvT+jLDGZizQ0EmLDCKHRjfVCjFBvoiwC02PlCSbwxGmV4NepCMn8RPyTks2f+qpe663lit3Ox
 7aM/MeKftb71NJzO+1iav5wizLShdCoHqKCJu9RpsqcgwHccXYpV3FZQAAAA=
X-Change-ID: 20250717-rework-rpmhpd-rpmpd-13352a10cbd5
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=jnQej5os8946OtwsAYxWV5AqWfH0NVCPXeIuQ2kik1I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK2X/4FUMKR/6O9sQRhqyVPR9hRSX6jxmwhn
 gheSKljeAiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpytgAKCRCLPIo+Aiko
 1WBDB/93DGP5KNuZts9BxHzohRG1Am3sPtjk5P93zmsB/JMqiWqKOM/hgbgj5r+UBDA8tyf+e2S
 eBGQrnJ6eZ3ybThugmU5ZTY8qq3d4TKf5hWv3P7bufQoeu0FWwMJNcg4nmSGxlrPWslux4byiRl
 86v7dmjWxDRHZkT6CtDTUVi+XyjMjCeIvssj0pR5GHfYMh8Y6JBV0daf0me7Sec1keBlgb6BboW
 DAr1H8ykZzXcebSMtffH3PEY36WiCxRAngEjpl+CcCQIVJNsRCgr2MA/7TOT09cFJZFqYaGa3sD
 O1EZUeyToT0ck7XzZCHFx0gcP1/M8gaCwNqEc5OheEDt7Y9U
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: CYIXT3accmvvfSK4VE5VwLOd4JWkSOwt
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=687a72bc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gAiK-lJt_Rg5ifV0ZIAA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: CYIXT3accmvvfSK4VE5VwLOd4JWkSOwt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyNiBTYWx0ZWRfX9ZL8s8T7YjCb
 qJA8yaNE+2GdUMEU6GyvOwnHwVRl7XqDUN0BkltOXlDcBYFVnO1IFN+AfPoXOm12wcg17zx3LLC
 G3pbF34/up/p1B7Q4l1VjG4AdlY9AIwAH2+yWxTjD/4r7BPZn38VoW3/SJGCZzZKqgCqQggzLF5
 V2LMjdyvLDbd2tydyVNoTAuGX+JXA/o3oKsGKmRKK/RguLa/kFirJNDM2qTWYlTDIJzr94wODMJ
 iZnq87J6gnEgqEc1CwIIKV284/0fvykd5gX+Gz5UzGy5UqI0mWCaoE8cecZQROaQ4PkWD0lizrO
 1FzfKB6WMjNOdaJedXx601F9INmYyOdIVpxVQ8BMVmpZXsfTKapABqK1GJLyMzuJPwvp7Du6x/z
 uNGTze+COhd1JfZfoxZ2IIKcwhQY/ROTHXSwTWJjTVUBmWstPxQyORag+3TYnIZudQXKdKCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=766 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180126

- Separate RPMh power domain bindings from RPM PD bindings

- Drop now-unused (after [1] is merged) binding indices for RPMh
  platforms

- Introduce generic bindings for RPM power domains controller

Two last patches (marked as [DO NOT MERGE]) should only be merged after
corresponding DT cleanup lands ([1] and DTS parts of this patchset).

[1] https://lore.kernel.org/r/20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (8):
      dt-bindings: power: qcom-rpmpd: split RPMh domains definitions
      dt-bindings: power: qcom-rpmpd: sort out entries
      dt-bindings: power: qcom-rpmpd: add generic bindings for RPM power domains
      pmdomain: qcom: rpmpd: switch to RPMPD_* indices
      arm64: dts: qcom: dts: switch to RPMPD_* indices
      ARM: dts: qcom: dts: switch to RPMPD_* indices
      [DO NOT MERGE] dt-bindings: power: qcom-rpmpd: drop compatibility defines
      [DO NOT MERGE] dt-bindings: power: qcom,rpmhpd: drop duplicate defines

 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi |   4 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi    |   8 +-
 arch/arm64/boot/dts/qcom/msm8917.dtsi    |  10 +-
 arch/arm64/boot/dts/qcom/msm8976.dtsi    |   4 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi    |  16 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi     |  16 +-
 arch/arm64/boot/dts/qcom/sm6125.dtsi     |  12 +-
 drivers/pmdomain/qcom/rpmpd.c            | 112 ++++-----
 include/dt-bindings/power/qcom,rpmhpd.h  | 175 +++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h   | 375 ++++---------------------------
 10 files changed, 306 insertions(+), 426 deletions(-)
---
base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
change-id: 20250717-rework-rpmhpd-rpmpd-13352a10cbd5

Best regards,
-- 
With best wishes
Dmitry


