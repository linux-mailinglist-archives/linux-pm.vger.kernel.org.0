Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63DD1C4E3A
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 08:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgEEGVY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 May 2020 02:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEGVX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 May 2020 02:21:23 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52BB9205C9;
        Tue,  5 May 2020 06:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588659683;
        bh=WsNWK9tsUi5XMJrw3yud/Cj9uT5myHrwx5V4T1Qlwvg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WSOFx9yRBefOuK9P0jqknh1PZ0kCLhDftzJ/faQIyq4Njhyvj/VmWeTt0k+xr7St4
         mmzR+6V7tggxJALz1d+/loAw+tdzrT6B+tDxvjoGW1NWv5vC3nCMs90mjoUd89yAxb
         cfbppld/2DWCtjwHacuk/jvPhzMKrSTuNAKtdyCk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200429205825.10604-8-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org> <20200429205825.10604-8-robh@kernel.org>
Subject: Re: [PATCH v2 07/16] clk: vexpress-osc: Support building as a module
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Date:   Mon, 04 May 2020 23:21:22 -0700
Message-ID: <158865968256.24786.10445159490828872614@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rob Herring (2020-04-29 13:58:16)
> Enable building the vexpress-osc clock driver as a module.
>=20
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
