Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BCC7C9F0E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 07:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjJPFoa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 01:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjJPFo3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 01:44:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76DD9
        for <linux-pm@vger.kernel.org>; Sun, 15 Oct 2023 22:44:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04642C433C7
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 05:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697435068;
        bh=daGrIIjivMK1GecsKyzz3sV3ppwG6cpgQD0LJEJCjpg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=my3g74NfDTdG5BWMnGPcAqqcNEFI1tPZ1iqCFoPoikDgOiiS8YFjSoF3AJyPRd7Xn
         zBhWSYUyhk7UXfsI/2p73lGz3UP7C2I4c//x81FJCzRK6+kk/FnEaXAZvVCB8OO94X
         I1pqCnovE3qJ7BKlKXXWvnZCqe+cEoGYv3emX44c51aGvJh+tOf+mQkKKVzPjxbgUm
         /V9vDzP/YaiC203svRdwVs+TGtMJSvKA4ZDKBkvvfVTsAevlXvB7FAU3wtT44BCh8U
         qAJjCPTiu34EAeYD8VddEhsENNTwpKa0QNPPxHNUHuykgohQZAAEzwyuzUG1LrRc9y
         6BD3I7zjxrtYw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E07C0C53BD2; Mon, 16 Oct 2023 05:44:27 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218013] [question] option
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y available in config kernel?
Date:   Mon, 16 Oct 2023 05:44:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218013-137361-xJ5PSUztpr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218013-137361@https.bugzilla.kernel.org/>
References: <bug-218013-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218013

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
This doesn't look like a normal .config file.

Are you sure your question is not about a specific disto kernel configurati=
on?

Here's my kernel config and it's seemingly exactly how you want it:

grep -i freq config-6.5=20
CONFIG_ACPI_CPU_FREQ_PSS=3Dy
# CPU Frequency scaling
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
CONFIG_CPU_FREQ_GOV_COMMON=3Dy
CONFIG_CPU_FREQ_STAT=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
# CPU frequency scaling drivers
CONFIG_X86_PCC_CPUFREQ=3Dm
CONFIG_X86_ACPI_CPUFREQ=3Dy
# CONFIG_X86_ACPI_CPUFREQ_CPB is not set
CONFIG_X86_AMD_FREQ_SENSITIVITY=3Dm
# end of CPU Frequency scaling
CONFIG_DEVFREQ_THERMAL=3Dy
# Intel Uncore Frequency Control
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control
CONFIG_PM_DEVFREQ=3Dy
# DEVFREQ Governors
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=3Dy
CONFIG_DEVFREQ_GOV_PERFORMANCE=3Dy
CONFIG_DEVFREQ_GOV_POWERSAVE=3Dy
CONFIG_DEVFREQ_GOV_USERSPACE=3Dy
CONFIG_DEVFREQ_GOV_PASSIVE=3Dy
# DEVFREQ Drivers
# CONFIG_PM_DEVFREQ_EVENT is not set

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
