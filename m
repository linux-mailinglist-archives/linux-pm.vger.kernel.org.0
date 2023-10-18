Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432FB7CDD22
	for <lists+linux-pm@lfdr.de>; Wed, 18 Oct 2023 15:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjJRNYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Oct 2023 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjJRNYs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2023 09:24:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F8A3
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 06:24:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEB22C433CA
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 13:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697635486;
        bh=ZJciHGr8N9I2RaJO06T1ZeA8u7wc/k9y32DBxJTPvOo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ixT8OvhaNF6Yz5pra/do/DpYvWq1G2aVmkEDYL19S4iSyf2kNF0nFNEf6unSdjY5c
         p//V8qOJprA7Imwk639nVjV0i9Fbka6Yrw/3kcDR0Wce76in+zTOHQuWirztt13wgl
         /uexj8X0Z2UTwDRi09YeHIc0z4yp8o9YR4EWTMnV973Bfpno/Z3PV+zJZEjfMfeNws
         MheUgOSUM7Kv7zmPwKL1Zi2kZ+gCL2RD+7vf+OS7KcSzJCuSs4QPJl0q5Np2MbkfdU
         k5cyEEBWYxLod+X6KVeZea/jfXxzGaO6eRDaO0tCiMicWK1Ra6YzultfjQzqzz+GtM
         lWx299+gCqFYA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C9237C53BD0; Wed, 18 Oct 2023 13:24:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218022] CONFIG_CPU_FREQ_GOV_SCHEDUTIL - 10%-12% reduced
 performance in lower priority processes on ADL Intel processors.
Date:   Wed, 18 Oct 2023 13:24:46 +0000
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
Message-ID: <bug-218022-137361-7WJPXIhJSS@https.bugzilla.kernel.org/>
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

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
You cannot compare different CPU families.

Speaking of:

> certain processes are not processed correctly at certain low frequencies,=
 and
> the return in frequency causes the applications to go under glitches

Could you please elaborate on that?

Please describe in details what's going on, why it's not working the way it
should and how it should work. And which tools you've used to figure it all
out.

And lastly it would be great if you tested kernel 6.5.7 or 6.6-rc6.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
