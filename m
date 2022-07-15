Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CD8575F89
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 12:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiGOKwN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 06:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGOKwI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 06:52:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6884C7FE40
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 03:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F2E8B82B61
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 10:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9427AC3411E
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 10:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657882324;
        bh=SZ59goTl2L49whhcpE8L9HYxrnUPH9mKzRutGCU/w2E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fPh699dQgImsHmH+14+4T1yR3dAXPdkduIfbHY9z4UXZo9MZwOj51LPPZ7ffwQWbF
         qbK3KnEHqVAqWLTDHaFMd3/NJoBxS5gvQ29badNtVSQJfR4RoDBlxMUWpO5WtEygr9
         qzq6YTyxm3i7aGEZBHVr8pTa7g8vaCZ1I4KetY15P1ljopFWBZzCpJPa1io17WxZer
         3cthD3ic52NNMl9AgkkyqSbyxjiQa8NZMTXsNQ1Qh8tKABnC8r/iqQvCl4qCiWjdJL
         L48DW1ouQgrDpti6sC71gawcAbdjCjqfaO/9vslHqGYaT4qgBnm7H+hXr+s04U5BLr
         PfAL2Hk8YG2xQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 7B7E8CC13BA; Fri, 15 Jul 2022 10:52:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 10:52:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: manualinux@yahoo.es
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216248-137361-JJyGtmAbqG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216248-137361@https.bugzilla.kernel.org/>
References: <bug-216248-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216248

--- Comment #12 from Jos=C3=A9 Luis Lara Carrascal (manualinux@yahoo.es) ---
(In reply to Arek Ru=C5=9Bniak from comment #11)
> Hi Jose, did you try:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/
> ?h=3Dnext-20220714&id=3Dfbd74d16890b9f5d08ea69b5282b123c894f8860
>=20
> It's fixing issue I've mentioned in #1

Thank you, I will try it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
