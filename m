Return-Path: <linux-pm+bounces-27765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7CAAC749A
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 01:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1387E4A22A8
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 23:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94286230BC4;
	Wed, 28 May 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UdUalJcx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70AD20FA98
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476232; cv=none; b=fEjgNHVTQguWOasX4TEHDN/OXUOeB3wT6AemYv/XbiCmfez08Ot37nVXCMniu64hgFRVTBQR/vTYE0nKVFwJMef79662H9nRl1XbrudRxE9viXS/+VfBlmk7jiIRDkQGF8zs1MXVibNEIMopeou7y05xj8qa/bjYN6Vddx0XSLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476232; c=relaxed/simple;
	bh=DbeySvr/sM6ieT7r42V6BOeJE6c/w1wzpJwxDwDaH50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sUHokNof4s05SMfKS+WEA6UYbLan4Sr4hVci+5rvnQANy/FBfddcVB91dbxJclhKIScy1fVYeIsULCQDGv0UkCVsM4pc9H6U4o0QQK8Q158AvpjKul+lsEebDGKcTpe1P7SHa6SznEA9mcV+k7+21vHJH5c2ZhNbgvOSWacX5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UdUalJcx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SBiRH3012235
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NEJfu7w/sAhMqmfIv8hz+5wbco5lcwAIRcg
	/3MPS5pw=; b=UdUalJcx6cttlqUDYoTe3PgN8R3hO5kcvBMx5l1TmsJUhDhrP5q
	kuKzrnTAoLYbwZTIRsAyPhpgBhWGzcsexFOEk2cI8t0aIbbcIRm797rEjDdAg8yk
	wciQtIo0cPV61iV60EN1OS+iv3vDPGG6FNnNleBqsUJVOC8veiSmB3VKhsIjMARj
	58H5V6uqdiDdk53mmau+dt5vrNGk/2QuWop33X7qWagkHJYQade3jRWSGwXJVnUx
	uf3fdjc0MpKm0iIZDi74dmaOKNnw4m7eFygEZOWamRtiRX7nGvT0/f0Vxgnpqlfz
	crEDSekNA2B6LqGT8J4z0TYYCZnTnHf0Nww==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w691ecc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 23:50:29 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7391d68617cso1093169b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 16:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748476229; x=1749081029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEJfu7w/sAhMqmfIv8hz+5wbco5lcwAIRcg/3MPS5pw=;
        b=hjx8bZNvF+YL7/GzbjASHEBwo8z6SXXJ4Wsb2EriVDp2Ewnp2OLbOxg1PRx3ggtL+z
         /gAkjRIpJEIs87tegfFb1+CZpOorpIE9s7OebKERcuSoF3NSkfZP3t4OM90DPJToikwi
         Y+bkTFaEabDnNG1pYF1vnqq/KXR8B/roJSCnGDPZ+ywTR4fJ/FfIFRYKEUtHc3JrtDIp
         rc44drHiufD9wMh+EtBqScn7WSOc1GeB/vhaiHYGEWMz6G5TcXI4kZOY5f7L30KYB5FU
         WGJ6kL9wiWUf+wtNMgyFjUlJtWcewRmCR+qa0aKyMVBLELhNQSFRNmPaf40R4v9g58XC
         5xbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7pzqgmhHAe1rjrEM/ZRj5ZH2BU2QTGd81rSaGZQmgth3/UedTPp+vDK3WCMWRymiG9zHLTPZi/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5LKvBIAq9gEjfu5QEIGFuoUjdYCGQ9AF3CCthAEpKSwlz6L3d
	BOZnXz8Ju9tsPvR10WKRnLH2mVkrNFcEMZTmtacZqyEIXKh5tT/oVIqG1xJ+c7laonOrJL9YeNI
	eyevwT3flKGu1PNAJzS16biYV2XlTCaEVN2vBtyJZ+cExd03JvJulFrA97LNWUQ==
X-Gm-Gg: ASbGncsizNMsPjyDj5f0CWJP0ejNroznjp5d4RtXTtEeBkUZ7qRtBfclpFjQSGBIvzP
	B7uyYCzDobVOFxoULSccRs6oZZ6isE9D9iAdiAGlE95hlBvYJnFprcQQNFb2B4wz+BuckBsLQ3u
	ZHdPRO5i5cue/WIdbFpgtICF4vfYPSKI8/TDVfQWaQc+oPfHj2L8kfw3JzlaZVye9GdJ2cqTzwG
	YCG6kX1zbx7HmIcjZJGhkMMJAqwfgHXQcnnJz9L/di+vxEPwA/H4vnndSX2HRz1uFjp1I84Mr04
	pkDiBJeujvCdUu5E6MI9fegID0URRtm1YUxayq1VPmYJGWieXiExZ4b+7z+E2ChLDZWM9JGW3Ps
	=
