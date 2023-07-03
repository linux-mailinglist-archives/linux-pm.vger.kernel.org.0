Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E749745703
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jul 2023 10:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjGCILi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jul 2023 04:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjGCILg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2023 04:11:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BB291
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 01:11:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6428160DE6
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 08:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C321FC433C7
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 08:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688371894;
        bh=n7B5gKlWG+xB7K3q/kQsuO4sorSgxoYpd7yVPaO7I04=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nKT3HrH98wquinzMVNIuTF+NvLL3xJtziOB17MpSMpxz9n1WAD94DOiONDQ87K6/P
         +OyjMvbcfnTHlubXMM6ujW7pDLvCO0G9u16FWbA7D6iwXQirJQRXFIaV32hvvmuItt
         tuaUO5lUfBAAaCNUoEqwWXwpcGjhUMGpiU8fL8MwbF9cWyPCWcyVCnnWZePwRxYEvo
         5U74v98vHXWk1e1VDfW2mb+SOpznZ/vhVMGs6GVEe3/ZR0ND0LnaYczY+YR4MNA+zL
         43F1a+IBcSRzMfm4RTK8zEuE5+rIRrIjXdjNOSc4/Jfui6TDakntHlx7bb39KGc6pO
         LbeQL7QA32pcA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AD916C53BD2; Mon,  3 Jul 2023 08:11:34 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217618] Changing maximum frequency and boost state does not
 work with amd-pstate in passive mode plus the schedutil governor
Date:   Mon, 03 Jul 2023 08:11:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217618-137361-EfXBN676kM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217618-137361@https.bugzilla.kernel.org/>
References: <bug-217618-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217618

--- Comment #3 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Thanks for your info share, I guess the boost and scaling_max have something
need to be improved when user try to limit the max frequency.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
