Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85487C995B
	for <lists+linux-pm@lfdr.de>; Sun, 15 Oct 2023 16:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjJOOKg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Oct 2023 10:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJOOKf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Oct 2023 10:10:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248BCD6
        for <linux-pm@vger.kernel.org>; Sun, 15 Oct 2023 07:10:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B995BC433C7
        for <linux-pm@vger.kernel.org>; Sun, 15 Oct 2023 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697379032;
        bh=mazWkWs9Yvp9x9aB2vZpqizn+UPywSxj7hFqe7d3Mwg=;
        h=From:To:Subject:Date:From;
        b=j5IrvWvMggTZ/JMHWUhw/apqTrOFsKLHG/w0Rjtih9s0iXpyQU37Wp1ENIFmozVlt
         lD3SQZVqdgqDsCk8twEbT94D/SQnRTNh+zYjKps8/Lqqv/ciKmiqCgR8IkjFHRao0F
         t68cf7UTJjmOE4SUNeMqMPWxf8ml9i5BMUxvq5YCYJfFLfrzaE7hLibnUyAePHOBah
         eF4P39lRF85AIzan5BSTeZBt1W2yfokCYsvHpfOinaSWaWOjrKe1s1K7NXTNOaicQ2
         BSg/lNta56uVCk0j9nABkUNddsgxIaJcxEDaMoXs38zGV6Q152wPjyITwom/3DnQ88
         a3YKCMLy8KISw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A4E30C53BC6; Sun, 15 Oct 2023 14:10:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218013] New: [question] option
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y available in config kernel?
Date:   Sun, 15 Oct 2023 14:10:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218013-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218013

            Bug ID: 218013
           Summary: [question] option
                    CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy available in
                    config kernel?
           Product: Power Management
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: ionut_n2001@yahoo.com
        Regression: No

Hello Kernel Team,

From what I can see, this option is not present in the kernel as an option =
that
can be activated.

In the following kernel versions, there will also be the option
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy?

Can this option also be available to use as a default option?

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
CONFIG_CPU_FREQ_GOV_COMMON=3Dy
CONFIG_CPU_FREQ_STAT=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=3Dy
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy


# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set; option available in the
kernel configuration file.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
