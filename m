Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9E73749B2
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 22:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhEEUuj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 May 2021 16:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230089AbhEEUu2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 May 2021 16:50:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5161361176;
        Wed,  5 May 2021 20:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620247771;
        bh=PzJFrmt9wogXp8aA0hx2iLum0KVL6EybLbueWzdfnQM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LUwHMqA3vh0wmdhodLVmEdNPLKnOH92S8o0/nlR6w3QxTYYn1eKdRUgYOS9J3rJjp
         zO0OihpK1SLceeG2fSfUIvN0zIBCNIcvjaBNgEjCNmARxetUi9jApWX0PgRJdu13wo
         zttexbwzQc5qu65pKaaDuEzVMF8VzA5ooA+x2tGXgrnBNl7NkDe/oWJ0BCztrBDHMr
         2Ld/JQLoIROoMlZx3/PmCaP9Z1MwVxo8eyzFMRi5KW9MLdOtt/1aIE+Psw/v2CQOde
         MZNpZVO43mkBACpHDpPHi09x1UySI9cTSZZC0HzIrp8pXiXDu3sxXg/iXCEkOXm4Ih
         agxEB7AstwoIQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 472B2609E8;
        Wed,  5 May 2021 20:49:31 +0000 (UTC)
Subject: Re: [git pull] Thermal material for v5.13-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <aaa1d843-a8fc-ed31-495d-45080a944558@linaro.org>
References: <aaa1d843-a8fc-ed31-495d-45080a944558@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <aaa1d843-a8fc-ed31-495d-45080a944558@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.13-rc1
X-PR-Tracked-Commit-Id: c310e546164d5cca4c12faf9582b75989b030b68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 583f2bcf86a322dc0387f5a868026d2e2fe18261
Message-Id: <162024777128.12235.11884678578593314250.pr-tracker-bot@kernel.org>
Date:   Wed, 05 May 2021 20:49:31 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        unixbhaskar@gmail.com,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>, zhang.yunkai@zte.com.cn,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Colin King <colin.king@canonical.com>,
        =?UTF-8?B?6auY5LqR6ZyEIChKZXNvbiBH?= =?UTF-8?B?YW8p?= 
        <jeson.gao@unisoc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Hao Fang <fanghao11@huawei.com>,
        brian-sy yang <brian-sy.yang@mediatek.com>,
        David Collins <collinsd@codeaurora.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        zhuguangqing83 <zhuguangqing83@gmail.com>,
        Robert Foss <robert.foss@linaro.org>, gongruiqi1@huawei.com,
        yebin10@huawei.com, dingsenjie@yulong.com,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        rafal@milecki.pl, Lin Ruizhe <linruizhe@huawei.com>,
        Ansuel Smith <ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Wed, 5 May 2021 10:44:25 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/583f2bcf86a322dc0387f5a868026d2e2fe18261

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
