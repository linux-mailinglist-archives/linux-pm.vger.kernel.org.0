Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3856770B62
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbfGVVbD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 17:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbfGVVbC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jul 2019 17:31:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF8821900;
        Mon, 22 Jul 2019 21:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563831061;
        bh=xJwOs8eh6wnbncGoeTw21vj4R8KhLdFsORfmYU7Lf3I=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=kpTa1yt4tICwzZeizjpF+rNU5ZHlEd3hIlkvTx1ZNFktON55CgJqXfZNpayZordNk
         0f0ThtuDVcxi9Q1qoh6BQ/PakL8QUg2aHzgwfmgP1Fe9jvEYYyOFf4RImt37Rh5/fJ
         XRrUy30G71WYl4dtSBHyIQuswTqvNUcSuskK3NbU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190705045612.27665-5-Anson.Huang@nxp.com>
References: <20190705045612.27665-1-Anson.Huang@nxp.com> <20190705045612.27665-5-Anson.Huang@nxp.com>
Subject: Re: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT
To:     Anson.Huang@nxp.com, abel.vesa@nxp.com, agx@sigxcpu.org,
        andrew.smirnov@gmail.com, angus@akkea.ca, ccaione@baylibre.com,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        edubezval@gmail.com, festevam@gmail.com, kernel@pengutronix.de,
        l.stach@pengutronix.de, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        rui.zhang@intel.com, s.hauer@pengutronix.de, shawnguo@kernel.org
Cc:     Linux-imx@nxp.com
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:31:00 -0700
Message-Id: <20190722213101.ADF8821900@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Anson.Huang@nxp.com (2019-07-04 21:56:11)
> From: Anson Huang <Anson.Huang@nxp.com>
>=20
> IMX8MQ_CLK_TMU_ROOT is ONLY used for thermal module, the driver
> should manage this clock, so no need to have CLK_IS_CRITICAL flag
> set.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

