Return-Path: <linux-pm+bounces-27085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4FCAB5A7B
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 18:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008A6170776
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1752A1DA31D;
	Tue, 13 May 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="IXcKLsMY"
X-Original-To: linux-pm@vger.kernel.org
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA000645
	for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154722; cv=none; b=kkxBVVnWd+K3q23FA0wFHhQSF27mRTeHQ8BWbuZOQtZeo9GVdNUdUEdGJGxJp7iCOj/Wy1YO13XKkXiTuFlmz52K/Ua5Jd4CQmCbsSW8/7vXGWtDimIDYbgQ20sO/svH82Bf+YG2znLoDwPhd73VEG01vhEgibC8TLFuDvaILpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154722; c=relaxed/simple;
	bh=njIzucSmzmIxTnajmetVrrjPJeE3qLTqesqBsT525I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhIYvJ/o1dQt+h1gYiXUrF+uBwrSHPnpaBGrMURpUNkYdlXclWiHhPXCLtBXoK/teTb+bLJJpG01vNeZPIIIiNYOXgqL2EK6c8mc1mHeZ8fgrUcQV0kK304Qt7snBvMAYsYSufYI67h6Ddq8PzqxsENd6VbHuVO4M7ueFH1TuXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=IXcKLsMY; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1747154716;
	bh=6Lt7NBxPwYNy6JNOB51hq3BllvsubtABLTk9iZlS/bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXcKLsMYzx7CaHI6wtXkaewcmaKNeKyGx38iCtDB4e4FmusF603oOCBMuLSo3sFT1
	 upLwVHjxhJ7ffBPrzBMeiGfwT8OfOc4HzTZ9VoR+QDUP9EHkA1ovbQvqBPWkAB+m4w
	 OEUM1rsMgvuf8hul/GHs7ykJ9eepQRUSbPXd9CJc=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4Zxj585k8lz6xfk;
	Tue, 13 May 2025 16:45:16 +0000 (UTC)
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4Zxj585Dcpz6vQ1;
	Tue, 13 May 2025 16:45:16 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1uEskl-00000000Gn8-2zW8;
	Tue, 13 May 2025 18:45:15 +0200
From: "Francesco Poli (wintermute)" <invernomuto@paranoici.org>
To: linux-pm list <linux-pm@vger.kernel.org>
Cc: Francesco Poli <invernomuto@paranoici.org>,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Justin Forbes <jforbes@redhat.com>
Subject: [PATCH 1/3] cpupower: do not write DESTDIR to cpupower.service
Date: Tue, 13 May 2025 18:29:31 +0200
Message-ID: <20250513163937.61062-3-invernomuto@paranoici.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513163937.61062-2-invernomuto@paranoici.org>
References: <20250513163937.61062-2-invernomuto@paranoici.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the use of DESTDIR variable in the Makefile, as far as the
installation of the systemd service unit 'cpupower.service' is
concerned.

This was caused by a misunderstanding about the purpose of the DESTDIR
variable in the Makefile, which is instead meant to support staged
installations: its value should not end up into installed file contents.

Link: https://lore.kernel.org/linux-pm/20250509002206.bd2519ba52035d47c3c32aa6@paranoici.org/T/#mfbb938f9c0d5a21173acb92a061eb9205fd0abfe
Link: https://www.gnu.org/prep/standards/html_node/DESTDIR.html

Fixes: 9c70b779ad91 ("cpupower: add a systemd service to run cpupower")

Signed-off-by: Francesco Poli (wintermute) <invernomuto@paranoici.org>
---
 tools/power/cpupower/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 9c2b5f71fee1..4ad931509eaa 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -310,7 +310,7 @@ install-tools: $(OUTPUT)cpupower
 	$(INSTALL) -d $(DESTDIR)${libexecdir}
 	$(INSTALL_PROGRAM) cpupower.sh '$(DESTDIR)${libexecdir}/cpupower'
 	$(INSTALL) -d $(DESTDIR)${libdir}/systemd/system
-	sed 's|___CDIR___|$(DESTDIR)${confdir}|; s|___LDIR___|$(DESTDIR)${libexecdir}|' cpupower.service.in > '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
+	sed 's|___CDIR___|${confdir}|; s|___LDIR___|${libexecdir}|' cpupower.service.in > '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
 	$(SETPERM_DATA) '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
 	if test -d /run/systemd/system; then systemctl daemon-reload; fi
 

base-commit: 99d2fce9b44dec6d270b85a7d28cdc99aaa93da6
-- 
2.47.2


