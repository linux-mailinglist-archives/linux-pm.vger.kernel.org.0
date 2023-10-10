Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF8B7BFC8C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 15:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjJJNBg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 09:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjJJNBD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 09:01:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C973AC
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 06:00:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDA03C433CA
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 13:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696942847;
        bh=ye6EeOzrs5dNBihjapjy0OSV9nRGdolRA9HiM4wCXkg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=d+vC0V7JmKkZwiL7IBaL5aXmvlyFedgo6svMG+HWBeiQEJ8XZBwrbvZ4Bz/VGO8jI
         p4rHD37F9JUTTlOLhxDdxtvtbsXCchiP7zkZZ9aw1JUgZPvE2iSkf0wrBkUfF0cQcz
         LzIwTm1JDLuexIWlzDTx3VhF86zWBKYg4exYzq2s2GMJ/euZUqTkt/jgMRE2FuadbI
         dMHobSHfUKAnZlsM+eeUKqpUqOH4yIWX8cnlHyQ1z7rQRTPUFXctzDhbK2mN0cYskB
         uiosV+gWlEgXjumO57hD2k9/VvDu52cN2veP7hUyjHk3rALkFcHafAb6jZltmYz1lx
         YzaInZMc0W6IA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B184FC53BCD; Tue, 10 Oct 2023 13:00:47 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date:   Tue, 10 Oct 2023 13:00:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-7KC1Oqc7fN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #10 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hi Artem=20

I have implemented the boost control for amd-pstate passive and active mode
driver, the patches are under reviewing, will sent out for testing once we
finish internal review procvess.=20

Perry

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
