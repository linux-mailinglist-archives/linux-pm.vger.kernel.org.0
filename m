Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2165604B5
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 17:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiF2Pfj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiF2Pfi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 11:35:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8D22FE72
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 08:35:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6CA9B824DD
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 15:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63119C341C8
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656516935;
        bh=1t0qnH5B02hPf7OgcasR5QtNPz8pxhl5B0buxQTR3o4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aSd9bsqqUc3K8tIKaaws+nkqA0VTzn2vl1Iw3UI3KUc/x6phHT/qFHWdjcxNNCf1v
         Z5D+XqmMpVdg29Hjdo8iY/DntDLlpqUffwk21aQ/wPgS1vWSWZXtqhcrlZEOBzbjSE
         2333COH7SirYWH5HX/cAjX2HlHTPAXk6iMC7qa2O4ZEmD/t1UuOTABHmlstAt1+1ka
         tFcGJCv17L0EQcoq8zXViel7NtsuCkKul0U3sccvk29CnnSlGWbBGv39Arcq3Bvu2a
         AU84AnGDzdXYxV/Ix2HywpjiHvjPt6yQff4QEPrbzV3enlb5EPGXoFiKJaN+cQzDyl
         NWRi8S7+/BaFA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5169FC05FF5; Wed, 29 Jun 2022 15:35:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216189] amd-pstate stops working after S3 suspend
Date:   Wed, 29 Jun 2022 15:35:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: a@annel.in
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216189-137361-emrt9LzVkK@https.bugzilla.kernel.org/>
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

a@annel.in changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #2 from a@annel.in ---


*** This bug has been marked as a duplicate of bug 215938 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
