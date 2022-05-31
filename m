Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EA4538BFB
	for <lists+linux-pm@lfdr.de>; Tue, 31 May 2022 09:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbiEaHcM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 May 2022 03:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238158AbiEaHcM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2022 03:32:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9063435841
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2022 00:32:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 655F06120F
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2022 07:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0C55C34114
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2022 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653982325;
        bh=AsuKN/uGim8e4043PNnGXUGRSHuslS+CxyLHRJFid5I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TQTJKdLJqy4lHUOEgFXqZ35M5XbWpykflxt/EwviBmCswnEkI6k50e3jol4H1yc+C
         FLHp97jj8KqEwuZE1FyeyIaWRZiWVE20Spjuzqq0mCxIcnuPAZlYhyx2ige/DWv64I
         3YA3pGOG8J8VVFCpNRyw1H8K0EN0tQyvvlOwQYK8J7DIya2JrnRt1dXESR+FqcFCsj
         KmdKrEyZYbQdg/yF82LoSbrYCeyatdtdSbDMjvMFBmmfs5aA7i2Kp3tZiuDLRXeVAF
         BnMDuPSEIoslkAcD7p4bgTu+neTEDHANDsuJPkNeJRIVC1NWF615I5VLMEfLxrrJ8a
         TVmzZ4hAz/unw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A725EC05FF5; Tue, 31 May 2022 07:32:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Tue, 31 May 2022 07:32:05 +0000
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
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-215938-137361-F739Aoyodl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

Alex Maras (dev@alexmaras.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #301003|0                           |1
        is obsolete|                            |

--- Comment #8 from Alex Maras (dev@alexmaras.com) ---
Created attachment 301080
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301080&action=3Dedit
dmesg output after sleeping - with debug params

I've attached the dmesg output here after applying those kernel params. My
kernel version has the latest commit. I'll compile from git to ensure the
results are the same in the meantime.=20

The dmesg results are interesting - cat-ing scaling_cur_freq still shows the
same behavior, but dmesg doesn't show any values above 1.4gHz. I ran `stres=
s`
either side of sleeping and watched the scaling_cur_freq, and can confirm t=
hat
it was maxing out at 1.4gHz before suspend, and not limited after suspend.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
