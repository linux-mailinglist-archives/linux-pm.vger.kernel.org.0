Return-Path: <linux-pm+bounces-21766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2A5A300EF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 02:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7D41885090
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 01:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA68E253B73;
	Tue, 11 Feb 2025 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unvcpvtC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84A253B6D;
	Tue, 11 Feb 2025 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237575; cv=none; b=J+DCBXw71/STKNl4cI7UQgwhhuT/tMYvnJLpY+fYpOm8hwvMIMezmbsLmJau1lUj0TLJNE9TH/L5xtfY9XbIF5O3K5g0ArDsBk271C6fFXcVg297SFY3jwax94hEd7m/NmsVxcsL1azUqExnlBX5OeGpMXwqtr1Yrf8BqcTayUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237575; c=relaxed/simple;
	bh=yjSVntJ6iXt8W9c259Qi78e29HqQPMM1IRfLfxua9SM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbkR7lXbzV3Cl5DkVEEfv5aGYIVEG2iu0PARW3t6O0Y2BSB/kWXuIhCnLUInLPrvOV5O6TxdbCLy2agu06ASOfhGdiMQz0VRISIk1I2vp7TURI3VfUqeU784n2TgU7yjTV7wZh5kT2e/4KIRWSHJ2+R8wjZT9KFr99LVhgGRkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unvcpvtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A75EC4CEDF;
	Tue, 11 Feb 2025 01:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237574;
	bh=yjSVntJ6iXt8W9c259Qi78e29HqQPMM1IRfLfxua9SM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=unvcpvtCD38t/sIOD4iBwdsfOnpm0Hg5oOcVhfmxQkp6osbpr9glV5OIxJnKsnZAc
	 KDbtQN9fe4GlJqHDjtHuu0q9/gNYZSY9WB0QEPzQcme5BJE8ByqfzHcAcrU46UE9oo
	 KaZJrCRSI1LeayWfeRapIfL9IbLCksycgVI00cpiKL3VnPkIseWXA284x98SKUBMSX
	 TAplB62CwGcYC2XuDC2WZvy2KpJp0DJRY2jC4XplTdKFNOSMLaBq3Eq5ChTbUThZf+
	 Ds5YoT+Q5kumdQj8X77rTyhu3Y9wuUN6VwjdRxgj9ncYef37if5cyBW+p2tyDnlxmS
	 QUh5EkR2WbLfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/8] powercap: call put_device() on an error path in powercap_register_control_type()
Date: Mon, 10 Feb 2025 20:32:43 -0500
Message-Id: <20250211013248.4098848-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013248.4098848-1-sashal@kernel.org>
References: <20250211013248.4098848-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit

From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

[ Upstream commit 93c66fbc280747ea700bd6199633d661e3c819b3 ]

powercap_register_control_type() calls device_register(), but does not
release the refcount of the device when it fails.

Call put_device() before returning an error to balance the refcount.

Since the kfree(control_type) will be done by powercap_release(), remove
the lines in powercap_register_control_type() before returning the error.

This bug was found by an experimental verifier that I am developing.

Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Link: https://patch.msgid.link/20250110010554.1583411-1-joe@pf.is.s.u-tokyo.ac.jp
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/powercap_sys.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 7a3109a538813..fe5d05da7ce7a 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -627,8 +627,7 @@ struct powercap_control_type *powercap_register_control_type(
 	dev_set_name(&control_type->dev, "%s", name);
 	result = device_register(&control_type->dev);
 	if (result) {
-		if (control_type->allocated)
-			kfree(control_type);
+		put_device(&control_type->dev);
 		return ERR_PTR(result);
 	}
 	idr_init(&control_type->idr);
-- 
2.39.5


