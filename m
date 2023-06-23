Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D4B73BC90
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jun 2023 18:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjFWQ3h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jun 2023 12:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFWQ3g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2023 12:29:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC44189
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 09:29:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99A7061A91
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 16:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05824C433C0
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687537775;
        bh=2THy+0iqx6M1bCtK/v37avQQjssgWqELbXndv2StP+Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YWMdZYqGDwv+YINseP/upIOO9E018bQuA85GBh1TQMXbH4VCMR7a/z3wQvYX7aBfp
         s2ooD+1P+ANkJ++l6PK0ZK6NvGHzLOA15dp5r1j+el3Wm4G0O7I7g+I+IgwbOlfRat
         yTMQxxcmRrpmD9xKmY7QUBuRFk6ttxn2YvBTMwgvrhJU/HgwycTyJnAdiP6GOFolDg
         8P9dr45o0dS1ce6X4BQwjOp7Lal3ldR/QhQEOQGaDr/nyCtUmIa9JYY7t6Aznn1txa
         0w5pTxpSrKyHXvOdWIW3F1M1ZNYQcGqqqXOIYrfOStj4+K1WCOMS7kvwXOkoaJZm94
         lMeTIF1n9x11w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D2861C53BCD; Fri, 23 Jun 2023 16:29:34 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217589] Intel CPU maximum boost frequency reduced after resume
 from suspend to RAM
Date:   Fri, 23 Jun 2023 16:29:34 +0000
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
Message-ID: <bug-217589-137361-0Fw6xYBnY9@https.bugzilla.kernel.org/>
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

--- Comment #3 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.co=
m) ---
I suggest to dump
rdmsr -a 0x774
before and after suspend to RAM.

They should be same.

The problem is voltage settings done via BIOS. OS doesn't have support to r=
ead
and restore. That must be done by the BIOS.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
