Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B329545005
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbiFIO7S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 10:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiFIO7R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 10:59:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A3A6E8E8
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 07:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DCE67CE2F5C
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 14:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04F18C3411B
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 14:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654786752;
        bh=o7H4ZO+2+4Df8MOc+Plpn6IJtVntPj9IWpvfx2rYp40=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LaLzFzR7XmKlNq8FggbzzKZiHxjx8hJwJpJg7EJe+W/y+U7FRxNEIaCQ6J0EDb2Lb
         cMzOaTgReOnPN5+14nTYAbGsgmhWJxEO6eHHnIA2kRYwGDxQAEie8ldGTYw9H4vceu
         GrOj73dxPn9+k9wAmMSJfpUm6X3cp+elNf4eTz7Qq2truOWWkmgwua33/Z9mj1Ah3U
         4fKqOnqhbo/J7V2gMxw8v38EgIj18GPsdCZ1anBCFcoXTlYLYfho6I2REK4+lJ4vbi
         14QFz5IeXJFb1cwq94I3fXexdIGWdIf7kTGmM97GlPjG7nMMuWLiI8FSRSwsSlns5F
         k+fxkLE7M2jaA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D0816CBF854; Thu,  9 Jun 2022 14:59:11 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Thu, 09 Jun 2022 14:59:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dev@alexmaras.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215938-137361-ghxkfydbhy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #9 from Alex Maras (dev@alexmaras.com) ---
Created attachment 301137
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301137&action=3Dedit
dmesg output - 5.18

same process with dmesg output with kernel built from 5.18 release tag

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
