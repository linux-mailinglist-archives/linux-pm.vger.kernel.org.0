Return-Path: <linux-pm+bounces-21765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C07A300D6
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 02:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60E2161358
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 01:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946EB2638AA;
	Tue, 11 Feb 2025 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQxSJGrh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84D2638A0;
	Tue, 11 Feb 2025 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237555; cv=none; b=Nf68KfxEldunPV8PKfSR9o1t/o1vdqGrmZU80HjXSOxFykC5n8N1c4iFEqD4ti45D8oBMAgNyft0igaGNUMJdWbZTLKQp2ufP7/DqeGr686Js6rxxZW+GkETscI99kaYzd3mjGXLdnApbIQYUHYNBroWZoruY15mKsfwKyYVxTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237555; c=relaxed/simple;
	bh=yyyMrPUwTP4pP3Bs1bNqgH5jsxA27ztwNAhxHKaphEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZ1j/o/kn+Vp1g7NRE1N/ybdoVuerp0YIu7541+fw+7f5kKwx1hrLwKqsZ+1Hv5B60JuwUyazyM9uREdqdmdsC2kNdPSP3GElCIU5qf0BdF5Q5RhobsP3KWBrtA+djtoiO0y+npGcivJFRMNHJefsK/Ra0eRoMK/Z87r2ikRYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQxSJGrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81065C4CEE8;
	Tue, 11 Feb 2025 01:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237555;
	bh=yyyMrPUwTP4pP3Bs1bNqgH5jsxA27ztwNAhxHKaphEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQxSJGrhG2ujcikyJFvUS9h0txfGDI/Wrads0Flml90XmuZenJkxa5aWm7QUqozPn
	 pSdI6KeO50WnIIUSgbK1Mw44SVHYxNRmCnNlYmx6Rf7VR0rmqO0zoMY+u1NORb70lp
	 Xh0vJ60O5gMsI3tEQIaxomWF0COMYWNTej2fWr4kY26fUFW4q9u/7WW74gYF4xZeRL
	 tHnwyuJyxygsbpaa8U1g9hUqJPOAVNiyXFfRxETT6ddVYqLhJ1bGsvsD2C4sjoJ15O
	 CGl7B+qgZrHfaTbzkVOpY0XrvF9ChLPhuLSl0MnLDxZAHDWi48IrHqfDYZALLfRcSs
	 i13UzY2zW6yWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/9] powercap: call put_device() on an error path in powercap_register_control_type()
Date: Mon, 10 Feb 2025 20:32:24 -0500
Message-Id: <20250211013230.4098681-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013230.4098681-1-sashal@kernel.org>
References: <20250211013230.4098681-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
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


