Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87717BCF7B
	for <lists+linux-pm@lfdr.de>; Sun,  8 Oct 2023 20:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjJHSEM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Oct 2023 14:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjJHSEM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Oct 2023 14:04:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BACDA3
        for <linux-pm@vger.kernel.org>; Sun,  8 Oct 2023 11:04:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 008BAC433C9
        for <linux-pm@vger.kernel.org>; Sun,  8 Oct 2023 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696788250;
        bh=uy2V2PvEav49NAH17+geiAbUuH4IaLzI5If6r7Ih/50=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=n5BtYxdKDAJWMvnoYyM1TdSMoTO6gFvQZKcqk8i4OTuM0LzXD/ROUPCW82KgKncuY
         SF/U1ctOGT/0bo73aeoMZWBbynPwepkVazcY0yFu+UYXGFK47eij72biHrRpdB39Tm
         ias6qv+dkiKA19XiPI48YcQ1PE2+BLUyHrL4ZFxBQX0AqIf5sxqbW7w7dJnuTK4NJT
         MCZVaj5j/96vJAKtLyjCgTkOa9p1yVwbwSTbTsp5VqdKz64B7Y8BOlHnjciz9BoIvr
         sI1pneZjaKr9iqLWU8i1uI4bf7z/KQx1z/Q1luLIPWw4kzHo65WMiIUSq/UzYLs2V1
         Dgk238UWlAunw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E38B9C53BCD; Sun,  8 Oct 2023 18:04:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215714] A huge unnecessary power consumption with
 CONFIG_X86_ACPI_CPUFREQ and ondemand governor - Ryzen 5800X
Date:   Sun, 08 Oct 2023 18:04:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215714-137361-StQD8NAY0K@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215714-137361@https.bugzilla.kernel.org/>
References: <bug-215714-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215714

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
This is reproducible for other CPUs as well.

Watching HW accelerated videos in Firefox results in ~40% higher power
consumption than necessary to actually play them.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
