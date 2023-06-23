Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A0173BE2D
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jun 2023 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjFWR7E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jun 2023 13:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjFWR7B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2023 13:59:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3642133
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 10:59:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A17EC61AD2
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 17:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12A3AC433C9
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 17:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687543140;
        bh=0BkLiEg4+N1eZvACQJch3sb4bXAtKiyVGWoCy1CSMv0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jnbMGO9uZA5nxmwlVwRM9cEOaWgAiZNkVdJ6HTrR0MFvc8dufaqEExapa6niE1EQG
         YpPvlyoxkvB9c5aRiMc6M10fsXVwyYXLULttu5IWLoRd/acaUpZComvFRaaWS/nUJb
         PTVO5kJXPgRZz27zZnLL4dNEVjvVXdDUqgV9XPETVu8cOFwqOvDFG7GGeu0Pj+wQd8
         aBlHEDVLDgAWgcET53AwDzfBkhPyPAiZtaECHzBknRp5ONqRZa405hd2xOEtq7CHaz
         5/EZeciExvH2R/rmaTijVXtlB8I7PlBEn+DcB8KIDsijLtGgrghcQLvbiLkJXX0BAY
         WBznFhsw2YFMg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 00D73C53BD0; Fri, 23 Jun 2023 17:59:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217589] Intel CPU maximum boost frequency reduced after resume
 from suspend to RAM
Date:   Fri, 23 Jun 2023 17:58:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bjackson0971@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217589-137361-Lh20yyfMSp@https.bugzilla.kernel.org/>
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

--- Comment #7 from Brad  Jackson (bjackson0971@gmail.com) ---
Created attachment 304475
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304475&action=3Dedit
pstate debug log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
