Return-Path: <linux-pm+bounces-30639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6103CB00EEC
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C933AB718
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 22:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70DF29CB40;
	Thu, 10 Jul 2025 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JQUg/9GR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFE2980DB
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187561; cv=none; b=HgQTe3jFdOKurZusuNXHP+3T6trOR8raCk2DuM9CXN6vC2q6dNA793z9Zsfk12h93HeCSVGsfnjbJaL+C88Ma9PscP6g8Tx+P6Lycvl5XvwYHYz/ccX+KIMcgsu3MUmJ9HWsuGHP6QZkZVev+3x2p2jz4xC7jF4nsHXKq7/svec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187561; c=relaxed/simple;
	bh=mmbmraD0GVPdhgEJxQAseZnsrJCcvwfGHElQMcTQKT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hQXGgZPXrDeFsWhE7qT5i8eUGdgrreNbZZv5/JcgOmPQ8yLRM906BIwdDfWEFS5MlW3qc/gV50HSdecyguPLDrCWgNqD41/jSZ4eNbNLAVAXghLgq/Vm0x9DrYXX45SZtC41t4x06ThrfKO8kFtFSN33UsqevMy1ZUMJkDUFCT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JQUg/9GR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AJR0ZL027436
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fafKzIR+UT4s3pdmqSTYy0cRGU3UkuQ70ms
	vu7PcnDU=; b=JQUg/9GRm07HG3V5q5P+htqWOQxUSo2ehvHJNua96cNsaQiYydB
	XkLFUyYaO6kBKEOrxQN1N5t0WEeQOTV0BgOIDCKxE/ynNxqGHKL0WHQNtG8xGGbD
	zAgwLWWtWYHZYUoVTr8YMWt/6kEIIhDSfUXQJ0wQa2r+xyYHsFqcDfIuOJGdpiFn
	ImwodB57eH6CIDDkLxPDRR1wG4NFvjbN6/B9ej5UO/6z5Vkv4KTrq0G4pg6LDdha
	esxEWcecFxSN36Ax1ghZ/9XsEbWbfAZ4e127PhFMIzfLP46OOrKt3Tx05+zxrzg2
	ExSWbbKPeFiX55q7NqaiGWdDE4hQFJ4mlZg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap6kkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 22:45:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23632fd6248so14843135ad.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 15:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187557; x=1752792357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fafKzIR+UT4s3pdmqSTYy0cRGU3UkuQ70msvu7PcnDU=;
        b=YYOlq4gyMH8OGGb7h4zAnL7+faMCSRR9ZW6Wq3DZK4rzkNS6uF3dLa2sEc8gzYFMLZ
         Yf9bWHS7j4WB2mdaVwkU2FtP5KcVL4IdbiVlrIr2gm7M20rQPJUbzXA3lU6iuIkPdcMx
         TRMjHPL0BUPc+v5CWt4dWZ0z0QUURxsa673O0pzKrJiP/P5JGPaE3bva2+G9DvZNMRkB
         dySY9QSJ6ZS2l1nHNHJgvrNqAtzST0lqgwaKHN0dL+VVkFNPgRw2uQEUbABhOssg1o0b
         J5Y7/v47NWLGk1sLichmVdbh/8HUbNEZUHwGmzWXb3tdzlEDpKDRHYMUomZvMVtBOVn5
         aL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfOORmdJBdHQrnK9uAARMFtwpvq08Abo0M6MlKwgh2tExOMgky2bKJSpqUSX7c9WXwCpukIJ3BxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyllRJxW8GLBwtjhN9SoulLcEZw5gOU74MjSvZFE5GXAW6sNLWm
	wLx8GbyttZ8vPwOE9zdCzq+ovcZfSw1rT6O5rqpZR9rdnLDpQWUWJiH7W7Yowo5ckrfpMrAIDoP
	FqiP2B/VPBzZJuzKBsE5C2HYfFCvw9gz78yuiEKulzucq+r+kUA6HpRx5R5yXgA==
