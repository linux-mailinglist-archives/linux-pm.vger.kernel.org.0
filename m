Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B1C4E273A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Mar 2022 14:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243574AbiCUNJX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Mar 2022 09:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347717AbiCUNJW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2022 09:09:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AA366611
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2022 06:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B647B8118D
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2022 13:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22CD4C340ED
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2022 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647868075;
        bh=SkX5HrgXAaYEUpkAiPk0EtRa2b2vqZaBC24ODE96F4A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OAx7ffKtUkmkdyf59uRDJhEKJiSG2oIOzBypSXDd52QHdq1xTKhbUKUvOTv34ghqb
         Hp8foNUi6or15tgIuteV2El1+kYbAtcBhAKVtz2nhdtmC71ze62HphKmBFZXzkb1pK
         y4VtHsJ+0lFuhtHlCgMX4PFqJg0rKKaXHmPMTlkoD2YEDfaWhfLWuU/2ytofKGsyB+
         3Sw69nER0HsaohRcWKF/rBLnt6c/OyZ2581w4pkiO1s4tSHclVVdMPeVr1gZDVwF7A
         VBCI3FBKyGzAbK8B0GrF3xc+zK4wQIDudMYPtt8CgslUgDRdQRhXViXoK9iEt5ipTy
         fm8Mpr+935Fsw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0FF10C05FD5; Mon, 21 Mar 2022 13:07:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215714] A huge unnecessary power consumption with
 CONFIG_X86_ACPI_CPUFREQ and ondemand governor
Date:   Mon, 21 Mar 2022 13:07:54 +0000
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
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-215714-137361-gp5P2HRA0e@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|A huge unnecessary power    |A huge unnecessary power
                   |consumption with            |consumption with
                   |CONFIG_X86_ACPI_CPUFREQ     |CONFIG_X86_ACPI_CPUFREQ and
                   |                            |ondemand governor

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
