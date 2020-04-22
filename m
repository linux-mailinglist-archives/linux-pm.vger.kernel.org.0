Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B381B3BC3
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 11:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDVJv4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 05:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgDVJv4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 05:51:56 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE2312073A;
        Wed, 22 Apr 2020 09:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549115;
        bh=o2n43kaLkZk8Yc3c5jw7xR0qABHEQs6JMUkUxQReAVM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SEusCKdNvAthriMYUMGBLbl+Npwh4x+yKKFsGZ+ZiCntRRFZE19TKIoA9b6fvJ5WK
         uxEuviBo94uJ7xv4ZyPWFnKDIyumUD0J9m15t2eufbrPkr3tIviPfgkhCD6l10hkw5
         wnnNR3eLnoOhe0CRRpu0McpMoGUooLe0GPAOvZP0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200419170810.5738-8-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-8-robh@kernel.org>
Subject: Re: [PATCH 07/17] clk: vexpress-osc: Use the devres clock API variants
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
Date:   Wed, 22 Apr 2020 02:51:54 -0700
Message-ID: <158754911497.132238.14935003164917739527@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rob Herring (2020-04-19 10:08:00)
> In preparation to enable the vexpress-osc clock driver as a module,
> convert the driver to use the managed devres clock API variants. With
> this, a driver .remove() hook is not needed.
>=20
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
