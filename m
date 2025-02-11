Return-Path: <linux-pm+bounces-21767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D455EA30106
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 02:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4495C1888088
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 01:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACD226A191;
	Tue, 11 Feb 2025 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z01XuxD/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005AC1E9B2A;
	Tue, 11 Feb 2025 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237592; cv=none; b=SJ7HzKijqvdhTHIAF8GmIrwqbq0a3z2Uv3NHpW9KW7mFdExGGxxRqVxeFVcTQXIBOp7vyM0zbKR6Wtk4+baxbGqEs1xaooSYSvrRpgjCuzrBAaaD/4w3g66aFJNLbU74OYv+RYlayh7Mg2SLgSQ8ruI3yJKteykVOSWtRrldS3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237592; c=relaxed/simple;
	bh=yjSVntJ6iXt8W9c259Qi78e29HqQPMM1IRfLfxua9SM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J5axwaGeTTHYkbsriD8LxbqPoj6AZMslgJVspSAnszG4vkloycsI0pk0l8XJNm/sEM4xxcutIzuzMJqCUdc48pBpjOKlnUL6AKTJd5uKtr4+ukXJxnBpVbrIPge/rioDS5JiUyC+/ESprlO3TuykQnW0avV7kB2pC+2QIQaUTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z01XuxD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A69C4CEE7;
	Tue, 11 Feb 2025 01:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237590;
	bh=yjSVntJ6iXt8W9c259Qi78e29HqQPMM1IRfLfxua9SM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z01XuxD/V2cYcGw6xDpuOdjLWkQah7shlwkIgkIjv+fnEerGb3u9D2lEfvDQkgLi7
	 wy+zGbFDY2Y5MM1SCKlrJVWEQwnE64fn1WiOzLFqXYUOBLDp2gWa8VFlnUXvmnRxCn
	 fo3Qwo9t7Uf0fCDYR7J4okYQCWrrjByoy5fY5T6D97cYxdQhEbckQUZJdyYj5p9Vsa
	 iiKFXBMuUEJv+Cutr03PUaaayKd+iAk9klrL0vf3cNapgHXBRQAUgMiN5hy/iQsGx8
	 +qWRGKBrRJxCqPhYFLO2y5fJylS6j1hwdmsUCVZWdG3BEUCslxkGA+rA+hYFO/yq8x
	 DLWvR6w+77wrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/6] powercap: call put_device() on an error path in powercap_register_control_type()
Date: Mon, 10 Feb 2025 20:33:02 -0500
Message-Id: <20250211013305.4099014-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013305.4099014-1-sashal@kernel.org>
References: <20250211013305.4099014-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.290
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


