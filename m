Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07E651A13F
	for <lists+linux-pm@lfdr.de>; Wed,  4 May 2022 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350842AbiEDNtv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 May 2022 09:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350844AbiEDNto (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2022 09:49:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E0941334
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 06:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87B35619D6
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 13:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8B70C385A4
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651671964;
        bh=GX3WY/Cv02uJejb8wzo6jweehVu3vk5wr17FfoVBmkg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=POPsGmAeEUWjGyeEw3RRigIVBGjreojpkQOmaIZNAhVk2pOD1fVukJanW47JCc4tg
         r3CpSgUVQUovOUoTc8oK+VEDtvraZNgMiEIzDanw6kZN4eD33TjarWQPFGMJLZIW5u
         8F/1SejoUDlygdegOpYfkD+CO2ylUIeENfPJbOT+JBEtk4E2k1aW6EZGWNgD/YaqfV
         qa8YeL9i1m+ya65TZL2KROZCs9YXEiIYSwcRWisR6WkxDLORX7S52QZQF9NJHipwtm
         U4GOf5hY4lKdCBKhQSNKw2fiIWhMuxRbg2IwnHC4nYQE89SvAtuyiLuBl4SnLdHAFD
         Fpr0MYQhZ9LpA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D13B0C05FF5; Wed,  4 May 2022 13:46:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Wed, 04 May 2022 13:46:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexmaras@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215938-137361-7jBT9NGDZq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #2 from Alex Maras (alexmaras@gmail.com) ---
(In reply to Artem S. Tashkinov from comment #1)
> Could you please check if bug 215800 affects you?

No, I can set my frequency to 3GHZ and run stress and my scaling_cur_freq v=
alue
reports ~3GHZ. I'm also on a AMD Ryzen 7 4800U, which is a Zen2 model.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
