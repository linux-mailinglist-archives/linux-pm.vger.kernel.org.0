Return-Path: <linux-pm+bounces-6072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5B589CF5C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75BB0B231F0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E61710E6;
	Tue,  9 Apr 2024 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU775w6d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583F2376
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622705; cv=none; b=TClaqiFBCupreVJmccq1tkvx6M37JPs+FxF7BtO01ZtfUS0pouXWrQPeUdZduc93rMiyPhTqoGxqIrmMhGbbZxPA5oOFuQ8409opa0frUWyXPdPHsnquSd7LmGmlGctAZi3pgYQeONDZWSbQr85QwtO+IlDuL34y7b+vCY4ytPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622705; c=relaxed/simple;
	bh=n+KZ9KRRX8AaeZGIF2htvWty8MN35nA2uZdWtLf6fWU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=jDN2Lc6l8tIsZFqfaSlHLUhXzjKiJSospcMbMeIC39v7qHmTE/OJz0/x20Oej+1Bl7VXGnnZwqx6TnxSj5lSe4DrzoxFsA2Mp0R710PnxgozKS0+3GCnyXasIiO+k9ZNwonyQFBSjEOl2RB1TZ9Eh4yivRz8LBxOh6TgQnaPUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hU775w6d; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc742543119so4833056276.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622703; x=1713227503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=A76i5m68q+AOBKuYUqIdp/qLHC7iT9etcjOTTLCM5Z4=;
        b=hU775w6dO8LtZItFB08eVZCMvqVRYdQQEgnWgVtisv5bA9LkRuMru8nTNcAANXIZG8
         WbIG/a+iZFx99idr1fLjLXlubFzmPm0cKSD/29qYJLZp00KKawBjCN4iw+7pQtVDQDLq
         FEdgECvsPzpiQ6OWQ4fukWghTR0XC8JxK7wTOYQnUVkooUvEk8xCMgfa/WJor3BkgAKH
         27CqOK25B9WBqQG4cUQvonwDk9KKKxNRRCmXJPKQ2Jtuayk8cQ+P1WtTV60f5MijYmO7
         T5kbyMzr/MUs/Prx6MGeCSlEQ1X+8zX+iox+TvPdBXEcT7dQLyEJTDSfLDTIat9xPqKG
         KK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622703; x=1713227503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A76i5m68q+AOBKuYUqIdp/qLHC7iT9etcjOTTLCM5Z4=;
        b=wlGTNN4VRU0j2laAJIWvmVZfJXDACjRKRjxytQbesIq/5mEwEMdvb8yLD+Hc8Za4Ip
         M138s6eSxSxAWtAoYhAAxwJm+/qkXm6gzt8QxaCRgqawr8Umd3vga0w4J8UCvGQk1ZO4
         JgOEKeMjsMPNuE8/sseFuye8/GY1HaF9RLCuWYZ5FNX9i39a7U+0LrE+5KDe1lAQ4QsP
         uKlEkNLC8GWCwi+2lXZOvR69vKMGkNjeHlwaLx1R9AgtomZbHXm+u4tWf2fIhrqa9PlB
         E0VM76YK7gzkQLtuCaPi6PwRMxv4zSX2M5m5DETBk6N5gHtCY9Ot90crNmwNPKAovzbe
         yPHQ==
X-Gm-Message-State: AOJu0Yw1SlihnrR26yAJla3I7AWC2Fryo8hKY6+L2a+IvQ71JxCRFNr6
	IX3mR8BTkBpvuLhpkNDXyPKWANaV5tS2BVhmvHct9V9P/l6auuBUHgSnk2T4
X-Google-Smtp-Source: AGHT+IF1kDl0/iuWHkGd7gFCsK+duw8rCblK/eR/C2T+HMHyJZ24YYBnyjun/idT0tMwGOYmj8j2ow==
X-Received: by 2002:a25:68c4:0:b0:dcf:c6cf:d824 with SMTP id d187-20020a2568c4000000b00dcfc6cfd824mr7754330ybc.9.1712622702998;
        Mon, 08 Apr 2024 17:31:42 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.42
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:42 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: turbostat 2024.04.08 queued for upstream
Date: Mon,  8 Apr 2024 20:30:54 -0400
Message-Id: <20240409003120.338589-1-lenb@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please let me know if you see any problems in this update.

thanks!
-len

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2024.04.08

Turbostat version 2024.04.08

Use of the CPU MSR driver is now optional.
Perf is now preferred for many counters.

Non-root users can now execute turbostat, though with limited function.

Add counters for some new GFX hardware.

----------------------------------------------------------------
Chen Yu (1):
      tools/power turbostat: Do not print negative LPI residency

Doug Smythies (1):
      tools/power turbostat: Fix added raw MSR output

Justin Ernst (1):
      tools/power/turbostat: Fix uncore frequency file string

Len Brown (4):
      tools/power turbostat: Expand probe_intel_uncore_frequency()
      tools/power turbostat: Fix warning upon failed /dev/cpu_dma_latency read
      tools/power turbostat: enhance -D (debug counter dump) output
      tools/power turbostat: v2024.04.08

Patryk Wlazlyn (11):
      tools/power turbostat: Print ucode revision only if valid
      tools/power turbostat: Read base_hz and bclk from CPUID.16H if available
      tools/power turbostat: Add --no-msr option
      tools/power turbostat: Add --no-perf option
      tools/power turbostat: Add reading aperf and mperf via perf API
      tools/power turbostat: detect and disable unavailable BICs at runtime
      tools/power turbostat: add early exits for permission checks
      tools/power turbostat: Clear added counters when in no-msr mode
      tools/power turbostat: Add proper re-initialization for perf file descriptors
      tools/power turbostat: read RAPL counters via perf
      tools/power turbostat: Add selftests

Peng Liu (1):
      tools/power turbostat: Fix Bzy_MHz documentation typo

Wyes Karny (1):
      tools/power turbostat: Increase the limit for fd opened

Zhang Rui (6):
      tools/power/turbostat: Enable MSR_CORE_C1_RES support for ICX
      tools/power/turbostat: Cache graphics sysfs path
      tools/power/turbostat: Unify graphics sysfs snapshots
      tools/power/turbostat: Introduce BIC_SAM_mc6/BIC_SAMMHz/BIC_SAMACTMHz
      tools/power/turbostat: Add support for new i915 sysfs knobs
      tools/power/turbostat: Add support for Xe sysfs knobs

 MAINTAINERS                                     |    1 +
 tools/power/x86/turbostat/turbostat.8           |    6 +-
 tools/power/x86/turbostat/turbostat.c           | 2197 ++++++++++++++++++-----
 tools/testing/selftests/turbostat/defcolumns.py |   60 +
 4 files changed, 1805 insertions(+), 459 deletions(-)
 create mode 100755 tools/testing/selftests/turbostat/defcolumns.py


