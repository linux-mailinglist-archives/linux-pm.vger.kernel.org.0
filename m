Return-Path: <linux-pm+bounces-36847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2CDC0AB9D
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 15:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162EF3B3545
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 14:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934FB2E8E16;
	Sun, 26 Oct 2025 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uV7V880A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E912EA46C;
	Sun, 26 Oct 2025 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761490291; cv=none; b=IBL5CRjKLDOohYhRQxIiIq/jHVohpvIH2dQyAWSxsj7rJDqD+PQTu40ELue5e1vHMxDHEiIb8ZiKn4Kd5LOLYNzYSMs1fn0mrciy2qIGFSuwoM0X0g/n5+j3xdIEeyHco4EXsjnOaGC6lihATVaVQndsnuqWeXmpZSrmDjg+2YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761490291; c=relaxed/simple;
	bh=2LNrlr2NJQ/6/20IkRMA1LsvtOwIVBAiLkqj8lj80Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RegcWzCSxjXURT1xj7U3QLUtLsZC1XTN32nB3DkE3aKwMZXdfJ9VGNGa61TUYoMtWvBpIZdSpuU6onpe75b5imL0Nf/FCwc2nmjzAJADIXd68HoBHOghxZxvK+y/FVRBcunw75CmJfz7d4mzCPx1P21w6KdkIxIZmWbmzsNYyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uV7V880A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D5FC4CEE7;
	Sun, 26 Oct 2025 14:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761490291;
	bh=2LNrlr2NJQ/6/20IkRMA1LsvtOwIVBAiLkqj8lj80Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uV7V880AUghjTcFaI/0dNtfe9HQ7mJxwNxjg6rbaa1lZvrezvJxQ2M7KlxLcRh+w+
	 LRMdl+lq37PgpY6OcO2jBGj3GZ6KU2WMHamwoELJ3UXctEgQUKwvQmMidVw6zICXtT
	 LVgPRtziAWdUROokR4+Os489hZJq+tm98KkoPl4UpXcswImkhAYHqKdEyELq1ix+fH
	 Lgm/oDEEBg6emQKl7AOjM7nGkQ5KN/Uf5/75iIABmwB8Fn9sBrf9GFUFIhE056rK7H
	 z9Rz7Z0z+ZxLFuXKf4rQTa0fWCGQzRnY4R9J2ltB2xIG3LQmrIFwAJwb7bXw5WGsT8
	 8QzTrq7oL4KIw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] tools: lib: thermal: use pkg-config to locate libnl3
Date: Sun, 26 Oct 2025 10:49:21 -0400
Message-ID: <20251026144958.26750-43-sashal@kernel.org>
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

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit b31f7f725cd932e2c2b41f3e4b66273653953687 ]

To make libthermal more cross compile friendly use pkg-config to locate
libnl3. Only if that fails fall back to hardcoded /usr/include/libnl3.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- `tools/lib/thermal/Makefile:49-52` introduces `NL3_CFLAGS = $(shell
  pkg-config --cflags libnl-3.0 2>/dev/null)` with a fallback to the old
  hard-coded include path. This directly addresses the existing build
  bug where cross-compiling libthermal forced the host’s
  `/usr/include/libnl3`, ignoring the target sysroot supplied via pkg-
  config; without this fix the library fails to build in cross
  environments, so it repairs a user-visible build break.
- `tools/lib/thermal/Makefile:66` now appends `$(NL3_CFLAGS)` into the
  compilation flags, ensuring the pkg-config-provided include directory
  is actually used whenever available. Because the fallback still
  supplies `-I/usr/include/libnl3`, the default on native builds is
  unchanged, keeping risk minimal.
- The change is tightly scoped to the userspace `tools/lib/thermal`
  build logic and mirrors the pattern already used elsewhere (e.g.
  selftests’ Makefiles rely on `pkg-config` for libnl), so it carries
  very low regression risk and no architectural churn while fixing a
  real build issue.

 tools/lib/thermal/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
index ac918e98cd033..41aa7a324ff4d 100644
--- a/tools/lib/thermal/Makefile
+++ b/tools/lib/thermal/Makefile
@@ -46,8 +46,12 @@ else
   CFLAGS := -g -Wall
 endif
 
+NL3_CFLAGS = $(shell pkg-config --cflags libnl-3.0 2>/dev/null)
+ifeq ($(NL3_CFLAGS),)
+NL3_CFLAGS = -I/usr/include/libnl3
+endif
+
 INCLUDES = \
--I/usr/include/libnl3 \
 -I$(srctree)/tools/lib/thermal/include \
 -I$(srctree)/tools/lib/ \
 -I$(srctree)/tools/include \
@@ -59,6 +63,7 @@ INCLUDES = \
 override CFLAGS += $(EXTRA_WARNINGS)
 override CFLAGS += -Werror -Wall
 override CFLAGS += -fPIC
+override CFLAGS += $(NL3_CFLAGS)
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
 override CFGLAS += -Wl,-L.
-- 
2.51.0


