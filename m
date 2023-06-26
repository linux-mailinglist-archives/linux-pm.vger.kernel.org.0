Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E57D73EA88
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 20:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjFZSxO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 14:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjFZSxN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 14:53:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66F13D
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 11:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64E0F60F18
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 18:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF87DC433C8
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687805587;
        bh=Tysq6ZgHqnf6Gsql+ucMCOzc8FYZMqkkCtGXco5u0Hs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EWDvwenwFg06yyNEleo+DA7FbbLb0/KqvtKEhDAd2HJuu00UymIcDVqhbi6YxSBCC
         EUd9ZPxxWc3E3zPLbt8ywN+YBPZhxVyQoFLA58nuo/VXDtJM+nv4G+wFXInUlP5toE
         63rTh3zDG9TjnSRl7rbEdAEXaU9NGSQSyL0b0uqg2dE4sHRkH6m1SAroUe/wAgkVwi
         dh/30TYDSknu5Z2RIhuJcEaqOXUflJ6ZEZ/FRjVYyzVrK3++pDCAtO/ZlR/1QN8y+Y
         /Ta4tLlheup6U7GmwWBIXQT1BOsjW50l4HJouaYgqDYDrXZGoQGj91UISNLQ7iNkrM
         JsuQIq7gtVhqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 978B8C53BC6; Mon, 26 Jun 2023 18:53:07 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217589] Intel CPU maximum boost frequency reduced after resume
 from suspend to RAM
Date:   Mon, 26 Jun 2023 18:53:07 +0000
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
Message-ID: <bug-217589-137361-L893VMV3wx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217589-137361@https.bugzilla.kernel.org/>
References: <bug-217589-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217589

--- Comment #10 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.c=
om) ---
The BIOS didn't restore max after suspend to RAM. So this is not OS issue.
Report to MSI.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
