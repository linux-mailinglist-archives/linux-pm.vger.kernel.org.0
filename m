Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330C17A1BEF
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 12:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjIOKW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 06:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjIOKW0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 06:22:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BA01AD
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 03:22:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2A43C433CB
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 10:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694773341;
        bh=DErf7eowDxw2vkaGYYFicF7i/jw8IkvE2vw4rQlh9/U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jcdGh+gVlYlLSWdTEUc/tpbK3T+x5jqdCNxwxmIvxomrzQoTji68JzHa6pI9yZ8E7
         md5aWc3b3n7mkbOAXE2itdi9dNdAzC5o6JnNXU9thbbxzFhLxCylAxxr0KBydisV2d
         O/Fnjwvbdl8GkF0ne7XtugXlQARXTH/7JP21JU+p7LNYcL9j1ggtljzhYcyx/MQYUl
         nB8wJwBjypUtKDrT+4/eHuPw5/qzoPFrkiE5qKBiGtMJzs6HyWPo340HHuMnUp/AOz
         hT9WGnVe9PaDUy0uiyHVNzlxagcQ8UxMCJRfVJKBCJ/DnlkzyB7nInaSCMjoEGyIoV
         nsz7AEIBqn9kA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AE5E3C53BD5; Fri, 15 Sep 2023 10:22:21 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Fri, 15 Sep 2023 10:22:21 +0000
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
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215800-137361-vHWw3dmgfx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #32 from Artem S. Tashkinov (aros@gmx.com) ---
In kernel 6.5 the values of
/sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq are simply ignored.

Looks like setting the maximum operating CPU frequency is no longer support=
ed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
