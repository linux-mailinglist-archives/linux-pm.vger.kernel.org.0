Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9FA7D4E73
	for <lists+linux-pm@lfdr.de>; Tue, 24 Oct 2023 12:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjJXK7y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Oct 2023 06:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJXK7x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2023 06:59:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58722E5
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 03:59:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB559C433C9
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 10:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698145192;
        bh=iaYto1K0nlDeiJSMVMYvehPDbrJXSJak3XLJXE1lilA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YicriJWFbFAFAP+DrnnXJMQgf7pqwB8jI7mU7qABpf2FGuOeF08kTr+Gn1GV28g1n
         FGrzqYlFVxhL/ib3PUPFUMbOWrLNhIVg+XPZqoaltA6iP3v0VEsRzVvTcB4AtqiKXI
         9qjEvzH8u5UG7ctHL1ifn20u+78S57p8MdtbVmnzeRcmtE2ljBlveQPDyNh1suwUSV
         o9BO7B8+JRlNvEJecXPp7obTSkyRKhKgjYA381MPINp9WI0JFUmv+AsCxdPHqE+gpn
         6/BHQyhS0pzLVkpypzO10/lF5CnYHUkw8ye2tG5OKLfwMHjEW5QdKNWcIkRkHKOcp6
         D4j22E2TkjlGQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D5D3DC53BC6; Tue, 24 Oct 2023 10:59:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218041] Buffer overrun in devfreq trans_stat_show()
Date:   Tue, 24 Oct 2023 10:59:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218041-137361-5ozZQc2e4X@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218041-137361@https.bugzilla.kernel.org/>
References: <bug-218041-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218041

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ansuelsmth@gmail.com

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Christian, could you take a look please?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
