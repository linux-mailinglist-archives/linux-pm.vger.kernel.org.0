Return-Path: <linux-pm+bounces-21763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 378C3A30092
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 02:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913C516331D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C81F4276;
	Tue, 11 Feb 2025 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJAoyxJh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC7C1E3DEF;
	Tue, 11 Feb 2025 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237503; cv=none; b=K+3pGp5uabIOTJf5R8Nolykfj6wMn2x0ezgVmg/FevTyyQfhf/aIv25X2p7r0ZH8c9r2IcjnQWUiWoZATdwn3OAiPZu9rOnTGazIWkPL0gZ4HzErjVLM5F8lPTpkvg+qutQsgG1fMTSZfFWxAtKa65gNOTJ75gxDvh0jMOH6hkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237503; c=relaxed/simple;
	bh=7bMjJEnwl4VKz9B0kjecL5TqCguIfjhP5xC90w54YSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ArfTEraXHueZCpT6eMtvvYaOk3zqwPaxcKAiqstiW/em2QT+yVfccyjGQhmbFgrVGT5kjJmdrzvQyk1qIfHSak4v4loCyG/c3z1VSGlKZEyq/G6baIakU9OT91r5mb7YjfFdLEiif9sj1H+0IqX+eMeazEc7jRu/ZByNzZuhYN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJAoyxJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B1DC4CEE7;
	Tue, 11 Feb 2025 01:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237502;
	bh=7bMjJEnwl4VKz9B0kjecL5TqCguIfjhP5xC90w54YSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJAoyxJhc8LIBuNComBF+gt0JBxzuzJXyzsTJdhWQTjfVMN9077y+oN/MKOkktOaZ
	 kUn+T4CALT9Taaoc4artNZVrF7SDbJvsgdX1/WB7A6QSm3cllpi0bg8u/wofiJQLaz
	 uNfGdOCnuYDfQesCcB7oT4VKmyau4whYZ4be28yQdadXldb2/n0/z0TOvaLl8WLe+K
	 3vb8SdKordnUTcvtd9wZzPF+qKPinX9H5eWynTWjPLRfkPY+zoX8bIOLP6ORCIxa5G
	 etV0UTTEdqjflbgCBNkhZZUewm2ZJQ5CwOO/m0uJbiZ7tIIMF/adSFA5noHbtOUgby
	 32WywAO7xqhhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/15] powercap: call put_device() on an error path in powercap_register_control_type()
Date: Mon, 10 Feb 2025 20:31:24 -0500
Message-Id: <20250211013136.4098219-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013136.4098219-1-sashal@kernel.org>
References: <20250211013136.4098219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.76
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


