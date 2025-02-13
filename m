Return-Path: <linux-pm+bounces-22035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2E5A3500D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 22:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDDC3AB7A3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 21:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896EF28A2C5;
	Thu, 13 Feb 2025 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NbxLY77H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C4210F58
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480648; cv=none; b=YvPlT8OCNQ590uUkuyvnQyW+EVTrErhLadntD88lFnaNNzJlbI/vFAolNrQLs7xTgVrRjLNcYRMh8normHEdBTNoYIA3zwjg1NDVhMM5gGQ6cakstrLL/Idf/VmUQU4Js81NJc48YKH1uxJ/Ea/Sa/mnGKsIa3X9goYt3qVZ8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480648; c=relaxed/simple;
	bh=YRGZnLfEo00umHgePB/lOxUrXp4t6Vz/QLbBg0QP3mc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VXEdM7eYHjzlNgdEsFw98dwCjB7+/2RdMlLj+6+LgbvRZT4lZ90BIyz7d/H9SVbYisukf6g0f9a2EBjNk6Sq06MaU7cAT4JuGxwI1CVt7TAc0dTFo8gobipsADXwy8ICWJ0T3BYSgsA7LGLtYj6q2o1tcRqL6P9O4/eukQHVmWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NbxLY77H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DKHNjn001789
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 21:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8VxP/CgXnqLT7dCVI0cxvlRc3vuTuhQDamA
	kGTDrmDw=; b=NbxLY77HESK8z2YTw5p41EtFM4+f1MZ/aI0SAtGTnwKV546D9wr
	i7icOiJES4OIy6pp3GoQaAXzwYxRZ8v2rSDLlnDa1Qgi0TvPYYuQ9K7ncdMvVLXK
	Hlfz2rltDyC5ARp/0tHLquq5RQVgrzNWFB444MR+gHWEENx+UZIGRfuiTHT4XSGP
	GMNCDM3LTkHScSDXFjkxgzzMSwWeuxdVCGeRNDBAW+DIsLCxNt3bPx8MtVYzKj8J
	+YTZgvNDXOw4LNBiENiUbVN9R2fvWPX8IcFE6dPTIT9LcOt5lJMYeZ/wgVJCXHdB
	pdQhYMLbMgKD3yNlH5zb9Zh2x/q1cvw0DVw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44semp9mty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 21:04:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21fb94c7fc6so28466545ad.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 13:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739480645; x=1740085445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VxP/CgXnqLT7dCVI0cxvlRc3vuTuhQDamAkGTDrmDw=;
        b=UAeSiDYm/x98D8UE7HH9mnXPE3RORT42qBvrsiGdZo1JOyUmPurETmrs0O9zdlZ6l7
         UYB+3C6uEKGYGsPe79ns05HR78x2Gl5Ne5Ln4+uHbqDI4upB78PHQt9RdakJKBAGIOG0
         YlWCL5PLSVWaNo26eeTEhfxJV8VNuRw228Gdr6qR6hZ56tKdLv0/YIKMuPpcaNjfab6C
         CYo/xGMrmAr3B0+6c4ZhtmEXRK8tEiST7rUNmDnzzGP1+KjejTJu7q1C6GGRZFs4bNwj
         MbBg4BhWV1Uf2YK3GIYO9srKvaUtiEKxtyEmaZScpoiQkKZxI5NFYUQ4CqeSLeQV0vIy
         gG1w==
X-Forwarded-Encrypted: i=1; AJvYcCU/v01oeJMbsj+PmSeMCZ0enSpPP6+gw1XqzUYLq1jGN67edsb92S5o//qzR/stLRc0QPB3VJc1OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxI2g6iremdjPOV2TL3+3biN+yTtXAC4GuzBdQxnpnAr+pS5GbL
	aa8/+N6VnUSSrlrmsHVnc2xCkJeJSIL2Ikck+lQvAcsnm5JUaMf3A83NXzkjBbS5O7tSunKUcOF
	Xzg0zszieOUXCR3H96LkREPscva54mTFB4dp2r7gg4Zz20QKOdhiHS4TSPA==
X-Gm-Gg: ASbGncufJDb1nzr40PYvOtNJZlzDRDn5ZLCdD1Qnu/e5bsrUTgHmeLjarxMkZdnWs3w
	O323eh//3dQkxLbaVfxl902m9p4t7mgP2Wn0T6Vz+1AmS46Xdpp5gJgr0H2qgaIiaBYc+ns60pm
	oc9FdBbPipCIAU7BBGGisCXWgudqXqBL2f9m3nWufzgvS+OLTt5FbLA23CO0mYRoH9TUNuSVgei
	jL8gOldUbfIB8emLLivgEeJ8sPB5PejBijAwjlNpIawBFDYiIx4okPrdc8+uTjF8l6XIodambtj
	slZZh8q2wdugwRDVv/qYpFAAfX6D/A1mltJ2amdAdRlxl1SUiTgGsfSvt6R2HScdfK7H
X-Received: by 2002:a17:902:e74d:b0:220:c94b:83a7 with SMTP id d9443c01a7336-220d20e9098mr66059125ad.29.1739480644978;
        Thu, 13 Feb 2025 13:04:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3PVefDcwgu/C99h90ihg+V7iq72uwEndOIuPiYoQ0b1DMyzjKKFzPMqJTWrNTXGvhYvMn1Q==
X-Received: by 2002:a17:902:e74d:b0:220:c94b:83a7 with SMTP id d9443c01a7336-220d20e9098mr66058705ad.29.1739480644579;
        Thu, 13 Feb 2025 13:04:04 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220dacfc769sm14339375ad.201.2025.02.13.13.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:04:04 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] thermal: qcom-spmi-temp-alarm: Add support for new TEMP_ALARM subtypes
Date: Thu, 13 Feb 2025 13:03:59 -0800
Message-Id: <20250213210403.3396392-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZL4v_6a8B19Q1SxW5yYt6HfxiMx-vNrr
X-Proofpoint-GUID: ZL4v_6a8B19Q1SxW5yYt6HfxiMx-vNrr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130148

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


Anjelique Melendez (3):
  thermal: qcom-spmi-temp-alarm: Add temp alarm data struct based on HW
    subtype
  thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC
    peripherals
  thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals

David Collins (1):
  thermal: qcom-spmi-temp-alarm: enable stage 2 shutdown when required

 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 515 ++++++++++++++++++--
 1 file changed, 464 insertions(+), 51 deletions(-)

-- 
2.34.1


