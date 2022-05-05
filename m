Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4143151BB07
	for <lists+linux-pm@lfdr.de>; Thu,  5 May 2022 10:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350511AbiEEI4N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 May 2022 04:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350555AbiEEIz4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2022 04:55:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9934B48E55
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 01:52:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EB6E61DCE
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 08:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4F68C385B1
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 08:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651740737;
        bh=95I7IHbjaJ6KPeEIYJxkRyxYJe2RH+D04tPWik2ZcW4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FW4nu50WkF0jOCPonkT1tujGjJ2cnn5Fz0ki77YxyqwzLq6TfuC4Ovd4LQtgG4Cgf
         1tNg91tOodSb3MsvjSKT7wCEAeur/v7NU6bXJQpChABoMKkYwyQ3PjyuwiGIA8gv4A
         ptX2rH9KZF534zKbnw2IBTX3REvyP8jyW3hmtjmF0QaPMJalXf06kXnsTXDixUMh5C
         Ng3tyCKvfKtrFRZRQSnE82iR+4ZV4oXsMKad+Z6S55iWojU/Jay2ebf43jrHTWHlKA
         V7H/kumoU6911QqTpI2/ZadUCRsYYcTlc8hX+XniJBQV00EGyRP8o9pWpF/OToDhO1
         lLU0FvJ72N06g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 936D3CC13AF; Thu,  5 May 2022 08:52:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215909] Regression with ACPI_STATE_C3 state freeze
Date:   Thu, 05 May 2022 08:52:17 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: ACPI
X-Bugzilla-Component: ACPICA-Core
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: acpi_acpica-core@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215909-137361-hi36iL9lVi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215909-137361@https.bugzilla.kernel.org/>
References: <bug-215909-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215909

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #3 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
have you tried if 5.18-rc5 helps, which contains the patch you mentioned in
comment 1?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.=
