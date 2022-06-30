Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D74561526
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 10:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiF3Idb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 04:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiF3Idb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 04:33:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACDC19C0A
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 01:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AF6BB8291F
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 08:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48494C341CC
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 08:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656578005;
        bh=MBLvBBhPgdHlgXaya3lfjtiP9xCJdUrqsKck+RbuX6Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Z2/ZHI7kUHpSkl9YewBmpuy16zAeIC5VEzA1pzzilK9NESN33OeXiB5aCUPmXv9sy
         fM71FinFeJdGWgqhDtMcK5fStcxU20X9ckZ2Eyum9LXSCvzgK49Z/PEomMSAk11lpL
         rF4AObSB9m7lQV8X9rizUVZTNGBzDnEUeS/tF+/YLVmZF2Tcp/Ih/+emmgs9tJhB/D
         DUtu+qIvOMn1RXNnxsyhOQKdOKVQb/thudV+R9yZtikgEOybYCiDrkOhayehZcrcGw
         6J6SrBz/X0E2QmisNhiL74+2jYcDSsPVLZlz8bzv86tK2mOjOWK8CRYeJRGuMCuJfa
         GdIoOqH/S78Qg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 318A9CC13B0; Thu, 30 Jun 2022 08:33:25 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216189] amd-pstate stops working after S3 suspend
Date:   Thu, 30 Jun 2022 08:33:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sujinzhou2008@126.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216189-137361-jKgAyP48H5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216189-137361@https.bugzilla.kernel.org/>
References: <bug-216189-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216189

--- Comment #4 from Joe (sujinzhou2008@126.com) ---
Hello,=20

It works on my local. Please try the update and close the issue.=20

Thanks!
Joe

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
