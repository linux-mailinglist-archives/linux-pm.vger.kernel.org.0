Return-Path: <linux-pm+bounces-26636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E469AA8F8A
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 11:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392691756B2
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0472157A6B;
	Mon,  5 May 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="GjA/xLbq"
X-Original-To: linux-pm@vger.kernel.org
Received: from outbound.mr.icloud.com (p-west2-cluster4-host1-snip4-10.eps.apple.com [57.103.69.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657611F5434
	for <linux-pm@vger.kernel.org>; Mon,  5 May 2025 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.69.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437234; cv=none; b=pCOWCqz1N9M+qxEytWCIL614kG//CtKkah7NdHaipHEVRk4cg6zKYAYhIBb+ytMghxzidmfLHngG7jHuIelVcLqFnB3J9ZNdrtT8rn1YNQtSQ+KJ9/CrmVGJ70F5Kx6gJB8FiUG3SLUZye/LmGRGxdFqWAHZ5V7ZzRkdYCF65Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437234; c=relaxed/simple;
	bh=pZyvOLFBKuApBznDeYImuouwzRpCU3KDlc0PkMx5eSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H8w3CXrff5qdg1MAHS2qWyHtJQbqn+k26OZqZoPHomqjy1+jSX/FAty6hbY7940Lv1sQ0JKFGmDMUYFcpccIhMuzRXqsLLAQCvjt+/LIBQbcWD81kOWHEgFQqXBZrXiOESEiqyYZqKKHgsmvXNMubUt9Gicep9/BRvr5ckRlnGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=GjA/xLbq; arc=none smtp.client-ip=57.103.69.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=+bNZg9fhVqFS5rCqRU6rBW1/wv3PMXLvMLVWs2j/KyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=GjA/xLbqdr/I9oJV3mGDLUAJadgDR/S8G9EDCoyT/8nPPwYExbovI4c7aMVbfcrrr
	 D6ZFYTx5ZfGxjPljqwFizpGvZbUF2ojCbSepJdd9Sx2s0uEEC82o+vVY9Xk6gtIPau
	 x5l+0YCkFq/2m/Fp3azm5BRjdUNEwgInBeAxR29IMZ63WHMgcE4st3Jm9Zpng9j0+8
	 Q36S8leE/evJ4GvSmJDOsQ/8602YAkgYHdmrEryAyTXiUbaEPghWBB0Sggi5KS5LLO
	 XvALObq55jXvNqMv8XmG40nUzZHTp1mcgankt83K9Lq+59EnWy4ZkSUi7NZqjGsylR
	 OyR8Y1W3gljiA==
Received: from [192.168.1.26] (unknown [17.57.152.38])
	by outbound.mr.icloud.com (Postfix) with ESMTPSA id D06521800175;
	Mon,  5 May 2025 09:27:07 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 05 May 2025 17:26:51 +0800
Subject: [PATCH] PM: wakeup: Delete space in the end of string shown by
 pm_show_wakelocks()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-fix_power-v1-1-0f7f2c2f338c@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFqEGGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDINRNy6yIL8gvTy3STTQxMU42TDQxtrRMUwKqLyhKBUqCzYqOra0FAOa
 qtVRbAAAA
X-Change-ID: 20250505-fix_power-a443c1a4399f
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Zijun Hu <zijun_hu@icloud.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: E-w5mm_cnpnXz-v57WN_7T6JAalSQppo
X-Proofpoint-GUID: E-w5mm_cnpnXz-v57WN_7T6JAalSQppo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2505050089

From: Zijun Hu <quic_zijuhu@quicinc.com>

pm_show_wakelocks() is called to generate a string when showing attributes
/sys/power/wake_(lock|unlock), but the string ends with an unwanted space
the space was added back by mistake by commit c9d967b2ce40
("PM: wakeup: simplify the output logic of pm_show_wakelocks()").

Remove the unwanted space.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 kernel/power/wakelock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index 52571dcad768b988eaadbd3ce98a4ac42dd2f7dd..4e941999a53ba69410f4526d5d55c32312c36140 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -49,6 +49,9 @@ ssize_t pm_show_wakelocks(char *buf, bool show_active)
 			len += sysfs_emit_at(buf, len, "%s ", wl->name);
 	}
 
+	if (len > 0)
+		--len;
+
 	len += sysfs_emit_at(buf, len, "\n");
 
 	mutex_unlock(&wakelocks_lock);

---
base-commit: 393d0c54cae31317deaa9043320c5fd9454deabc
change-id: 20250505-fix_power-a443c1a4399f

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


