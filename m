Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B831C73E70E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 19:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjFZR5I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 13:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFZR5I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 13:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D061183
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 10:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E668560F11
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 17:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56964C433C9
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687802226;
        bh=fw+blmTno1+Xu5E8mLwGXWGUBH8sm0OAJ3pHvpNrSrs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sfuhd2CDauIzphpcMhDn0Cp9fwvdEmiErjvNCl5zhLLZbSf1/5NSSZEB8lz01GhBH
         whcBNsutZbfmjAxTAEc4VQtrPndUysMH1V07SgehKhVBB6eQXOmcZR2TAClYKhO92n
         WHiGLyFFL+Oi5zvBQzXELw2WTC86VSnDdcGpB7/NrsWIWwQh6Na8A1OoO4BdVCIFoR
         ItGxGaPGV7ZyZy/gUDxq7fnq26GWRyzUxMbfsiSIOKVFHbqgT1vAx7KXM8DLpQadUg
         uE6Pczbb4UKK/AZ8ql5jOnfenD6dmrs42k0iFyasY6NKiQQJI6q47AGyqO/9e8UAhG
         p/cLDH4WO3qpA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3A0C0C53BD0; Mon, 26 Jun 2023 17:57:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217597] lscpu reporting incorrect CPU current frequencies
Date:   Mon, 26 Jun 2023 17:57:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: yang.jie@linux.intel.com
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P2
X-Bugzilla-Assigned-To: yang.jie@linux.intel.com
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit priority bug_status cc
 assigned_to cf_regression
Message-ID: <bug-217597-137361-hHjRgPR4qc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217597-137361@https.bugzilla.kernel.org/>
References: <bug-217597-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217597

Keyon (yang.jie@linux.intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |f3eca381bd49
           Priority|P3                          |P2
             Status|NEW                         |ASSIGNED
                 CC|                            |yang.jie@linux.intel.com
           Assignee|linux-pm@vger.kernel.org    |yang.jie@linux.intel.com
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
