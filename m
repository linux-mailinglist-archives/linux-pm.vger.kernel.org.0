Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27A6F530B
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 18:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfKHRzK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 12:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfKHRzJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Nov 2019 12:55:09 -0500
Subject: Re: [GIT PULL] Power management fix for v5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573235709;
        bh=xHy0nvHljiRRq8DzBp+xPk2iIrF2LCGDg3fG2/b1mCw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jdlqnbF3CBofTaEVqz3AAZ9oi6r8N/Rf+wlIApUMKvkLedIBx3/VIhZ5GewuIv1Bt
         S5a57dYTplwLjgDpbYvBVnw9mUQellAgQQTORCa5eBOd6GfKGjl3gkIgagNAJQCOWV
         GnjWZPcrQGmKQj10XKQnrjC92KCKXXPU09NYzj3o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hTxyzNAyEeeZfqu1XNcFY9mYeft9EnAP+zD6s7x0Csqg@mail.gmail.com>
References: <CAJZ5v0hTxyzNAyEeeZfqu1XNcFY9mYeft9EnAP+zD6s7x0Csqg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hTxyzNAyEeeZfqu1XNcFY9mYeft9EnAP+zD6s7x0Csqg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.4-rc7
X-PR-Tracked-Commit-Id: c31432fa7f825de0e19838f1ac7746381c509ec4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d8b3262af02c4245ac396b7f2bc71eb328931e2
Message-Id: <157323570899.12598.13332361822305090207.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Nov 2019 17:55:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 8 Nov 2019 12:05:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d8b3262af02c4245ac396b7f2bc71eb328931e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
