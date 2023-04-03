Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF4B6D532E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Apr 2023 23:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjDCVMC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Apr 2023 17:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjDCVLx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2023 17:11:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466E11FC2
        for <linux-pm@vger.kernel.org>; Mon,  3 Apr 2023 14:11:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id kc4so29321578plb.10
        for <linux-pm@vger.kernel.org>; Mon, 03 Apr 2023 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1680556296;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MrvB9dLaBUlXb9132dHY3khaWN+MmC+4xODtdYapChQ=;
        b=YClfDXVMnyD4N/fCkOJ+5VV43bCDFEyC1WQwMYHhnhYIf7C6qaiUXvhRzZcrRvH4yq
         iw2q93xPIKLX+F4RibdFqKd4d6EB87+Qe2Ior7VTT2MUeVWVeBXTIK/GU9v5uNHsBewS
         wYjozfd40gTZ/lIdRHaXeUlCcXeyjV6ING3N8rvaIpxgxO03uPihY0RlSdtmw3cWqAn2
         LhVuaOfgrYWD2u5+7iqx9klGDMlmbhGqWxXA+c0YaV6mfbjTE9NhdmLIctUm9w46U/t7
         ayfbtWPc6/TBF4VJBqv96J/mTuOwTvWuJF+I/q2uC0iZhEWOBckW0ejA//xiX0t9hmQP
         j4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680556296;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MrvB9dLaBUlXb9132dHY3khaWN+MmC+4xODtdYapChQ=;
        b=rKwhbko0XiK8aOZKftQN/zODKCTCxl9yGSaJWEE1Ravc07Ks3bapm5uOh6aT88Lyp5
         Tt8PW40s69FYO4qMu/uVl222Q2mJdImpZ6vbUePx1Bj1ZMHW8O8YYuJSksk/Cqf0U2qb
         EFXK7MGUiXQ/94oTSGu5YdSBXfeenPtPCSnL0Md87vi285+mvIZ73YggYV/sI2bwPg5/
         3fcpXblU9aODe6RBcwrPYONxjZeDNeJ9HZAkE0NNItNz/H73jtk1YFgfkNlt21iQ11Vd
         kqm0V7rLLk1PsEbFJHEQ1jbwLyZotgcCUfwbtcNpF9HQy6xVT6kxfktdELNtovc8rKI6
         6z7g==
X-Gm-Message-State: AAQBX9d0O2gjTusKbOAi+3ssuJzFZmLnhqLYLLRA3YfRLg8KBEo7coNd
        Hlrex6l1jSzrAoFB3jE/sM5Fzw==
X-Google-Smtp-Source: AKy350ZzxDFZgHJ2G4M8Pxq7ivSpG//SCIzPE9kkjUJ8tEoQ90iiNfJXeSTWUFZ8dy2vd+2jwWd+KQ==
X-Received: by 2002:a17:903:1d1:b0:1a0:76d1:545c with SMTP id e17-20020a17090301d100b001a076d1545cmr19062125plh.10.1680556296542;
        Mon, 03 Apr 2023 14:11:36 -0700 (PDT)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902760500b001992fc0a8eesm7090147pll.174.2023.04.03.14.11.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2023 14:11:35 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     <lenb@kernel.org>
Cc:     "Doug Smythies" <dsmythies@telus.net>, <linux-pm@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>
Subject: [PATCH] tools/power/x86/turbostat: Fix added raw MSR output
Date:   Mon, 3 Apr 2023 14:11:38 -0700
Message-ID: <00d201d96670$e15ab9d0$a4102d70$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: Adlmb4+/+92L5McLQC6ljBs2sqN+CA==
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


When using --Summary mode, added MSRs in raw mode always
print zeros. Print the actual register contents.

Example, with patch:

note the added column:
--add msr0x64f,u32,package,raw,REASON

Where:

0x64F is MSR_CORE_PERF_LIMIT_REASONS

# ./turbostat --quiet --Summary --show Busy%,Bzy_MHz,PkgWatt,PkgTmp,CorWatt --add msr0x64f,u32,package,raw,REASON --interval 10
Busy%   Bzy_MHz PkgTmp  PkgWatt CorWatt     REASON
0.00    4800    35      1.42    0.76    0x00000000
0.00    4801    34      1.42    0.76    0x00000000
80.08   4531    66      108.17  107.52  0x08000000
98.69   4530    66      133.21  132.54  0x08000000
99.28   4505    66      128.26  127.60  0x0c000400
99.65   4486    68      124.91  124.25  0x0c000400
99.63   4483    68      124.90  124.25  0x0c000400
79.34   4481    41      99.80   99.13   0x0c000000
0.00    4801    41      1.40    0.73    0x0c000000

Where, for the test processor (i5-10600K):

PKG Limit #1: 125.000 Watts, 8.000000 sec
MSR bit 26 = log; bit 10 = status

PKG Limit #2: 136.000 Watts, 0.002441 sec
MSR bit 27 = log; bit 11 = status

Example, without patch:

# ./turbostat --quiet --Summary --show Busy%,Bzy_MHz,PkgWatt,PkgTmp,CorWatt --add msr0x64f,u32,package,raw,REASON --interval 10
Busy%   Bzy_MHz PkgTmp  PkgWatt CorWatt     REASON
0.01    4800    35      1.43    0.77    0x00000000
0.00    4801    35      1.39    0.73    0x00000000
83.49   4531    66      112.71  112.06  0x00000000
98.69   4530    68      133.35  132.69  0x00000000
99.31   4500    67      127.96  127.30  0x00000000
99.63   4483    69      124.91  124.25  0x00000000
99.61   4481    69      124.90  124.25  0x00000000
99.61   4481    71      124.92  124.25  0x00000000
59.35   4479    42      75.03   74.37   0x00000000
0.00    4800    42      1.39    0.73    0x00000000
0.00    4801    42      1.42    0.76    0x00000000

# rdmsr 0x64f
c000000

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 tools/power/x86/turbostat/turbostat.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8a36ba5df9f9..d8d667934a23 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1744,8 +1744,9 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
-			continue;
-		average.threads.counter[i] += t->counter[i];
+			average.threads.counter[i] = t->counter[i];
+		else
+			average.threads.counter[i] += t->counter[i];
 	}
 
 	/* sum per-core values only for 1st thread in core */
@@ -1764,8 +1765,9 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
-			continue;
-		average.cores.counter[i] += c->counter[i];
+			average.cores.counter[i] = c->counter[i];
+		else
+			average.cores.counter[i] += c->counter[i];
 	}
 
 	/* sum per-pkg values only for 1st core in pkg */
@@ -1812,8 +1814,9 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
-			continue;
-		average.packages.counter[i] += p->counter[i];
+			average.packages.counter[i] = p->counter[i];
+		else
+			average.packages.counter[i] += p->counter[i];
 	}
 	return 0;
 }
-- 
2.25.1


