Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2198457660A
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 19:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiGORat (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiGORas (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 13:30:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E766F326EE
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 10:30:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4EA7B82D72
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 17:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B719C341CE
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657906245;
        bh=nGFqpo8vN5HQLq44nugRuhbbDnxbC61FlCY5T3fQzUE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KvGOZ/+MyCiG81phjDXsuIozuxn9Cu++BvSo79ZNuNpP+fSA7ScTClK2OmIIsVmuq
         +N1143b7PBw2lwXa3K/n3vuJvTbdqk3Bq0KiaQjVoHcbrd2TDc8+dorzTfV3gVstC8
         uB4ObVMnVDnhZz+KeZh7EnO3wDBogQgsXPTUbqTefWabPpifGP+gaaVhaWdXtp9i+o
         NO96WgWpN+/UzX9qFSFp+5sTdrEHocRYWVatAxtt4FOThlktFdZPYMVOSqW81Az0xc
         EMyfrYKigEBg/c+Q54dOSonT64N4qselydNXoPAIfVcqpPT2GnHzzrwZ/RfO122OVT
         3dm4SxfWK3Afw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2EFF1CC13BB; Fri, 15 Jul 2022 17:30:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 17:30:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arek.rusi@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216248-137361-sTshmSIVm9@https.bugzilla.kernel.org/>
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

Arek Ru=C5=9Bniak (arek.rusi@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #16 from Arek Ru=C5=9Bniak (arek.rusi@gmail.com) ---
Mario, Perry thanks a lot for help.
I've testing patch onto 5.18.2 and it works as before.=20

[    3.337866] amd_pstate: AMD CPPC MSR based functionality is supported

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
