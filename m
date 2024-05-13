Return-Path: <linux-pm+bounces-7771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2398C47B4
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA861284142
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A3A76C61;
	Mon, 13 May 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1/JqWPr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20B5768EC
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629272; cv=none; b=piEA/zDgrb/pin1vrRFmCSVud+ozmd4eckGGmPQVDhdEhqyiTY9R5nsJi5Kon6y6ljxU1SM+ZEdIL6R9vj0HDYTDNfhy/kcE6Dx8YiVRO4kCcF54bTYZohDhvTVlqVYrwzkJJ3hiyZn3W3Kpyhk17n2IrbVW4FEH8tFtJP8MC8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629272; c=relaxed/simple;
	bh=Xbm4rkGOwm1oWbFO2iAYFVjgKXPFYXhUfPzgee27iEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZL8VYe6kbpFCTPpNfNxM0HMn95C+GfyOnc2n71se1RGQdIkntJw7tNuwzCQSeVDWafZyzSfh17+jb+nUTWqgGg6ZzPmcN9jF23GB2WA+uclNIao5qzvILiAX1EFcfW1BDQ/X4fBPp2z4Cy5kkG7LaJvQ1aEeQnMTgbJl95vhBBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1/JqWPr; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-62036051972so53306017b3.1
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629269; x=1716234069; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cikk7vN4WIozqjdFoaZn04LVyi/C+q5ONZ4XMpBkOHk=;
        b=S1/JqWPruSWKD8pR77OyyoNNwXy8z0/O4MUHVT1yOTcT6UonnFUrNNfx0xAX8trImb
         KJlEu1lOL5IkjCOlXEWpkbrXxPPvEfDQ4s3K4MjQ8UenPr+YZlHGPiFmsy9QmcymRWx/
         Rj+HuxptwpRr+Kw8qiA/L9cuB5ZK4DIUIV807HmCopbz6Ld+yTWf/8b6G7bdWHp7ucrk
         /o9K2ih6HZ39GeEwX8dMpE81otchVF7NM2kY0WCatcC+RbLgNr5Mp0DzsdLL6UVB8Hk2
         uP1YA2OpAEb/PCO/ky3JDqXiyyq8f8LMX7Z/CTfJRbQt43mT1ztuu/hT9fMG86T9a/8N
         SVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629269; x=1716234069;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cikk7vN4WIozqjdFoaZn04LVyi/C+q5ONZ4XMpBkOHk=;
        b=W8YqSxV3+NOeozvcc3ZXQ5piS8ulSnr89jv1ZVjgiR7pDB1etx+E2nmrnbPK7urWV9
         rcst8NxZ7uAjxRPAg3Xvs4CTLFs48qsPoMdAoDuXLw+Az4bA2CIQEhvJ5LnEjMwymJJU
         wsJvxVRr5OMf9198SOB9fQydVGWEopJKZCWYd28REGONl9iChxY8/ggrJ0dWOGPKaGZU
         Np8V3OdzcPHog4yBjObz13Rbaiyamiqg/UnP6iRNsc4N8Kf3bjYvrVzjhzbOCyVIlfZa
         7Fhve6k6Mqet3w0zvKINm56IY9FDyVESnoGN0eVa6U8rPQ4FSxHmP7Hi7HTmYHAWjDYR
         XGAw==
X-Gm-Message-State: AOJu0YxfdgnEyfEl3wAIoy2CVd03VRjhGUbcAjSxi4rWUEhWekmnYzra
	N90N/vcIjemN3DwRuqL+47d/nXuX4mUU8iPA6JeDOckX3d/Yw/KXcpprCw==
X-Google-Smtp-Source: AGHT+IEmIDAv3vvUvIOQ35UmzA0dynn69Ad2j99B6hklLP4aF9nHpdYINtFjkbL4/wBhC5jf0OsqlQ==
X-Received: by 2002:a05:690c:88:b0:61b:2b7:27d8 with SMTP id 00721157ae682-622affdc90emr122927037b3.23.1715629269268;
        Mon, 13 May 2024 12:41:09 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:08 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 02/15] tools/power turbostat: Harden probe_intel_uncore_frequency()
Date: Mon, 13 May 2024 15:40:38 -0400
Message-Id: <ae3326ac5742506409a03ce5d69716a8dba4eabc.1715628187.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
References: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
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

If sysfs directory "intel_uncore_frequency/cluster00/" exists,
then use uncore cluster code (now its own routine).

The previous check for
"intel_uncore_frequency/package_00_die_00/current_freq_khz",
could be unreliable in the face of sparse die id's.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 98256468e248..ca33fb057d1f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5294,16 +5294,13 @@ static void dump_sysfs_file(char *path)
 	fprintf(outf, "%s: %s", strrchr(path, '/') + 1, cpuidle_buf);
 }
 
-static void probe_intel_uncore_frequency(void)
+static void probe_intel_uncore_frequency_legacy(void)
 {
 	int i, j;
 	char path[256];
 
-	if (!genuine_intel)
-		return;
-
 	if (access("/sys/devices/system/cpu/intel_uncore_frequency/package_00_die_00/current_freq_khz", R_OK))
-		goto probe_cluster;
+		return;
 
 	BIC_PRESENT(BIC_UNCORE_MHZ);
 
@@ -5335,9 +5332,13 @@ static void probe_intel_uncore_frequency(void)
 			fprintf(outf, " %d MHz\n", k / 1000);
 		}
 	}
-	return;
+}
+
+static void probe_intel_uncore_frequency_cluster(void)
+{
+	int i;
+	char path[256];
 
-probe_cluster:
 	if (access("/sys/devices/system/cpu/intel_uncore_frequency/uncore00/current_freq_khz", R_OK))
 		return;
 
@@ -5351,6 +5352,7 @@ static void probe_intel_uncore_frequency(void)
 
 		sprintf(path_base, "/sys/devices/system/cpu/intel_uncore_frequency/uncore%02d", i);
 
+		/* uncore## start at 00 and skip no numbers, so stop upon first missing */
 		if (access(path_base, R_OK))
 			break;
 
@@ -5382,6 +5384,17 @@ static void probe_intel_uncore_frequency(void)
 	}
 }
 
+static void probe_intel_uncore_frequency(void)
+{
+	if (!genuine_intel)
+		return;
+
+	if (access("/sys/devices/system/cpu/intel_uncore_frequency/uncore00", R_OK) == 0)
+		probe_intel_uncore_frequency_cluster();
+	else
+		probe_intel_uncore_frequency_legacy();
+}
+
 static void probe_graphics(void)
 {
 	/* Xe graphics sysfs knobs */
-- 
2.40.1


