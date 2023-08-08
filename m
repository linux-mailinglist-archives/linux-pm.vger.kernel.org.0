Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9A7741A8
	for <lists+linux-pm@lfdr.de>; Tue,  8 Aug 2023 19:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjHHRZt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Aug 2023 13:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbjHHRZ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2023 13:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91AC20277
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 09:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89CDC62402
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 06:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEE96C433C7
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 06:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691477004;
        bh=MosVKOuy6jPq/LCkViJ7sv3ayb567UnqlFy5Rrz2tV8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LZS5ok+YUl+6Yxf1MGOQEHWI6gcmbkA02WZhJZta9AaNhN1Y8N9LdK4XN5jpkdmdO
         fDK1OwMTkAxI/DAbiyYHd7KFtzRznGeAVwEK+SELqwuXOt8YOnhT1dcJtyadLxicVI
         3QXJ3BImhyoIhgEQ0EjIRib0hS6BcWBGmRR2UCKWDDrUPl/gosadFp0vWhmMnMJBte
         H+odUYh4VNZUh96VVPEvX+sC9MCfRi7Lo0cR9z6bfcoLO3AvJQRNVGE6FyoUbQPtMR
         V8Xmbq14GaRfQGsN47NYWMTpVdsGJoCQGqT9Q+HLTu3rQiDCTbM8l16ayBQJsKmea6
         gASgbD/PpvGMg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CC9DAC53BD0; Tue,  8 Aug 2023 06:43:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217765] CFI violation when reading amd_pstate/status
Date:   Tue, 08 Aug 2023 06:43:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217765-137361-YRdsyJitJq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217765-137361@https.bugzilla.kernel.org/>
References: <bug-217765-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217765

Perry Yuan(AMD) (Perry.Yuan@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |Perry.Yuan@amd.com

--- Comment #2 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
https://lore.kernel.org/all/20230807-amd-pstate-cfi-v1-1-0263daa13bc3@weiss=
schuh.net/

the patch has been applied to 6.5-rc as the fix.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
