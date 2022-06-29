Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995F95604B2
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiF2PeK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 11:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiF2PeH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 11:34:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB77E22B07
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 08:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 24407CE248C
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 15:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DD86C34114
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656516843;
        bh=NxeirAMr+Us7OlXqknOjqeiyLuB94tdaBst8LW5JIgg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fBLvNmIdaVMRIR2JsrM72AwM/Lv7GVEBLGQfK+JsCGvnIj6HiqGu8VmVNj+Y6qm49
         MRSQTW/ZBAmNEyIVK3MxJpp6NnSeWKCgp876mPtuU79xVwmncXbM9x0jOU7nc2o5S6
         ahoFELhXGQcAz/VmUxs4vs0hoKtS2/KR4/pDAIGIEOkiJtEqrBZQ9vC0c3F82lVDX/
         6YQY0ewG/cA1o4LqXAeS1HLuR7jYKXST5aKFY0IYLRxOk7Lsm6jWIrVyC91H1iNmGo
         I460cQBkBSomyo4NTBsGtz4VVhFKe0L9+72LLRhFUXSNenvfBxBrK+t9SX3wx/ZXII
         L2t7ERhXtiOwg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0B959C05FF5; Wed, 29 Jun 2022 15:34:03 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216189] amd-pstate stops working after S3 suspend
Date:   Wed, 29 Jun 2022 15:34:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: a@annel.in
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216189-137361-ShicoHlMw0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216189-137361@https.bugzilla.kernel.org/>
References: <bug-216189-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216189

--- Comment #1 from a@annel.in ---
May be duplicate of https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
