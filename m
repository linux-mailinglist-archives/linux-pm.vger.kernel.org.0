Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDDA4E4A6E
	for <lists+linux-pm@lfdr.de>; Wed, 23 Mar 2022 02:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbiCWBW6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Mar 2022 21:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241108AbiCWBW5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2022 21:22:57 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A416A013
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 18:21:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F06C45C05A9;
        Tue, 22 Mar 2022 21:21:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 22 Mar 2022 21:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=S+iu6Z
        Ib/LKvE8rf+ENQtEacTbCXCd4zjEwhqBC+6c8=; b=fvzdipVfPdgCQpNPy9gEHa
        bVW/zrcBD7/4EZD7BLsfWqD8JKr6V/LP9N1FeTKErpQSP4doGIM+/2pjmgo1BUD4
        neG2bt6s6meWAkCgVFKT/GpZ6EgEKZ6Nom1Cns7rWsNmZMWNErKK+eJQ7+F1Zp/3
        Ary6IRNu/H7fATTh9r/7AQohYoVddLt7bDgLke2tKfncioXE63+f2YN7js2oJofR
        UQ5K4QneYWUaBcdWeFFVaybcKeDr+X4CuYbIMuXgCRKVeyY11WurNerznRd5eFEj
        c9OlY2g2j504H6daMezN+uYIXsbPqTdyweZYikSa6jfOyzLqJkUd8JU59wntII4w
        ==
X-ME-Sender: <xms:F3Y6Ys0IoJjShYiCX1z2PkQajDxVjenBKLS-QQJzY3iC9JK9xm3ITeeW>
    <xme:F3Y6YnEJ_u4u5VQZfyq-oDT67VO0S-CWfbFXjaEFWCj-1SxHLBzwuI7f0eaiBMhxH
    BUzBo68gqeQke4>
X-ME-Received: <xmr:F3Y6Yk7jMaiu_Apfy5aweP7wlf2WevVW-vO4p8XMb_o9jarfpBO_fqdL5IOUMqD9EvQFCoN0gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegiedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomheplfgrkhhusgcu
    mfmnugiiihholhhkrgcuoehnihgvugiivghjkhhosgesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeefgedvleeiteeigfefvdduheef
    geefieehvdekheeuteekheeigeetfffgffetgfenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehnihgvugiivghjkhhosgesihhnvhhishhisghl
    vghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:F3Y6Yl1IQeTeX6fNe-82kMLvlGO-98dfVkVmg-_ebb4Sqfjr0W3SWA>
    <xmx:F3Y6YvEhz27Frokss767QjvssOkIY9nxXGKiSCDn1sZnxhX1qaq1Sg>
    <xmx:F3Y6Yu-Vwg-oBLmUigK3yRn81FRFlGRQeOYRKeSwRnm9Pe4zHjdsBg>
    <xmx:F3Y6Yu3RMEQuP2jknAZX4yC3Ao2m3LgFTbZpMR1BnuBCgz6g5sxrUw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Mar 2022 21:21:26 -0400 (EDT)
From:   =?UTF-8?q?Jakub=20K=C4=85dzio=C5=82ka?= 
        <niedzejkob@invisiblethingslab.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Cc:     =?UTF-8?q?Jakub=20K=C4=85dzio=C5=82ka?= 
        <niedzejkob@invisiblethingslab.com>,
        marmarek@invisiblethingslab.com
Subject: [PATCH] xen: don't hang when resuming PCI device
Date:   Wed, 23 Mar 2022 02:21:03 +0100
Message-Id: <20220323012103.2537-1-niedzejkob@invisiblethingslab.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If a xen domain with at least two VCPUs has a PCI device attached which
enters the D3hot state during suspend, the kernel may hang while
resuming, depending on the core on which an async resume task gets
scheduled.

The bug occurs because xen's do_suspend calls dpm_resume_start while
only the timer of the boot CPU has been resumed (when xen_suspend called
syscore_resume), before calling xen_arch_suspend to resume the timers of
the other CPUs. This breaks pci_dev_d3_sleep.

Thus this patch moves the call to xen_arch_resume before the call to
dpm_resume_start, eliminating the hangs and restoring the stack-like
structure of the suspend/restore procedure.

Signed-off-by: Jakub Kądziołka <niedzejkob@invisiblethingslab.com>
---
 drivers/xen/manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 374d36de7f5a..3d5a384d65f7 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -141,6 +141,8 @@ static void do_suspend(void)
 
 	raw_notifier_call_chain(&xen_resume_notifier, 0, NULL);
 
+	xen_arch_resume();
+
 	dpm_resume_start(si.cancelled ? PMSG_THAW : PMSG_RESTORE);
 
 	if (err) {
@@ -148,8 +150,6 @@ static void do_suspend(void)
 		si.cancelled = 1;
 	}
 
-	xen_arch_resume();
-
 out_resume:
 	if (!si.cancelled)
 		xs_resume();
-- 
2.30.2

