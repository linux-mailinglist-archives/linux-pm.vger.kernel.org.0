Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3F02DB821
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 02:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgLPBB2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 20:01:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbgLPBB1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Dec 2020 20:01:27 -0500
Subject: Re: [GIT PULL] thermal for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608080409;
        bh=FXHkQmQiwi0L0d7Qt1C4IF+fiKMt3xaOPb80BEliyL4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ws2OGi+WNhLuMFNLCmshOZUaibLVkWiwMVv2TRhGjO3sq/ybkMFCUCqCrYVYLwa8v
         ZAV75ROzX9AI/xaDbUCs2rMPoQJ/POUk2aJ3YcatBlIfKOVPm5EQEV6o3dLrVYNWC8
         g25Rl42OxV6pBLbKUIpy2cTiu9D32x4IABc7NEN7lpFvaBLHH6iiQsvm60hOq+nZv/
         w8j4lpyc5RwpHSiYPdVDDIUvv6PZvsVZ8ELJxDZRIpd20C9mQbIypd5wD/gTEeX62X
         sCUenY08J/ZByaUMiSK2TTHLMq6qbhZ2C36T6GMlItSEI/AUbp0XRFbjbWl4AZiAt/
         wFJFERwb4kX+A==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9a2b3f9e-458a-bb66-2c38-db6cbf5a6c73@linaro.org>
References: <9a2b3f9e-458a-bb66-2c38-db6cbf5a6c73@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9a2b3f9e-458a-bb66-2c38-db6cbf5a6c73@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.11-rc1
X-PR-Tracked-Commit-Id: 4401117bf7fc11dc738c0963fa0c94814abc8dcd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b109bc72295363fb746bc42bdd777f7a8abb177b
Message-Id: <160808040981.29502.3041225195237569127.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 01:00:09 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        "michael.kao" <Michael.Kao@mediatek.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>, Bernard <bernard@vivo.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhuguangqing <zhuguangqing@xiaomi.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andres Freund <andres@anarazel.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        rikard.falkeborn@gmail.com,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        zhengyongjun3@huawei.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 23:17:29 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b109bc72295363fb746bc42bdd777f7a8abb177b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
