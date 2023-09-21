Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153D17A97A4
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 19:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjIUR0h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 13:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjIUR0f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 13:26:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278CFCD3
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:03:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58F57C116C9
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 08:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695284285;
        bh=D8V+TQFZG9rU+mIOSaehx4C3OFiPh/LaJ48LHYRyM74=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nt/tvg9F4UuR79pRiBA3aksqEbPs7/wuL1bAoDgWKBRZyUXW6LADjG4rD1kgtkPGa
         X18uljDf2xnFRneYtbi6PjKj7cm+WovEMznDJxBvbDMZR031PyGO8xYLlrd/txfpwL
         lyGBBqlhocbcjkJ6AwEjg6yt0fQW3128bXTBcZYftMn5a8oAYA+pl9GuQTDJ7RyRZb
         D7yYU14N6N07iBUMSAlmQaEe06ofuRGcfIS7WXjPKb+TMUTXRXWZKF2l680OlDMIBo
         8azftFTxPUYrqS4Y6MqfwRCXDSb35LiTRl0wQziSubKmPv4q4+pDL+WFoBcCDL3t+9
         NfYVoaaGJLWEw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3FE5AC53BD0; Thu, 21 Sep 2023 08:18:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215801] Rmmod'ing amd-pstate doesn't restore acpi-cpufreq
Date:   Thu, 21 Sep 2023 08:18:05 +0000
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
Message-ID: <bug-215801-137361-WGuteNqqJi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215801-137361@https.bugzilla.kernel.org/>
References: <bug-215801-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215801

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Perry Yuan(AMD) from comment #3)
> (In reply to Artem S. Tashkinov from comment #2)
> > This is still relevant as of Linux 6.6.
> >=20
> > Would be great if removing amd-pstate enabled acpi-cpufreq.
>=20
> Normally the system hardware needs to reinitialize CPPC and low-level pow=
er
> management firmware when CPPC driver loading, so it better to change grub
> parameters and reboot again.
> dynamically removing amd-pstate and load acpi_cpufreq probably cause some
> potential issues.=20
>=20
> Perry.

Could you add this as a note to the amd pstate driver documentation?

Documentation/admin-guide/pm/amd-pstate.rst

Thank you!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
