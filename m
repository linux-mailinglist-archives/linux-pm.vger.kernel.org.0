Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74C352E97B
	for <lists+linux-pm@lfdr.de>; Fri, 20 May 2022 11:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiETJ46 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 May 2022 05:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiETJ4z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2022 05:56:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A58660BAC
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 02:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E70B8B82A96
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 09:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB5F9C34113
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 09:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653040606;
        bh=eTBPNdEqauDWrxlPBuEZwiLzCYVyKaBiu8ShQN8wRTU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=q5Yxd++vaHEtnQCQg3NI3XHk8VmNDPE4SXXtnsx9xK2zv5excrUjxV45mCKANBGMk
         jn03XsZvaYzetDEf19NZ17jLFXdsxSl1Yte+Vx0pW0p6Ba57ohl09AgF0iuUBBi2LB
         R8Cf6femO6JEx+UGWpo0QKjqfjiOpz2OvkSeKFlmTv5I83uo5h3HeUU4PoA39QC23H
         DrzDKFWMT+66IQCsxD10RuBOzx6gzfFZjxSyHC2Q1MV8W+4cCX47V+eMmDpjdBmavh
         mmMAkv4Y+XXyOeY4w7soudOARS5m10MdOpmLMUurxyZt0UZ3uB6afLTEoubcTPbbqg
         zZ6iZ290j+8Sg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 98FA5C05FF5; Fri, 20 May 2022 09:56:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Fri, 20 May 2022 09:56:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dev@alexmaras.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215938-137361-jGQg1iITlY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #5 from Alex Maras (dev@alexmaras.com) ---
Created attachment 301004
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301004&action=3Dedit
cpuinfo

CPUInfo output

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
