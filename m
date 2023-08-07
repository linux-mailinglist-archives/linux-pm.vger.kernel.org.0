Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60885772A42
	for <lists+linux-pm@lfdr.de>; Mon,  7 Aug 2023 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjHGQNh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Aug 2023 12:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjHGQNg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2023 12:13:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2821510C0
        for <linux-pm@vger.kernel.org>; Mon,  7 Aug 2023 09:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F2ED61EDA
        for <linux-pm@vger.kernel.org>; Mon,  7 Aug 2023 16:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10C79C433C7
        for <linux-pm@vger.kernel.org>; Mon,  7 Aug 2023 16:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691424815;
        bh=lRlHvtd7FbBLq8M6UBbyhU4GRtDMFLzif1ldTuSzJn4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GXfbmeISq8T8xQ3YUfY1sZuQMMPbvNHObAuGMQS3uYiZdNi4jX0IKSvTjRVDXqAuv
         pGIl9i3w39vTLNbHE/JHUM8LjUhnooE6eAMAOH/4Yq9nTEmtlYpMZ0ZFNQwizACPV8
         6x7b8mf3ZY2ljg4CvbT+gn47quWTC9eXZ7WLqwzs2qzWXQ4QcRKROZsxF+y3UYY5aE
         YgsllEYmCYvVQ/sHmvNvqQXxsz/G0W/s+LXCysleJXriD3J8aAAK65W95bZzFXMfsK
         SH6TXBDJkorXE3elNoY5ySOLHxNNcBUt2RFnMO3Ilr6V+vE2RdCwlEB0zqUCSi/2Tf
         1r8c6T7gh3lcA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E774BC53BD0; Mon,  7 Aug 2023 16:13:34 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217765] CFI violation when reading amd_pstate/status
Date:   Mon, 07 Aug 2023 16:13:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ndesaulniers@google.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217765-137361-FyC6goVV7U@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217765-137361@https.bugzilla.kernel.org/>
References: <bug-217765-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217765

Nick Desaulniers (ndesaulniers@google.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ndesaulniers@google.com

--- Comment #1 from Nick Desaulniers (ndesaulniers@google.com) ---
Thanks for the report; I've filed this in
https://github.com/ClangBuiltLinux/linux/issues/1901 where we will track it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
