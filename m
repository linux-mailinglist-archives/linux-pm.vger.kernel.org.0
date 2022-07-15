Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3173575E5E
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 11:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiGOJUP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 05:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiGOJUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 05:20:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9F564E06
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 02:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 359A1B82B4D
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 09:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6B7FC341C8
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657876808;
        bh=jfiYkHEu66Ken7ZP2sow6zIPMz6LzRAnCg2aAlTO6DE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pSMMnXoCq08BqKmiHCyyPMkhmApSsesy6WsRLyJ8pESwLIzgrpiOMQprY21wWQ9mc
         y73IYUEEPDQjbYzSZvQp8ljkfHMZgbRUucRJc+ZpwtWumXr5OVBRGtYiah4GxotNRn
         dl9YHDexvMQIHGr4Xs4BRkJbRfjQb+b4tfu5M25fBftveyUVMw0zngC1d7fWHGqccP
         /eMG29FSlNUdkz4nfJaCkkWYhOBWTyDrtcJWb2KsYP9wQNhiSjikju5r2riir7JKsj
         xKkW9LeuZzV5QPZRFt5ueliqk7K6hx5pE2E0qXj1BCQMy4f2F4XOls5dG8GhPkqgWV
         8dpFLoeTu9gNg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A0BD7CC13BA; Fri, 15 Jul 2022 09:20:08 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 09:20:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arek.rusi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216248-137361-Kmk1WtW8Uk@https.bugzilla.kernel.org/>
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

--- Comment #7 from Arek Ru=C5=9Bniak (arek.rusi@gmail.com) ---
Created attachment 301434
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301434&action=3Dedit
more debug stuff

[    3.964861] amd_pstate: the _CPC object is not present in SBIOS
is this what we are looking for?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
