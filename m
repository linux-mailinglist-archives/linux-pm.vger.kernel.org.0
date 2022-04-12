Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F5E4FDB13
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 12:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiDLHsD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Apr 2022 03:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359482AbiDLHnF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 03:43:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD7A1DA53
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 00:25:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 379BA6153F
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 07:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A16B2C385A8
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 07:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748331;
        bh=2Ai3FSshducRmjLrOWQ5GGM+JOOqrm9d0uI84CJLUcc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aEWjJoZ/as7gPq2QTrAV1NOkwTrAnE291+wo+52m2CUSGCBTa1JsKuVJvq/AzJboH
         ipanECGcHiYnvell99yMpmOGR3TkqUSJDZBDbpILTI6uOvTdFFB/mzHMooM5jIcgei
         aSGJE0dRnUCqMv4kyIVisa62ch6OB9mRQTlEadbd000GEKCnqm/GH3Nx9iRxyyKE0p
         EFAXI0H9jM24ZpypfCAhBrZPgmhRDdfa89P4zt+cgdx4OaFS+JzdC9kbPMWbEm7lAl
         SsueShUy8IQE9XFPhEPDraDSJDckJGUYCa89n+sCxMYtJxjCbxt9esVP2OMGTc2yRg
         395OudvK2EBRw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 85335C05FD2; Tue, 12 Apr 2022 07:25:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Tue, 12 Apr 2022 07:25:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sujinzhou2008@126.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215800-137361-7DfNzYzfjh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #7 from Joe (sujinzhou2008@126.com) ---
Created attachment 300747
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300747&action=3Dedit
Max freq

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
