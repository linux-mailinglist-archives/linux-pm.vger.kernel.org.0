Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F73519CBF
	for <lists+linux-pm@lfdr.de>; Wed,  4 May 2022 12:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiEDKUA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 May 2022 06:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348002AbiEDKTn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2022 06:19:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAA425E91
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 03:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE298B824C9
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 10:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B35EBC385B0
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 10:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651659360;
        bh=8HxVW8qKxOhhO9vR8vnTap1jgcXYh8upSp7fBdzJf3M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ORX1frP4Pr8S2NS83QzLdU5bEJ/5XUCcPQPafZARDHWVnsMqg7gZJn/sQC70U/1aD
         4FMKKfywoTQNe5Tl6sRjvi2A5A+vlm+9wAUSnUI+ylV4zqYwxtIT3l7dIryLDUR0N8
         bwd9n2QneEclmEw/74z8A2dUU9twBVJGNNJ7JRCXAnEyx7vdmQsbQjUJUTCYRPJhMd
         lNi/Uh8OmHK8y0srT1Imcl4Ucl33EF1l5qIH8EM9Ow7lVKjCw4LOZ3rXV6MfMp0WYg
         fKCDjKjVWxOUg41lE89vyQ8fuGo9EHaAW3DbdV//P6OXUnDV5AdEsyjkq1uGM3rbtB
         r00DDpb8KgY0Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9A03CCC13B0; Wed,  4 May 2022 10:16:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215909] Regression with ACPI_STATE_C3 state freeze
Date:   Wed, 04 May 2022 10:16:00 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: ACPI
X-Bugzilla-Component: ACPICA-Core
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: axet@me.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: acpi_acpica-core@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215909-137361-J9B0EsBU92@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215909-137361@https.bugzilla.kernel.org/>
References: <bug-215909-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215909

--- Comment #2 from Alexey Kuznetsov (axet@me.com) ---
new test: 5.18-rc4 failed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.=
