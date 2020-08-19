Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA9249350
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 05:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHSDNf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 23:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgHSDNe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Aug 2020 23:13:34 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D1EF2065F;
        Wed, 19 Aug 2020 03:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597806814;
        bh=jBJh5kxEFmem8OBd4D3VvTvseJXtj5YSJL31DFhDNRg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WyPqN4dWQaX7X9BksHna51LU8C201UlVBvovPE6gkQ0CbzPoiR0AnqqjRQTc9u2FY
         EEC/aLO5jXWhlIgmYK+4IBr2V5oaRQgJ9X50ZViVnZ6KkE2IDZyCW0JYcYlKSkzyJ6
         gYfjtvpMUkQq6nIwD88oPbYaPi6GUa4PIAbSrjmI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200811084943.GC7488@shao2-debian>
References: <20200811084943.GC7488@shao2-debian>
Subject: Re: [clk] a2499eff4b: BUG:kernel_NULL_pointer_dereference,address
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel test robot <rong.a.chen@intel.com>
Date:   Tue, 18 Aug 2020 20:13:33 -0700
Message-ID: <159780681339.334488.10402512224012716827@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting kernel test robot (2020-08-11 01:49:44)
> Greeting,
>=20
> FYI, we noticed the following commit (built with gcc-9):
>=20
> commit: a2499eff4b30a85d56e4466e6ca4746c72a347c6 ("[PATCH v2] clk: samsun=
g: Keep top BPLL mux on Exynos542x enabled")
> url: https://github.com/0day-ci/linux/commits/Marek-Szyprowski/clk-samsun=
g-Keep-top-BPLL-mux-on-Exynos542x-enabled/20200807-213239
> base: https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git clk-next
>=20
> in testcase: trinity
> with following parameters:
>=20
>         runtime: 300s
>=20
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
>=20
>=20
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m =
16G

Cool robot. But this doesn't look related to the patch at all?
