Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3814FCD08
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 05:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbiDLD2A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Apr 2022 23:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbiDLD17 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2022 23:27:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1072E9D4
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 20:25:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3859CB81996
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 03:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D593FC385AA
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 03:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649733939;
        bh=0AeTsdn5JUlYy+mumSOkOuv+4Y7iySPU+LMX1NV9T9U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IBUFwR0THcfvbLWI9tkRl69/vlA69XqDMMtqb4rCh94s6tuFB+LQAByi2zKu+Cy3+
         Y44dXdYiohcrnjEE8rPCOIyKCfhbWwJRzk0F9L9eiLgydT6j4Vn+a46sZxdWnDTwUs
         aMDxPnzXi1JT04SwjTHDP1r5YIJu5yrRvJp9RhAR1AddB8GXtwJfwppxGrWsLa/9Tj
         xGhwN7EEQcC1lSOkcZlQFVF8H4KurKFJF8DHZAT1SliMJpPV8AgWXCqJJz2S9XCNDa
         MLi9hgVFZrYOlIHJ+wcuqqzvqmSvmdLL3cMs/iEalclYob0ur6NHlLAb/hUp1vuadq
         o6ynUAeriPB3w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BC0ACC05FCE; Tue, 12 Apr 2022 03:25:39 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Tue, 12 Apr 2022 03:25:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sujinzhou2008@126.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215800-137361-pfEsWNqvqx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

Joe (sujinzhou2008@126.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sujinzhou2008@126.com

--- Comment #5 from Joe (sujinzhou2008@126.com) ---
"I've tried to fix the issue by `cat cpuinfo_max_freq > scaling_max_freq` b=
ut
that didn't work. "

cat does not work. Please use "echo $number > scaling_max_freq".

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
