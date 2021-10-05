Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5EE421DBE
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 06:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhJEE4y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 00:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhJEE4x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 00:56:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551DFC061745;
        Mon,  4 Oct 2021 21:55:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so1456372pjb.0;
        Mon, 04 Oct 2021 21:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODryz1qJ3820wCAnBD88fIGS778Gw9beQmeRzHAzA2U=;
        b=g9xB7GlYHu2zTrwZGEsY4vvTVTqfoSUvZe6hnqP96mXCPXMO96JMU+sM6dTGFiNkdw
         64o7ox6MpN096O7j/nw8LINyawvf1++a/uQPiBEvzwwpYd9dqmgwtmFcXTWsbiTmL7cT
         SiqTaHwh1PLPZIKieiIYOIU8gzX0iGMkMKGIzKi8qBoWE/CxxGhkwdXlOuOYu67Pk944
         ypscLHvaa/ctVUiUoQPUuhWfUDqR/4FjaCllsnl+uSHA0O2sghPkv19zAPvehEUNNw7T
         jnEzLbxHug2y+DDyfr5pla2Lxo26yaW+k/JEVotqmCK8+is3QIEQxnNSgTLTRXaGocHh
         UGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODryz1qJ3820wCAnBD88fIGS778Gw9beQmeRzHAzA2U=;
        b=PHmvxD6ASMccMlTJ3Rf8GGCqgsg/XQo8wCc85e6gl64yvGKtmijF+IGKknzGFTHyqI
         1ja2KDDhXN1/BEw6X482POCpZfzqM1RtGXvSHmPsnjsgD+iVpOwrwvMhKv5LuUTpl9eL
         nD6eznNBJD17ccF2h6ce5qOp3lJb71kjXRdBnNpIDf64k+E8axjtxXeDmw9OOLYVIkvu
         pEU66o6vaJSf7MekReKu6KX6Fxwl05jEy6QfYEjiIvXsn0R1rdEcLB+/VVMISnSMTguZ
         AkOfC5jSk6Wjuo1o+sceThWsl/F6RM7fGHKYKlcFF+yr1natlajgZ5AS0ok0amJUm7pl
         hiTQ==
X-Gm-Message-State: AOAM530Lz0WOnbCCJD7rsIhXxQrbockkY/dpDr/70NQppXxdU8DQBm//
        X7Erbe7THgHKTDqgt1RG5yDoGg2sgs9Duw==
X-Google-Smtp-Source: ABdhPJxO77NQAfQW/Gd82O28mevcw2/I0pRjEyDvMxP1JZJMaDQkunNP5wCj3C2PcNjC2vZarIUMWw==
X-Received: by 2002:a17:902:e153:b0:13e:90b3:8b87 with SMTP id d19-20020a170902e15300b0013e90b38b87mr3267117pla.77.1633409702519;
        Mon, 04 Oct 2021 21:55:02 -0700 (PDT)
Received: from unconquered.home.aehallh.com (24-113-252-168.wavecable.com. [24.113.252.168])
        by smtp.gmail.com with ESMTPSA id q18sm19554786pfj.46.2021.10.04.21.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 21:55:02 -0700 (PDT)
From:   "Zephaniah E. Loss-Cutler-Hull" <zephaniah@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Zephaniah E. Loss-Cutler-Hull" <zephaniah@gmail.com>
Subject: [PATCH 2/2] tools/power turbostat: Allow printing header every N iterations
Date:   Mon,  4 Oct 2021 21:54:39 -0700
Message-Id: <20211005045439.1430114-2-zephaniah@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005045439.1430114-1-zephaniah@gmail.com>
References: <20211005045439.1430114-1-zephaniah@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This gives the ability to reprint the header every N iterations, so you
can ensure that a scrolling display always has the header visible
somewhere on the screen.

Signed-off-by: Zephaniah E. Loss-Cutler-Hull <zephaniah@gmail.com>
---
 tools/power/x86/turbostat/turbostat.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f5d634ee5fee..b3f5a21a845a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -48,6 +48,7 @@ struct timespec interval_ts = { 5, 0 };
 unsigned int model_orig;
 
 unsigned int num_iterations;
+unsigned int header_iterations;
 unsigned int debug;
 unsigned int quiet;
 unsigned int shown;
@@ -722,6 +723,8 @@ void help(void)
 		"  -l, --list	list column headers only\n"
 		"  -n, --num_iterations num\n"
 		"		number of the measurement iterations\n"
+		"  -N, --header_iterations num\n"
+		"		print header every num iterations\n"
 		"  -o, --out file\n"
 		"		create or truncate \"file\" for all output\n"
 		"  -q, --quiet	skip decoding system configuration header\n"
@@ -1394,14 +1397,14 @@ void flush_output_stderr(void)
 
 void format_all_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
-	static int printed;
+	static int count;
 
-	if (!printed || !summary_only)
+	if ((!count || (header_iterations && !(count % header_iterations))) || !summary_only)
 		print_header("\t");
 
 	format_counters(&average.threads, &average.cores, &average.packages);
 
-	printed = 1;
+	count++;
 
 	if (summary_only)
 		return;
@@ -6334,6 +6337,7 @@ void cmdline(int argc, char **argv)
 		{ "interval", required_argument, 0, 'i' },
 		{ "IPC", no_argument, 0, 'I' },
 		{ "num_iterations", required_argument, 0, 'n' },
+		{ "header_iterations", required_argument, 0, 'N' },
 		{ "help", no_argument, 0, 'h' },
 		{ "hide", required_argument, 0, 'H' },	// meh, -h taken by --help
 		{ "Joules", no_argument, 0, 'J' },
@@ -6415,6 +6419,15 @@ void cmdline(int argc, char **argv)
 				exit(2);
 			}
 			break;
+		case 'N':
+			header_iterations = strtod(optarg, NULL);
+
+			if (header_iterations <= 0) {
+				fprintf(outf, "iterations %d should be positive number\n",
+					header_iterations);
+				exit(2);
+			}
+			break;
 		case 's':
 			/*
 			 * --show: show only those specified
-- 
2.33.0

