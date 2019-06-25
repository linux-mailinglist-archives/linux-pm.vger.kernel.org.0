Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF27455B76
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 00:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFYWmW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 18:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFYWmW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 18:42:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2643520645;
        Tue, 25 Jun 2019 22:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561502541;
        bh=KouZu5qnypdtE8X3me3dX90B1JxpSh5C4RafRD60fCM=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=OEzP8BP4Lowoj6agjatrsqH4p0/Rlwt9Wqqhp+TLMA8djoRnhxsT5RYrNFEDN/EC+
         i9ShFoH6/UnIjVb6AzY5jsAqX5OGuJ9NV43putA86b4kunILYqDfbQM8LkBi45HHTN
         +u1I+xQvL+o7DqJG8KziRJ6JRxCFYuVYXbKYtb2o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190625221736.853892086D@mail.kernel.org>
References: <20190611180757.32299-1-paul@crapouillou.net> <20190625221736.853892086D@mail.kernel.org>
To:     James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 1/5] clk: ingenic: Add missing header in cgu.h
Cc:     od@zcrc.me, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 15:42:20 -0700
Message-Id: <20190625224221.2643520645@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Stephen Boyd (2019-06-25 15:17:35)
> Quoting Paul Cercueil (2019-06-11 11:07:53)
> > The cgu.h has structures that contain 'clk_onecell_data' and 'clk_hw'
> > structures (no pointers), so the <linux/clk-provider.h> header should be
> > included.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >=20
> > Notes:
> >     v2: Rebase on v5.2-rc4
>=20
> You seemed to miss my review comments on patch set #1.
>=20
> https://lkml.kernel.org/r/155726035790.14659.7321778387595703949@swboyd.m=
tv.corp.google.com
>=20

I've just decided to fix it instead of wait. Let me know if that's a
problem.

