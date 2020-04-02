Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C8B19B98F
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 02:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbgDBAdo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 20:33:44 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:64472 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732385AbgDBAdo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Apr 2020 20:33:44 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48t3vn20Xyz89;
        Thu,  2 Apr 2020 02:33:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585787622; bh=g5oktEpziHDxOpMYAK40bYCrnaceF9EuhgSDmuCb+tQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHzbpWP7YLBof2cEB7+K3kdEh4KmkQL60ONggM5hLT/9YesMPMLT0blDz7juIG7WM
         f8T8kAygAhTn3jyA+X4EjNrzWsqHlhUuumx5ARR5GxWuueqfcWvfVvAb7cMVuEf31Q
         5hEDpWZdGwpoLFJyOeE6aaaKRAyz+AKW7TJZMAwF+vzizTCfAzBiGR9OeYHNMVmpbh
         9+V09Rv7tMlhnH9DLFF7es4GmWqoWW1axAQW2WZyP6lC/ihdGBg8WxAeXkbWCQ5wBT
         VyRutW5p2nt/5XLnV2XDP3wXwrSpI2pnvEiVZb+14t9Uec93v65x1PAGT0UQXNN6cm
         69yQ1vi/qPTPw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 2 Apr 2020 02:33:40 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] clk: Introduce clk_round_rate_unboundly()
Message-ID: <20200402003339.GA11124@qmqm.qmqm.pl>
References: <20200330231617.17079-1-digetx@gmail.com>
 <20200330231617.17079-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200330231617.17079-3-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 31, 2020 at 02:16:14AM +0300, Dmitry Osipenko wrote:
[...]
> +/**
> + * clk_round_rate_unboundly - unboundly round the given rate for a clk

Just grammar nits:

clk_round_rate_unbounded - round the given rate for a clk, ignoring users' min/max constraints

> + * @clk: the clk for which we are rounding a rate
> + * @rate: the rate which is to be rounded
> + *
> + * Takes in a rate as input and rounds it to a rate that the clk can use
> + * which is then returned.  The given rate isn't bounded by clk users min-max

s/bounded/limited/ ?

> + * rates, unlike in a case of clk_round_rate().  If clk doesn't support

"... unlike in clk_round_rate()."

> + * round_rate operation then the parent rate is returned.
> + */
[...]

Best Regards,
Micha³ Miros³aw
