Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73127CE6DE
	for <lists+linux-pm@lfdr.de>; Wed, 18 Oct 2023 20:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjJRSij (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Oct 2023 14:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRSii (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2023 14:38:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCE6F7
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 11:38:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34936C433C7
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697654317;
        bh=LFUgayu+9rk6ceKHKIIaGE7qskwnLsaaXiMbRxwR2jI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uKw0gzMwmd8my9qcdUQm0qHVNO+FJhenHw1pPf4nC91yQossZZ8dmSUcxumjYfdxv
         /HExL+W+cCDfCN0gDpmwi8BXn7+UBjT57ZS6XFsTgs/G9wfXOVQLEQUhFUQb68Pspl
         BQKV6FYrItCnQg4eKAqsjF5KL7QvlefQSivFvTIftgjbrUbbulpQfdLnJhJr6RSRNc
         G1UkwbmcRngwzRQUEnnHo3jqaMs47FrPDtC90EmuSZc8ZD5AKGw3QLVzpCWE+964EF
         Lw46jdGV/Ncya1iME/A5TVU0JhgcJgsEz2mRAFnAi+LFrFBEFEh4jiGe8OGMeHOGej
         od+6+JPdL3zVQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 21246C53BD0; Wed, 18 Oct 2023 18:38:37 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date:   Wed, 18 Oct 2023 18:38:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: hej@hot.ee
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-oHi9DJJCnQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #11 from hej@hot.ee ---
Hi Perry, is it possible to also add scaling_max_freq support to amd-pstate?
I'd like to restrict max frequency on the cpu. Thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
