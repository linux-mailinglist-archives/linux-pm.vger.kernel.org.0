Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C1E575FA3
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 13:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiGOLAc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 07:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiGOLAb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 07:00:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD26C85FB9
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 04:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 605C762272
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 11:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C79EEC341C8
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657882828;
        bh=aTZ+idjntyNAszM+ZQUeUW0P9KTnUMIeVJIje6hC3v4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WsOaIZdtWlAyZdohULXdkqaRv5/l3jN/Ww95rgMaTn1Bc8PRdb86VOhb7vGIbXEQK
         fH4paYSr9kWc2Ova0QmEWP8pwn1gSjT1xz1gbEpv51E2u5HHhJ3MbhtDGwny1tOLDU
         TzLBFQ290va91CwhlV+9jMZIEyrFYSzwui66tw1RtcJhZGV7VQDjvsbsKLO6rgVpg8
         q49l3imuHXv0+3T+Od1bLDlIPCGm7vKjoH+H25ACHIbd1FMflzLYPHwanDnsOXAJDu
         6rWBWy4L6DpOg3QeNa7VBSAEz/6Z5AuZYYhvu3ob9OQ6GvHOK3qPVA2k448UTbtEVk
         qpraqUVC1szkA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B46F7CC13B0; Fri, 15 Jul 2022 11:00:28 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 11:00:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: manualinux@yahoo.es
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216248-137361-svYg8CM19M@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216248-137361@https.bugzilla.kernel.org/>
References: <bug-216248-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216248

--- Comment #13 from Jos=C3=A9 Luis Lara Carrascal (manualinux@yahoo.es) ---
Problem solved. Thanks to all.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
