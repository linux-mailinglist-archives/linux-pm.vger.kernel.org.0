Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1CB52E97C
	for <lists+linux-pm@lfdr.de>; Fri, 20 May 2022 11:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiETJ5j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 May 2022 05:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiETJ5h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2022 05:57:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB65B6A02C
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 02:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8783761C4A
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 09:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB700C385A9
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 09:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653040656;
        bh=j/2zylwLcPOv2ilxcYCTlMTBb+0rDd8Gbyfnoefl6oU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Mu5xwnoEDcFdPN7icnG9NKUbfpykf0h14T6jdWwvvO/PiZaw1lYgmn+hhCYKmYA0i
         ypyrszfkusDAqVOV2QAPPmWRPyxO8hxfjckqAigsvTkQX2JWYkKsmkkq/WmsH4kmAu
         5aWhCEZWJ927kgYVZBMEApz7KbZpyykLbro5z/r32xpku61ixg3T3MPItg3RDSuvi8
         12d8FswRyBPCeeqL93X1rFBr06XL8I1SNS018RjeX+I4kHL6y5Q5P61AtkDngNOv7c
         up+S14eocorg6+4WR/zkdEoszhr2xdHeqXfxYbDsq+DlOF41ysbSkzN2+KoA2CFe0P
         ECH+cmLZHA8hg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DB602C05FF5; Fri, 20 May 2022 09:57:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Fri, 20 May 2022 09:57:35 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215938-137361-XTwbuEW6eY@https.bugzilla.kernel.org/>
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

--- Comment #6 from Alex Maras (dev@alexmaras.com) ---
Hey Perry,

I've attached the /proc/cpuinfo output and dmesg output after the listed
process. Do you want anything more for the moment? Let me know if you need
anything, happy to help.

Alex

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
