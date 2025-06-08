Return-Path: <linux-pm+bounces-28225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4BAD13A7
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4011889887
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396E513B58A;
	Sun,  8 Jun 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAfahP8r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14351C2FB
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406734; cv=none; b=DcL2m6T+1gHS/bFX+litYaFc4vGtGPkLELjBhDV+SFC2P5NCSVkMgSr/GPP+b8u3vXhFXcP915KhtZxihs24+aXswx4pjbpuODe+C/pH/M1ffmJ3JcxTgKzu6zjpDMQqtQtY9/RdSUkyCxDT7UaLob4COX71Il4eRUdeZr/bqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406734; c=relaxed/simple;
	bh=TzPAXw+/RhtZ3FoAPXLvpkw33nxw6MiWnFaSUC4gXho=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Gxey23c+yEuFBwZvAU/EsNHvBlbmReMUoAKN/DBUsgd3NA9liRLIk203tkyDi8yYxwISo6yo1hEfTCWgXeZVRuMeEAYaH/qngwx5avQpRP5m2epjWA1UXwP3/dxGjcKJBNgO0P8GlOEYTiPKCWQc5PdiMD8/Dsx3GdyLoSbRnHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAfahP8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DE3C4CEEE
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406733;
	bh=TzPAXw+/RhtZ3FoAPXLvpkw33nxw6MiWnFaSUC4gXho=;
	h=From:To:Subject:Date:From;
	b=YAfahP8rLt12o5ni7oyEvXa248cKFhIU4oVolJC2VtDr23hQZGL1efxdqbpFcJQ1W
	 6nO7u+mPi5ATZwGiwJzvYRV5uBH2yZ/MR9vA44hgtTt2Invjef949hZIG3LNMhavGj
	 c/5XAoJJLvVwBTuw3GZ4pHaD1uZjN+bcHzINu7z0orbMrebz3vMCJnVeRhh0S+MUxR
	 tgJkobUkLuNJf885FMcCSKZoVnTF/7H6/8wSYuviEbnef/V82cZXjy4+g0wPpfmtk2
	 iT3rJLdlM3wF0N28DQNSMTgKs02wvAPgsRhUwIU2qvspmYvNKQ+tupL0XCvxC4pDtf
	 McZms/boq8p6A==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 0/18] turbostat v2025.06.08
Date: Sun,  8 Jun 2025 14:16:59 -0400
Message-ID: <20250608181849.569543-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please let me know if you have troubles with any of these patches.

thanks!
-Len


[PATCH 01/18] tools/power turbostat.8: fix typo: idle_pct should be
[PATCH 02/18] tools/power turbostat.8: pm_domain wording fix
[PATCH 03/18] tools/power turbostat: Add Android support for MSR
[PATCH 04/18] tools/power turbostat: Fix RAPL_GFX_ALL typo
[PATCH 05/18] tools/power turbostat: Fix AMD package-energy reporting
[PATCH 06/18] tools/power turbostat: Always check rapl_joules flag
[PATCH 07/18] tools/power turbostat: Quit early for unsupported RAPL
[PATCH 08/18] tools/power turbostat: Remove add_rapl_perf_counter_()
[PATCH 09/18] tools/power turbostat: Remove
[PATCH 10/18] tools/power turbostat: Remove add_msr_perf_counter_()
[PATCH 11/18] tools/power turbostat: Introduce add_msr_counter()
[PATCH 12/18] tools/power turbostat: Clean up add perf/msr counter
[PATCH 13/18] tools/power turbostat: Allow probing RAPL with
[PATCH 14/18] tools/power turbostat: Avoid probing the same perf
[PATCH 15/18] tools/power turbostat: Dump RAPL sysfs info
[PATCH 16/18] tools/power turbostat: Add initial support for DMR
[PATCH 17/18] tools/power turbostat: Add initial support for
[PATCH 18/18] tools/power turbostat: version 2025.06.08

