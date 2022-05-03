Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083EF51924F
	for <lists+linux-pm@lfdr.de>; Wed,  4 May 2022 01:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiECXbG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 May 2022 19:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244261AbiECXbF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2022 19:31:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296AB3E0D9
        for <linux-pm@vger.kernel.org>; Tue,  3 May 2022 16:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7643617C9
        for <linux-pm@vger.kernel.org>; Tue,  3 May 2022 23:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25E29C385AF
        for <linux-pm@vger.kernel.org>; Tue,  3 May 2022 23:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651620450;
        bh=eXqr6ordca2xAkUYpX8Fu2y0E8BWND38wO75Lzs8A9E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=X4yMUEzfQPLYkbICSZdOp5cm34dSN/NCB7Ey48BMVUuOJqR8fR5uZUQKOdryh/gS3
         tjnJaNwYW2xuzJKNgcallLYPaKCfY+vSSaC5J7YuGZQRtMZqTXnb9JP/kzx9DMaLDU
         D3+4+AYxQlnjo90PYQabEk441CFpFK6dH1o/W6XzhivNo/qbFyjC3uiNuh/++73VTK
         Jy5hTML2uYK3NWEhnSeSTI63/xe5f+asQNRq6oKj14U394YmApLP5Dd8abJWaANpPp
         r3/p7rz0A7+QgO1Bpbe+U5fnXuyrUEqW8wHYOc1e+TZZMba+tJj9iXdWBDEm2Sq0P0
         RWUl/4wzj+fMA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 08096CC13AD; Tue,  3 May 2022 23:27:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215909] Regression with ACPI_STATE_C3 state freeze
Date:   Tue, 03 May 2022 23:27:29 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: ACPI
X-Bugzilla-Component: ACPICA-Core
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: axet@me.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: acpi_acpica-core@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215909-137361-1F77DFl882@https.bugzilla.kernel.org/>
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

Alexey Kuznetsov (axet@me.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |linux-pm@vger.kernel.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.=
