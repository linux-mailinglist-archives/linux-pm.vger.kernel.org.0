Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9EE7C9FAD
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 08:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjJPGea (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 02:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjJPGea (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 02:34:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D9E97
        for <linux-pm@vger.kernel.org>; Sun, 15 Oct 2023 23:34:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0528DC433C8
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 06:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697438068;
        bh=DCZBrjUITnXCdX5wuq1pwZ5ISj78xcUaEvAY0kZaUwI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=td6ZRNINXNbjrwg/Y3I3oxOaZgB8+/0gPuVBPGYO+0FQZ7+QksOyHF2idsazWF7vV
         un/Eu0aF/rB35ivMrW6/7HySjaBpUluqKCBgdtSnFfMyR2kHjUBseg+BxAlwYnZuB/
         3MbWbq33gCy1c3zOhB605gpstaSSTuQGMx23lOhy4CwaDwWGR1U6WV1CjHBHxyD5Wf
         Q16AiLkrFu3VYez5Cl2W7S4mJxnVXGzKdsx0+XYeq/PxXHVG5gcysgbbdQTxpBeyK/
         j6kExSsHSIxza08SCP36VGL3hY7KUGsz0lZiZlCBe4e6qLFjFxAYPm5YOquuDnnqRS
         16KOo7Wz5XHVw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D6874C53BD0; Mon, 16 Oct 2023 06:34:27 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218013] [question] option
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y available in config kernel?
Date:   Mon, 16 Oct 2023 06:34:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218013-137361-H7C0GNMEAt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218013-137361@https.bugzilla.kernel.org/>
References: <bug-218013-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218013

sander44 (ionut_n2001@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |REOPENED
         Resolution|ANSWERED                    |---

--- Comment #2 from sander44 (ionut_n2001@yahoo.com) ---
Hi Artem S. Tashkinov,

I use vanilla kernel.
But this option is not available.

I have AMD platform.

From what I noticed, there is a condition in Kconfig for this.

../linux/drivers/cpufreq/Kconfig

This is a option:
And i notice this: depends on !(X86_INTEL_PSTATE && SMP)

config CPU_FREQ_DEFAULT_GOV_ONDEMAND
        bool "ondemand"
        depends on !(X86_INTEL_PSTATE && SMP)
        select CPU_FREQ_GOV_ONDEMAND
        select CPU_FREQ_GOV_PERFORMANCE
        help
          Use the CPUFreq governor 'ondemand' as default. This allows
          you to get a full dynamic frequency capable system by simply
          loading your cpufreq low-level hardware driver.
          Be aware that not all cpufreq drivers support the ondemand
          governor. If unsure have a look at the help section of the
          driver. Fallback governor will be the performance governor.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
