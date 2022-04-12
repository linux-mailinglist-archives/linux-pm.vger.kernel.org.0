Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6C14FD964
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 12:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354531AbiDLHsE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Apr 2022 03:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359872AbiDLHnt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 03:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4934504F
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 00:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0990614FA
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 07:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63753C385A8
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 07:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748395;
        bh=lE1yoAe4JM8MtQFRGZCzsy3O5t+1jodlIk/tbyA0dyA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dKIY1SAdMpcSKsV5a90txGCX6lwp1cLcgf69Vdvbtbqwr4mFTKRVs5PRM8nwpKRg9
         D5QVDVs+8WcswHYmXIwgG8D87dZ7hfo9jhZ46/sktmImBlZiLXkVMgTtYpQIltUtaE
         CtFfHgyVFqcBLCsCUhFFf52dWvpwid5pkyXa9gVx4U5/sj6ga6asQIwZhXFrYoa0q5
         hdyb4zNU3IfR9RDZJ6xjhaIHTF8T8iDJ/OEzHnU52/50RPTQSP0AlMB8snQ32jQ4ha
         PFzZYS76YNexdmEP+6SK3EOKdMHzVX7x4R4dsyoRo2w4uwUQZmHzjbr/ZoHS0csSTg
         EoX0LM/Ixt6BQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3C8E0C05FCE; Tue, 12 Apr 2022 07:26:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Tue, 12 Apr 2022 07:26:34 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215800-137361-poeFlnrtZP@https.bugzilla.kernel.org/>
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

--- Comment #8 from Joe (sujinzhou2008@126.com) ---
Attach is the operation step on my side. It works with root privilege.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
