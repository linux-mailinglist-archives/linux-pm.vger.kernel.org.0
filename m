Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F57E73E5F7
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 19:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjFZRF2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 13:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjFZRF1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 13:05:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F69BE7B
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 10:05:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29FFB60E93
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 17:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EE47C433C0
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687799125;
        bh=abb1lXgksV3Dohs8wJ5FuNTy5Od6BCZn1LwV79ie2pc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Y+52jZH+7eT0D+oX7fjgs5z3VgL4mtDAIKcdHLoxg03RWptmQnh/T3V8whyVJK5QJ
         xQiTaP5ex/xue4r1LbKn83VdcENxzZAd8Na6wdZ6xujBBaJzr5qEXQ2Hs81j5IicVA
         7xxE9yTUZYxhVcH6039WYdPNDtGZIiOofbGTikEyz0XG8tA1dAz5H4TO1fQHX3FQcJ
         QHCbCQprG/VnFAhXxPaOLfEMc9FVZa2e2HepP3txUlvXkKuMNqtZltdc0m5G4Xni2E
         cODj9gjSfCCLAGvs93ElYN3FcN1Tsz2R/576tA6/C4519HNPJnqmpXEkn5GdbHhBXN
         hpMvcxmV0rnzg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 62CA9C53BC6; Mon, 26 Jun 2023 17:05:25 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217589] Intel CPU maximum boost frequency reduced after resume
 from suspend to RAM
Date:   Mon, 26 Jun 2023 17:05:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: srinivas.pandruvada@linux.intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217589-137361-TJUzbQR3rj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217589-137361@https.bugzilla.kernel.org/>
References: <bug-217589-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217589

--- Comment #8 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.co=
m) ---
It is indicating BIOS issue.
Please dump:
rdmsr -a 0x771
before and after suspend to RAM.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
