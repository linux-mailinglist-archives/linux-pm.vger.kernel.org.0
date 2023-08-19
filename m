Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A309781BB3
	for <lists+linux-pm@lfdr.de>; Sun, 20 Aug 2023 02:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjHTA2J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Aug 2023 20:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHTA1m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Aug 2023 20:27:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C7311C246
        for <linux-pm@vger.kernel.org>; Sat, 19 Aug 2023 15:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 957FA61D0A
        for <linux-pm@vger.kernel.org>; Sat, 19 Aug 2023 22:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDBBAC433C9
        for <linux-pm@vger.kernel.org>; Sat, 19 Aug 2023 22:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692484696;
        bh=SN3BNIuPEy4bSj1HUPaeSzEzCA800LyZc95ZF4vTMH8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Q23WDCRsgcyw1yAtpK/xxsPqDBKJuh5Cto8NTEpJZNFr5ADAcr/zPMXIywhcwH44y
         bvbM9BpJCgrUAJZuFqnAirxHW0SUCP0pYtsCK1i263RR45kKnpKfzdU+w/g+KNZNr5
         5VpTFLq4LeAGUBiOdTed9DQPdC0wLUoi1FNcj7lqJ/x5xbZf0NCqd2GNpbMRjk3zpB
         oiv4kJIjxw1sCAHmR6MuwXzlcuHCpq5dTWvTk1MonJ2GRmX591kiwX5RwqKGCNJL0o
         UKhKhQm1acGR1a86bHTVirOQosvbolrRGFzORhB4JmLZ+aaUXS4G8akHOJeRvafm6a
         jf1IQ2WP6qnSA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D635EC53BC6; Sat, 19 Aug 2023 22:38:15 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217809] Core frequencies do not float correctly on AMD Ryzen 7
 5700U when running on battery
Date:   Sat, 19 Aug 2023 22:38:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: soren@stoutner.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-217809-137361-won9PdcSP5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217809-137361@https.bugzilla.kernel.org/>
References: <bug-217809-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217809

Soren Stoutner (soren@stoutner.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |soren@stoutner.com

--- Comment #1 from Soren Stoutner (soren@stoutner.com) ---
Created attachment 304913
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304913&action=3Dedit
Screenshot of core frequencies

This screenshot shows several KDE widgets.  The one on the top right shows =
core
utilization, with the second core (blue) pushed to 100%.  The second widget
down (which is expanded to the left with a detailed view) shows the frequen=
cy
of each core, with the second core locked to the lowest possible value of 3=
99
MHz.  It also shows that some of the other cores have floated up to higher
values even though they have lower utilization.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
