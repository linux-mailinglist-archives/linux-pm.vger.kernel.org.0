Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF171C4E36
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 08:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgEEGUw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 May 2020 02:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEGUw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 May 2020 02:20:52 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 331EA205C9;
        Tue,  5 May 2020 06:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588659652;
        bh=djMwJInpML5g6hw6YsI4MhjTVHB2grQ/LVDJ5Pfpyqs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=wOj+3RbezTlPzKKG46Cbnv0iiNmPUOFRWT/yJnklgDlwuBUu+lb40/yG9uuLZjT7B
         h/ytCfFtwinS+MFDWN1ppJRcM7VkA06+RkGDyWixy88hcZAPcV2kK1LADhomi0g5FC
         UNLsSA8H2CNhcJvpOaXAthJD/wm8DBa+res/ttm4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200429205825.10604-6-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org> <20200429205825.10604-6-robh@kernel.org>
Subject: Re: [PATCH v2 05/16] clk: versatile: Only enable SP810 on 32-bit by default
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
Date:   Mon, 04 May 2020 23:20:51 -0700
Message-ID: <158865965153.24786.2443315306749414618@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rob Herring (2020-04-29 13:58:14)
> While 64-bit Arm reference platforms have SP810 for clocks for SP804
> timers, they are not needed since the arch timers are used instead.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
