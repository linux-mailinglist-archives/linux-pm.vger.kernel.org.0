Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53F01E38A9
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 07:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgE0F5O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 01:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgE0F5O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 May 2020 01:57:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EDEB206F1;
        Wed, 27 May 2020 05:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590559034;
        bh=gzYDsc4yTRXjwRrubCOSTfXhjkTXv+sPDRxNFrDrKAQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PkJ1Lv2ZnQe9Yl0Jyj0rmKzdwjBpwkF3pBASWPbe2h0z7YiiNE1ZDdQ9e9cdOSWaP
         VPscRnqc88YezlXaJVKsqR9RfzWE7DkOUwh/0LTJacAHi5CmMyY+WWPecqdNT0iEDm
         x0rh+xgoYG2uegnWV+QKql2+rHN9FfRNHbM5b//Q=
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
Date:   Tue, 26 May 2020 22:57:13 -0700
Message-ID: <159055903348.88029.4091179421954621221@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Dmitry Osipenko (2020-03-30 16:16:14)
> In same cases it may be desired to round clock's rate without taking into
> account current min/max requests made by the clock's users. One example is
> building up OPP table based on a possible clock rates.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/clk.c   | 49 +++++++++++++++++++++++++++++++++++----------
>  include/linux/clk.h | 18 +++++++++++++++++

BTW, please run get_maintainers.pl patches. Russell maintains
include/linux/clk.h (the clk API). CCF implements it.
