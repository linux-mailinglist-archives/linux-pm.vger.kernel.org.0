Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0315251BD41
	for <lists+linux-pm@lfdr.de>; Thu,  5 May 2022 12:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbiEEKee (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 May 2022 06:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355807AbiEEKeb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2022 06:34:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE8741F8E
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 03:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D709A6198A
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 10:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48776C385B0
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 10:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651746651;
        bh=JNIaHhQtYsG/NBP9nmBvV1NUWWCbmPzPTz/XdZhikYU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=edgk0G9Bz7mWLqCyACkcJfh8NvbB9K/KZ45e7DADrFyKdosG5ztIENJrPE1yME7uX
         P+zHqFTvvaTRQAj+1O4W4fhFj0UXWYMIS70166Rg/4tSJTuYMwlSfJG4PUjnscUxy5
         ZQqp2mmHsFu8ohIkJMdsyVAQ+ampZzaKCQH3QlMPQKe+IDJREampHlmL/etsbC0rcr
         NenObG/cVhpenM3QzXWJc9+Oa1XgKa71xOA/QIPAGSWYC9d+hkyd9tg5Qh2q9BRT2R
         QIrky56UNSPfN70Zx237FJDtnUM/m/4d7C6WCfBl++jkpOnOfS7FSxNhm4wGs/rCox
         4jcsmfRVD5G8w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2459CCC13B0; Thu,  5 May 2022 10:30:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215909] Regression with ACPI_STATE_C3 state freeze
Date:   Thu, 05 May 2022 10:30:50 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: ACPI
X-Bugzilla-Component: ACPICA-Core
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: axet@me.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: acpi_acpica-core@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215909-137361-iE4Liq8FJn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215909-137361@https.bugzilla.kernel.org/>
References: <bug-215909-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215909

Alexey Kuznetsov (axet@me.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--- Comment #4 from Alexey Kuznetsov (axet@me.com) ---
I've been told to try 5.18-rc4 for patch to test. That was a mistake. 5.18-=
rc5
works! Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.=
