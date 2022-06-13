Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1006547D75
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jun 2022 03:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiFMBje (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jun 2022 21:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbiFMBje (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jun 2022 21:39:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E4B3EA8C
        for <linux-pm@vger.kernel.org>; Sun, 12 Jun 2022 18:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4171AB80D33
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 01:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E98B9C3411D
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 01:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655084370;
        bh=+Bu7RGM3CcPJtZGwXrwfaYH+nWhGXGhutpeaBEAEV/c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EaXaEGh/+XfYIkUA66V5yyPIcfqts6FmKKCT3tOVH1T2LeW95infVK7/WW7n986o/
         kKh5w8tne0caED/F3jbKM6p4Qv+/KvmhzMtAfm1vODgcVXdorsVLzjwrLEhSA3vpKJ
         hg0yPh3fIEsLR8Rj1LVNu+y9MoI6JXC/d6XCe8+Sa/hgmPauEyzdzQdw32kO1yregg
         cXjiSKmlUsyhwRRcOMYlsVTkLbO765wwWpvwcoLeSTMLQH5m8w3fzfgtGscQN2IzMg
         dpJV0XjKi1DduJlmZO2JzhKFA+SFk75BUhM45Sz70n657pLUnLWkq1iZNSDF8DJub9
         hYEkVjmBHkQ6w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D9FCFCBF854; Mon, 13 Jun 2022 01:39:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215714] A huge unnecessary power consumption with
 CONFIG_X86_ACPI_CPUFREQ and ondemand governor - Ryzen 5800X
Date:   Mon, 13 Jun 2022 01:39:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: rui.zhang@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc short_desc
Message-ID: <bug-215714-137361-pNhqVDbEwj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215714-137361@https.bugzilla.kernel.org/>
References: <bug-215714-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215714

Zhang Rui (rui.zhang@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rui.zhang@intel.com
            Summary|A huge unnecessary power    |A huge unnecessary power
                   |consumption with            |consumption with
                   |CONFIG_X86_ACPI_CPUFREQ and |CONFIG_X86_ACPI_CPUFREQ and
                   |ondemand governor           |ondemand governor - Ryzen
                   |                            |5800X

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