X-Gm-Gg: ASbGncv8bDOBAG1tPrYPKAFxTPFMb8X7EqTK+rpDaHr7CzT+h0YK0ax39kqfTBJhC1p
	NcDpeOF5F+arpM/zc4yB0VdZmiSwYy5583OWc7LnaG9VMEbVWv2P0gD+B90LWrcxY5n/wvYjHfJ
	yBAKQWCj+SPQpZydsJ2C2gTxXp5K8R0GXNOuQIqExlikC+5oNFn4e7IIPosWa54DpMe/k2+AhHn
	Z8icAKqAOaiQjNnSHS4iruUGcq/+13d7HUT5qJrBY/kMzKo28f0YH77X8T+DjH4SvOzDOIMApUk
	ZWsaKZcXWs1uTfhS1UgnLdfQNJpCl7W9UuBd3QZVb2n5Sc2Auf5WAILZxL0TSHh5m5kVpHn5f3x
	IanCpyL2hfr89wTqEPsCeM+HU1fc=
X-Received: by 2002:a17:902:cec8:b0:234:ef42:5d48 with SMTP id d9443c01a7336-23dee0c6e5dmr11945535ad.38.1752187557254;
        Thu, 10 Jul 2025 15:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Js2zgDvvFTjbOa9Smev8Tav2pVyi97CNSmAdgK0xJNfcRNqNo9js/40yj5slNO+Q0jYhRg==
X-Received: by 2002:a17:902:cec8:b0:234:ef42:5d48 with SMTP id d9443c01a7336-23dee0c6e5dmr11945325ad.38.1752187556816;
        Thu, 10 Jul 2025 15:45:56 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm30479615ad.189.2025.07.10.15.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:45:56 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        konrad.dybcio@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v6 0/5] thermal: qcom-spmi-temp-alarm: Add support for new TEMP_ALARM subtypes
Date: Thu, 10 Jul 2025 15:45:50 -0700
Message-Id: <20250710224555.3047790-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=687042a6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=p-nOP-kxAAAA:8
 a=EUspDBNiAAAA:8 a=NNaZUpVlUtzckGV9HeoA:9 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22 a=XN2wCei03jY4uMu7D0Wg:22
X-Proofpoint-ORIG-GUID: j9TXURYs9hN0mYto-CUogjWXcRR6rh_E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE5MSBTYWx0ZWRfX3cLWPcbxzLfb
 IKoVchpWATLBZ7dsAUjBRCbOs4TnSWjid/b8nQo/TZqPQMlJxoAWU288Pt/MVhL1bAT7Twzsong
 EAQVuPwui+zM9WnWNQlODT+9IP6tKwhUE8nks7BAdJbyiPs4PRPJaLlSXfCiD0BDKpj8Pjz8QKM
 xQVmrC5QtIu8KAGGTkJqrhLrqCLlYi9UXn1sxQEg3kQlF1nGylHxRxyN1r1bzf8rwMtk27cZOhB
 xFPaJ/Y/3uDJkCMaDqcNukBkAEn93E3tnboeHFK4DcTbpmzHABe9RC7ubeKCRbbxZV808SVt/gK
 odEhOsIlZvPEA9te+SY+tBZpzx7AQeEAAcv3j4/lRLQbFeN0f9LL2n2dXMm4FBcqx8E1oa2/dlB
 ZUERDDLBJsD6j03VkGniY72f1e12/qsoI6/4bFCka3H+W/Pg76n1lKFTXFrm2vtBbrPRx9dD
X-Proofpoint-GUID: j9TXURYs9hN0mYto-CUogjWXcRR6rh_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100191

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

Changes since v5:
  - Updated variable names to use stage2 instead of s2 in patch 1/5
  - Added overtemp_stage enum for more clarity when reading back specific
    temperature threshold in patch 2/5
  - Updated temp alarm data subtype identification order in patch 4/5
  - link: https://lore.kernel.org/all/20250620001918.4090853-1-anjelique.melendez@oss.qualcomm.com/
Changes since v4:
  - Removed the unnecessary thresh member of the qpnp_tm_chip struct in patch 2/5
  - Updated order of logic to limit acquiring and releasing lock within
    qpnp_tm_init() in patch 3/5
  - Fixed misuse of signed vs unsigned integers in patches 4/5 and 5/5
  - Added Dmitry's reviewed-by tag in patch 5/5
  - link: https://lore.kernel.org/all/20250528235026.4171109-1-anjelique.melendez@oss.qualcomm.com/
Changes since v3:
  - Updated order of logic and made dig revision a local variable in patch 1/5
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

 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 596 +++++++++++++++++---
 1 file changed, 520 insertions(+), 76 deletions(-)

-- 
2.34.1


