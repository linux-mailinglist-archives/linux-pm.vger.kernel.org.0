Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5AF73E6BE
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 19:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjFZRpR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 13:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjFZRor (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 13:44:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A548AF
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 10:44:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3693F60F10
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 17:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E8AFC433C9
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 17:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687801485;
        bh=kCoAXBgfq/UCGDswF6mB6oKfOzCu7IMs5dNy1SypMTk=;
        h=From:To:Subject:Date:From;
        b=hJ2gsvWJ0+uf0E+VbIoOlf9y8JgcGlAJI1OhtOIB6ETg9t9CI+W6hSnS7aROK6MPs
         3o7t1lGHzwvwqeUYEIuH9PjZOq9ncfmDkYR3LvLJlt/Qny/bvMZ+FfG2E0zON3oZsv
         oAxvyqYF0obPBbdW768WGmXEUiSOb0XDqnJ4+g3w9zA5z4uFpUgoXHOIqaxzrb54IQ
         zpv3swYIMpMIT+biDYXOtJdZLifeZ46V57WuGc6Qr/D1JREzLbO1r/EmhWfedo1dbo
         +3npz04W+JhcG6VbSfcXJt9ROSXzurdthUm71VWu18GyW9kDy5QjPSERq+MoZAHs4h
         /wKn8IGIxtvRQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 863D8C53BD0; Mon, 26 Jun 2023 17:44:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217597] New: lscpu reporting incorrect CPU current frequencies
Date:   Mon, 26 Jun 2023 17:44:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: yang.jie@linux.intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217597-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217597

            Bug ID: 217597
           Summary: lscpu reporting incorrect CPU current frequencies
           Product: Power Management
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: yang.jie@linux.intel.com
        Regression: No

From Linux kernel v5.18 on, we notice that the cur_freq of CPU cores are not
correct from time to time, the cur_freq could even be > the maximum ones, as
below:


# lscpu -e
CPU SOCKET CORE ONLINE    MAXMHZ   MINMHZ       MHZ
  0      0    0    yes 4200.0000 800.0000 4200.0000
  1      0    0    yes 4200.0000 800.0000 4200.0000
  2      0    1    yes 4200.0000 800.0000 4200.0000
  3      0    1    yes 4200.0000 800.0000 3600.0000
  4      0    2    yes 3000.0000 800.0000 1732.7410
  5      0    3    yes 3000.0000 800.0000 1685.1310
  6      0    4    yes 3000.0000 800.0000 1715.8409
  7      0    5    yes 3000.0000 800.0000 3600.0000
  8      0    6    yes 3000.0000 800.0000 1716.0790
  9      0    7    yes 3000.0000 800.0000 3600.0000
 10      0    8    yes 3000.0000 800.0000 1603.4210
 11      0    9    yes 3000.0000 800.0000 3600.0000

Here, the cur_freq of core 7, 9, 11 looks incorrect.


With v5.17, we get the correct ones as below:

# lscpu -e
CPU SOCKET CORE ONLINE    MAXMHZ   MINMHZ       MHZ
  0      0    0    yes 4200.0000 800.0000 4199.8760
  1      0    0    yes 4200.0000 800.0000 1444.7260
  2      0    1    yes 4200.0000 800.0000 1554.8870
  3      0    1    yes 4200.0000 800.0000 1577.0760
  4      0    2    yes 3000.0000 800.0000 1800.5040
  5      0    3    yes 3000.0000 800.0000 1767.4659
  6      0    4    yes 3000.0000 800.0000 1800.3500
  7      0    5    yes 3000.0000 800.0000 1600.4460
  8      0    6    yes 3000.0000 800.0000 1597.0200
  9      0    7    yes 3000.0000 800.0000 1681.0930
 10      0    8    yes 3000.0000 800.0000 1700.8730
 11      0    9    yes 3000.0000 800.0000 1785.5389
 12      0   10    yes 2100.0000 800.0000 1202.8650
 13      0   11    yes 2100.0000 800.0000 1597.0270

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
