Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731154FC253
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 18:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbiDKQaz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Apr 2022 12:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348491AbiDKQay (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2022 12:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4BB3134D
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 09:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC897616FA
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 16:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5227DC385AA
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649694518;
        bh=Om/mIDGz4OuLN5cm0s1OGIOzbNGU/9bqiJwbDEwg6cM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QEpBdfatWt8NTXfgGOpOOlBkie1XE8lzDV+4yV9KooTaF2G6yyVaZabFPbDa8JPkP
         VFyb9o4S5aCRl91r96dXihR3j+gysfCkB4bJ1hAHVu2p8Wk0IAEHEZg56IqgOkupcJ
         +kJnANcRzjrxDxO37Iw/vL8WxJ/m7OlHB4p06Wwo8qpJOYNXXb65vXGR8kfmNf9X1h
         Kh76KxTY/Wy/UUQ593eX5/E7FTsgB3r7thzqkvgL5LTGFnUrJc7VnEdlxrJIqn8dxY
         3X6HJUKrVKmbuqdtLtPhoUXPtnzaKOIsTYWcXRzUNgITIVVZaoFOzimCFNM10eJESG
         yxmdQiqQAEcng==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3A1A4CC13AD; Mon, 11 Apr 2022 16:28:38 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Mon, 11 Apr 2022 16:28:37 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215800-137361-GantoQsk7d@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
> Thanks for the report. Can you print: "lscpu | grep cppc"?

# lscpu | grep -i cppc
returns nothing.

# lscpu --version
lscpu from util-linux 2.37.4

I've loading the amd-pstate driver prior to running it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
