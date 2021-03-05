Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B2732F5A5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 22:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCEV67 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 16:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhCEV6n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Mar 2021 16:58:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 71C7464FEE;
        Fri,  5 Mar 2021 21:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614981523;
        bh=+TBnC3SMnEC6Ds+3HIEQUoC9zq0kY2PaJsR3PO/+J0c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZVppED+2ZLAqBwxyKgEeSgjZ+543sL9GprVu+yp7SCEdeLmr24zM+5iVwDD7FcADI
         PdGgTOWUnaXcIU4Z/U2aN1okp4ngw570QqiiryvbKvFuDgobCllk0mS1/UryOwzFIz
         6btwKcW31I6SA96NUsMDqpil2j2dPV91ka8DhCftlKg/aObq5fKOtHuj4MXNs2P9cB
         mM37tUWxgWGKfmvPDkrfESo7QpwrjZf4weouIE3CGMDFQZ+SEeJ0YCSQuTF4HkfjLI
         9GJKFhfVTWz5X/ar7nrioO0p/YH8hXGcqzSuwIGRH3KHxVrNYBN5Qzv8VHLiySkBHa
         pyrOuvG4bjYGg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5F231609EA;
        Fri,  5 Mar 2021 21:58:43 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.12-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jrtn6cbeQ9rgqmeiV_rAc_GB+rRT6qjtwbmgcCFPg-Qg@mail.gmail.com>
References: <CAJZ5v0jrtn6cbeQ9rgqmeiV_rAc_GB+rRT6qjtwbmgcCFPg-Qg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jrtn6cbeQ9rgqmeiV_rAc_GB+rRT6qjtwbmgcCFPg-Qg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.12-rc2
X-PR-Tracked-Commit-Id: 7bff4c26b6d2c82bebf8630f31b1cca11b1bd562
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d47254c063426541e7134fc5632243356ee74b1
Message-Id: <161498152333.14373.957763445346742559.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Mar 2021 21:58:43 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 5 Mar 2021 18:26:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d47254c063426541e7134fc5632243356ee74b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
