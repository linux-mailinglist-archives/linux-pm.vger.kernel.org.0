Return-Path: <linux-pm+bounces-10176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C38591BB65
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 11:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAEB2281A38
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E2315250C;
	Fri, 28 Jun 2024 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="NcKm3GuY"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509FF142E67;
	Fri, 28 Jun 2024 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566747; cv=none; b=J6Rmnqk1cv7DoeM0C6uYjc32K2c9PG1MM2MrimVFP9Et8rC4Si43Duq7RHmn0kpDBtjSc+QhCMNuwdI0z482S29nK4d4rP8Wxacwv2gxTqjbvQUM2Yl6XN5DEj0wyAj4qv+SB3jQG16wjhjkpBO0n5iN3zgTSXa58DhGBaztloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566747; c=relaxed/simple;
	bh=p+9itOriD3JMz166j3OewbAwWqdhC+60tgGWWOsytto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOprM00vc2/NntcEsVnCX9kZC+ZRSscuheS0TqriBtnNc7RSuE8Oqp0ExIqMnmpxoY4yWQCs/fFW4iJkgBnk/t6lYB2SMM9B3TRGkO4rkgcCkCtvFcw4Upv+fL9wvRArfTuwlp8KDS/M4ZgbeJYB5LxWKOZkIHYNdxgaN+Agj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=NcKm3GuY; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
From: Daniel Hejduk <danielhejduk@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1719566742; bh=p+9itOriD3JMz166j3OewbAwWqdhC+60tgGWWOsytto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NcKm3GuYW8Dc/57ocwq9VrLVNzqapBg6hEUO+6/qTF+ZeuYBMaiyAzR9NgcigLysc
	 GNMUrrOItxM/cxGiGGHPxFBWuX/AwpSCfREyL8MKA0oSzepi9jfYMMu+l/A+cv8vTS
	 +mn14WMJADiWbu6CxShO9Q0eLWHmzubSS7zRW3NksfiSs5i0P7d1lh2UqBTKjXLmdA
	 4fo0GelxlLj+In63ZDb1rSLcLZK2S7FbEMtk3cdYMW6AVhBezILOjQ4FXJn/bqpBUS
	 EGw+q1meAvHjUbw+AeUl3uvCubjbCrQ8/LohBel9SmD4nIHT+CBIGnsBKmZUvEsRtx
	 qKdJNp5xZz3gQ==
To: shuah@kernel.org,
	trenn@suse.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Hejduk <danielhejduk@disroot.org>
Subject: [PATCH 3/4] Signed-off-by: Daniel Hejduk <danielhejduk@disroot.org>
Date: Fri, 28 Jun 2024 11:25:03 +0200
Message-ID: <20240628092508.3664-4-danielhejduk@disroot.org>
In-Reply-To: <20240627135437.2301-1-danielhejduk@disroot.org>
References: <20240627135437.2301-1-danielhejduk@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixing revision

Whoops I forgot to add the new date.
---
 tools/power/cpupower/po/cs.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/po/cs.po b/tools/power/cpupower/po/cs.po
index 8c6e254a1..0441b34f8 100644
--- a/tools/power/cpupower/po/cs.po
+++ b/tools/power/cpupower/po/cs.po
@@ -10,7 +10,7 @@ msgstr ""
 "Project-Id-Version: cs\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2011-03-08 17:03+0100\n"
-"PO-Revision-Date: 2008-06-11 16:26+0200\n"
+"PO-Revision-Date: 2024-06-27 10:49+0200\n"
 "Last-Translator: Daniel Hejduk <danielhejduk@disroot.org>\n"
 "Language-Team: Czech <diskuze@lists.l10n.cz>\n"
 "Language: cs\n"
-- 
2.45.2


