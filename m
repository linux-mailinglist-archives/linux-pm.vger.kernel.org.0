Return-Path: <linux-pm+bounces-11480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEC193E086
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657C7281E12
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377BE187340;
	Sat, 27 Jul 2024 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4/CtuGu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90448187331
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104818; cv=none; b=oik3shQEyvAJnrVPQrHOUAj4hbsZ+PxBydaG29k4+/4s1waMqTAI3ybxjTRqj/gYQAC6ttMxLGKhRaNZVsuIqMiC4h9jtO/d+jWI3lmz+vme0ePLF8c5OSSduguWd6oInwImzhjRpbi0iC5MJMvhxMrfnEDbBw9Gvgeg1uEDwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104818; c=relaxed/simple;
	bh=IIFpAJwNYV8QpywEO8KhHKeJJengft3XXYvf8vwBkAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSi3J4VIW/FKu7rpfMKY2fLCAJHNUOWhduHhZ4A2FoOF27Kq3lQ1d5TLjqmoeNnNbaRO4BGXwsbmfsy+M81OAO+uQhX+xayJAqpK/1BiORwkii889Bq6TBC8gnghZDUaoFWchp7m267QlgnVaD2zBMGsrHscb+DzAfMU98+OFrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4/CtuGu; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-260e1b5576aso1531412fac.1
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104815; x=1722709615; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8qG7JoCX2tMWNcvRRsqH9ez6+WghHNnVv08SxrCD30=;
        b=L4/CtuGuAoFywFkOaRikdxVof1Li8SN9rJppHGCVlUygIl+M8b7tqNcUzbp1n0Ot1H
         AoBXwh5MahsCPksyolzuKbZzhptOq/zKcH2q5kbyNlrlJiRbDGJY+M0Br7L+40cskl4R
         UarQLiLrvo09Qz5DC6ikj33Sro2DtSp97eSI1+EuRgYLK5AfZVHymI7g4xxzaarmBhAP
         K8VYuMqH3k+FnBV6qIGM1l990aBt6DFSipbuP0LqsyV4l1/SmGWLs2PgMubBNrsbH3VK
         BScZTZHqEz1xizjVAI0Qa0RWDctHcMniFfmABsYI/bhPB3YzikVl8Auq8MhCiuZ1jPA+
         htcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104815; x=1722709615;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8qG7JoCX2tMWNcvRRsqH9ez6+WghHNnVv08SxrCD30=;
        b=rq0yT8ddkzcSxcHUyr1oXgk1ntxN37i1sghX3mSqPM83fPvqcToK8FsK/gcMbWus66
         Mt1kvrxWhY6mtxBHjxGwUDaXkEuNyUtMtzaGuKfMF33u4jiPDj4PPBSibS6FUXtbYBN0
         dC0MOZeETwP28X+hHGQzAB1fzcRsxmoR/T9xjd68YwZgcbEFt4rzOyyU4fvHUA5epCX9
         YSOWZdwKaggX+9xcMVenhlsur4ixNj38AUfBe1Lzpqj1fXbnXlk/TXZI2/w/oIySrad8
         2XTNK2GH8MrSAhS4EBv8kGbFBMuBrHfRKJt2QjLTk+bTpoTJhc088yv5Lg18h3BBErSc
         9Kfg==
X-Gm-Message-State: AOJu0Yx4QzD1SOhmeWGYyH8+UDlX8TLbeD0nJ1YfOzrkPSIAz8SGbfD4
	Ln5JnJAAITMpR4Nbo2mBqGw4s15B0MZv3zTjO3rlDU2w8T+Uw0l4ROlIow==
X-Google-Smtp-Source: AGHT+IFeKvbqx9xGzrLii4aBzHSPlU02kvrvJEcLBdFSIoBwe143rup1AvnWm+lFcLag1U3VxLfNkA==
X-Received: by 2002:a05:6870:c112:b0:260:f24f:62d2 with SMTP id 586e51a60fabf-267d4d5dc22mr3947575fac.17.1722104815423;
        Sat, 27 Jul 2024 11:26:55 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:55 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 10/18] tools/power turbostat: Move debug prints from stdout to stderr
