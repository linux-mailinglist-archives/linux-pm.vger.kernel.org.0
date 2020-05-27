Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485391E38A3
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 07:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgE0Fzu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 01:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgE0Fzu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 May 2020 01:55:50 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AD90206F1;
        Wed, 27 May 2020 05:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590558950;
        bh=PcP0elMmxsxvC2yH2JORrMx/2zoxr/+2rXhvhlQJreI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OhocTK+Uz/yQpuW5nOGw7pZ64VE+pkmrKgYxsJ2bRR0uxGgVQ2y0o9D4cPASOhtDi
         BO4Dxh6HPtbHVS6xKrNo17LfFDr5RI1a1n7MSnYtLvgbpoQO6Agjwr3JRq27IRQQnj
         jTwS8Lc73ngULTpqDPrjBZ6AgWcHKM0PZlKadvBI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200330231617.17079-3-digetx@gmail.com>
References: <20200330231617.17079-1-digetx@gmail.com> <20200330231617.17079-3-digetx@gmail.com>
Subject: Re: [PATCH v1 2/5] clk: Introduce clk_round_rate_unboundly()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>
Date:   Tue, 26 May 2020 22:55:49 -0700
Message-ID: <159055894944.88029.2029223648098859689@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Dmitry Osipenko (2020-03-30 16:16:14)
> In same cases it may be desired to round clock's rate without taking into
> account current min/max requests made by the clock's users. One example is
> building up OPP table based on a possible clock rates.

Shouldn't the OPP table come from firmware/DT? I don't quite understand
why we're generating OPP tables on top of the rate rounding API.
clk_round_rate() is supposed to tell us what rate we'll get if we call
clk_set_rate() with the same arguments. An unboundly version of that
doesn't make sense.=20

I wonder if perhaps the clk provider should be populating OPP tables in
this case? Or basically anything besides adding another clk consumer API
to solve this problem. Who is the caller? Something later in this
series?
