Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F9C3183A0
	for <lists+linux-pm@lfdr.de>; Thu, 11 Feb 2021 03:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBKChi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 21:37:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhBKChd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 21:37:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A816E64DEC;
        Thu, 11 Feb 2021 02:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613011011;
        bh=8JFRYjQO064NzGbL2ItVEeVztIl7ENhK6ljAQvhKP7M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=S97nrwfbnVO/WCM4jYz8MyD61rlDHOlRAm/TExk+vQM+RMA7JQZHVjod3krMzScTu
         /9Z0tYuFI9kmI+7/S3G5d4HrUP4S4THdzn39VEISTE9uQVGHSqiVnduDr8grSeya84
         LF8D0uLPtVbSzxxN34Zkb/vjZNzQZRyoT75l2X4BXj6GdrcFMlnR8zm2yqI/N7nBPX
         5epViA1puwUNPik4KUL9ggZYSwW7KS8czf11uLy06jlUzFlqxS0DI/2O316vovVCBT
         1ciJPi8iXLbRnKutn+fCpHeN1D4+ShnGNwl5WOcxjgHat7FJIoUh3oU5Gppt3qK1Cb
         WjEMjwyzSFd0g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210114102643.16108-1-kostap@marvell.com>
References: <20210114102643.16108-1-kostap@marvell.com>
Subject: Re: [PATCH v2 0/2] Enable usage of Marvell FW SIP services
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org, mturquette@baylibre.com,
        miquel.raynal@bootlin.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, mw@semihalf.com,
        jaz@semihalf.com, nadavh@marvell.com, bpeled@marvell.com,
        stefanc@marvell.com, Konstantin Porotchkin <kostap@marvell.com>
To:     kostap@marvell.com, linux-clk@vger.kernel.org
Date:   Wed, 10 Feb 2021 18:36:50 -0800
Message-ID: <161301101043.1254594.9073888291006598011@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting kostap@marvell.com (2021-01-14 02:26:41)
> From: Konstantin Porotchkin <kostap@marvell.com>
>=20
> These patches enable usage of Arm Trusted Firmware SIP services on
> Marvell Armada plaforms for accessing system registers that are not
> normally accessible from kernel or user space (EL1/EL0), like DFX
> registers group.
>=20
> v2:
> * use separate legacy/smc regmap functions registered at ap-cpu
>   clock driver probe according to FW response

Please fix kbuild robot errors. Probably some Kconfig dependency is
needed?
