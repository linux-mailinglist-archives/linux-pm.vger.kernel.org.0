Return-Path: <linux-pm+bounces-28682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 685C1AD9050
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 16:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8A618931D1
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E08019995E;
	Fri, 13 Jun 2025 14:54:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992E15573F;
	Fri, 13 Jun 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826465; cv=none; b=rcgM8Ki6u0VDfk9yqAdMwasFiONBGqs1GVFeahMjRJecSnHpG7NyqCf/trLdmdNbJ7CHI2k8NCadG02mi8LRlRygsabJLAI2oUW/61NeeZzPpWH7p9XR6AvEMjQmrvRWAM922J6u+fYs2K1kGWJ/keKXsdxkI9GGYyBTQpYxUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826465; c=relaxed/simple;
	bh=8cOPkGn/szCCpXB2qWZWgqyw7ZOYYE0Zy6npeEJKfws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OMzZ7AyiKTaNykrC1v8iHGSVxFrOPDp4eIvHitSszZdnJrD4xEpNMCmnMnQDZ7mM/kDUymSX4cIAM1nq+tyA30p0B+7cHbEtnZ1QgbBUjscBwEMPB8VZVc6bPZZAhjj4DRUPtV1hCw0rkWQ2PjqQnZmIHyiyqlFPrW4jzLEjWXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1749826425td2e088ce
X-QQ-Originating-IP: Z5TTPs9mOc1QREyKbkANH7OY8KCSckJh6gkg7KuqpRk=
Received: from [192.168.30.36] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Jun 2025 22:53:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6558941307661380512
EX-QQ-RecipientCnt: 6
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 13 Jun 2025 22:53:38 +0800
Subject: [PATCH] interconnect: qcom: sc7280: Add missing num_links to
 xm_pcie3_1 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-sc7280-icc-pcie1-fix-v1-1-0b09813e3b09@radxa.com>
X-B4-Tracking: v=1; b=H4sIAHE7TGgC/x2MQQqAMAzAviI9W+jmnNOviAepVXtR2UAE2d8dH
 hNIXkgSVRIM1QtRbk16HgVMXQHv87EJ6lIYLNmWvGkwcWcDoTLjxSoGV32Q+hCcJ+NCZ6GkV5S
 i/+045fwB/uIKRmYAAAA=
X-Change-ID: 20250613-sc7280-icc-pcie1-fix-098846014872
To: Georgi Djakov <djakov@kernel.org>, 
 Odelu Kukatla <quic_okukatla@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749826424; l=927;
 i=sophon@radxa.com; s=20240424; h=from:subject:message-id;
 bh=8cOPkGn/szCCpXB2qWZWgqyw7ZOYYE0Zy6npeEJKfws=;
 b=LYU3mT8poMy5IX056AH7Ctc3vbR2+hrcFJdzFhBppoxyeXqEKEK0du4TntPpXLEMHo2ykPEph
 bNmcW6p9bm5AYiHTkWaDQhWm0/045K3Svl5Db8WWj2Gt9QesNOXnvOx
X-Developer-Key: i=sophon@radxa.com; a=ed25519;
 pk=vPnxeJnlD/PfEbyQPZzaay5ezxI/lMrke7qXy31lSM8=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MMRwY2QoRaEQwrIgYAyvWdURrqOddORGOmj2cKN3JzWsy8L0RIZUCSmR
	C4QdZ4TYRDBc0Uti6Ev5LFuf5xd6OMAFCUzy/8aTx76DwRgw683VDRIqGBDIs5t+JStDBUg
	Ns33mrlIZAKMKEZJrmXBAAGAKIYlyJBHtawk+5HHmOgja/+9UC4jYMShDafE5O5oJTKGStT
	0uzljY8GGB7gVoRl4etp8jOQC4WDLX8N8vuZ+fR2EnsIIJkfoe4/tyq+FLJJSrC+DUbv1w3
	CC9BoR2wHnXK6r/qh3WNdDfwKv97nR2m997yVPKzWLh5ahIkeq0TS0Ti4dEOFY+FjLYRvBz
	xHZlF146ss0eb8jUfpnM0uKo6KLf+1m4bcszSKrgMs/z5Yb29aXQto+Pts++KbuPbp7pzKJ
	E19Nu9NCsZ/7PIvNXssvBWMLe59Xvk73Ld8SncHsdkiZQT5akXs6659tx5vH/jGAyHr/T0y
	q5nYqeBmAc4sUZ/cXXwFIMGg2mrDeTDsacpH8wDOsfCxR/tUZGfLNAYfOWJAXo2REWu02NR
	3ZAT2nLm6ODmUNpYEPLzcLGIlJeG1jVn9PsO+KIOhA1hCtwP4+MzvipQHj6YIVwZOnZSBQR
	bqcmOE/EouMKT+OdJAu+3z0zsNv7vWjALa8dGNlX5KXe8FqxOBLbkHAMbeK57O855VT69y/
	5hrfDRtEJbxtJwo2UY+Gxt39sDu7j213r27oNKgeySAsqw9HgQ6IZl32f/APW2smkwq94At
	aUOQ4Mp4a7sH0dbDYnXROHNRLKVlsxr9fJs+gsYxVuCSxA8gxOHjKw2u2OnWFEYdpvLffon
	PhXk58fNUVcpq1fT4SZrCe93XjeQP/i+n+Br3Vzj0zwU1vYEhwrhGwiAhle5Fv3Ib9DFdIo
	Wxq790/moJmy+KAM+L9v2ERaqa2HIXGi6/mXdPni0FIRXYmugyLLfTgwwCp1oF9OF79cak0
	G40Wq1QtzCNctEiytlrH7qQErnPDzrI6n7/vHE9iORe1/7jX3qxRLRNntQFPK/T1zEyEJ8i
	PZmUBXUCr4qj3e1uxCs8l3Lx3tJKM=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

This allows adding interconnect paths for PCIe 1 in device tree later.

Fixes: 46bdcac533cc ("interconnect: qcom: Add SC7280 interconnect provider driver")
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/interconnect/qcom/sc7280.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 346f18d70e9e5e95821437ca716ef8f151a42574..905403a3a930a2e1cd01f62e375e60c6b2d524f7 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -238,6 +238,7 @@ static struct qcom_icc_node xm_pcie3_1 = {
 	.id = SC7280_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
+	.num_links = 1,
 	.links = { SC7280_SLAVE_ANOC_PCIE_GEM_NOC },
 };
 

---
base-commit: bc6e0ba6c9bafa6241b05524b9829808056ac4ad
change-id: 20250613-sc7280-icc-pcie1-fix-098846014872

Best regards,
-- 
Xilin Wu <sophon@radxa.com>


