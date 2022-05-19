Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D5252C9D8
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 04:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiESCe4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 May 2022 22:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbiESCez (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2022 22:34:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CACD682D
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2022 19:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81953618A6
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 02:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4592C34113
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 02:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652927692;
        bh=LIVL+qUgk3ilP+w8eihz0D04l+8Pg6TJrPyZMJFCEYA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RqLqWVNFG5IaHoDqyo+L70DO3raEKgC2mh0tqulsMqRKQtCw23jf2yW+qyNfIYaek
         7wtAcnw+lp181qTVU1iDR/LarSoNnLn2EsH21CQthxJgmBGCbqzARGj7Y6VP0fDzjr
         dp0qpWyItSclR2n8SFnscI+6MYgHCk9avgIb/QpyBHHxwCZ20/BNCtNUd86y543omv
         jqMTcaHmnp2gKTWJvyYRKBv9rOA0Y75D/mnYfvCwb2SZahLAtoB+XGXrg2uaGh6Dyr
         DJvH3vYwv+SOIW3OcpDEFv0VWGZwdzHsGqu6lg3mTRJTEujwTAb8RfS345TwSuYMWP
         HE58JTKKf76jA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C9F19CC13B5; Thu, 19 May 2022 02:34:52 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Thu, 19 May 2022 02:34:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: perry_yuan@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215800-137361-xL2EnTfVJU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #17 from perry_yuan@outlook.com ---
(In reply to Artem S. Tashkinov from comment #16)
> (In reply to perry_yuan from comment #15)
> >=20
> > Could you help to try the below kernel ?
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/
> > drivers/cpufreq/amd-pstate.c?h=3Dnext-20220516
> >=20
> > I tried this kernel, but 5950x cannot reproduce the issue as yours.
>=20
> Does this patch require enabling debugging in the kernel? I'm not sure ho=
w I
> am supposed to share (debug) data once I've applied it.

Hi Artem.
I mean you could build the kernel and install it on your system.
and switch the governor , capture the min/max log ,etc.

I do not find the reproducing way, but I still want to try to reproduce the
issue if you can confirm the kernel link has same problem.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