X-Received: by 2002:a17:902:f608:b0:234:325:500b with SMTP id d9443c01a7336-234f6a00996mr20513645ad.22.1748476229055;
        Wed, 28 May 2025 16:50:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKbW1/kLYzGQbIQ/o5WdKXwB0TpfoIo+PFYWnoYFwlzs+U0mDAJrZ5d1L/i0+BsVrOUOkC4Q==
X-Received: by 2002:a17:902:f608:b0:234:325:500b with SMTP id d9443c01a7336-234f6a00996mr20513255ad.22.1748476228683;
        Wed, 28 May 2025 16:50:28 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd3506sm1403445ad.156.2025.05.28.16.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:50:28 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        srinivas.kandagatla@linaro.org, stefan.schmidt@linaro.org,
        quic_tsoni@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v4 0/5] thermal: qcom-spmi-temp-alarm: Add support for new TEMP_ALARM subtypes
Date: Wed, 28 May 2025 16:50:21 -0700
Message-Id: <20250528235026.4171109-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WfoMa1hX c=1 sm=1 tr=0 ts=6837a145 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=p-nOP-kxAAAA:8
 a=EUspDBNiAAAA:8 a=R1SgPpZEabuFLtygwqQA:9 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22 a=XN2wCei03jY4uMu7D0Wg:22
X-Proofpoint-GUID: UWhVgovcDbrBzfgwAze0gt4SguI3sAEA
X-Proofpoint-ORIG-GUID: UWhVgovcDbrBzfgwAze0gt4SguI3sAEA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDIxMCBTYWx0ZWRfX+kUHaXC5t2Xr
 K/RT8cpmY8s8P5MqZc0rjYQeD+LsKa1fXXtwKD0UWs55zH1yzXZZpfARqEZW8NsTmvIMwIdVPWt
 8cz19n8iy+yL3JJj3/O1zpJOWBkYfHW0svcE2sOAHOOsX7PPTKdZIqx4xCNe/JbMPjxTMqlRIUA
 85oVH8v7LpQ1KwSs09zgNQyC+BqwVXrbgVnGH81/mMnum1xEJQN4wrmiapMVm13kxMuXU62+23w
 Gk1fm1fznVLFRuUaY7H9/E2oicDp7jUezX0SFqeYCnN+5ErVghKfEqIpd/POrzhI84QqleKcnal
 JXqZmIgVyFPjJhvY8u3JdS4GD5NjT5b47wvvEvLy3eNt7dylnjTn/xncEaRCla+KCSjJrvD7go0
 sjUw3F1soTGwCt1IDzM0NvdJXYEaFYlLeQsWBLXyFwiR1R67+31DZ3BJtNaU/yGITCnMrqjH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_11,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280210

Add support in the qcom-spmi-temp-alarm driver for the new PMIC
TEMP_ALARM peripheral subtypes: GEN2 rev 2 and LITE. The GEN2 rev 2
subtype provides greater flexibility in temperature threshold
specification by using an independent register value to configure
each of the three thresholds. The LITE subtype utilizes a simplified
set of control registers to configure two thresholds: warning and
shutdown. While at it refactor the qcom-spmi-temp-alarm driver to limit
code reuse and if/else statements when deciphering between TEMP_ALARM 
peripheral subtypes. 

Also add support to avoid a potential issue on certain versions of
the TEMP_ALARM GEN2 subtype when automatic stage 2 partial shutdown
is disabled.

This patch series is a continuation of older series from 7/2024
(https://lore.kernel.org/all/20240729231259.2122976-1-quic_amelende@quicinc.com/)
but current series has been reworked to address the change in thermal framework to
update .set_trip_temp() callback function variables
(https://lore.kernel.org/all/8392906.T7Z3S40VBb@rjwysocki.net/)

Changes since v3:
  - Updated order of logic and made dig revision a local variable 
    in patch 1/5
  - Updated Locking Logic in patches 3/5, 4/5, 5/5
  - link: https://lore.kernel.org/all/20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com/
Changes since v2:
  - Updated function name to include "gen1" in patch 2/5
  - Added Dmitry's reviewed-by tag in patch 2/5
  - link: https://lore.kernel.org/all/20250225192429.2328092-1-anjelique.melendez@oss.qualcomm.com/
Changes since v1:
  - Remove unnecessary moving of code
  - Added new v2 patch 3/5 add a preparation patch to v1 patch 2/5
  - Updated temp alarm data function names to be consistently named
  - link: https://lore.kernel.org/all/20250213210403.3396392-1-anjelique.melendez@oss.qualcomm.com/


Anjelique Melendez (4):
  thermal: qcom-spmi-temp-alarm: Add temp alarm data struct based on HW
    subtype
  thermal: qcom-spmi-temp-alarm: Prepare to support additional Temp
    Alarm subtypes
  thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC
    peripherals
  thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals

David Collins (1):
  thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required

 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 522 ++++++++++++++++++--
 1 file changed, 472 insertions(+), 50 deletions(-)

-- 
2.34.1


