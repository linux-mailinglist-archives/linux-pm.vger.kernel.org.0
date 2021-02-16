Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B107C31C4FE
	for <lists+linux-pm@lfdr.de>; Tue, 16 Feb 2021 02:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBPBmh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 20:42:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhBPBma (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 20:42:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D51EF64DDA
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 01:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613439709;
        bh=WktawmuCXCsjfFEj/1jW39fEc1eTsnGNu6NXz3Osw8I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BR7ApY6c6eus8RtM52NYxEzjAF0Yc+8t3gaCZQwXCx3xgsnKqx876xjol++Z1QwNN
         DWxvVVZPlIxohUJmBFZ/fWkBZtbSZpdfyk3IvETJ3S3KlUvkYq0CX88ag1LIlj0d9I
         GMmm8LJIW3Fq372VLiCGSL51WOCx8pobk1OPBC9miSJhjuh7BU65FBBgflq3iUPEND
         UUFoayxXpig9STuau+1RqyzQThDJTR4p2X6rOH5kUFb6VVPl/6pRCJf3mSLEfuXRDq
         +w6DIabMMbAeTZobpSIs6x+7WVvqiCeOi6U6UTlHEdqJdhA0GGXMNMBcPo33fGudVY
         JmG3agU/DF2rg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id D0DB5653BC; Tue, 16 Feb 2021 01:41:49 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211791] AMD CPU /proc/cpuinfo reported max potential boost
 frequency instead of actual operating frequency
Date:   Tue, 16 Feb 2021 01:41:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: me@rin.cat
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-211791-137361-akVteemIfz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211791-137361@https.bugzilla.kernel.org/>
References: <bug-211791-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211791

--- Comment #1 from me@rin.cat ---
Created attachment 295307
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D295307&action=3Dedit
lscpu

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
