Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795902B0D78
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 20:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgKLTKQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 14:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgKLTKQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Nov 2020 14:10:16 -0500
Subject: Re: [GIT PULL] Power management fixes for v5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605208215;
        bh=b/3PCyJoiWcoWEPBn4UbDbQmDX1uqwZ9u2G50G7B/d4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VZfD4Apy1y0Y5NcLS4h0ZmgQSKwfYv9yGdafr1sjXD2EKWPCki6MSTb4S1lvnvMFB
         XSVX2BKXPSeInU86fglnCI2r4/J1ZMMSu8fY8GUM8JEFi8uwub6Nnskq+7LED6Dw42
         nrWmHm18WGFm6PHfpT2G1AQzpjpZB6+nXPF2HAUM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iypErbx8R-0wOnBOK=BNsY0HCNK13BEkdUoxsXJQ1K3g@mail.gmail.com>
References: <CAJZ5v0iypErbx8R-0wOnBOK=BNsY0HCNK13BEkdUoxsXJQ1K3g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iypErbx8R-0wOnBOK=BNsY0HCNK13BEkdUoxsXJQ1K3g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc4
X-PR-Tracked-Commit-Id: fcb3a1ab79904d54499db77017793ccca665eb7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcfb67918c0bc26c595c424b14f736205a49328a
Message-Id: <160520821579.3788.10534961589254491456.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Nov 2020 19:10:15 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 12 Nov 2020 16:58:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcfb67918c0bc26c595c424b14f736205a49328a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
