Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B74E49DE
	for <lists+linux-pm@lfdr.de>; Wed, 23 Mar 2022 01:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbiCWACs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Mar 2022 20:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCWACr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2022 20:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC471FA65
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 17:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87F49612F5
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 00:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED241C340F4
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 00:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647993679;
        bh=vA8RtMbB/K0G/UxG/g/XnDpbzWc3apsFLXvDaflUo8c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PNvLm3hhmHbFc4hqup1HVrNlH/A+LSD3agibWpzpivwW6z/mrd/9c39EbsErlq2Sv
         lRYJRXZ/CnPjXoucrLlaD7PkQ/DMOVtErWlKVkPmcLYROfnNbcyEe5GruLmt3EqVi9
         tdbHViwGF0uH97CR+mlmEYFqJoeVMbFLT996EypToWmrJMTvMrF7fMYyuGf9IOnADb
         PdLM6zOmZj8xrqOtEbYZ5JCExOOaNgQtL5KqFA9nwL49EP43cXqFNvpG6CAk9RFF4E
         L7EcwGlZRsEZI1ft9nNOP9ntKSlrTQ2cyVSSWqIN3Ue36HIV9wnXe0NoF5aakW/rVu
         r/MqlTEQie0RQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BE83ACAC6E2; Wed, 23 Mar 2022 00:01:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215729] amd-pstate driver has a much higher idle power
 consumption for a desktop Zen 3 CPU
Date:   Wed, 23 Mar 2022 00:01:18 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215729-137361-k8nDBjd9CC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215729-137361@https.bugzilla.kernel.org/>
References: <bug-215729-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215729

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ray.huang@amd.com

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
CC'ing Huang Rui - please check.

I'm not changing any CPU frequency related options - i.e. everything is run=
ning
by default.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
