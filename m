Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A14575D16
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 10:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiGOILH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 04:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGOILG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 04:11:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720DD7E822
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 01:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0608561EC4
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 08:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6691EC341C6
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 08:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657872665;
        bh=GRZ+izX+tcfEz4fV3vLlA8Rd7wp/2LLgQ73G3Q9qrcs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=r2hdAhPX3jqzy72pnIEB7glvu/DhPLJwloSpeUn0AnGJo8IFVOs/+CxkJ/LGx4nxL
         D+H+33DPUcCtHay8UGHQG7XiuMAIqhpqEI7lTjxCCIJiOnJqAdvj2BwA//p/P9lnGx
         Lev9Ho3fX6Uv5AVjvPl+VO8bSkvJDNEq3P2hcizaJKqxU+N+ssMnqoHRurnkktZLfE
         pJ3YeaQ79JIyt67rZu9XiTg3yAJr1CzEh/c49slV9m9bBdi51o4/bSFzg8htO1W++m
         +fz202hfAMFg7/k8eW88tE3XB+9vrm3CxMPbl25znmdNZ73d+1oo3uKj+z3v5W1Qwz
         qUwBSJiEhi9aQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5360BCC13B0; Fri, 15 Jul 2022 08:11:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 08:11:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arek.rusi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216248-137361-aXeks3aOOj@https.bugzilla.kernel.org/>
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

--- Comment #4 from Arek Ru=C5=9Bniak (arek.rusi@gmail.com) ---
Created attachment 301431
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301431&action=3Dedit
dmesg

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
