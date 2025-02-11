Return-Path: <linux-pm+bounces-21762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFCAA3005F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 02:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A9C7A1693
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 01:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBA21F03CC;
	Tue, 11 Feb 2025 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ7M1Mzt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F31EF0A6;
	Tue, 11 Feb 2025 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237454; cv=none; b=W6DzvpnxxVPVLKjCZMv5L4eyUgAlOtr68YHOxAcHRBqDpH1G2C9beOcLSiqOq1JZd0838DENG+FrTQg3Tq3XicwyxuDD80B65T0+A3iNagJjX/hTaRarxzziJ1A6d4PPuVqYWsiachQeAwuzWSfBMqzU1ea7/BNGqh4PT+ghQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237454; c=relaxed/simple;
	bh=7bMjJEnwl4VKz9B0kjecL5TqCguIfjhP5xC90w54YSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bq2hZr1ZITCFP3TBXogu7GNAwThoTxRhjJ8uFRsqMrl5Wbm3gK/dthiXFMAEYsgp4lIyZhPfD7HKEAfbuaWJ+67lA2bRsBO6xeA00U1/ncmCcEe/QzuCPtNNXt6zYbykuEblBrFUV7ATgSqyhN+okdCCdcuQTftaHRc//dYJh6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ7M1Mzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2FFC4CEE5;
	Tue, 11 Feb 2025 01:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237454;
	bh=7bMjJEnwl4VKz9B0kjecL5TqCguIfjhP5xC90w54YSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJ7M1MztAx8llPrNxt6CkNJaOUEZiawMjfpz7G5pw+sSvITE8PilZ9Qr8os1JqV/D
	 MNvJcxrdyjxk2weeETee32FnfqBSyzUkiG4Ffql1POkI7YGLpyxuaRAKvBDtlfICOO
	 Hj1CH5pX7vejsb1QyWZlCBV2LwQqnzWa9BpRe9m/84ImQjEyfArSV2O29e12DPvnMm
	 L35iL72zzLUoYC6fItntKpvQaIAHVMP5nRWY8g9phEiXXvHqFTmF8RcMQYozDaojju
	 ZapMawaaMG/wZMDoC+XktXXz92a+GyX1vUYDLyaFLh5bIB3LILB/k3kR7GMgSEAvD3
	 S1xM4fMr66J9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 04/19] powercap: call put_device() on an error path in powercap_register_control_type()
Date: Mon, 10 Feb 2025 20:30:32 -0500
Message-Id: <20250211013047.4096767-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013047.4096767-1-sashal@kernel.org>
References: <20250211013047.4096767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
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
index 52c32dcbf7d84..4112a00973382 100644
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


