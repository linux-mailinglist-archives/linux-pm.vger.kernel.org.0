Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5195C14E061
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2020 19:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgA3SAR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jan 2020 13:00:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgA3SAQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jan 2020 13:00:16 -0500
Subject: Re: [GIT PULL] power-supply changes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580407216;
        bh=aVRiGFRtERdZiobP1u7JD7R+PuRRALh/IlDSc9WjZpU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1cJGJPUROnqCx5XF3PZbEnyEATcojZViLwnEVuWmvPCmSEELhnVoqxY1S96F10mTn
         ++tvzhl06TqEbqougJlePrzt4+lXC+NWdzF5Cr6FXSPEVCdOJrC9EO7ngP5hrPZUmS
         jJx+DyP55bB8el5AaCUPxERxalnjFqoSbArCFlwA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129224926.owfuj6mfya4crpwm@earth.universe>
References: <20200129224926.owfuj6mfya4crpwm@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129224926.owfuj6mfya4crpwm@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 tags/for-v5.6
X-PR-Tracked-Commit-Id: 3d32a8437c051013352baf5cbd0844fcf5d2f409
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cadc60d6bcfee9c626d4b55e9dc1475d21ad3bb
Message-Id: <158040721634.2766.17366184752319645480.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 18:00:16 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 23:49:26 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cadc60d6bcfee9c626d4b55e9dc1475d21ad3bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
