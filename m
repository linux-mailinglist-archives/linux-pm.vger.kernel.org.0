Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 461AD10EEB
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 00:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfEAWKE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 18:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfEAWKE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 May 2019 18:10:04 -0400
Subject: Re: [GIT PULL] power-supply changes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556748603;
        bh=UE28lYkTYNrPj6QrzxBXTjJp9ZvJ/7j1m3GZZ/pt7DU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lmi2kjnrCRp6LnWwI+StO8q3UMDMdHAuNtBEvswKfP7zFZyQEmZp8K7XUxZsuQ0R9
         zgIaapI0nftllTTkoDbXDiGvCfFjZ5UF/9bAivmDda0j5eP2bywe0fIsCQHqpmzk8O
         zltckELcpWc+LF1Y/8BF6FOCj9F9Mk2q0SH5RhEU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190501212610.5qrl7gyttdyzs2dq@earth.universe>
References: <20190501212610.5qrl7gyttdyzs2dq@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190501212610.5qrl7gyttdyzs2dq@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 tags/for-v5.1-rc
X-PR-Tracked-Commit-Id: 349ced9984ff540ce74ca8a0b2e9b03dc434b9dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 600d7258316d87cf9ecd58b6fdc8a35deca0870c
Message-Id: <155674860340.24187.4197229987499690721.pr-tracker-bot@kernel.org>
Date:   Wed, 01 May 2019 22:10:03 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Wed, 1 May 2019 23:26:10 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.1-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/600d7258316d87cf9ecd58b6fdc8a35deca0870c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
