Return-Path: <linux-pm+bounces-30541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C68AFFCA9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 10:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769F7561DA8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199B228C842;
	Thu, 10 Jul 2025 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5myfMHL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E500228373;
	Thu, 10 Jul 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137018; cv=none; b=qg9CbY9YXk/lKAAm92StVqo6u5x1eguHmlWl0fea04RiNhieNPcgVIwZxd8+tXhRW4aP8EdO7sUYFsPopSAJRRA4m0lQYtPj+K38WLTpq+KKCyvUcz8G1UybzWyU9ighrcYsd4/Z2TeRvDQezlmuxGao23yBgKadSj9hSWWcEGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137018; c=relaxed/simple;
	bh=PxguUBGo6Ik3PJKiPYuQhRYnBpgQXurtIzAQciEWTGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KfVobiugg0I1dbeyGKbLTLfJu5SEimJSz4EnOSNMKR9PdzYkN3wsLLg9Y3Q9dtwK+9raVFRn3xPi1ms5ZnneH3y9bgO/3c0+WWh/al7tN60VVeUbx2PnokBNCflgP1MinzXff59a22t6q5ltzg6T87MqSRIXMEHUBxSLzwLzQOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5myfMHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DD3C4CEE3;
	Thu, 10 Jul 2025 08:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752137016;
	bh=PxguUBGo6Ik3PJKiPYuQhRYnBpgQXurtIzAQciEWTGU=;
	h=From:To:Cc:Subject:Date:From;
	b=F5myfMHLlxb4xZv+TcOR3ES9BqoMawRrL0u0ewTjAFUSvZKqXyVlFRALfOSygPW9P
	 3pf8LvPQ+1VxwP6pY7Y56WusT10j34PkvsK8oEoekN2eaS+vVcz2w1UoFd2m3KxcYb
	 UyfPJqOVQDdXSgmNn2wnRYGfL4q7Ab6W7W1qErT33taJNFmgvQIbFIH9jlCq4eCkwv
	 SbZ1boLxJpa1MMltp4v7Aj3H+aUkLYoBpObjYeHwb8c1jbHlXe4HdMBFeN70u76xlg
	 2j6/STQHqLpBpx9fuYODUFmyL3CBxe/O+x8kE6HoO+c+5c5hRm9vjD3B2Q5FINFYy8
	 MAfHTuNqqkHfw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1] PM: suspend: Drop a misplaced pm_restore_gfp_mask() call
Date: Thu, 10 Jul 2025 10:43:26 +0200
Message-ID: <2810409.mvXUDI8C0e@rjwysocki.net>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The pm_restore_gfp_mask() call added by commit 12ffc3b1513e ("PM:
Restrict swap use to later in the suspend sequence") to
suspend_devices_and_enter() is done too early because it takes
place before calling dpm_resume() in dpm_resume_end() and some
swap-backing devices may not be ready at that point.  Moreover, it
is not even necessary because dpm_resume_end() called subsequently
in the same code path invokes that function again.

Drop the misplaced pm_restore_gfp_mask() call from
suspend_devices_and_enter() to address this issue.

Fixes: 12ffc3b1513e ("PM: Restrict swap use to later in the suspend sequence")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/suspend.c |    1 -
 1 file changed, 1 deletion(-)

--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -540,7 +540,6 @@
 	return error;
 
  Recover_platform:
-	pm_restore_gfp_mask();
 	platform_recover(state);
 	goto Resume_devices;
 }




