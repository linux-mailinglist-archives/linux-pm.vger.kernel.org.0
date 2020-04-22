Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741FF1B3BB6
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 11:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDVJsR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 05:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgDVJsR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 05:48:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C6F2071E;
        Wed, 22 Apr 2020 09:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587548897;
        bh=h8tZAV1eis5614o2tQVbfI2ZmvcSpgzNnKdTVSCh42I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mM+dNvvLtV8uOjdbcDTZ3krIOs8MmSM92wH9Yo0CXQ6WeULLFikAmN7EAHkzrGEpi
         l5SFs9zwzCrNMwYmkvhd/vgpCSBJuD1Y+Fiw+DbKL0X5cNvG9MlaZfd5q1ZWKhRasO
         l1UthmmBaS3QIv/hiFETHYFQNS+taGz8sFZ2IVjk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200419170810.5738-7-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-7-robh@kernel.org>
Subject: Re: [PATCH 06/17] clk: versatile: Only enable SP810 on 32-bit by default
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Date:   Wed, 22 Apr 2020 02:48:16 -0700
Message-ID: <158754889667.132238.6344706569385433482@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rob Herring (2020-04-19 10:07:59)
> While 64-bit Arm reference platforms have SP810 for clocks for SP804
> timers, they are not needed since the arch timers are used instead.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
