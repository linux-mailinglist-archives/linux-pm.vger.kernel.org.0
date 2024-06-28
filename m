Return-Path: <linux-pm+bounces-10175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 926D291BB63
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 11:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478A42816C9
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96B314F9FF;
	Fri, 28 Jun 2024 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="f5yVTrbR"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934A14E2F9;
	Fri, 28 Jun 2024 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566745; cv=none; b=q6zzdQU3+OuERjivGgUYB18ZTJ5oWvrdnyA3d/Znzf7nsAzbeWTBwELjNzD4gNZzajIvS1Ma13ysAiywlX0C9fgj/DsZ65O6wvCYLD3akdxqdnoNrHragUSgOvnc14kHHjSUxjxjymZhNDW1U6Khlpr0yIUfBW5mBqtIYe8gSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566745; c=relaxed/simple;
	bh=i6a7e+6oMEh5oVQk0M7eXRa11SAzrIujkHbXYKmD/Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxR1Opfx6gJKBPoZBJ2AayDdD2tHnsxsWjNj/xNCY5L6tcmwazledjEEjb7idlvUQMCiQTgWmtPF2w8qZ3fx5F3w66z/keP0/baFvTNFElLYhPd3rK2VnolJJQI3MzwKpJ7mOq3qKQdLNdf2rXZ2W0e1VI/KB7LSvv9gf98/5ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=f5yVTrbR; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
From: Daniel Hejduk <danielhejduk@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1719566732; bh=i6a7e+6oMEh5oVQk0M7eXRa11SAzrIujkHbXYKmD/Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f5yVTrbRmX7QKafpL3yN3KNEkAGJ/cXb0U77I1tASEYH4gLC2FK1+IiNTYXQxnTy5
	 S+NJYJ/igjDfLZzcI5DZiHsKn9HlGCDcwj5/tXNeintX4HPnV/m4EnFZSOCbMcq0mE
	 rUUhjaFA1qomrxtd7UaUQK5irvOuZ+wYT/Q3IPkUarAwsue5ETcWreemlyXPgpyuXu
	 qXaWbClxjVBPYHfe1XUtJqf1E+5HPPtazvBUi3HPGLJ+ze/16aXEN9KNGJfTI88SPs
	 Kn/q00soke6EZxHCW5XvxbUYCSWbVXxv5QwpYxqIaEP+4RqEWPPMBPYDqhhGZt4OBA
	 /HzhWUZbEIUyw==
To: shuah@kernel.org,
	trenn@suse.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Hejduk <danielhejduk@disroot.org>
Subject: [PATCH 1/4] Signed-off-by: Daniel Hejduk <danielhejduk@disroot.org>
Date: Fri, 28 Jun 2024 11:25:01 +0200
Message-ID: <20240628092508.3664-2-danielhejduk@disroot.org>
In-Reply-To: <20240627135437.2301-1-danielhejduk@disroot.org>
References: <20240627135437.2301-1-danielhejduk@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Updating maintainer of the translation.

Last update to the po file is 5 years old. I will try to complete and
maintain the translation.
---
 tools/power/cpupower/po/cs.mo | Bin 0 -> 12805 bytes
 tools/power/cpupower/po/cs.po |   6 +++---
 2 files changed, 3 insertions(+), 3 deletions(-)
 create mode 100644 tools/power/cpupower/po/cs.mo

diff --git a/tools/power/cpupower/po/cs.mo b/tools/power/cpupower/po/cs.mo
new file mode 100644
index 0000000000000000000000000000000000000000..e82a23760d4f26a628d9402f84c20bfda1df4263
GIT binary patch
literal 12805
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

literal 0
HcmV?d00001

diff --git a/tools/power/cpupower/po/cs.po b/tools/power/cpupower/po/cs.po
index bfc7e1702..64fe78861 100644
--- a/tools/power/cpupower/po/cs.po
+++ b/tools/power/cpupower/po/cs.po
@@ -4,14 +4,14 @@
 # Copyright (C) 2007 kavol
 # This file is distributed under the same license as the cpufrequtils package.
 #
-# Karel Volný <kavol@seznam.cz>, 2007, 2008.
+# Daniel Hejduk <danielhejduk@disroot.org> 2024.
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


