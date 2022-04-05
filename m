Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6478D4F20A6
	for <lists+linux-pm@lfdr.de>; Tue,  5 Apr 2022 04:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiDECBT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 22:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiDECBR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 22:01:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3791C2D9B
        for <linux-pm@vger.kernel.org>; Mon,  4 Apr 2022 18:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 76720CE1B6F
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 01:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF581C340F3
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 01:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649121362;
        bh=z7vNxvOqUKwVn5Zi86q3xxv7/1Z+XvcZ1sAHvy2DGto=;
        h=From:To:Subject:Date:From;
        b=JGvsB1MyeurvcslV9CY/ulbtPeb/9PMkdJoqNATIQd/nM5bWEV0GGcBxCPW8ciO0K
         Jc1o/pM59AmIFB/DmOdmhUyqZfhWTICt7p5qqKIL9yC0pQfnzxyJTT+2ONDndiQBva
         mh1aSOPly5AOcGxoS5dUjY2qpti5+Fg1FaJs7eu3clqD/TvQ0KRVIjMYfcLYX7MSlj
         KuFeL2GyAaHtl3SJdESLQfsoHMgeiOnI7uT+qXtqZgzVXwX/sj/aQw7rRRndWfjiva
         i+dDqdkjW6NAsHdoj99ADOa6Pg2E92CLHEkIvAUw5d+t+xNZtRDrqU9qC+YeUsUT91
         IHThv2VNAEmKA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A3C66C05FD2; Tue,  5 Apr 2022 01:16:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] New: amd-pstate does not allow to set arbitrary maximum
 CPU frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Tue, 05 Apr 2022 01:16:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

            Bug ID: 215800
           Summary: amd-pstate does not allow to set arbitrary maximum CPU
                    frequency above 2200MHz for a desktop Zen 3 CPU
           Product: Power Management
           Version: 2.5
    Kernel Version: 5.17.1
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

For my Ryzen 7 5800X I've tried (under root) numbers from 600 000 to 2 200 =
000
and they all work:

echo $number | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq

However anything above 2 200 000 instead makes the CPU stay at 2.2GHz.

This is after booting with acpi-cpufreq and loading amd-pstate with replace=
=3D1.

Even switching to the performance governor keeps all the cores at 2.2GHz.

I've also tried the userspace governor and again only frequencies up to 2.2=
GHz
work. Anything above will be ignored.

I've tried to fix the issue by `cat cpuinfo_max_freq > scaling_max_freq` but
that didn't work.

That looks like a bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
