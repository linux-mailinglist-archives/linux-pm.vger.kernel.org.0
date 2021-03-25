Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4150349AE2
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 21:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhCYUNy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 16:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhCYUNk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Mar 2021 16:13:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3FFC06174A;
        Thu, 25 Mar 2021 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=68o8jDraRG/5zbwxLlhq05M769Ic9hxiORbKB2o14bE=; b=aL3MBgZ+3WZNyaPZ/UMxIbkPWA
        pyVk8i13iai3GlXHbwN7q7+24hxSHzvxSMrGPsry2IXw6qYSvLFEMlcJRA1aF19cdzGEkWd6Kdxxe
        svLnKpzEl2yoP7L6GN/BmLXCI1qz0L1uVDzuhlvC41vd+oJ6FVNPNvxmgaZkA1WZgn/UJkKTHM63u
        UxrOYrJknq86MiI4wJ+q8Wf0C00LBNX6/Z+/geeCd397g72GxamdNBMAQPXJGgz2XlHfclB/JMT+Y
        0c3+3FRDksRxTFz8u2QWGrdEHqmcY6kxdLg5aQPh4cVxCWol4dyx/L3anT8CMPhNMN7z2Nhkv9LU/
        YranBzwA==;
Received: from [2601:1c0:6280:3f0::3ba4] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPWML-0028qB-9K; Thu, 25 Mar 2021 20:13:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Borislav Petkov <bp@suse.de>,
        "Len Brown" <lenb@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH] tools: turbostat: unmark non-kernel-doc comment
Date:   Thu, 25 Mar 2021 13:13:33 -0700
Message-Id: <20210325201333.16792-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Do not mark a comment as kernel-doc notation when it is not
meant to be in kernel-doc notation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: "Len Brown" <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 tools/power/x86/turbostat/turbostat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210323.orig/tools/power/x86/turbostat/turbostat.c
+++ linux-next-20210323/tools/power/x86/turbostat/turbostat.c
@@ -2449,7 +2449,7 @@ dump_knl_turbo_ratio_limits(void)
 	fprintf(outf, "cpu%d: MSR_TURBO_RATIO_LIMIT: 0x%08llx\n",
 		base_cpu, msr);
 
-	/**
+	/*
 	 * Turbo encoding in KNL is as follows:
 	 * [0] -- Reserved
 	 * [7:1] -- Base value of number of active cores of bucket 1.
