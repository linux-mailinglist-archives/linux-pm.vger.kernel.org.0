Return-Path: <linux-pm+bounces-6074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB8989CF5D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF891F248CB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1E5382;
	Tue,  9 Apr 2024 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ4ZpFzW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0965663C
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622707; cv=none; b=AzlrHDQEYlHSErwQabE9GvgwY6j6GCuI/h5l/dESyfGjRqYBrjzPZGriLo82X3eS0Rb4g/dY99eMUm17pWc6WS9zrbMKoI8YdCS4QHVwWwWmgMHKWY+6gycVI0qTdH4KZ3kakDlmceh47UwcUmbCS+nwq5uhFk6zskZON1zXhtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622707; c=relaxed/simple;
	bh=NsqnX681j7O112UO6rRXOw7GmGTFuMuzYPb611YjYNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=USceAcdTuB9hdgSFedeqiGPXgNOPAw/PXR74oARNEHUUj28Akzskw6v0t331we6PBxKEWz58DtPfur3Nr5ij0yczFde1IjYRT5Ugj0vvy1PLGJ/XiHsfTuCzrgkxjbbR6jyhfgdHjwtiEzHC1wPp0Wi4Dz63QGHemI27KHnKg6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ4ZpFzW; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-ddaebc9d6c9so4498736276.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622705; x=1713227505; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWv7YaPT+AQc6ZDleo+YgSH84ys8lUqrs8eUMiDH/18=;
        b=GQ4ZpFzW6lmX4TleNboED3OGd2CclXG323iHO8hWPSY75heKocFwe4KRAVy5RA4SKF
         F6hza3YrrPd/lEb9z4zr2GziUeDKEddbLCTnj0xyyzaI7b9tZF6oFNky2EdB5dlMp0Rd
         C/F8ng2JxFlKJQOmGsczn1HnP/ZKdiC2HTp9zCpgPtBs9Hp/BZfeY62pTq80dbatdkA2
         deqLnqNnRarQWCLTgPi0mKiZuKsFgauZiWeixYL6C7eHL3Z4rAiLAyUPti9oRxQtOXdb
         Cy6mnFwZbV22Vir+C8Ed4Rw7sMk1RvDMoZyvW6jh6Ug8ctipPbJoPHf37+kvw9/OEoul
         Lmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622705; x=1713227505;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWv7YaPT+AQc6ZDleo+YgSH84ys8lUqrs8eUMiDH/18=;
        b=l/et0yCkgPSy1zu/LGxmQqyDDKTAo5zom0b3zzP6JtFznJtqwkHcOLFNXh7hoM2WbJ
         KMqdWUoLWbVj3hQkkvfF9U16wERkutdML7INgTFjk6WmpV2z6tFm5jAhENKKLwZdNvbJ
         ekHqr4cUAsokUWulFXn5y2xL6qblLtLYu7fBJxJldRf0qSmvUcSHkaTlVvaH7shbMRaQ
         Iu4YD1VD7pZbi8ApbiIRr83T+Zxr2obHs4WmTTYwf1Rn8sE6ndYkzm3KLEv1JAHnAbab
         GYFpE4OF1GH82f+9H0Kwyp2sqzFIL160r8Bfqh8KO8Wv4jo9TUMmqVdvCm+fqJzFCohM
         90ww==
X-Gm-Message-State: AOJu0YxhPMs/8d55/WFtajGO5bp7pQJD5IkueTQSOcv5CcH635myBTcl
	EJL97Mq4MUjoCxDizNYVErtgEnUfhfB22pq2kth8ndwbhxo4QujSufMs7iY5
X-Google-Smtp-Source: AGHT+IHGromULSOLPoYt12dN/E5DAgg8qnRy+0YPLb9ExDv1bdByzrA2YMTazpiP8tFGd4Ir8oYgGA==
X-Received: by 2002:a25:4ac3:0:b0:ddd:72ab:233e with SMTP id x186-20020a254ac3000000b00ddd72ab233emr7808349yba.54.1712622704693;
        Mon, 08 Apr 2024 17:31:44 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:44 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Wyes Karny <wyes.karny@amd.com>,
	Doug Smythies <dsmythies@telus.net>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 02/26] tools/power turbostat: Increase the limit for fd opened
Date: Mon,  8 Apr 2024 20:30:56 -0400
Message-Id: <3ac1d14d0583a2de75d49a5234d767e2590384dd.1712621427.git.len.brown@intel.com>
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

From: Wyes Karny <wyes.karny@amd.com>

When running turbostat, a system with 512 cpus reaches the limit for
maximum number of file descriptors that can be opened. To solve this
problem, the limit is raised to 2^15, which is a large enough number.

Below data is collected from AMD server systems while running turbostat:

|-----------+-------------------------------|
| # of cpus | # of opened fds for turbostat |
|-----------+-------------------------------|
| 128       | 260                           |
|-----------+-------------------------------|
| 192       | 388                           |
|-----------+-------------------------------|
| 512       | 1028                          |
|-----------+-------------------------------|

So, the new max limit would be sufficient up to 2^14 cpus (but this
also depends on how many counters are enabled).

Reviewed-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index fca7913f6c84..2550a0e35914 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -53,6 +53,8 @@
 #define	NAME_BYTES 20
 #define PATH_BYTES 128
 
+#define MAX_NOFILE 0x8000
+
 enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
 enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC };
 enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT };
@@ -6705,6 +6707,22 @@ void cmdline(int argc, char **argv)
 	}
 }
 
+void set_rlimit(void)
+{
+	struct rlimit limit;
+
+	if (getrlimit(RLIMIT_NOFILE, &limit) < 0)
+		err(1, "Failed to get rlimit");
+
+	if (limit.rlim_max < MAX_NOFILE)
+		limit.rlim_max = MAX_NOFILE;
+	if (limit.rlim_cur < MAX_NOFILE)
+		limit.rlim_cur = MAX_NOFILE;
+
+	if (setrlimit(RLIMIT_NOFILE, &limit) < 0)
+		err(1, "Failed to set rlimit");
+}
+
 int main(int argc, char **argv)
 {
 	int fd, ret;
@@ -6730,6 +6748,9 @@ int main(int argc, char **argv)
 
 	probe_sysfs();
 
+	if (!getuid())
+		set_rlimit();
+
 	turbostat_init();
 
 	msr_sum_record();
-- 
2.40.1


