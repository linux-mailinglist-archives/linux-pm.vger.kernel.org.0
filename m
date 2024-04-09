Return-Path: <linux-pm+bounces-6088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBD189CF6B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D292F1C2083E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88C410F2;
	Tue,  9 Apr 2024 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdo+ivwL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469056FD5
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622720; cv=none; b=czSX58yUzbyqhiQxyFu5sQ5F2x4AxuKUEnn9f5PCD2qTeYBU/lyTYksxePC/oxrBXIH+P+VdUToBmR4vLhgz21UTcA0eCOd4qy54BYfi8G6NFz7MAZCc2qVoQ1T9z1LLA95+ilRVDHMNskVWs+wOlP12NpD1rX8BzpyXNqjeJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622720; c=relaxed/simple;
	bh=QcsR8GFLLUcoEwCTy8OquTANzpK2tV93+W+zUjPvIz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F73n/r4+c0BaZps5ZPE550eOzDAMD5XPNIOrajk7CIScuzITdD1+BTVqBwA1/yCFqe+8lY2saJBpqEBLWDcl3hTBVxHYZH0mISSh6qy7vdd+yR10s/SCDgzwrqjTasRiNO7JJjsBpDsIkr23TMb3s9K+7tSXBFcoUMqpOqSF9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdo+ivwL; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so5134494276.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622718; x=1713227518; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QmnEMEsjHYE22TmDe1imfSPWxSpKz0iav82ZtHiWfiE=;
        b=bdo+ivwLTSXRalNdMgZTlzjsRt+GNnWq+qud23K9+A52LauVF/2XSvvVXcKlvH/oro
         3R7l1qHJ1AiHOJkipfftMw052rG88fk/T78TX3wUUGxch44EpkIfp/1s+FAFGaaqANIE
         T0bSR7JrHp/f4ql7KmlPDP6joc1FAc5t+yDuVfhFLISfEpXHPnf79hOpHpgqfrMO4hgA
         Oi/QkmVzo0PwuMAPi+8SB/6ogLRfEeAwMQ0gxwBKBwTb3nmo6+IOifGIMzP1AQq/VuUc
         48BwzPc9Nh+/jXw8L4vDmk202pJxRtI33hHIcyM3qVx3llFQ5SikPXainvYy5m9TL/Py
         WJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622718; x=1713227518;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QmnEMEsjHYE22TmDe1imfSPWxSpKz0iav82ZtHiWfiE=;
        b=oaz/CRf191zr5bpAJAkF/H3RJaxoGCnFivu1J+XYvAl5E2zuErqWwphhOsF9M4IC2r
         y+b8d4ocey5hMHyqdkQ5hPNijZQiybMuuEpKHNidIoXKwVxLFfsY41N+l97d0qzXcnrK
         E0QhShL+sqdD/CIBUeBjTIYJjcxwqPU711nexcCZ/BwAwKsMr9iXIvSXWlZLykzKRoMf
         gw74DwYSqhiq7iXZW0Q9i+nDE+Rdd5cVGCFafdS94u+0hIYaANIu00mqVcBYj38XELuy
         e2ZbA84104FFsowcjJXvNAH1N0vcYqjWULQnxMlTm4ZLIlF6AZTcrxaxMTE2inUdEcXA
         1bJA==
X-Gm-Message-State: AOJu0Yyv19UEwhxJH0+JeU61GsQ4PWx4nLCmuBUNyrk9/0Kga4deSCVJ
	Eec6b2hPpcJKBGrp8x+R8P0OkHMclnfjeBlcYiNCNjD7wh2rUCssn2qFRCH0
X-Google-Smtp-Source: AGHT+IHWwFO1FTUooUqwmycfKnAZxaMrILDpG7YGbSmY5XIBlSUKPkEYeOPPoktzP+JlkqUcQXFYTA==
X-Received: by 2002:a25:ed07:0:b0:dc7:48f8:ce2e with SMTP id k7-20020a25ed07000000b00dc748f8ce2emr7790310ybh.37.1712622717997;
        Mon, 08 Apr 2024 17:31:57 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:57 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 16/26] tools/power turbostat: Add proper re-initialization for perf file descriptors
Date: Mon,  8 Apr 2024 20:31:10 -0400
Message-Id: <ebf8449caba1df2eb6ba0b465fe15dc06d3b9135.1712621427.git.len.brown@intel.com>
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

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b4a892bf22bf..a380829c5890 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3669,18 +3669,25 @@ void free_fd_percpu(void)
 {
 	int i;
 
+	if (!fd_percpu)
+		return;
+
 	for (i = 0; i < topo.max_cpu_num + 1; ++i) {
 		if (fd_percpu[i] != 0)
 			close(fd_percpu[i]);
 	}
 
 	free(fd_percpu);
+	fd_percpu = NULL;
 }
 
 void free_fd_amperf_percpu(void)
 {
 	int i;
 
+	if (!fd_amperf_percpu)
+		return;
+
 	for (i = 0; i < topo.max_cpu_num + 1; ++i) {
 		if (fd_amperf_percpu[i].mperf != 0)
 			close(fd_amperf_percpu[i].mperf);
@@ -3690,6 +3697,21 @@ void free_fd_amperf_percpu(void)
 	}
 
 	free(fd_amperf_percpu);
+	fd_amperf_percpu = NULL;
+}
+
+void free_fd_instr_count_percpu(void)
+{
+	if (!fd_instr_count_percpu)
+		return;
+
+	for (int i = 0; i < topo.max_cpu_num + 1; ++i) {
+		if (fd_instr_count_percpu[i] != 0)
+			close(fd_instr_count_percpu[i]);
+	}
+
+	free(fd_instr_count_percpu);
+	fd_instr_count_percpu = NULL;
 }
 
 void free_all_buffers(void)
@@ -3733,6 +3755,7 @@ void free_all_buffers(void)
 	outp = NULL;
 
 	free_fd_percpu();
+	free_fd_instr_count_percpu();
 	free_fd_amperf_percpu();
 
 	free(irq_column_2_cpu);
@@ -4067,10 +4090,13 @@ static void update_effective_set(bool startup)
 		err(1, "%s: cpu str malformat %s\n", PATH_EFFECTIVE_CPUS, cpu_effective_str);
 }
 
+void linux_perf_init(void);
+
 void re_initialize(void)
 {
 	free_all_buffers();
 	setup_all_buffers(false);
+	linux_perf_init();
 	fprintf(outf, "turbostat: re-initialized with num_cpus %d, allowed_cpus %d\n", topo.num_cpus,
 		topo.allowed_cpus);
 }
-- 
2.40.1


