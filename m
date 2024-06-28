Return-Path: <linux-pm+bounces-10204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3D191C515
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 19:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F211F23677
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C701CCCD9;
	Fri, 28 Jun 2024 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="fRio3MUp"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D91CCCBA;
	Fri, 28 Jun 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596682; cv=none; b=lbzRcVgVbuSf9z5C9gyTV0xPc9MC8TLKfL3sV/c+Tq5Ev6BUnbw9dB2jAw2yNNHjUdC0H8BxeJhNyFPa2sM6UF8jucpK/1yPZH3mOl7PDDszZ5oDT+ZeOEYTbwyeRI2b+xlD2fym5mhIB0KsiH6zLn6MS1mDyU1zfZ8IF/6GCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596682; c=relaxed/simple;
	bh=+T6vuJ7iezUMDlkpEHzJA01ybZ/rO6HF0l1ITPdouvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jY5Omh43/qGR81GSAeJuBOLDzA+h+E+exCVqkQa0CPXAuX+Zm5HTz6O0Hwal/eixwuccWaqQVNaA/umfUJbGX1TeiiGOqi5VPyzAs59wwqx7q3RW41jng07W7r0UraPl6g3AHni+Pm5Aw9YIQ4rJmGKdC+D4LST7UuAHCGBKj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=fRio3MUp; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
From: Daniel Hejduk <danielhejduk@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1719596677; bh=+T6vuJ7iezUMDlkpEHzJA01ybZ/rO6HF0l1ITPdouvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fRio3MUptAUlM/W+6vjWorCtusOw2OEPHqaQot1EoDUYj6QvC6FE/FejVGnkEzGFA
	 rlHn8LyTqEPGaHu7AUc/IWtQJufppM9ddbBJSx1DqHBndqC4NU8C0FWTAxHJieXFcc
	 M5NbWn6Rop1fJRCTlQVST53EnhcSsYN1q3MQRp5g5a6HJ1XqgVClvwSYHhaWv9UxdE
	 fF9w3diw1uhkdDfUpI7V29yOB4q8WaIe4Wp747lJY/68j+B45EmuVQ5AKuEuzWXcf0
	 IT6tkPrH/8kyoA7Kaint/ldeWQwrcE5CInrdbIX7LTmboCLvEi8tQ4sctXzpcVUccg
	 HdhdFhbMGlmbg==
To: shuah@kernel.org,
	trenn@suse.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Hejduk <danielhejduk@disroot.org>
Subject: [PATCH 1/3] Updating cpupower's Czech translation maintainer
Date: Fri, 28 Jun 2024 19:44:16 +0200
Message-ID: <20240628174420.5370-2-danielhejduk@disroot.org>
In-Reply-To: <20240628174420.5370-1-danielhejduk@disroot.org>
References: <ba4d74fd-6762-4e9d-8346-5f3384cb60ce@linuxfoundation.org>
 <20240628174420.5370-1-danielhejduk@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Czech translation is not maintained. I will maintain it.

Signed-off-by: Daniel Hejduk <danielhejduk@disroot.org>
---
 tools/power/cpupower/po/cs.po | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/cpupower/po/cs.po b/tools/power/cpupower/po/cs.po
index bfc7e1702..8956f00bc 100644
--- a/tools/power/cpupower/po/cs.po
+++ b/tools/power/cpupower/po/cs.po
@@ -1,17 +1,17 @@
 # translation of cs.po to Czech
 # Czech translation for cpufrequtils package
 # Czech messages for cpufrequtils.
-# Copyright (C) 2007 kavol
+# Copyright (C) 2007 kavol, 2024 Daniel Hejduk
 # This file is distributed under the same license as the cpufrequtils package.
 #
-# Karel Volný <kavol@seznam.cz>, 2007, 2008.
+# Karel Volný <kavol@seznam.cz>, 2007, 2008, Daniel Hejduk 2024.
 msgid ""
 msgstr ""
 "Project-Id-Version: cs\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2011-03-08 17:03+0100\n"
 "PO-Revision-Date: 2008-06-11 16:26+0200\n"
-"Last-Translator: Karel Volný <kavol@seznam.cz>\n"
+"Last-Translator: Daniel Hejduk <danielhejduk@disroot.org>\n"
 "Language-Team: Czech <diskuze@lists.l10n.cz>\n"
 "Language: cs\n"
 "MIME-Version: 1.0\n"
@@ -217,7 +217,7 @@ msgstr ""
 msgid "Report errors and bugs to %s, please.\n"
 msgstr ""
 "Chyby v programu prosím hlaste na %s (anglicky).\n"
-"Chyby v překladu prosím hlaste na kavol@seznam.cz (česky ;-)\n"
+"Chyby v překladu prosím hlaste na danielhejduk@disroot.org (česky ;-)\n"
 
 #: utils/cpupower.c:114
 #, c-format
-- 
2.45.2


