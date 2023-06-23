Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AE873BDE8
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jun 2023 19:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjFWRgI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jun 2023 13:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjFWRgD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2023 13:36:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783F12703
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 10:35:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0A7561AD5
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 17:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6503BC433C9
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 17:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687541756;
        bh=Qk2dsnF82ptlEURY6G9LY2+PbcC/O9Jo9s8R+eP+hOY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fAza0TQYU1YN1iSFSh8JxKBE+r14166cBhxsP9iNKGBMJkJ+7SagHN3t1JiIlTb4i
         i79xqW0JgTcnsBEnRahiEaiEvTMyt3/Tq7HJy48RYICWq4r00gxFrtMg2JkY3o54X5
         zzdvTKlOq7sm3czMwBe9e11iHmu13GiHFjPvjLp6PQnu7ihvDIm1qJ6mBIdu+eccba
         BXIRVchzKCtL/PYbxeouvUe97EZ20Q57hzHQrPj6EIl8pd4SwPeYv6LlxP32+po0cV
         0MHzlIX70DWtziyW/L2Cq5wvCSLcmJhQO51kRwpddvKzNHw5yayVHLtjTcILHkG1pd
         3mNzuKQLIBQQw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 52252C53BD0; Fri, 23 Jun 2023 17:35:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217589] Intel CPU maximum boost frequency reduced after resume
 from suspend to RAM
Date:   Fri, 23 Jun 2023 17:35:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: srinivas.pandruvada@linux.intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217589-137361-5gdif2KABg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217589-137361@https.bugzilla.kernel.org/>
References: <bug-217589-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217589

--- Comment #5 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.co=
m) ---
Capture one log with:
echo "file intel_pstate.c +p" >/sys/kernel/debug/dynamic_debug/control=20
echo 0 > /sys/devices/system/cpu/cpu1/online=20
echo 1 > /sys/devices/system/cpu/cpu1/online=20

Another with=20
echo "file intel_pstate.c +p" >/sys/kernel/debug/dynamic_debug/control=20
suspend to RAM and resume

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
