Return-Path: <linux-pm+bounces-22912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEB8A44B34
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 20:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A44189464D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 19:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774B51A76DE;
	Tue, 25 Feb 2025 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D5mHQbY+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0D1917F1
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511475; cv=none; b=CTLcxt/Dd2WkYAHn6V4esKpT74y/znQ7D7vJgdEDPmOhtWV+H4mqmZkq9vTbuBt/bpZ63Sdrr5ra+oJkPOXjEJEGXhxF+lVx9ywF0TbX5D8IVQRGIxPrCoXL05RrXtVagTRoUtrI1c8DirL0BTEM94Wo8JQr3GoOQdWzfMRa+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511475; c=relaxed/simple;
	bh=6OgzkiWBMP/7RrxzCGyTQ49Zen1dwXVUytChFQLaUxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EdluV22jVy/SoKGkKksYOB7dx+5h0qJJhoMgCRSpfZomkNog0IXJfNPI7Cd9nn1gHn8hA3eGHJLT/45EAwva+0UCa2U/u9/S98jLMzE8iDmMG46twGKjZGjYABHW18uwNGvhm8vr+5xMZLWkvDomaWWK4RVgLi9HcSeulq5oP20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D5mHQbY+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PI29RR009109
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 19:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=TsrQvuOeoQBZ/rKsZq7MLKcDFYqh1zrSm9L
	OgeM5M04=; b=D5mHQbY+wpnQe8qqXmKHApcbPpeqUU/vohykitgk7sAuIwKK+ry
	WbqdiGGol+HDmxv06hBCAONBAONX+TpPTAHCduQH6qnmImIoTDZKfD638iKPYWFr
	X2AGV+Gx4uq5iBVPyzVqGufPZPLVJ1kzHAjRHytEGCBLG6KmmDEG17HiKdXLefBk
	1X1MqIrQJ8EdNhnh6/ccCQObtBCaZtybfYurqKed8HGT7xRYv9QTj1gNIFFYwhMj
	jbfoeKxrbW/kw8kJocx8bfsqEKpPnClwrRhsYAg1gCab7YZnkcR5asW+xNMpfbAC
	ZfDMc7bOgfCTk00IRi3yiaum6ifohDw+Jwg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y6y6sypx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 19:24:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220fb031245so103920695ad.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 11:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740511471; x=1741116271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsrQvuOeoQBZ/rKsZq7MLKcDFYqh1zrSm9LOgeM5M04=;
        b=TEUDNPkKvkNaBwoxGYTDNKfwg8tiH81ztmtlOgeaEsSlbAMMCV99nAmMeHnyx0uFt1
         75WHEB8FY9IhKoSrklRsKZULXXMVq9S0qGDtPBUB52O1vrPGiVP8ZyMFWKERZpmRX6Au
         VckwwdMjUh4sSI6QOSJ29aCLfswpVecu7BP0FDSZ/+Ntv9weQLrGejC8Zg8DSsWzr+Ok
         d1pfKwBdwWj/ybjp5LiKziKoxHISZdaU5G1JgU2FatumqxTgwmxPlhzvaYTzyMkAVpUw
         W4o2sRVotcTIephX1UGW4l9xXjmGyjWIQUYJI3rGXHbBGJokjQAyhmgmgO/X65sF8I1U
         JipQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSSCfHFJWijx6nxPw8E17Tk9UlVRKJ1sJor2xkmvyScFjCnyl2hkoiQyrvNc4BJJ7zhZr2sXQD1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMdNgH6Mjy3cjuXzJJvcJicamEfMre4Rbr+zjSO6YMfpsm9jTn
	D0EB0+k6iJ2cQ3Nibola/CMrY+CI+b4TcmeLFFbcqjgwXFz10KsZ6X/GTmbZk30hiBuxSOEy3ib
	ME0rPRN5zB62kIMt4EO3OpzOIUasB06tvNhYkxkKjlmEmSOuIJVVl/BXQoQ==
X-Gm-Gg: ASbGncuqCDw7t8yi/BPbYFzdMoI4Nuh5Mnk5q9rQo8d03e7mkkH5/Y78Rgk4eGMMgmJ
	obInZOdnuSRo82QLhKgRH5bszTxSjnYtOPHnaLi/vSwynGQw8a+glQruicmWSEpgaUWu0G8wLjU
	ha4PmeXC50Z37hcsf/zYUZPvXy3SJSA3sJVNdObQUFrJvcFbPFGKby5sGguTpdTXLKUYptMRZ4v
	pUaBEa+r1O3q4VDZtl+1FBC0Of1Cy86vVfPGpKx6Mb1qO3EW4r8jpLOKTQj8MVBc4L+GCSJb8Wz
	Ur1fTGZ7e+7c1aYBk2sEaZN32Iy46Hkr03FWtf89mnbrEqbFSyENRmlX7Q3hSBvz9N4zHBCzx5T
	+6OQ=
X-Received: by 2002:a17:903:230d:b0:220:d532:834e with SMTP id d9443c01a7336-2219ff9ee9amr310444395ad.19.1740511471041;
        Tue, 25 Feb 2025 11:24:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDz/JNFm/2arbEk/SBsmKjhdJe2VRlvVj3HEycbLIoL67Uud6lEOpWzpbXBsGL78mTEoh8gA==
X-Received: by 2002:a17:903:230d:b0:220:d532:834e with SMTP id d9443c01a7336-2219ff9ee9amr310443935ad.19.1740511470637;
        Tue, 25 Feb 2025 11:24:30 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a095865sm17915365ad.145.2025.02.25.11.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 11:24:30 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] thermal: qcom-spmi-temp-alarm: Add support for new TEMP_ALARM subtypes
Date: Tue, 25 Feb 2025 11:24:24 -0800
Message-Id: <20250225192429.2328092-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mnyEemjqQ-VtKUPSwVi0_qPRUDxRVSqo
X-Proofpoint-GUID: mnyEemjqQ-VtKUPSwVi0_qPRUDxRVSqo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_06,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250120

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

Changes since v1:
  - Remove unnecessary moving of code
  - Added new v2 patch 3/5 add a preparation patch to v1 patch 2/5
  - Updated temp alarm data function names to be consistently named

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

 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 511 ++++++++++++++++++--
 1 file changed, 462 insertions(+), 49 deletions(-)

-- 
2.34.1


