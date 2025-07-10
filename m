Return-Path: <linux-pm+bounces-30585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0BBB0030D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 15:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2689F162C16
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 13:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF1D28DB5D;
	Thu, 10 Jul 2025 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRc1SjZN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9C25D21A;
	Thu, 10 Jul 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153161; cv=none; b=URUpNR39qQdyPzBynH4PAnZok5FUNLLJaG3pUzKWgZdlqA90hrmqiDt781prbEQlAcL1JpeTrHL/lz547pkapZoy4Yqu+j4uyWsdo1XkXJ+csk2tVaCqV8RsFWGv4izknVSmfw52dFglb7xf/afhv5AZDnCEzj+n43Z0vm0/ys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153161; c=relaxed/simple;
	bh=a6txXrLzW35b1zGTDyVpZzhGd+F09XjuI6q5NT4EVMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkU5pIS/Z/faHIktjz34nHWB8rAQvATk4Q9GVWWAIOIe5tH3uDyBDR2tJstWhPCUHr3wV4mUDP/lNMrPHv4We3KI2oUnmYU1h96uUXXkWg/jIt+/h3eglu1qFg0v+fORaOisKFrsC5JgoDH9ToKRcvg6aO51H7HrQxiLgqrXHaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRc1SjZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85D4C4CEED;
	Thu, 10 Jul 2025 13:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752153161;
	bh=a6txXrLzW35b1zGTDyVpZzhGd+F09XjuI6q5NT4EVMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRc1SjZNgXXpjmpXsaw4eDEyvO/ho/becbOhM5LEAjK2Z7tINUTXv9DUrzR/6m3fz
	 iu13CBOdgvgemyk9mcBYKjiqLxp2fgBaGvduQZep3H0BCGdWIz2bJFuEG9hlAVvh4o
	 HPoqcqg5X8mXVsv3Vwz9KijDymRgtlQfi+MRWjw/G/72nZZ3Iul1u6M/jd8yhY7moZ
	 6t0Q+FnGF+UyIR+hKlaHmdhaUg54XNRErqDUrGkeJ5NSoAWCoslCE86VBsYYt8JNGz
	 BNiXlka9GW/XAbEA5IQnGfD/cMBGlj2yOmOx2tUfgXm4VxfVe7XvfFGLZr9HA/u270
	 TUMhkIqHYAbrA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: kexec@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v1 2/2] kexec_core: Drop redundant pm_restore_gfp_mask() call
Date: Thu, 10 Jul 2025 15:12:20 +0200
Message-ID: <1949230.tdWV9SEqCh@rjwysocki.net>
Organization: Linux Kernel Development
In-Reply-To: <5046396.31r3eYUQgx@rjwysocki.net>
References: <5046396.31r3eYUQgx@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop the direct pm_restore_gfp_mask() call from the KEXEC_JUMP flow in
kernel_kexec() because it is redundant.  Namely, dpm_resume_end()
called beforehand in the same code path invokes that function and
it is sufficient to invoke it once.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/kexec_core.c |    1 -
 1 file changed, 1 deletion(-)

--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1136,7 +1136,6 @@
  Resume_devices:
 		dpm_resume_end(PMSG_RESTORE);
  Resume_console:
-		pm_restore_gfp_mask();
 		console_resume_all();
 		thaw_processes();
  Restore_console:




