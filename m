Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A7D22793E
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 09:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGUHJ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 03:09:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgGUHJZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Jul 2020 03:09:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65C0721702;
        Tue, 21 Jul 2020 07:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595315365;
        bh=tFu8F8n6vWk0A1esQrhBCBky/rSzYMHkaMGFxPk4/LM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NkFLC7saeyDppAG2mVH2kQKg5/VJ3L6kCIkPv5uLo/Ne7REzJ8RuVhwPIkIdzt3JH
         LieWRBAgVyQjJapin35tM7Zf1FEIuvDzYbgnW8RMXcAkDKjB0sAPmmr49kQ9WIq2fT
         wdRO7WnXyMWCje5jKfFw1j4gpqqYPpyF7cDyNwN4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200716022817.30439-2-ansuelsmth@gmail.com>
References: <20200716022817.30439-1-ansuelsmth@gmail.com> <20200716022817.30439-2-ansuelsmth@gmail.com>
Subject: Re: [PATCH v4 1/7] ipq806x: gcc: add support for child probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Jul 2020 00:09:24 -0700
Message-ID: <159531536464.3847286.9536176354576279117@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Ansuel Smith (2020-07-15 19:28:10)
> Add support for child probing needed for tsens driver that share the
> seme regs of gcc for this platform.
>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---

Applied to clk-next with the typo fix and tag.
