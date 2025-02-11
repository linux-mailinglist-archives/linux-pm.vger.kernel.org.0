Return-Path: <linux-pm+bounces-21764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0520A300B9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 02:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCAD16316F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 01:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EC722068A;
	Tue, 11 Feb 2025 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WepTNoQl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B821E0BC;
	Tue, 11 Feb 2025 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237532; cv=none; b=V0oAP7Yj2A1y5lOI9/dP6iyxIy1RH7d8HtImN6owN7Y11zQSNpQs693ukg1uQnG2YX2N9DXEfthnP2VMDl7jXtohL5Et+hL60hkp0HG8WKQfLGiZUSb5rP3Kxk7WRW+Xiie0tdIxhub2dvEehu7lcXytzPBRWKEUgqMtldCALyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237532; c=relaxed/simple;
	bh=yyyMrPUwTP4pP3Bs1bNqgH5jsxA27ztwNAhxHKaphEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CfeCu2/nEaRbOx1stRC6JPRT0/CxZNmsMnxCtAK24W+dyrj5DbOLrRh9jlaLW8I5f/hL3Zp6oVRGnMqrYNCZ61w8WXkN6basRaorZ+OL/LAfIYrAdQ875GWtFfirx8juMrOLWbtlfdZS6k4scs8pJJq6Z2TWhrbZFYGcjA/n9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WepTNoQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6847CC4CEEA;
	Tue, 11 Feb 2025 01:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237532;
	bh=yyyMrPUwTP4pP3Bs1bNqgH5jsxA27ztwNAhxHKaphEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WepTNoQlIkgFXTpuh3o4I8mb/3THk+mSHezGzo3Cf5nQYwao0GnT9E/X1wKHLmoAO
	 t2mzY+mq2kXHcNPpxFQc/jARPVCxuTVaWwGe9BVqLKtC0hWJswx6y/53xgiR36xhlw
	 zPnkM7v0bPDxAnBNpQzWhTSDwcMTO4049wvSGuCyuiCRZTHwfhO/smyPr+SSJkN7wl
	 FtDv1JNjOEdfjwpAMFSlFjO5jn4fhzvorL3/uLG40ytLam4bixPnd+rkf+ThQ21j+6
	 IWpTxp8jlEhkHgJZMkpWb+7ncThNUOGs3ue7Df4ESw2z+zH3JrOi0/BGMtoITx2ui0
	 L+wcGwA8nBkDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/11] powercap: call put_device() on an error path in powercap_register_control_type()
Date: Mon, 10 Feb 2025 20:31:58 -0500
Message-Id: <20250211013206.4098522-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013206.4098522-1-sashal@kernel.org>
References: <20250211013206.4098522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
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
index ff736b006198f..fd475e463d1fa 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -626,8 +626,7 @@ struct powercap_control_type *powercap_register_control_type(
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


