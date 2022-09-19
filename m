Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5515BCB7F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Sep 2022 14:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiISMKI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Sep 2022 08:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiISMJl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2022 08:09:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F412C656
        for <linux-pm@vger.kernel.org>; Mon, 19 Sep 2022 05:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33FA8B81A60
        for <linux-pm@vger.kernel.org>; Mon, 19 Sep 2022 12:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4CA3C433B5
        for <linux-pm@vger.kernel.org>; Mon, 19 Sep 2022 12:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663589328;
        bh=lMc+ZMKuhbipeB1DoL/r5MKQWs2lR+gDYaq1l2MIYmA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GdGaIjtfIEkKgIV3KZYYNXTBGl5DedkZEMn9wU6fJochxYUh3wWHXBSBx5gHxY70J
         /+cI7devJv6zX/WOtJ5t3gJO2itjV7jIM5I44c7ncD9mYRUtXpRhqX6dSZWWpzN4a1
         HQTdtm2DekX6/xWzojcQbhVpSAKmZ55xVGwBwwDM8IID/VtvEQz0V+NWS/+PMkbcI8
         w8hUx8eoRTXQcDZqxiW+RQ8e0En4SW0/oJT6znMVQPYHfjt1ZUvKqEOTBuiP64oNMx
         c39kzI3uxdfaCHopy3qDMnDWiMre40rBwwK2MpjjCIHjvp4IH9rrxp0bfV+YQ9k2NO
         pz29uKbtUWwIg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C22BAC32747; Mon, 19 Sep 2022 12:08:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Mon, 19 Sep 2022 12:08:48 +0000
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
Message-ID: <bug-215800-137361-0fZ8md0KQF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #24 from Artem S. Tashkinov (aros@gmx.com) ---
Is this driver (development) dead now that there's a new AMD driver for CPP=
C?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
