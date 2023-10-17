Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE66D7CC9A3
	for <lists+linux-pm@lfdr.de>; Tue, 17 Oct 2023 19:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjJQRQG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Oct 2023 13:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjJQRQF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2023 13:16:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9CE94
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 10:16:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB4D1C433C7
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697562963;
        bh=CtrR8t198L3SqmRNV5NZHRcaMfueHLRtlqkFJZgSkRE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=efq0PcAdhcyXQ1lyrYM3nnXdPTXGN7ZvgajNgpqByrKEsGUbC+OdBm4tfAzlWyPMQ
         Ee54/94ElMCGnnbCAa+iWSgz0mby9EFohRXJP+yntFV3+RL/vxxXzYwW8hf+jkwzqM
         T9zAxGcu3hQs1gh+WrNr2Qx5X+ZJf8Qr+Y/9S1LllLYaXgjBLREo635N2cm2+3AWLZ
         wN6TZwXEF9AV2XCn4vjyIA2uUwkKC2GMQwBLC5TVq1kLxpZE+3Q8+8qt5LfD7LkpZM
         lGEq8nDo0FsAIHuzM5iGVgmhHjVIAeGGSkfFR28VwOpbbHE0bWPLztDk407xU2TNHS
         YEE0LZhAFGg+A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8A0C9C53BC6; Tue, 17 Oct 2023 17:16:03 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218022] CONFIG_CPU_FREQ_GOV_SCHEDUTIL - 10%-12% reduced
 performance in lower priority processes on ADL Intel processors.
Date:   Tue, 17 Oct 2023 17:16:03 +0000
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
Message-ID: <bug-218022-137361-qNZvWFizb4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218022-137361@https.bugzilla.kernel.org/>
References: <bug-218022-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218022

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
> "reduced performance"

Compared to what?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
