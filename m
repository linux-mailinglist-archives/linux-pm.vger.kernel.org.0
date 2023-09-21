Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7137F7AA06F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 22:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjIUUhl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 16:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjIUUha (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 16:37:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFE083307
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:37:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0E21C4163D
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 08:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695284614;
        bh=rIslKoqQA7eDek1JI3G0Q7QE9fK3DN5uHFOOb0ha91c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ot24mxcM77d4vJp1ffnjRk6eoh17Gl6Y1PUbHwxke2X2aGjrQKY/VeqY0CKOISJr+
         0RWlwoxHkEmw8yGDmBzqjnEFwNsBpUpCS5/sMDy5IwMFU3nYvMLt4THy6HDguRuqk8
         IwvO+gOs06FKN1i1AHYe8DDISdGA3gp10JgD2z9Gn53qwo0CQzqHLX58zhX2S0ZLwc
         W4X26ihcVWJhIly3a9JSTIc2JDOGbvIEL/K8quFrN7R7dSO/jhpKd1LRoHPRsfPPXG
         ql6IQYuoUEPSwjkbZ76JBUNT7q7kzJF30BBmJXtEPHAGrtEsSO/L/fzN7NGhbyXP+g
         3ctTNE1PIc2ng==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DAE4DC53BCD; Thu, 21 Sep 2023 08:23:33 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date:   Thu, 21 Sep 2023 08:23:33 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-WwEZzfcnXW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---
This would also be hugely useful for hundreds of thousands of AMD handheld
users (not limited to Steam Deck).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
