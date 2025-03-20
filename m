Return-Path: <linux-pm+bounces-24345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C89A6AF16
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 21:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265BF983AD0
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6CF22836C;
	Thu, 20 Mar 2025 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Md+EPPkN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DFD2A1A4
	for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502255; cv=none; b=qoLFN70SI8S9ONl6Qeph8hww3TlBtNtf7zpO9tdNpIN6knpoApNN91iTs/9XZ0Ss1Pg/tmLo7DA/zWuTU6kBBviSlJVLvJUPI6fzvppnlOAREMCvdtQSbGFwbMrRr54qXMzwmil06PKRocoudUfu+U/bQVxVQXKJJr7AvZF8QkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502255; c=relaxed/simple;
	bh=gyKX3CgdnF8FkgfxbhLBxoEUdW3TAckRtfZQeshuh3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ovb2Ps7LI1+KUH5pBJmcdMjZU5kuVt00+MTr5YRGikwa+do6+aSRmwPQtLW/M7v1nNP/OAQg2dLh1ym8ekiBhfURaggfNkJFhFQuIpFU+7xNMexUfFeOFWeuaHreUdyN+1sTHoHeCnLD/OAo9vyUY0yrXbL10+6c9vm68aSn+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Md+EPPkN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KETggp025362
	for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 20:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+7c6G1I6tQ/t7e2y76H9AcxAq6Pwm0K4cZG
	N9sjyBKQ=; b=Md+EPPkN86r9Y5WlDFf5vLW3x0r3nONgfRyKbX0OCjE6DugnMjv
	8qRX8RWScuE9nKAwQN93fYAOipNTaLotYI8kDSVasLfBsF18bs95Yt4tJaAbIZVN
	02vnRjHj11lJmEBPpCdqmk7S3+ZmTnRoVMopEjv4C+z4tEVX5n7nKf9l9s5Zh+7p
	k+84ZU0U5jSycnIwOd2FxJh1Xwud3p8OVoDRw04LbGHsQa8qIFiIemMQ6fx0B9hl
	JQZWrszwQ5AeNhsdPG01FZmSBbhV/fQmKmoawKq6Y5Ox3vuuAsH8bnuNH0NOjLdL
	Gny3dS9hj1gp4EZj1OauWxLO2OAvjbwGsdQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g15y49fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 20:24:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-225505d1ca5so16493655ad.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 13:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742502251; x=1743107051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7c6G1I6tQ/t7e2y76H9AcxAq6Pwm0K4cZGN9sjyBKQ=;
        b=GB41XcuHyHcqeqTA2+6MaTGYHfg4LX20K8ncpJzOuQt+icZI92VsbJEyNHZXTY01yu
         WXUlhlDULPVpTvRQfC5oQhDtq9Ol2Rf3q33zhpXGJ4z5EvJMen74sz0ULt+ElPf+4RV6
         1GtDzXZ2Uzq4t8C9EvfICv2tKTRzBrhXIRzMoB9jIEaZy8p2hv138tY/62ZvSkN+/zaV
         JN+tY0FzVeKkM8d/gULKQnplk/N+lKmzg/lCCOmOjaEZrF9sIdhe3GQTDdQSTg4KjwA7
         ukScQ3fURR5+892ynJhknHJTRFRPEJouBoMFbMJ7ceNicZSrVYK9ZPazqZqu3mAA1fQK
         MieQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcOODuJHc719lNFpQBTfe+JgWxGPjljJtje5fE7/Gx9RRQ/wYLbnOKdE9nHORL7u7an2tDIFKTBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdLAbirs88waJCkbsGT9Jigvz6xgeorWIz1ryjrpPAXUPWI2G2
	a3SwKqjj2PSZdYncRPcF/Z90xwqEW3jJD2uBvX5Miymd5cbaQCu4EO+quwgyuajun/20nPE2ikW
	GV7mvJga5eYBAN1o4ogQpH6nfO9E3QIrtf37GnMOZ81HIbVUdsBsfAAQ9lg==
X-Gm-Gg: ASbGncsLKGyHVS6kz/NwIQC8InG1YwMFBKKSYzCV6tgDGZ6XvAk5rp8DOEVqwIz7zSk
	4w5I/tBWW09bcXE5kqq9oLDuauShXBlymQ+L0VifoxiJGDedDCYBA1XVJZQA+FG2VXCx+ndjq6Q
	hYADV2uFRxPSWyAPKMIioYEl6oagNNi1a2ybfBSyPlYSObpuwKuOEWYlBPEN+JIJBSw6ax2dIrX
	IaulHwlByIql+YJh8krUC17KFwr/X1qATJTVjngd4Li/ehNw8w/8qFISOlnI7OtHQr2k/6vuV6E
	hxmxqzX7kUezTkbHRgfMxdOVnwf4rzIqp/6qyyVvXIyNu68E4YPkz01MNo9PD8LeWK2f/C4VCtb
	LSxI=
X-Received: by 2002:a05:6a00:a29:b0:736:39d4:ccf6 with SMTP id d2e1a72fcca58-739059763admr1499570b3a.8.1742502250587;
        Thu, 20 Mar 2025 13:24:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC7WMk6IcHirEuRb1Mgq2qX5tdTzQX7J4XfeCDRDXTRtaQbuyxonjtPIgdVJ7X2V+/isEVVA==
X-Received: by 2002:a05:6a00:a29:b0:736:39d4:ccf6 with SMTP id d2e1a72fcca58-739059763admr1499523b3a.8.1742502250164;
        Thu, 20 Mar 2025 13:24:10 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600b9b1sm249308b3a.76.2025.03.20.13.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 13:24:09 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        srinivas.kandagatla@linaro.org, stefan.schmidt@linaro.org,
        quic_tsoni@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org
Subject: [PATCH v3 0/5 RESEND] thermal: qcom-spmi-temp-alarm: Add support for new TEMP_ALARM subtypes
Date: Thu, 20 Mar 2025 13:24:03 -0700
Message-Id: <20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2BdSxhGyuZzZoSqLcnpPQTgaY5S5nBqn
X-Proofpoint-ORIG-GUID: 2BdSxhGyuZzZoSqLcnpPQTgaY5S5nBqn
X-Authority-Analysis: v=2.4 cv=VaD3PEp9 c=1 sm=1 tr=0 ts=67dc796c cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=p-nOP-kxAAAA:8 a=EUspDBNiAAAA:8 a=R1SgPpZEabuFLtygwqQA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22 a=XN2wCei03jY4uMu7D0Wg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_07,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200130

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

 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 515 ++++++++++++++++++--
 1 file changed, 464 insertions(+), 51 deletions(-)

-- 
2.34.1


