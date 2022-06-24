Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73606558CC6
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jun 2022 03:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiFXBYR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jun 2022 21:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiFXBYQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2022 21:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8155676A
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2022 18:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9179D62002
        for <linux-pm@vger.kernel.org>; Fri, 24 Jun 2022 01:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0C77C341CE
        for <linux-pm@vger.kernel.org>; Fri, 24 Jun 2022 01:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656033854;
        bh=rae9EYvx42wYC+Mi60GF4sBbSjUpFm8ZYfLsXfKe9vs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LlLgYu+dZXwSJAHivYJ7WU1kR9hzInzt2unP7gC4px/lUWGbcRKJ949QF6u9L/01z
         BKx2X+RjWZWYLEOke8E6z2M6EywDCSSL3f11kV8upGEXlZsrBqw0DK7TmxwS9SC+eA
         RRRfRxd9bvk2CbSk/x4GhdTkQLb6e2YhKCE5dRNrubh5E2OXj6yPWWlcwyMrqu0Y5/
         CJQl/3NcHC+I9X1K7PfxXWdl2ISq4N3CoBwPCKE3QSxRKznirp9uRIMRgcZAS7jJxH
         ec1cq4ur24ixRrlg0mMfQ3ZZjXh0NzeJlQLzzth7ZmV3pKf4TIB4cVGDTIFHON8wQe
         C1VJ5c8/e8ZpA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BC43ACC13B1; Fri, 24 Jun 2022 01:24:14 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215135] proposed cpufreq driver amd-pstate regresses wrt
 acpi-cpufreq on some AMD EPYC Zen3
Date:   Fri, 24 Jun 2022 01:24:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rui.zhang@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc rep_platform
Message-ID: <bug-215135-137361-0siqpn6RbR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215135-137361@https.bugzilla.kernel.org/>
References: <bug-215135-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215135

Zhang Rui (rui.zhang@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rui.zhang@intel.com
           Hardware|All                         |AMD

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
