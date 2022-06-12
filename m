Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2BF547A7E
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jun 2022 16:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiFLOe6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jun 2022 10:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiFLOe5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jun 2022 10:34:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977BB31221
        for <linux-pm@vger.kernel.org>; Sun, 12 Jun 2022 07:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55D12B80BA5
        for <linux-pm@vger.kernel.org>; Sun, 12 Jun 2022 14:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC81EC341C4
        for <linux-pm@vger.kernel.org>; Sun, 12 Jun 2022 14:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655044493;
        bh=9sx01SWQn6vTt2DXgZJYjLWJantWLVyqvbVbfNS5Jf0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LQ/XGfZe/LdMCFj4wlPMu7EDHx5D7/9H3bIWeYDTKfXAylrsBYNGitzwipC74klO4
         IJIzdlLWRFvxyFX1ysf9inC/dS2D0yDFdwezsic8lEdopLmODirH5+x5FT3919ZwQm
         CHpH/mvzb8JeDFMzfQPTv2sPoRi5JZ9ptiRPJnCWR/6OGyEKwXLHKaHMMgxMh5wNeA
         l+mQtx6++eNGPjFfX6UfYIJcIVKPa1PXzdGr9ejCRHUarEZkToe8cDfKQblpfoROCJ
         bsfAyO1bgQ5CCs7YOJrFBr6A2OEf/6SB2m0j5ha3frzC6Ao8g5FvcdJjzKkAd85D/c
         f8J5MkZ0468GQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C8D72CBF854; Sun, 12 Jun 2022 14:34:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Sun, 12 Jun 2022 14:34:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215800-137361-5tZp0tYQaV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #19 from Artem S. Tashkinov (aros@gmx.com) ---
All the same with 5.18.3.

Steps to reproduce:

echo 3000000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_fr=
eq

Now all the CPU cores are stuck below 2.2GHz.

This is after `modprobe amd-pstate replace=3D1`

I really don't understand what else I can do. This is reproducible with a
single command on my Ryzen 7 5800X CPU.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
