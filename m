Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9B07CF347
	for <lists+linux-pm@lfdr.de>; Thu, 19 Oct 2023 10:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjJSIxW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 04:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjJSIxN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 04:53:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBF5134
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 01:53:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF24CC433CA
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 08:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697705591;
        bh=OT7RzAdfEC0aZ3O/bGkNW5/9KcO6NFmPJabAG0ddVaA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=esqswU8JvALiu+6BFZ8I5n/kK+nuR+d2rS1vU5Z0v2adGFQ2IvNVB6iwvJpGfQIG3
         w6JouLy8ICTfmbg4FLtjlg2DTYcc+2w2p+6YPdo0n4hhoRTkmktE2/xxuUo2d+5yXw
         uX3ocj/gxaPksp00PclHVRwMPMmR5GGoc8zUXlnXWEGTNtOpuHnCpQq5ei5yDZQBAv
         LyTyoVDX6ExcGnWlrZXauS1iPBFrU7oyFADReewFYrM0yLoq137nHAP10Or6pIb+xV
         ZqqPbg5QVbVrCBC/lFgRwUSCHr2I5iYP/enpaYjbVJJ6pZWOULuGaZpnSntKtNdNRu
         8IZaUWdXIB7lA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A2175C53BD2; Thu, 19 Oct 2023 08:53:11 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218022] CONFIG_CPU_FREQ_GOV_SCHEDUTIL - 10%-12% reduced
 performance in lower priority processes on ADL Intel processors.
Date:   Thu, 19 Oct 2023 08:53:11 +0000
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
Message-ID: <bug-218022-137361-CxvQpvEj2p@https.bugzilla.kernel.org/>
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

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
Your bug reports was about the diminished performance (which you're still y=
et
to reveal how you measured) now you're talking about freezes. I've kinda lo=
st
the plot.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
