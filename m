Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55016114849
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 21:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfLEUpZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 15:45:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfLEUpZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 15:45:25 -0500
Subject: Re: [GIT PULL] Thermal management updates for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575578724;
        bh=K3G2xfF85qnI+L6YrE0WXy/VTwCuslOtU0yJMagB8Rg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c2pK//Kl1GIGyc7Y4/TuzeoBreUWWmnKOyEuiHOlT2fAjEO1gtY0oB/i4wHn3TUXi
         QoWcXsQthWfV3KTe+NF9K6jCHEvjx0mkmQTVE6MjMPeAWiDlqFUbfRaXgBOIcWQ9Xu
         FzOg554uD+zXtbqqedKaqVzh49wMTby+mNLtPSt0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7f4da1c663268f53f2123424c1b8abdbe8316556.camel@intel.com>
References: <7f4da1c663268f53f2123424c1b8abdbe8316556.camel@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7f4da1c663268f53f2123424c1b8abdbe8316556.camel@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git thermal/next
X-PR-Tracked-Commit-Id: 163b00cde7cf2206e248789d2780121ad5e6a70b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb3da48a8640f634242a0c61b78c3a5c724c5004
Message-Id: <157557872460.26858.8137883580141541225.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 20:45:24 +0000
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pull request you sent on Wed, 04 Dec 2019 14:16:55 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git thermal/next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb3da48a8640f634242a0c61b78c3a5c724c5004

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
