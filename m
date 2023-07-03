Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F607453E6
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jul 2023 04:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjGCClq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 22:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGCClo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 22:41:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABB9188
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 19:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEBB660D37
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 02:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27690C433C9
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 02:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688352103;
        bh=0ETXk4ScxWPIAbbkkWgBm/QNPofe0TnLdHK+I3IC5aw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VNqwq+HtfNvZFYhcrJjfmlVrUh7Qm92PDV8ZHIbnW4LXbecslHhI9/8S9W6CQn5nc
         oeeCkXaTEPlJ5+wvHfl4lNj/PEO5NuXbntcP4fsphOPz8pHkM5VOGE9WU5SNpMwQKr
         FtoTU2IERrEnnwWuc3rN1cPXGfJxzo8JPay+XudXcWJlFn5dcX3E7QBYTqk4L3BoEN
         D8S9DlELYEQDoS/UTkLAmJdn6s0lX8nXUeAXQyJAcvb2rDSIK+ep7EQ8tPSLEHh9EB
         xLcfCT5bTWm3H1zp4I2axEfQOLCGXfOPZo62wcBdqzrl8WZmU9Sg27b/nXN19ZUmhP
         w3EY4VWeIkGyA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 09F8CC53BD2; Mon,  3 Jul 2023 02:41:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217618] Changing maximum frequency and boost state does not
 work with amd-pstate in passive mode plus the schedutil governor
Date:   Mon, 03 Jul 2023 02:41:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: putr4.s@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217618-137361-NW14y8Slzk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217618-137361@https.bugzilla.kernel.org/>
References: <bug-217618-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217618

--- Comment #2 from Prajna Sariputra (putr4.s@gmail.com) ---
Here is the output of the first command:
4785000
4785000
4785000
4785000
4785000
4785000
4785000
4785000
4785000
4785000
4785000
4785000
4785000
4785000
4785000
4785000

And here is the output for the second one:
191
196
196
166
166
186
186
191
181
181
176
176
196
196
171
171

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
