Return-Path: <linux-pm+bounces-36845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B34C0AB7B
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 15:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B8E18912D9
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 14:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FBD2E9EC2;
	Sun, 26 Oct 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOCya6fO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF712E8E05;
	Sun, 26 Oct 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761490279; cv=none; b=DCgbJ4MSXLL3Lw4mMpmRE50FS8kj8jD9xMetgZ6nxd7SvCB7Y8RkxnJrIrin/adOseylAaycaNAKOD6Y2uMx1Kv8XJ0xjo/kVPiyOLPJ/7/tud8B/VV3dr158vLdM1NgW7gObe94onMAelkUdg87v1HFwQycgjTrvgXdQo2IWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761490279; c=relaxed/simple;
	bh=SYV9eyovYulD064QVE+2/waqUfi+lusbdzAyC7ld0Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzH0uFZJOswmx5X76Mdkpr1Qpy0W7dUNpsTrVxIZS5nPNLhS9SBU4fJPcJhwxEMhQJ0W2qyZ7HnpHovQYbOGbHrBXx7L+HaHPF7Cb9rIuBFN2jl9FCfW+AJ05yZCz5/kbq0mnl07bsJnC0Ynd6LJrlhDdgR66Ie8YM5dbO8GIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOCya6fO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B8FC116B1;
	Sun, 26 Oct 2025 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761490279;
	bh=SYV9eyovYulD064QVE+2/waqUfi+lusbdzAyC7ld0Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gOCya6fODjpE5jkqZ2InsTR/qlFfjXFwjs9m5xEQnb6hXnAAscD9bdrnXu/jEk+vO
	 45fc8+kNmFy9oB+M8pZxm7Bi9TUmoHQ0DfNMBEhHsE7u4B9xv2ZuP4ihmWvYYZiwkL
	 9SH9XM0T+d5aGJh752qECqVFIpX3d6BQeyrvKTddWMpFLp2hBQC1RERqyrmxrNnpGK
	 D1bq7X4DyyeLex1f9Sp+hV/SvwuWOBkWdMlTCpFZLCc/InrA9kj7tW6/fPgKERsGS/
	 3SrA2G8Lhn/Ztq3P8uzUqj+T1AOt5/xc/vzPZKQRdEBodGLq5eS+qL6+/QU8E41IJG
	 /6nWL+HTX6nEA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Emil Dahl Juhl <juhl.emildahl@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] tools: lib: thermal: don't preserve owner in install
Date: Sun, 26 Oct 2025 10:49:14 -0400
Message-ID: <20251026144958.26750-36-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026144958.26750-1-sashal@kernel.org>
References: <20251026144958.26750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Emil Dahl Juhl <juhl.emildahl@gmail.com>

[ Upstream commit 1375152bb02ab2a8435e87ea27034482dbc95f57 ]

Instead of preserving mode, timestamp, and owner, for the object files
during installation, just preserve the mode and timestamp.

When installing as root, the installed files should be owned by root.
When installing as user, --preserve=ownership doesn't work anyway. This
makes --preserve=ownership rather pointless.

Signed-off-by: Emil Dahl Juhl <juhl.emildahl@gmail.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- `tools/lib/thermal/Makefile:142` switches the install step from `cp
  -fpR` to `cp -fR --preserve=mode,timestamp`, deliberately dropping
  ownership preservation while still keeping permissions and mtimes.
  That resolves the longstanding issue where `sudo make install` leaves
  the deployed `libthermal` artifacts owned by the non-root builder,
  which is both a packaging nuisance and a security footgun for system
  directories.
- The regression surface is tiny: it only alters a post-build copy
  command, introduces no source or ABI changes, and continues to require
  GNU `cp` (the build already depends on it for `-pR`). Non-root
  installs still behave the same—ownership was never retained
  successfully there, as noted in the commit message.
- Stable-tree criteria are met: this is a clear bug fix with user-
  visible impact (incorrect ownership on installed files), it is self-
  contained to the tools build machinery, and it avoids any
  architectural churn or new features.

Natural next step: run `make -C tools/lib/thermal install
prefix=/tmp/test DESTDIR=` before and after the backport to confirm the
installed files now come out root-owned.

 tools/lib/thermal/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
index a1f5e388644d3..ac918e98cd033 100644
--- a/tools/lib/thermal/Makefile
+++ b/tools/lib/thermal/Makefile
@@ -134,7 +134,7 @@ endef
 install_lib: libs
 	$(call QUIET_INSTALL, $(LIBTHERMAL_ALL)) \
 		$(call do_install_mkdir,$(libdir_SQ)); \
-		cp -fpR $(LIBTHERMAL_ALL) $(DESTDIR)$(libdir_SQ)
+		cp -fR --preserve=mode,timestamp $(LIBTHERMAL_ALL) $(DESTDIR)$(libdir_SQ)
 
 install_headers:
 	$(call QUIET_INSTALL, headers) \
-- 
2.51.0


