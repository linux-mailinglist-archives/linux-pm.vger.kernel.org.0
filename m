Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F047C549C9F
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jun 2022 21:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbiFMTBa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jun 2022 15:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346159AbiFMTAw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2022 15:00:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A114553D
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 09:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96BE0B80ECA
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 16:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 368C9C3411C
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655137520;
        bh=HsKADRwYWcQ31KE+7JTyOhtuKmLHfgAH3VfqLfurEO0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rnNrF5EOAoY2/mbidwdk309+bzBJGECVUn1+pfjnMrqvWfW0nmUyxWC8/PsDifQuS
         ceRsbCj8jOA/4KRI/DKfej6w6tJPXWhk1SfcmW+CZH3/oi8SUv9ezYR5inllJNELrz
         ZpZHshzIorZzWCUQCVkqFXlodSSWcX9zEfnrC3dqtW4k38Unb155QwTQsxzH2AdslQ
         H9X4XfXwqWgy449IdPKMo80mVDzFDyGOaR3yKBu1C/ytbUpepFNwwdcrqhLpwuqyvF
         m6e6FPRvbSXgCstQXKrBLQEZHUl55kH2QWTO3RZBa8YTRirgLG/PnJa4ZLskMgw0xd
         Rr/z7orZDQZ7w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1D6C0C05FD5; Mon, 13 Jun 2022 16:25:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Mon, 13 Jun 2022 16:25:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: perry_yuan@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215938-137361-toY8hyqcag@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #15 from perry_yuan@outlook.com ---
Hi Alex.

I have been preparing some fix patches to resolve the prolem.
Will update here after patches sent.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
