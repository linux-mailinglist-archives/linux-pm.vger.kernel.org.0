Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299E729F46D
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 20:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgJ2TDR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 15:03:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44302 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgJ2TDO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Oct 2020 15:03:14 -0400
Received: from zn.tnic (p200300ec2f0ce9003d743c4902fedd6b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:e900:3d74:3c49:2fe:dd6b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A31AB1EC04E2;
        Thu, 29 Oct 2020 20:03:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603998192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWYo35+XzQdIjKwQb+3WnhjfJWr6EkLKG83NImMbM0U=;
        b=VpkNgOr6mi9X6Pj7A6I0sjSgRRzho3Gmm0NkPaFEgu4AxCVUuGS0/0Skdvkm3bHI+kUkHH
        c4OrTdC9p1K0FVLZUcmszcP3PumFm2ZgCw+bubVUnUp9BC6MYu7VCiUWOXdym+prAZm1zW
        7uDKDlMH9vj0l+dUvUgjkf/FNdHcYkE=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 4/4] x86/msr: Do not allow writes to MSR_IA32_ENERGY_PERF_BIAS
Date:   Thu, 29 Oct 2020 20:02:59 +0100
Message-Id: <20201029190259.3476-5-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201029190259.3476-1-bp@alien8.de>
References: <20201029190259.3476-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Now that all in-kernel-tree users are converted to using the sysfs file,
remove the MSR from the "allowlist".

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/msr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index c0d409810658..b1147862730c 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -99,9 +99,6 @@ static int filter_write(u32 reg)
 	if (!__ratelimit(&fw_rs))
 		return 0;
 
-	if (reg == MSR_IA32_ENERGY_PERF_BIAS)
-		return 0;
-
 	pr_err("Write to unrecognized MSR 0x%x by %s (pid: %d). Please report to x86@kernel.org.\n",
 	       reg, current->comm, current->pid);
 
-- 
2.21.0

