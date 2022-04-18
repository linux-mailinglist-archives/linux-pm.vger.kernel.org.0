Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7962D505AEE
	for <lists+linux-pm@lfdr.de>; Mon, 18 Apr 2022 17:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiDRPYc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Apr 2022 11:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345394AbiDRPWf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2022 11:22:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2898ED59B7
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 07:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 535BFB80EE9
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 14:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBD8DC385A8
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 14:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650291615;
        bh=uSeuLQ2yLmCojWJ8G8ZrunDfBHAjGcHQ3GD3rmmWgzo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eFkJZTV4D39CPZe6kiivIV9oXK5LyPlTDgwVp3Iw/bQNG4T/Nr/tsr/gnmNs1pq5I
         hmvE/7MWnkwd8qo00t46bwGKmDI/60A73b74G1aXCH/2liaL9VMI0qr16b2edoJ0l8
         z7GXVm1q4jpSfMbDU/zn3zXCGgZ4SpgRTEPSvDIyktn6far0uoEFL3N1msM8yr7ux+
         4BdSmk7KM2WEC92e4LO0pk6j7OvpRqmncqKOUew3HHND1DwOsqqh+R0QpVgoHWXWUz
         k/Zs7hLwfxJjop4C6i0imBAlksac73olbfX/I+hGnoWR8255ZqW3WdtLjn2E4izx4m
         jeynfQ3QiQ7Cg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A9E1BC05FD6; Mon, 18 Apr 2022 14:20:15 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215574] Frequency boost disabled by default on Asus PN50 -
 Ryzen 7 4800U
Date:   Mon, 18 Apr 2022 14:20:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: parag.lkml@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-215574-137361-cgfCB0FLCU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215574-137361@https.bugzilla.kernel.org/>
References: <bug-215574-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215574

paragw (parag.lkml@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|Frequency boost disabled by |Frequency boost disabled by
                   |default on Asus PN50 -  AMD |default on Asus PN50 -
                   |Ryzen=E2=84=A2 4000 Series Renoir   |Ryzen 7 4800U
                   |Mobile Processor with       |
                   |Radeon=E2=84=A2 Vega 7 Graphics     |

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
