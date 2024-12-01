Return-Path: <linux-pm+bounces-18308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6647D9DF558
	for <lists+linux-pm@lfdr.de>; Sun,  1 Dec 2024 12:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C83281198
	for <lists+linux-pm@lfdr.de>; Sun,  1 Dec 2024 11:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20D4139CE3;
	Sun,  1 Dec 2024 11:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JaMrDjjr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LBiOBkQZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF261FD8;
	Sun,  1 Dec 2024 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733051861; cv=none; b=oly98R7fLHODcCnFutZvEuQGB4YM3Dl8PrWTLoDbZld0md1kN19vHjH2EU4p8+iJNcr6/dGK4OWvHs0UjSemJR0XiaQVvrI2kN9RFRj8cFnJEbX8NmRVuu+JXvjb3ksIX/MG999KMpvgs/vs2O4rRlSN9XNMSCfJw5nUqYoDj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733051861; c=relaxed/simple;
	bh=lNlWXzEDSPTzKHeRhPw+BpQtoHc4UzYShBEOPrJVR48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sL3WfZGldlBg5Yd4qc3esw5R7AW/NBM863sTuJ4IK2ud2wio0ookC7Wqw19Szb6SRsOVp5NHcImZEeHQs+rSBk4+ItAmUsHl20kthr03RAhlAuL0L++E8/25iTqQ3kC9p71KYjn+/kHrYaF8mfhqiwSPJK3jpCsb0Rl4Efr6jt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JaMrDjjr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LBiOBkQZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733051851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRZlKi0Qgf8O88p9J6mCLg0NhX+ek0Zt0DfrEKxje4Q=;
	b=JaMrDjjrMdpYWWKJjzSTqjiqtvqa2S2fuCGgdO/l6pR2F2KLnsvt2f6dPO2/PxWdNjoLAQ
	iiEdluXIBby7ys2jx5qmJkl/yccknUnU0hSC6q1iNtWGgJJcRmd0s7LMN3XlFjEXD/Alvg
	C+hvlvdEaLmUzXNdGlyOH9+xkuu0XTAP3JSTx7nKWkzvSxXZi7y59G2gHXpKy+SZNY17Mu
	Hqd/qO7Vz9ahz0Y39ppRfBQ3icROOvaQSad44SLq6Ynf4PALKz78QwY5ZixRXLQ6zCKWM2
	BgJhYP4knI4jLbshni9Cv2izKeX2qVr+BhttKRABCrlEfkQ8I6vbqmZGmeQagQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733051851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRZlKi0Qgf8O88p9J6mCLg0NhX+ek0Zt0DfrEKxje4Q=;
	b=LBiOBkQZK8Ee1urWlu7/iYsigNZhfpWpyWuh7wIaYF7KXx1y8YVUzKXr+iEZijbO72XRoL
	qXBvGzeXrB+bZ3Bw==
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: 20241015061522.25288-1-rui.zhang@intel.com, Zhang Rui
 <rui.zhang@intel.com>, hpa@zytor.com, peterz@infradead.org,
 thorsten.blum@toblux.com, yuntao.wang@linux.dev, tony.luck@intel.com,
 len.brown@intel.com, srinivas.pandruvada@intel.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com,
 x86@kernel.org, linux-pm@vger.kernel.org, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 linux-kbuild@vger.kernel.org
Subject: [PATCH] modpost: Add .irqentry.text to OTHER_SECTIONS
In-Reply-To: <20241130114549.GI10431@google.com>
References: <20241128111844.GE10431@google.com> <87o71xvuf3.ffs@tglx>
 <20241130114549.GI10431@google.com>
Date: Sun, 01 Dec 2024 12:17:30 +0100
Message-ID: <87iks3wt2t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The compiler can fully inline the actual handler function of an interrupt
entry into the .irqentry.text entry point. If such a function contains an
access which has an exception table entry, modpost complains about a
section mismatch:

  WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference ...

  The relocation at __ex_table+0x447c references section ".irqentry.text"
  which is not in the list of authorized sections.

Add .irqentry.text to OTHER_SECTIONS to cure the issue.

Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 scripts/mod/modpost.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -785,7 +785,7 @@ static void check_section(const char *mo
 		".ltext", ".ltext.*"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
 		".fixup", ".entry.text", ".exception.text", \
-		".coldtext", ".softirqentry.text"
+		".coldtext", ".softirqentry.text", ".irqentry.text"
 
 #define ALL_TEXT_SECTIONS  ".init.text", ".exit.text", \
 		TEXT_SECTIONS, OTHER_TEXT_SECTIONS

