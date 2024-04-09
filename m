Return-Path: <linux-pm+bounces-6078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB9A89CF61
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA511C23F13
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4046210E6;
	Tue,  9 Apr 2024 00:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acgMAU3N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF515C9
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622711; cv=none; b=NA6STnG+b+GC5jNkPpWGE/fn6qxclGSLiCf3abxca2eWv4vMiVcZF12XgPM1Qw29GCu5XBpnEWTXl/w7DZPY5Vl88Hcb41fGo/4LV3t8G0XLx2n0++FitS2OhkPPTWT2u52MEA4xIdtW22oBu5vhxcHVtx8YGedgN1P4VjqvOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622711; c=relaxed/simple;
	bh=g3RVByLQ+8Bh54XgLofEREcrGbS+XvId+H7AKRjdoV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lhg6LfqgS8U9BBxGjt+RT0YiQ5hjSHh4Pjk96yGpqtxNfLra0t5Noe576Z7tW+LOwb29/OYR4ra0C3ZwGaoTctJ36ifUs53L0g59mywcC779U8X41W2cpkvNq6IMftkgkE+7eANlRzx52uZvM+MbagK0PnRjUPFjtUit8hgFLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acgMAU3N; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso5205443276.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622708; x=1713227508; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFIxVyrsUDEXGio/9XkcU04zv3Ref9GoDK/AocRFr34=;
        b=acgMAU3NYzKyz8VumLZ2bGGfEVb4STTY0CcF+4GpyyyDdHmyb0hhYKAHLgj4YJB1gu
         qb6inQ9wiGWk+8MmX7gDWnyNa3Osf6x6t1RL4zCTaPHryDB0lLZzcU3uzT8OzdtujOzc
         lFu+QkIi+mCT8MrW/W3477zd5gJ3o0TzEzPDO9tzJEO5x0G51/pgjV76hpwehukZF2o1
         /i2PGwjlLQyPgeTc/F6Qp6oZD6wVn1TBFqLtHhgiyatH7KvMb52AnyPF9SrbFhTJKHQ/
         KpIQSThQmrxbrnWa68u6iHEmmJA9vSRMPxMVfhjDNDgVZVTcY8MhsgUHDemWgKy1m2jJ
         wXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622708; x=1713227508;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFIxVyrsUDEXGio/9XkcU04zv3Ref9GoDK/AocRFr34=;
        b=TQs3hgZrsxrkswsTrHoVGeEIPyceemuLKc2hR3pxmIH2k5bG7nRD7+oKhCxC0xmnBA
         RmpW9RBLKlZv3gnLWUVd8tCrUEnpn2dkF6MAqtOKB9b9gTKY2Agn2fpxOI63UCcseu+8
         nXAaDKANtRB8wyDDZvFDwYEBgPBchiKfK3hNn/n5IbmHI2D82IXxLxg3eSHqoSACfbTt
         LTcve7xegJwJPSbpN+nvGcrxVcZPyjORhhxCOPBR3kMByEYpMSCGtkBZs/heoktm4nq7
         OkMIW4dxjm+nFMUpMBG0cHmZ/qp0UxrPK8PQSEDhMhDr2doM7aEqZ7E42vb2E0sQlf/0
         g6jQ==
X-Gm-Message-State: AOJu0Yyc1Z+45f6cObtAilyWD6zMbCDYPFH36t1UwR1psYrLfaPmHiSa
	6rHF4FIWxkBXQjgDD6CBkCC/sDWPpB1VD3EQ3dF2XtVkZe2LVT2qRIxBN/Dz
X-Google-Smtp-Source: AGHT+IGWCYmW3QWvDGFfjvuj85iSPiAQ5SOMN6mBOagwJq4xByBspSFMuEs5b/wMTCR9nUoOL7swSg==
X-Received: by 2002:a25:ab67:0:b0:dc6:57d0:ac9 with SMTP id u94-20020a25ab67000000b00dc657d00ac9mr8645601ybi.6.1712622708202;
        Mon, 08 Apr 2024 17:31:48 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:47 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 06/26] tools/power turbostat: Print ucode revision only if valid
Date: Mon,  8 Apr 2024 20:31:00 -0400
Message-Id: <fb5ceca046efc84f69fcf9779a013f8a0e63bbff.1712621427.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
References: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

If the MSR read were to fail, turbostat would print "microcode 0x0"

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bbd2e0edadfa..a4a40a6e1b95 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5679,6 +5679,7 @@ void process_cpuid()
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int fms, family, model, stepping, ecx_flags, edx_flags;
 	unsigned long long ucode_patch = 0;
+	bool ucode_patch_valid = false;
 
 	eax = ebx = ecx = edx = 0;
 
@@ -5708,6 +5709,8 @@ void process_cpuid()
 
 	if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch))
 		warnx("get_msr(UCODE)");
+	else
+		ucode_patch_valid = true;
 
 	/*
 	 * check max extended function levels of CPUID.
@@ -5718,9 +5721,12 @@ void process_cpuid()
 	__cpuid(0x80000000, max_extended_level, ebx, ecx, edx);
 
 	if (!quiet) {
-		fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x (%d:%d:%d) microcode 0x%x\n",
-			family, model, stepping, family, model, stepping,
-			(unsigned int)((ucode_patch >> 32) & 0xFFFFFFFF));
+		fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x (%d:%d:%d)",
+			family, model, stepping, family, model, stepping);
+		if (ucode_patch_valid)
+			fprintf(outf, " microcode 0x%x", (unsigned int)((ucode_patch >> 32) & 0xFFFFFFFF));
+		fputc('\n', outf);
+
 		fprintf(outf, "CPUID(0x80000000): max_extended_levels: 0x%x\n", max_extended_level);
 		fprintf(outf, "CPUID(1): %s %s %s %s %s %s %s %s %s %s\n",
 			ecx_flags & (1 << 0) ? "SSE3" : "-",
-- 
2.40.1


