Return-Path: <linux-pm+bounces-21231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FD3A24F1F
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0AD7A22A6
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4051FAC52;
	Sun,  2 Feb 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij0eIol/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0971FAC34
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516387; cv=none; b=BFhSe6IJxnY1ByTVCrWh6qLu24SJ+ihdYtcbp33iIkt8GDN31hCvm/LDVpsf+SFOzopLtYlsniz3HIJd+KeJp2Sw7TgRD5bbTFoUZRHK5Ggb3/xgk3ntCm8NFnlChkzAvjfcWeRm0K14cfX+BHx3cZ68dgNUnlBwA3rb4EhkHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516387; c=relaxed/simple;
	bh=xz3ylO83r/1iuIodRRdE+lYtRBGpl+8bAhGm5AorPpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNA87pnbD1XiMBP66yUeVgoRNfFybIXnOa2bzNzi02ky7hyOua5pMd3wcnufUEtuC9hzySIhLBzGyyg0OIKFtfBCXoFQkj460iKEwlVZ98WE50rg4PfiqmZ3K9i3N+efeyvpO8vKIn+ZJYfId8GQ3L50TQgjhetITpU1wOqAUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij0eIol/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AD6C4CEE0;
	Sun,  2 Feb 2025 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516387;
	bh=xz3ylO83r/1iuIodRRdE+lYtRBGpl+8bAhGm5AorPpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=ij0eIol/NE+/561VbZkFxxnmdnJcDG3tr5fSwKbJ8DiVEESkgq84kx7LqX07XXt9S
	 RQFWuIA4SN2TnOX8Rm8pzU+GmvBigYH5jq55QZGr1sMy2BqZPfWJS9JewtHlpsYJPp
	 6g/eNVn6I+JKp1nVYyymZ1guxdIWf2pA8hFLfdGzhiW32S9jM3OiGen1Docz82Iyed
	 nnqgzTw+1Y4MQJAdnSha42y/qjuGIvxDX4S5ti7xf55pPMsXXZzrZcu7a//PB/9xal
	 Ze1FqxdGA2AVGQO80KpYGYDqlkoxmDf1yl8GvQiSxhjlVUQkjQesEGAe0VeTM07DB1
	 inHG5qwhYfVkw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: [PATCH 08/25] tools/power turbostat: add Busy% to "show idle"
Date: Sun,  2 Feb 2025 11:09:24 -0600
Message-ID: <05c14d8fd71b9c19391d0b4d65b1c1764e1c440f.1738515889.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
References: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Suggested-by: Artem Bityutskiy <artem.bityutskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 7accc4a73366..7a10e51a1349 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -270,7 +270,7 @@ struct msr_counter bic[] = {
 #define BIC_TOPOLOGY (BIC_Package | BIC_Node | BIC_CoreCnt | BIC_PkgCnt | BIC_Core | BIC_CPU | BIC_Die )
 #define BIC_THERMAL_PWR ( BIC_CoreTmp | BIC_PkgTmp | BIC_PkgWatt | BIC_CorWatt | BIC_GFXWatt | BIC_RAMWatt | BIC_PKG__ | BIC_RAM__)
 #define BIC_FREQUENCY (BIC_Avg_MHz | BIC_Busy | BIC_Bzy_MHz | BIC_TSC_MHz | BIC_GFXMHz | BIC_GFXACTMHz | BIC_SAMMHz | BIC_SAMACTMHz | BIC_UNCORE_MHZ)
-#define BIC_IDLE (BIC_sysfs | BIC_CPU_c1 | BIC_CPU_c3 | BIC_CPU_c6 | BIC_CPU_c7 | BIC_GFX_rc6 | BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_CPU_LPI | BIC_SYS_LPI | BIC_Mod_c6 | BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_SAM_mc6 | BIC_Diec6)
+#define BIC_IDLE (BIC_Busy | BIC_sysfs | BIC_CPU_c1 | BIC_CPU_c3 | BIC_CPU_c6 | BIC_CPU_c7 | BIC_GFX_rc6 | BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_CPU_LPI | BIC_SYS_LPI | BIC_Mod_c6 | BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_SAM_mc6 | BIC_Diec6)
 #define BIC_OTHER ( BIC_IRQ | BIC_SMI | BIC_ThreadC | BIC_CoreTmp | BIC_IPC)
 
 #define BIC_DISABLED_BY_DEFAULT	(BIC_USEC | BIC_TOD | BIC_APIC | BIC_X2APIC | BIC_SysWatt | BIC_Sys_J)
-- 
2.43.0


