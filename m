Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD37547A93
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jun 2022 16:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiFLOya (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jun 2022 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiFLOya (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jun 2022 10:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0E331506
        for <linux-pm@vger.kernel.org>; Sun, 12 Jun 2022 07:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EB9A60F1F
        for <linux-pm@vger.kernel.org>; Sun, 12 Jun 2022 14:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DABBBC341C5
        for <linux-pm@vger.kernel.org>; Sun, 12 Jun 2022 14:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655045667;
        bh=lLPoEQ4aW20F+FB+DAj+qAAwvcDJHN4ElgpxaifpUsU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bVVdgVb/IBfn/ArD6RppgCe0TMd8RCD5Jo2sESPSpYMX7L3r4aezMN5kOfCB7JKFZ
         +Mc+y8iBWaxV7qWTT2m90CxyKHp/jn+u8ICHqzU9jlxte6JCkvMmJ5wD6ePgLCCi5I
         manv6Kcp7HcDA00ZfXAx5AMI/qtbkOZ/aYRhW2GMs3FwL43E5f5msmID4e7iOMYkZe
         9XQLvFegB9zJz/ZV6jECGegV6eOVCURJvHIk3ptRrU9+OHR2GQ/h3Zhf6I6661W3if
         Zj6/fDB13+fG72iQnYSu3MnNQYrj8vS5zJCA+zm34NnCP0IedI69cJ8QvIplcFRmNQ
         7njs37pUf5OmQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BCF41CC13B4; Sun, 12 Jun 2022 14:54:27 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Sun, 12 Jun 2022 14:54:27 +0000
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
Message-ID: <bug-215800-137361-xFy4nFn2Hh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #20 from Artem S. Tashkinov (aros@gmx.com) ---
> capture the min/max log

Now idea how to do that, where is it logged.

/sys/devices/system/cpu/cpu0/acpi_cppc contains this:

feedback_ctrs:ref:1185870842796 del:939045433401
lowest_nonlinear_perf:59
highest_perf:186
nominal_freq:3801
lowest_freq:550
nominal_perf:128
lowest_perf:19
reference_perf:128
wraparound_time:18446744073709551615

No idea what highest_perf is - it's a read only value anyways. No idea what=
 its
scale is, 0-255? Why is so below the maximum value?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
