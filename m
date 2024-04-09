Return-Path: <linux-pm+bounces-6073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6DA89CF5B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4181C23F16
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71C2376;
	Tue,  9 Apr 2024 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKpcF4PF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D347382
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622706; cv=none; b=L6OF03MNpmV6G8BUOF7hqBQ5HvB6QMAuq3+wbnPBWY4fTwg5rAQ65t9dYuo3yvWSBYU/bg3jahR/jrUYs5ewPsN1obz34CpcxVGAEVp15Sp84PRh57o7ybL2SYTfYCDtcn31tQmq/KA4CC3SUxUQhpaiIRNZLMjwA428/BJ8RY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622706; c=relaxed/simple;
	bh=RlhC/xUQk4MAdwBytgnImtHjmI7/6NTKJdA01MVdtDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bdqmx2NE02lVPPjVgfsENPh5hrUeqAYG2fisODwgakwvJFaz+PRYHKDENnw2abVqn+DrgXUTg0H07RbOYCjIfLO3gTwrMwCYa/RWOFOVCTltg4UnfGA5mKsuAmZimVnoCmNVI/0xM/WJ3ma+QORjgURGxbi3yuLMGoFcjxcH9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKpcF4PF; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso5137952276.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622704; x=1713227504; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gr54WfPIa9tY+PnqtNuEfFEWnHK3AyKonEAXuKDeLes=;
        b=XKpcF4PFbzsG0wfmwDhlDJXTfJtztCuUt6o0UjU0pXTzs5W1HEZcK4bjaz0EcmfxG5
         9XQEE1ZcCDs2LQD6jo8pWGeUtOZhiJC67+W9KO4I/Su9gFFh6CM5XEB7TLpvx6dbUXZ9
         AHg5qqNQ7VzGWuY/UYssLfa+7h8qtMTkhEXlDsUZMrLTGdXWTSNX3HtCN8ErESiihTGk
         ILfILQeJ0MyfVNJgV/bBvG5udL7IlRNwk6yeuzysWO2kwd9GJEKEwqmyXBv7QwRxcktr
         jtruzEBLgMEw9wf8FLHXRPIXqu3/fZBWky+pk5FevgebVRn3BJVcSmgNDc3vrxkFJrki
         Oawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622704; x=1713227504;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gr54WfPIa9tY+PnqtNuEfFEWnHK3AyKonEAXuKDeLes=;
        b=J0E97hbHZ9I7fBKewcD4GzmojgvTy1G0JU/HkMmOPoo4K/zc8+gW/gyj8zelPECyBb
         XgEaROuDgJnfYz6gSn3+qyTEDuQSijuVfwpWQ2CPJA9ML7kTQJOCBgsKe6rbPHJO8VU1
         ilUjrVIpzXBA/OpbGU+u4ffWNRx5iZU1Cae3f8cr+feoFYP9P4MWGC19qnm6QU/lV+L9
         yxO2z7L/bq7ujANK2/rR12/iYpB6hagyjysx9f1+Jk9MlVY2L9TEMlpvrAWfyHW0pKyJ
         AiXnfMyN0e7meJvkDQbjGfYkkqkdvEdAMDBb0laRHvE7NLYM6tlSlC5oStc8QF420XfB
         ZZag==
X-Gm-Message-State: AOJu0YzSLUoh45wu0ywkeNAUmeTxy8S7TIpsASV9ldXv9iUcA7PpxACL
	oXJJMT6sLHg/pOqKgKwMh4k1IsFdB3Wt7DS16J0A67/8Jm0MscMsTIGu5BWy
X-Google-Smtp-Source: AGHT+IGtkMbEW87YS9U7SetdabfWotj+Bb5eyoyIkUHOdgPZ403VbB2ccOroJomQQxU5QDmXEAURFA==
X-Received: by 2002:a25:bac6:0:b0:dcd:5635:5c11 with SMTP id a6-20020a25bac6000000b00dcd56355c11mr8444198ybk.45.1712622703898;
        Mon, 08 Apr 2024 17:31:43 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:43 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Doug Smythies <dsmythies@telus.net>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 01/26] tools/power turbostat: Fix added raw MSR output
Date: Mon,  8 Apr 2024 20:30:55 -0400
Message-Id: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240409003120.338589-1-lenb@kernel.org>
References: <20240409003120.338589-1-lenb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Doug Smythies <dsmythies@telus.net>

When using --Summary mode, added MSRs in raw mode always
print zeros. Print the actual register contents.

Example, with patch:

note the added column:
--add msr0x64f,u32,package,raw,REASON

Where:

0x64F is MSR_CORE_PERF_LIMIT_REASONS

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

c000000

[lenb: simplified patch to apply only to package scope]

Signed-off-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 7a334377f92b..fca7913f6c84 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2444,9 +2444,10 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	average.packages.rapl_dram_perf_status += p->rapl_dram_perf_status;
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
-		if (mp->format == FORMAT_RAW)
-			continue;
-		average.packages.counter[i] += p->counter[i];
+		if ((mp->format == FORMAT_RAW) && (topo.num_packages == 0))
+			average.packages.counter[i] = p->counter[i];
+		else
+			average.packages.counter[i] += p->counter[i];
 	}
 	return 0;
 }
-- 
2.40.1


