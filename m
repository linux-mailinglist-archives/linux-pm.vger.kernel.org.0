Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6CD74774F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jul 2023 18:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjGDQ4r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jul 2023 12:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjGDQ4b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2023 12:56:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FE9E41
        for <linux-pm@vger.kernel.org>; Tue,  4 Jul 2023 09:56:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C8B8612F5
        for <linux-pm@vger.kernel.org>; Tue,  4 Jul 2023 16:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78CBDC433C8
        for <linux-pm@vger.kernel.org>; Tue,  4 Jul 2023 16:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688489789;
        bh=SrRxaGf5FC9/WU29QE9BaME2nuZX9g3U+8d64HBMH5o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ukayA5IQILXKsFVq5gXNT4DeK3sNMV4c8fQoVz706UK5WoGgjy0u3BGdbarO8kTl2
         P/zmww8K+7h1PEKb2F2SMA2VIka3Ky5FaAsTYODcaD6FcSOX8JPavR+IhZ4Z1mydcT
         5gAxCX56NdT+hIlPnpKL08fPytC1aXw/xNjgpZb6HGEKV7UAQXx2Z3H15pwmt0LiF9
         YFx1aGa1W8yGdT+NCt5VvstNssHitc6LS5vyUg+lOjN0odKB+M32Tb5RlWMuOt+oQs
         IzNiwJ9XHOsXiNaDlSwnq2/Ct599uFACuTkHkwleUbXRBYUqzE+chNKvxIawxSYV8/
         0ENGW+smlaC0Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5E7E3C53BD0; Tue,  4 Jul 2023 16:56:29 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217630] Kernel fails to load amd_pstate driver on 3970x while
 Windows works well on the same machine
Date:   Tue, 04 Jul 2023 16:56:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: pshirshov@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217630-137361-bJFGnTUO3A@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217630-137361@https.bugzilla.kernel.org/>
References: <bug-217630-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217630

--- Comment #3 from Pavel S (pshirshov@gmail.com) ---
It does show up in 6.4 with exactly the same manner. I just made some typos,
sorry about that.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
