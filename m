Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E31ECA8D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 22:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKAVxi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 17:53:38 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:45655 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfKAVxi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Nov 2019 17:53:38 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 474bVf6Vvnz45;
        Fri,  1 Nov 2019 22:51:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1572645083; bh=g1Sbe1Y39eeH3TcNY4+DDp2UVtzLy356El6ORW/CpFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cz7oiq2PKQ7/N+D00vdEw61RZdD/JydQuTCh74hrwVDYz+tL7Ql2H6nZuLYYYL7hJ
         kKbwjhU6DkrT/FMMiQB3w1bmkR+Er9+qkLdELmWuM5sLf0bJ89s54KSeWlUHYBC22P
         1eoM7eTQ+niLDDA3mRLU6gDof/5psHgsQ7jw8dZZKWhFlPxz+1aTwbGEbM8YseT2ER
         RX0xO3/Sn5h9C4aBn5csa4aDXm69pLrwXWQy+jWTwOeQstH6A4kIoeKweXJAt/n6U6
         VInxX1cXDOR4r1l/rEndT1PR2zBM0x33B/yzIEzqlwJCfrwFipN9hjydVvT0bP9Vz9
         nc8EeiCpEphwQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Fri, 1 Nov 2019 22:53:32 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 13/19] PM / devfreq: tegra30: Increase sampling period
 to 16ms
Message-ID: <20191101215332.GA8724@qmqm.qmqm.pl>
References: <20191029220019.26773-1-digetx@gmail.com>
 <20191029220019.26773-14-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191029220019.26773-14-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 30, 2019 at 01:00:13AM +0300, Dmitry Osipenko wrote:
> Increase sampling period by 4ms to get a nicer pow2 value, converting
> diving into shifts in the code. That's more preferable for Tegra30 that
> doesn't have hardware divider instructions because of older Cortex-A9 CPU.
> In a result boosting events are delayed by 4ms, which is not sensible in
> practice at all.

This is made irrelevant by patch 17.

Best Regards,
Micha³ Miros³aw
