Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F1C40729B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 22:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhIJUcU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Sep 2021 16:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232635AbhIJUcT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Sep 2021 16:32:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5133B61074;
        Fri, 10 Sep 2021 20:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631305868;
        bh=OHf6gU9X8ixTZKCKxvn9vs2klZK8S4bZpcNlWZgXEm8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qivVeOkiZdpMQuIGklRD0re8Wx8k08IshP5rYlCe7UX2h2Xjecykf9Jm8jqTWGZIz
         m74vNMNv9V/CRSBtFJ3U+H8FsWgtPYLbJhfbHQBtcSagP+zyml5/3je+5YIfBAin0z
         lQ0JbVJ13wEbFazZXVVq61AHBdVfpjGl8edy9lWmuQ0/b0IQP1QJpyct29JcdgOiLM
         nbwm40+fEmlkdOfbmhBn/dkp3mmWp6p8OvwKOli+sqoDQkt8sKQ4Tp13FWAwvivitv
         uT9N9vJZOD9YUrbEySFag4ZIyvYrOQveQHWdP1GVWocABXn9SBCieBkZY62zbo0r89
         k/VnfkgZphs0Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4514E609BA;
        Fri, 10 Sep 2021 20:31:08 +0000 (UTC)
Subject: Re: [GIT PULL] Additional power management updates for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jsnv0QYY7AeaUoxd3FsrSz_pxjjJsLk5svK4Uk7u25mw@mail.gmail.com>
References: <CAJZ5v0jsnv0QYY7AeaUoxd3FsrSz_pxjjJsLk5svK4Uk7u25mw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jsnv0QYY7AeaUoxd3FsrSz_pxjjJsLk5svK4Uk7u25mw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.15-rc1-3
X-PR-Tracked-Commit-Id: be2d24336f8876d60d8a4634f1a1e4753c4be124
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6498af58f5c7fb7b252f4791620fe4dd7213ca3
Message-Id: <163130586826.23508.16418228731499342592.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Sep 2021 20:31:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Fri, 10 Sep 2021 21:02:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.15-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6498af58f5c7fb7b252f4791620fe4dd7213ca3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
