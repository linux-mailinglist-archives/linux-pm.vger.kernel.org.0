Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED24152E977
	for <lists+linux-pm@lfdr.de>; Fri, 20 May 2022 11:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348017AbiETJzI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 May 2022 05:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348015AbiETJzG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2022 05:55:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD79E14AF66
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 02:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78E9F61CB5
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 09:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5270C385A9
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 09:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653040504;
        bh=uzIIqevNFeT7rBgDolRJWEWxN0Oc4bGxRdSfmqKAjAk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lyGzvRDGor/l2auLKcpcrwfWRzGsT5SPfyLvP147Xkx96y/WzRfGdXaPrLX67H5//
         /Pmd0AzVlxMe5fFhGO2lpOKoM20FgBpw3KQZt+Mw9qhseMbUcgc/flq16EtYksEL8I
         ahAtCUCuGBjZ7m0HOPNf9JXHSNdbboUl1fXQU8wa2cnrK/bvhwiRcrd5vPWEgY8jY7
         X3ByyJjCJrbyQtXh8nnYCH+ns7CFEuGcoLKd8l1mS6VfMxKCw5+Y6FWz17CCPbUgOn
         cCHHep+wD3mZPPceiWNQsGnJklxyoG6W+9Qsud+q4soANtrAi4ZPY3kRV8lBLWQ04e
         RjlKMPc6ObMng==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B2C6FC05FF5; Fri, 20 May 2022 09:55:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Fri, 20 May 2022 09:55:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dev@alexmaras.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215938-137361-zSwJP4ipDh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #4 from Alex Maras (dev@alexmaras.com) ---
Created attachment 301003
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301003&action=3Dedit
dmesg output after sleeping

1. Started up laptop fresh
2. Set governor to ondemand and frequency to 1.4GHZ
3. Checked CPU frequency, settings respected
4. Shut laptop lid, waited 10 seconds, opened laptop lid
5. Checked CPU frequency, settings disregarded
6. Grabbing dmesg output

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
