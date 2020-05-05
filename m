Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668211C4E34
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 08:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgEEGUm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 May 2020 02:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEGUm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 May 2020 02:20:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E90C205C9;
        Tue,  5 May 2020 06:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588659642;
        bh=sdnQohPvQROCI2sRvGa17udMmgVaBKbSC8JyZGmjCz0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=opMRFndCpGhUSprX51C8E5OXTbXiJzzCxdta3veIIiFi4mSSUWhAFRS2DjG8dSOd+
         iTGzqSAdY762EM94ilunogJWghFSKdz+b1dlSzMQCyObTJX+wAmN9Vig67Oy38DPpb
         sxD8nHvcSb69ON4PrN1dPbNuBoYJNIRPYnayKG4o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200429205825.10604-5-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org> <20200429205825.10604-5-robh@kernel.org>
Subject: Re: [PATCH v2 04/16] clk: versatile: Rework kconfig structure
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Date:   Mon, 04 May 2020 23:20:41 -0700
Message-ID: <158865964143.24786.3579131427025004348@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rob Herring (2020-04-29 13:58:13)
> CONFIG_COMMON_CLK_VERSATILE doesn't really do anything other than hiding
> Arm Ltd reference platform clock drivers. It is both selected by the
> platforms that need it and has a 'depends on' for those platforms. Let's
> drop the selects and convert CONFIG_COMMON_CLK_VERSATILE into a
> menuconfig entry. With this make CONFIG_ICST visible.
>=20
> Move the 'select REGMAP_MMIO' to the drivers that require it (SP810 did
> not).
>=20
> This also has the side effect of enabling CONFIG_ICST for COMPILE_TEST
> as it was not visible before.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
