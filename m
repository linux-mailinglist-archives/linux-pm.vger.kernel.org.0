Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34EF23E5A1
	for <lists+linux-pm@lfdr.de>; Fri,  7 Aug 2020 03:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHGBzI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 21:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgHGBzH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Aug 2020 21:55:07 -0400
Subject: Re: [GIT PULL] RESEND: thermal for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596765307;
        bh=VKHTneHgQd9kfBEFTXy/ydtlL31JnW0bvl2ACafIqr0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TdowF9EnLsmGGm1GW3upeFv5zKyeAxRr9S29REfKo/psivR/YNL4zmTqafIs3P7TE
         D6uFMLmX3dbvD9RnmXB0XYdhLhyPJn7VGssfdanVZM2HEbVDj873wOkCZ9WgCWiiww
         zjmVOaZtCuT0CWCK8EAZdILphxqAPk46HmyVbtKc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <db1dc155-0c7c-f4eb-7fa6-047a78829a82@linaro.org>
References: <db1dc155-0c7c-f4eb-7fa6-047a78829a82@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <db1dc155-0c7c-f4eb-7fa6-047a78829a82@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.9-rc1
X-PR-Tracked-Commit-Id: c569e805c7bcebdd069e5c97ce5f8543f6d02433
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96e3f3c16b7aedcd71502ccfc5778dddfc2e7b15
Message-Id: <159676530743.30846.14861257054393255674.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 01:55:07 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Colin King <colin.king@canonical.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Henry Yen <henry.yen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Thu, 6 Aug 2020 22:18:59 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96e3f3c16b7aedcd71502ccfc5778dddfc2e7b15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
