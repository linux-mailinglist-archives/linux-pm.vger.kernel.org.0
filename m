Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671E14FBD2F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 15:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243805AbiDKNf7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Apr 2022 09:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbiDKNf6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2022 09:35:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04253BA74
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 06:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88ED7B815EB
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 13:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BCD7C385AA
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649684022;
        bh=pYOKtw+VjK35b47FJZMoYPFBRmhgvhDCyR8usfMV8Bc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UQV2YIAIrk+HKdflPrvXsFgkdPIbmp8XpL/Mc5CD562+YSNEVarEvIl13sNae9Mzt
         UyyDhvpi3RGT1zVjDEN0SkaAnk4GgM2zYgWeUmhuUjGHUUzxAqbSsYLYEruYjB5rbs
         EbuXf2DBbpJSwEksW/uIlcj24hgP8cYCBB+/2IzvVcGTdfjrPewZ2M4EA70BottQ0r
         RlHymJU9GJJg5CIRNaYZncn+1gNfPHFGzsu8+gThoTQGbRd9aiw6Vc1fVF/UtSldQR
         mwkIlnKIcGV9A4g64Yq1LwoczRjkB0Q9WwztD5FYeHWqwktT3+ZNEHnuMMwGHTl/oj
         hjKdoSGdNXldg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 13692C05FCE; Mon, 11 Apr 2022 13:33:42 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Mon, 11 Apr 2022 13:33:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: huangrui@mail.ustc.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215800-137361-6cUyLcAXdn@https.bugzilla.kernel.org/>
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

--- Comment #3 from Huang Rui (huangrui@mail.ustc.edu.cn) ---
Hi Artem,

Thanks for the report. Can you print: "lscpu | grep cppc"?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
