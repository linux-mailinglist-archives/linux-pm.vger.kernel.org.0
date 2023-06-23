Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B25873BA86
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jun 2023 16:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjFWOpW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jun 2023 10:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjFWOoo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2023 10:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA4130D2
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 07:43:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12C6161A6D
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 14:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78FE9C433C8
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 14:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687531437;
        bh=zbAeW7F37wR98+Ozdb+YfB+DZqqvuYUG+oix/lnJUvE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iDKFKR5jjmL+XdBXAbvrvu8EkXZjh+afHEzz6TELxpmT18X0LqkpJjymMU7MDy774
         oX30RP9HRA76YSlYkyvgIJnw3hT9DC6PKXXoFR1a5QqPXHEXkAMPs+jtkXV81pP9ND
         JRtNvT245ffmTwXw3Z4nkvxVR/NLhM3jT4ZeQb9TpbBpg1Pthx07aWpQ60iEi18XM3
         zEeiQoki1sYVaZ2IoFpmQwSWty5KA+omBXcvUb5oU+YgqYXQPcQx4+TkIDEbVSETbH
         2MBQlTYepHj2s+2shK97FR+deHJWDa9cqwJQtVy8nRDEtulN5O/sS47iNV2Kzr2ads
         Z+aVlfyd0SL9A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6181FC53BCD; Fri, 23 Jun 2023 14:43:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217589] Intel CPU maximum boost frequency reduced after resume
 from suspend to RAM
Date:   Fri, 23 Jun 2023 14:43:57 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217589-137361-qmID73BAWa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217589-137361@https.bugzilla.kernel.org/>
References: <bug-217589-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217589

Srinivas Pandruvada (srinivas.pandruvada@linux.intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |srinivas.pandruvada@linux.i
                   |                            |ntel.com

--- Comment #1 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.co=
m) ---
How did you overclock?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
