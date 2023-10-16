Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF247C9D7E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 04:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjJPCqW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Oct 2023 22:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjJPCqW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Oct 2023 22:46:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A75C5
        for <linux-pm@vger.kernel.org>; Sun, 15 Oct 2023 19:46:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 455A9C433C7
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 02:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697424378;
        bh=FZGU7hv8Lj7PQ3PXAUd6Fpq6k9alktet7bFE5DkfbUo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Y2ywGx71p4a2uvMLUeKJae/DP5jNcd85Sn6w6OJzXjbK66FdJ1TJby0hoJmvqoVeT
         UXmU0U8PG9bFXMT8OfNK/P+AW5FM0Q7NXaCLb3IRBReDDw+aIIacc5PjrzSavAa6br
         5r5Of8rVZQhe55Bu2cou4jlxpoh3IO6sBYUFQ3YRgaSMAZj19NRieWgJ+W6s2KPkhP
         itkpvj3ajLhnjtNHmYl000iVdpNM0dNgXTrfrxhGqhYRNXjZUxIMsYx9ujoS5tj7TU
         oQ6QWaOUNdgulzPgaiw5/gI1otLzXQ7MargXtembHsZ3KDAWMD313Zl8/cFuKE8qye
         qAkiQIgAgTdMQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2C2FDC53BD2; Mon, 16 Oct 2023 02:46:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217618] Changing maximum frequency and boost state does not
 work with amd-pstate in passive mode plus the schedutil governor
Date:   Mon, 16 Oct 2023 02:46:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217618-137361-vDhxU1imJB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217618-137361@https.bugzilla.kernel.org/>
References: <bug-217618-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217618

--- Comment #4 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
I have implemented a new boost control with a patchset that are under inter=
nal
viewing. it works for both the passive and active mode.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
