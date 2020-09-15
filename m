Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAD726B17A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 00:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgIOWbE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 18:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbgIOQRU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Sep 2020 12:17:20 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D8D520708;
        Tue, 15 Sep 2020 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600186631;
        bh=8+1P9qS5z6t5FdvETm4LTTARiYF70pqWnyt3JI9TZ8Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uD2AeQEj4Xqs79H2UEUkkuZq7CbJ3GVHCXBCL8oH28D1uCvoWlLteMCd4nPTq3Azn
         rYOQ7rcKMSW4KbnqOKDqgx5G+DzheogSz6ZDUNAk5GFqpHue1Rx8TEpbcaBXJ2KrhB
         hnwM3dHCfhaGftsvBY/Hvxd1jBBs6SJ8MF/j8NOw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8d90ada6-ac26-9d7a-6ad5-7f7704cfffc5@samsung.com>
References: <CGME20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f@eucas1p1.samsung.com> <20200807133143.22748-1-m.szyprowski@samsung.com> <159780685238.334488.5802955284004610550@swboyd.mtv.corp.google.com> <f4c87130-25a0-2195-9caa-be805d207c34@kernel.org> <fff07b05-f1f6-5333-a056-69ba6995ed4f@kernel.org> <20200824103123.GD25860@kozik-lap> <3ba7cf94-1b1f-a500-4c4f-a9769531097b@samsung.com> <8d90ada6-ac26-9d7a-6ad5-7f7704cfffc5@samsung.com>
Subject: Re: [PATCH v2] clk: samsung: Keep top BPLL mux on Exynos542x enabled
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Date:   Tue, 15 Sep 2020 09:17:10 -0700
Message-ID: <160018663023.4188128.11636063556241845225@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Sylwester Nawrocki (2020-09-15 05:43:07)
> On 02.09.2020 11:24, Sylwester Nawrocki wrote:
> > On 24.08.2020 12:31, Krzysztof Kozlowski wrote:
> >>> the clk/samsung tree for next merge window?
> >>
> >> All current multi_v7 and some of exynos defconfig boots fail on Odroid
> >> XU3-family, starting from v5.9-rc1. On kernelci and my boot systems. If
> >> I understand correctly, this is a fix for this issue, so it should go =
as
> >> fast as possible to v5.9 cycle.
> >>
> >> Otherwise we cannot test anything. The current v5.9 RC is then simply
> >> broken.
> >=20
> > Right, we need that patch in v5.9. Stephen, can you please apply
> > the patch to your clk-fixes?
>=20
> So I applied the patch to my tree and sent you a pull request
> instead... :) I thought it will handling subsequent patches
> that depend on that one more straightforward.
>=20

Great!
