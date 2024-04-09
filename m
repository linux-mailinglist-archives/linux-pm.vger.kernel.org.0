Return-Path: <linux-pm+bounces-6087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBE189CF6A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFE0284B74
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A694A2C;
	Tue,  9 Apr 2024 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4+Hm8ea"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5ED10F2
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622720; cv=none; b=fzi0T3oMWVy/lE6FDY4a5TIkLjQIugTfNFABcnBD7WpQDpUCxwTMfZZgUNmnzpzufS2a7nCf93hJrb45umbV0+xrEPBlEiMn95pm/daohhcTbLT3hV50oi1qDD4SCKTUEIIgtzmXfoPZ9VrHxOUGLDsCnq9D1eoyXRScRjwe69Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622720; c=relaxed/simple;
	bh=Wyf/xeYNMTebt+gtGkQivYTc22AFahIAjvMfUtiOVvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/LWOLkKONQL7goiWFxP7BWoriOytQb9qQIB3MMMLMhpo7QHZohTGxEibIN+vcl6tRilYzn6ZPc7vSJm/91nOJAHPjjRnpkVAa+9QLC7jqe0KccV6nZ7cvfUsk3cupoUxmKycPaKjOtdJxTJAN79iyvyPKhWdsO6Cjpr5sv6LFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4+Hm8ea; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso4741551276.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622717; x=1713227517; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6SxItsuR1lM8G3EGEqZ2t7EFKHGphQEmG5btbZ/69E=;
        b=E4+Hm8eaS+CwVurz+WJ6ok+xX8JW5hgRacfIPPpGcrnvbuztr5qXWLp1Ld+iKEFMh/
         FzQ9P0GWXofgLAIh0VG9QnkVwlNLkxM9JXpHnsRAfGCjvDKSYc8ysKPh/1gcnanPxZVf
         pcomqGBt1NjkLWrsipVtScYJqkzALqDD++JRcMwZHiFi+MoFZrMPSkMdGNU7UlYOYSV+
         HyzakLJ1toIHoQh1E5Z1vI25A31We6x1sL/wOINclL9zhcd39mV0LniKAbapQoOASTkk
         W+9073p8g+5CBHOzppVYrCf4V+iN45AdC2EXmqUxbS4CecetJjWxsD1OUIn0Vg8Ntyf3
         mRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622717; x=1713227517;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6SxItsuR1lM8G3EGEqZ2t7EFKHGphQEmG5btbZ/69E=;
        b=USMIbhy6RFDQH9t4DRGMY5okncSgIISXlGw3JmaNoii9BA1og85zCo6Js9PEHMIL40
         DvvKabXkJI0Yam9DpB+q73FpHqQEHmq6ZI9+9jMF/7W5YQrk5OovvbYgwfXxH4sF8llu
         WRy6c3novscaXBYypdYxEXYWRxF+qFAg6V3yEOmxAgXQAxDUnLGWlhBkH/bQQ4y2fPRv
         u4NIRRyamu1yKU7Rk1s84usOCgOqH9W6F4rD/dl4RFhPo6RWAYy2QsSB2vhHc7oaa0/h
         hDijbaggCszkXsOUma+2HqUYHwQpyoVAa6+Rk9TBa+gu6pX3kYMUZxTofJBaxgbwnHnw
         1brw==
X-Gm-Message-State: AOJu0YxDORVlaFp65B7tCvgQOl8BEYjEhzXcmlPLlv0uCh6bYZLWnIn+
	u+GUZlol+u9tnc8OnG5g86T8MAe8fO5PnfTx5+2bZSkMHQf3QitMM9m6Qalp
X-Google-Smtp-Source: AGHT+IFNeoDzjG4dMxN1SNGXTvfptxI+cl0D0lAf/vD7Ls+TMS0EWmFJvoHaSpenjXGouEepWsM1iA==
X-Received: by 2002:a25:952:0:b0:dcf:bc57:cd61 with SMTP id u18-20020a250952000000b00dcfbc57cd61mr8565044ybm.50.1712622717292;
        Mon, 08 Apr 2024 17:31:57 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:57 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 15/26] tools/power turbostat: Clear added counters when in no-msr mode
Date: Mon,  8 Apr 2024 20:31:09 -0400
Message-Id: <4a1bb4dad5d16669e841410944e7bc84ef7263fc.1712621427.git.len.brown@intel.com>
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

If user request --no-msr or is not able to access the MSRs,
turbostat should clear all the counters added with --add.
Because MSR access permission checks are done after the cmdline is
parsed, the decision has to be defered up until the transition into
no-msr mode happen.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 47 ++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e5e01b58992e..b4a892bf22bf 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1160,6 +1160,37 @@ struct sys_counters {
 	struct msr_counter *pp;
 } sys;
 
+void free_sys_counters(void)
+{
+	struct msr_counter *p = sys.tp, *pnext = NULL;
+	while (p) {
+		pnext = p->next;
+		free(p);
+		p = pnext;
+	}
+
+	p = sys.cp, pnext = NULL;
+	while (p) {
+		pnext = p->next;
+		free(p);
+		p = pnext;
+	}
+
+	p = sys.pp, pnext = NULL;
+	while (p) {
+		pnext = p->next;
+		free(p);
+		p = pnext;
+	}
+
+	sys.added_thread_counters = 0;
+	sys.added_core_counters = 0;
+	sys.added_package_counters = 0;
+	sys.tp = NULL;
+	sys.cp = NULL;
+	sys.pp = NULL;
+}
+
 struct system_summary {
 	struct thread_data threads;
 	struct core_data cores;
@@ -1315,6 +1346,8 @@ static void bic_disable_msr_access(void)
 	    BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_PkgTmp;
 
 	bic_enabled &= ~bic_msrs;
+
+	free_sys_counters();
 }
 
 static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu, int group_fd, unsigned long flags)
@@ -6601,12 +6634,24 @@ static void set_amperf_source(void)
 	fprintf(outf, "aperf/mperf source preference: %s\n", amperf_source == AMPERF_SOURCE_MSR ? "msr" : "perf");
 }
 
+bool has_added_counters(void)
+{
+	/*
+	 * It only makes sense to call this after the command line is parsed,
+	 * otherwise sys structure is not populated.
+	 */
+
+	return sys.added_core_counters | sys.added_thread_counters | sys.added_package_counters;
+}
+
 bool is_msr_access_required(void)
 {
-	/* TODO: add detection for dynamic counters from add_counter() */
 	if (no_msr)
 		return false;
 
+	if (has_added_counters())
+		return true;
+
 	return BIC_IS_ENABLED(BIC_SMI)
 	    || BIC_IS_ENABLED(BIC_CPU_c1)
 	    || BIC_IS_ENABLED(BIC_CPU_c3)
-- 
2.40.1


