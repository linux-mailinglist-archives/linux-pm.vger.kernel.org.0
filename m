Return-Path: <linux-pm+bounces-21760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F13A30013
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 02:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582003A3979
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 01:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A9E1D5CCD;
	Tue, 11 Feb 2025 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fErnIBQ4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789281D5AD4;
	Tue, 11 Feb 2025 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237401; cv=none; b=ekDXoMSyTj04Lnl6qN1CsM4lF6dSAC8a8lvqh9XkBCYnGx/MXi2/SGIgksMordQL/iE5lawc5TKZWeYm++TDS0NlOI3t1aRtOtoM/RVE1/YdC+8FW93GuC7qyQPKKqlvg/VsdlHLb4EnHNE8YfBiqTFnvdO31Xz625T6UnXzcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237401; c=relaxed/simple;
	bh=7bMjJEnwl4VKz9B0kjecL5TqCguIfjhP5xC90w54YSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scmWOpnXMVs+XvgBzfdCcTrx2iNLoSP9ZWKDRRv4RIMbax6da2tPmKjSHrnOXin2v6jBp/+toQocnjI/KHJIaZ5cK8UgJK92vQ/m/Ga8zA9m1GgB2D86XRlL2pzOT81MZMfut50qPuyQLuR6AlzV1sxuAinJ9CqUJEMPccgbJhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fErnIBQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8326DC4CEE9;
	Tue, 11 Feb 2025 01:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237401;
	bh=7bMjJEnwl4VKz9B0kjecL5TqCguIfjhP5xC90w54YSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fErnIBQ4CbH/Pq3bHTf5PdCSJL2xp9vuCjJIz8neZ/KTHMlP23842isdQzVo3b9Wx
	 JtQ1zbnIO8K2NT4WY6/crAe1GqnCLfFRceSwGqyFaCs6/ysyL9G4y9oG0lVhpVW5JA
	 mewVNLcm6FrVYXMG9esArbIktQY1+H2MKftf/0g+1NXSC+GnTmcGsrK3YfMHeTRkxZ
	 f9txIa/hJTYesCKWRRacCJ14Ah8FTH6sUnwchJ9Ql5phq8F1PDuhKgoKHLVzK7ta4L
	 flB9a01mht0gesYyQV4doGXKfkEayQWO8Sjwet6AS6CUDMs/z8Ladq+LdYPmQwIv8m
	 AHMffRqDewLng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 04/21] powercap: call put_device() on an error path in powercap_register_control_type()
Date: Mon, 10 Feb 2025 20:29:37 -0500
Message-Id: <20250211012954.4096433-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211012954.4096433-1-sashal@kernel.org>
References: <20250211012954.4096433-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.2
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


