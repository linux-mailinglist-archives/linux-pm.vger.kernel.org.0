Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F4C7A9E17
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 21:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjIUTzg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 15:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjIUTzR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 15:55:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABFED66F4
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 11:27:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24797C433C8
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 18:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695320851;
        bh=W8ZRV80l2nleZS+KF1qVrs9gjJ/hjjtUhbHPzPIIyYY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LniWe3LVHiKQJKTGHI74nmBFKbJ9g235liLhTJVqRCFe71ebnVObnE+3EjsQaShyg
         65EmpvvhJNBsaEPrpG9lw2Ciq+1927fwFxyHBTQN1bk+8FFpApNVIoouxslmpW1c6B
         S9ppVF2ZMmi8kUpA3VoiP3JbnZlGgjpv+uYFtb6CWMYFoeQ2PBVhSWhuU1GzvaDq9U
         /BfgZ+tP67yn7kYqRxdTeMMhW9yapsmK/+M/nDx0+BlDV3Kf83OI3UjPhl+zPDccj8
         OTLNykt3RurRNeMXPok4WMIvN1OTi9WV/Qt2XTFQIpHGTbypZAKLwPmk3tU5qye2e2
         NVRV9q03Ym82g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0F589C53BCD; Thu, 21 Sep 2023 18:27:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date:   Thu, 21 Sep 2023 18:27:30 +0000
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
Message-ID: <bug-217931-137361-WHGvDUPwKw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #8 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to hej from comment #7)
> I'm also looking for a way to contol min/max frequency. I tried active,
> passive and guided modes and was surprised none obeyed scaling_max_freq.

It's currently not implemented at all in amd-pstate, so those knobs
(scaling_max_freq|scaling_min_freq|scaling_setspeed) do nothing.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
