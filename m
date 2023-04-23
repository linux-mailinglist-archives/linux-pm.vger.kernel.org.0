Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE3B6EBDA3
	for <lists+linux-pm@lfdr.de>; Sun, 23 Apr 2023 09:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjDWH2p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Apr 2023 03:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDWH2p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Apr 2023 03:28:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F131BEB
        for <linux-pm@vger.kernel.org>; Sun, 23 Apr 2023 00:28:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CF496103B
        for <linux-pm@vger.kernel.org>; Sun, 23 Apr 2023 07:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFA4DC4339C
        for <linux-pm@vger.kernel.org>; Sun, 23 Apr 2023 07:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682234922;
        bh=JJ1TyvOEN+oXBIoWIIg9Q9m7oOU2+XF0wYhwv8twUso=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dEHLZmW1TMbAlC5QBP2UYg7FNLgBLcgRiVv+4gKxzWoUELmJC4+EvNaCDELrc3H4m
         5NMPXkWZdx/rtnQbaiKtd3NvfpyOjRg36N3zlEL0ODSP391AE8LuyAYNgFXsNF0pLl
         T0QT4lh2ovnPUfZpNG8MiWJF3u/EXO9tcjAyV4DL5GrQoDUfxEHrupuIeoZ+/0N9ac
         7ihZrwKXl9t1SP+rhz/5g+VHKqReWxrSy6BOmKVFCjTuTVWR4rAEzqsofUeQxd+rB7
         mPhOIV3tDmppnbLC4u9mNYcun8YByffMbci3JStNLORN/uadf3ks8EN3C8FsqvXkDJ
         VIM0taETc+eCw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BF861C43144; Sun, 23 Apr 2023 07:28:42 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217361] AMD P-state driver is too aggressive by default
Date:   Sun, 23 Apr 2023 07:28:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: REJECTED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-217361-137361-hNpDivYZy9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217361-137361@https.bugzilla.kernel.org/>
References: <bug-217361-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217361

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |REJECTED
         Resolution|---                         |INVALID

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
You're using the "powersave" governor which keeps the CPU at the lowest
performance at all times.

Please switch to ondemand or schedutil

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
