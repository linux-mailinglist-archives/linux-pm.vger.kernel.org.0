Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854287A9FF0
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 22:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjIUU3U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 16:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjIUU3H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 16:29:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA65663E0
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:34:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09A8FC433CA
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 05:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695274821;
        bh=NHrZa2Xp4nWp7oGu4wOjfMWqFY4XW0m+inMbaHLJUOk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gOZ+gly8kCX+LrxfeBGAF8rDR/4DUj/OlVc+YwuYhJCsBxjNDs8Dck8CANk8/H6JW
         WRZjFv8wNBKLF70mmQEtGoSHQHHtbSdWQoDbze+yV4tijyn5SfuyrLo8uudS/xX/s7
         SoyeSgCPCAKfM8Lb701ZEOHrQ/y5dqMdQEmSKCGPmSethOMfXfUrUXpghr6Cwdn/HD
         H2ne0dvDA5tF6PkdCMhTooyQzUVuTuJvL046Jfgzj1M/oRHtYu8aMwuKPOgiAnTKnb
         i5ZDGRMsReUpkk0gz6AxT+I7vGcWWzt7BS4iUK9j4VRwbv2uAP4DEZXR/mUUFovEAq
         kkaHuXsoAX6JA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DBFE4C53BCD; Thu, 21 Sep 2023 05:40:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215801] Rmmod'ing amd-pstate doesn't restore acpi-cpufreq
Date:   Thu, 21 Sep 2023 05:40:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215801-137361-Aba1zfLXqv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215801-137361@https.bugzilla.kernel.org/>
References: <bug-215801-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215801

Perry Yuan(AMD) (Perry.Yuan@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |Perry.Yuan@amd.com

--- Comment #3 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Artem S. Tashkinov from comment #2)
> This is still relevant as of Linux 6.6.
>=20
> Would be great if removing amd-pstate enabled acpi-cpufreq.

Normally the system hardware needs to reinitialize CPPC and low-level power
management firmware when CPPC driver loading, so it better to change grub
parameters and reboot again.
dynamically removing amd-pstate and load acpi_cpufreq probably cause some
potential issues.=20

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
