Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF11F55B96
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 00:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFYWsk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 18:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFYWsi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 18:48:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B2C208CA;
        Tue, 25 Jun 2019 22:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561502917;
        bh=xEOhnZFYPU0kl7vlwY6b72T7LtUSnI7LyCrwDMJeNQc=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=FAG/FBASb4pUoMWvnBeMVJZ0REWyiW3tGGOSCkbCnRUnarXch2LSrsVmXloLOpinJ
         fS3ZQRp87jP/VRVGWCaNuQVecJpKRt1HAn1h8eJiEwsgHafPZJbEU9j5b0nXTVR3II
         3I8MKcBLA3DogQTMnLF/uRJLsR4dwoMZ8tHFxCCA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190611180757.32299-3-paul@crapouillou.net>
References: <20190611180757.32299-1-paul@crapouillou.net> <20190611180757.32299-3-paul@crapouillou.net>
To:     James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 3/5] MIPS: jz4740: PM: Let CGU driver suspend clocks and set sleep mode
Cc:     od@zcrc.me, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 15:48:36 -0700
Message-Id: <20190625224837.58B2C208CA@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Paul Cercueil (2019-06-11 11:07:55)
> Instead of forcing the jz4740 clocks to suspend here, we let the CGU
> driver handle it.
> We also let the CGU driver set the "sleep mode" bit.
>=20
> This has the added benefit that now it is possible to build a kernel on
> SoCs newer than the JZ4740 with CONFIG_PM.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next

