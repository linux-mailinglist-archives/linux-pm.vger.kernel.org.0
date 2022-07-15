Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4F3575D1B
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 10:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiGOIMT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGOIMT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 04:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83867E828
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 01:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54181618BF
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 08:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3E5BC341C8
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 08:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657872737;
        bh=lbXmW925DZiRWEhZAzwJ7uVbN9T1lDyYmhekd8Nr7uk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XmIwUWpqkvN4/DNpJxVLBOPEApAkZA66ICM9JxNx1ddxjKkGb2QMe8ESPExtifN6u
         f7YTijoTDYup4OtQrQNd0U8zdi+BX8xFMSSJMr6JQe+2x1oaixSOlbqMdz3svY9zLV
         AQmDbXiac5+1GLGzSx7m922+K7n2dN1z5o/KQ2NzmP9yEdQNaFBLA6JBp5bPlyFLkz
         17LoyUuNMEaYb4xQjxzvJ0TSntiAmfzfQ9tisk93bE2kCfrH9qpFKdDnCYzYFXwjbo
         dJpT0t1MUshRAWQxYnBjRZTKITku7sKzbKgt2ygCMYw5cUKA2Hz/stox3wusgkoqFO
         Y9s/QHRpAEUDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A2153CC13BA; Fri, 15 Jul 2022 08:12:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 08:12:17 +0000
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
Message-ID: <bug-216248-137361-D5QTMww0Qw@https.bugzilla.kernel.org/>
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

--- Comment #5 from Arek Ru=C5=9Bniak (arek.rusi@gmail.com) ---
Created attachment 301432
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301432&action=3Dedit
acpidump

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
