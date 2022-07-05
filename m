Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB46D566629
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 11:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiGEJaD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 05:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiGEJ3b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 05:29:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E433DEB8
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 02:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66031B816A6
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 09:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25F91C341D0
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657013339;
        bh=dDsk/0iHsfwB6mPPSmyk3ZpsD8SvIvj4N+YQNC3tzZ4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qs7PHiZdWFPXkzB2SG/io/3KGqgFhom4zsufvIANfRorKqhSK8RwHkZ4bDVAnpxzO
         iMHsJAGywvq8qEh3/3p57SGeRVLXVOnlolWhUizFE3RWpQmEh4Ca5zD/ww5ROx7O5C
         8Vvi/O9SNCXMl1rrugXPqvWGp7iD7YExMSlSaRhWzmenLYEleNAujka+37Y+fsJrh7
         GQD7yPMYZSA9Jx2Xw9HxSjCejDQIp2y3NeAvGsZ0oMmV0Fu50flYzSnyUp1QsjO9Fe
         x3OJxf6UBRdBozEnbikncKSiu6ZPZUmyDCLspYfZlK7Nq5gzmHOIDSyFP+6rcEyOso
         QUNGhaBGhZrYg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 08E95CC13B1; Tue,  5 Jul 2022 09:28:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Tue, 05 Jul 2022 09:28:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: perry_yuan@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215938-137361-UZoih0iMk2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #19 from perry_yuan@outlook.com ---
(In reply to Alex Maras from comment #18)
> Thanks Perry - tested and working as expected. I'm now able to set the CPU
> freq with amd-pstate, suspend, resume and see that the cpu frequency limi=
ts
> are now respected correctly, and changing both the governor and the
> frequency limits works as expected.=20
>=20
> I've set this to resolved with a code fix.

HI Alex.

Good to hear that.=20
Thanks for your confirm.=20

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