Date: Sat, 27 Jul 2024 14:23:36 -0400
Message-ID: <52e130764ab6bdc439bcf124ac3e15f52ca0c8e5.1722019621.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
References: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
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

This leaves the stdout cleaner, having only counter data. It makes it
easier for programs to parse the output of turbostat, for example
selftests.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index be345a4bbe96..cccd9f4311a0 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1984,6 +1984,7 @@ void help(void)
 		"  -c, --cpu	cpu-set	limit output to summary plus cpu-set:\n"
 		"		  {core | package | j,k,l..m,n-p }\n"
 		"  -d, --debug	displays usec, Time_Of_Day_Seconds and more debugging\n"
+		"		debug messages are printed to stderr\n"
 		"  -D, --Dump	displays the raw counter values\n"
 		"  -e, --enable	[all | column]\n"
 		"		shows all or the specified disabled column\n"
@@ -8262,7 +8263,7 @@ int added_perf_counters_init_(struct perf_counter_info *pinfo)
 			pinfo->scale = perf_scale;
 
 			if (debug)
-				printf("Add perf/%s/%s cpu%d: %d\n",
+				fprintf(stderr, "Add perf/%s/%s cpu%d: %d\n",
 				       pinfo->device, pinfo->event, cpu, pinfo->fd_perf_per_domain[next_domain]);
 		}
 
@@ -8422,7 +8423,7 @@ struct msr_counter *find_msrp_by_name(struct msr_counter *head, char *name)
 
 	for (mp = head; mp; mp = mp->next) {
 		if (debug)
-			printf("%s: %s %s\n", __func__, name, mp->name);
+			fprintf(stderr, "%s: %s %s\n", __func__, name, mp->name);
 		if (!strncmp(name, mp->name, strlen(mp->name)))
 			return mp;
 	}
@@ -8439,8 +8440,8 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 		errx(1, "Requested MSR counter 0x%x, but in --no-msr mode", msr_num);
 
 	if (debug)
-		printf("%s(msr%d, %s, %s, width%d, scope%d, type%d, format%d, flags%x, id%d)\n", __func__, msr_num,
-		       path, name, width, scope, type, format, flags, id);
+		fprintf(stderr, "%s(msr%d, %s, %s, width%d, scope%d, type%d, format%d, flags%x, id%d)\n",
+			__func__, msr_num, path, name, width, scope, type, format, flags, id);
 
 	switch (scope) {
 
@@ -8448,7 +8449,7 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 		msrp = find_msrp_by_name(sys.tp, name);
 		if (msrp) {
 			if (debug)
-				printf("%s: %s FOUND\n", __func__, name);
+				fprintf(stderr, "%s: %s FOUND\n", __func__, name);
 			break;
 		}
 		if (sys.added_thread_counters++ >= MAX_ADDED_THREAD_COUNTERS) {
@@ -8460,7 +8461,7 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 		msrp = find_msrp_by_name(sys.cp, name);
 		if (msrp) {
 			if (debug)
-				printf("%s: %s FOUND\n", __func__, name);
+				fprintf(stderr, "%s: %s FOUND\n", __func__, name);
 			break;
 		}
 		if (sys.added_core_counters++ >= MAX_ADDED_CORE_COUNTERS) {
@@ -8472,7 +8473,7 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 		msrp = find_msrp_by_name(sys.pp, name);
 		if (msrp) {
 			if (debug)
-				printf("%s: %s FOUND\n", __func__, name);
+				fprintf(stderr, "%s: %s FOUND\n", __func__, name);
 			break;
 		}
 		if (sys.added_package_counters++ >= MAX_ADDED_PACKAGE_COUNTERS) {
@@ -8617,7 +8618,7 @@ int add_perf_counter(const char *perf_device, const char *perf_event, const char
 
 	// FIXME: we might not have debug here yet
 	if (debug)
-		printf("%s: %s/%s, name: %s, scope%d\n",
+		fprintf(stderr, "%s: %s/%s, name: %s, scope%d\n",
 		       __func__, pinfo->device, pinfo->event, pinfo->name, pinfo->scope);
 
 	return 0;
-- 
2.43.0


