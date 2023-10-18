Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCC97CD4A5
	for <lists+linux-pm@lfdr.de>; Wed, 18 Oct 2023 08:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjJRGuC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Oct 2023 02:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJRGuB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2023 02:50:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CFFB6
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 23:50:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF0D4C433C8
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 06:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697611798;
        bh=Zcm2nCa96KM3ZSZE92n2jIKpLZNtLgCKnllG0H+xc3s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BzJzmX4nCBRJCbLUJrBRwVnhpq1IYmD8ESYd87TVawc6AXBhaRdipPUF8y0W74lTK
         dCVB5ESj26aGFqyw0tk3jAB/4yjNEr67ftJvfi32MbIB0DwBhev5YGyDft5E0c+J2X
         tfW1nXNSIOq054klhnyPQklm+6pzg3E5hXG57drve631hAQehqgr20GKWHw/QoZd1U
         DR0R325HnxBiEe9E6bCGzJMqXK7KhvZBwwm9eRreRpcNdZhvjYMaeTCWgk4bEi+k2K
         /PEE9eoZMHKpmYeaMY+b5nMpW/pajxaswb9pr5QKmC9V58owkWqz/H4Xg8JCvtqMt0
         Md42LqNGRnfqQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D7DE4C53BD0; Wed, 18 Oct 2023 06:49:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218022] CONFIG_CPU_FREQ_GOV_SCHEDUTIL - 10%-12% reduced
 performance in lower priority processes on ADL Intel processors.
Date:   Wed, 18 Oct 2023 06:49:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218022-137361-0c6uF5XHqY@https.bugzilla.kernel.org/>
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

--- Comment #2 from sander44 (ionut_n2001@yahoo.com) ---
I compared with Intel TGL.

Do you know some tools with which I could check this performance problem in
more detail?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
