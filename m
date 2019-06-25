Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4750B55BDA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 01:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfFYXCW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 19:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFYXCW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 19:02:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C772084B;
        Tue, 25 Jun 2019 23:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561503741;
        bh=82RyR5pFqn05vyyNq4lzd/5m52MIeTMNFiRkCRUTQV0=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=VxhOM3T0rDZQLYc6U+By4eyc5T1Fg6CRnnOjooSqYTLKhmT0WzIfRkbcCbpHuNkUd
         SfdZrjYkzhyLLpm9MxCLhuxO6J1ugyIMAFleGIH7ckoKy9+stTLZIYRJk83AxLdGaZ
         xithUTuimVB8qjTsllcRV1+jXFeDlIjceJxL68DU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d8b20179-45ef-479a-47dc-390a4a2dfddf@i2se.com>
References: <20190612182500.4097-1-nsaenzjulienne@suse.de> <6a9e1450-80ad-a13c-59d2-d0b39f25f67e@gmail.com> <7acfd967-0a82-5429-4eed-8b802e6620f5@i2se.com> <d8b20179-45ef-479a-47dc-390a4a2dfddf@i2se.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 0/7] cpufreq support for Raspberry Pi
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, mbrugger@suse.de,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 16:02:20 -0700
Message-Id: <20190625230221.A1C772084B@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Stefan Wahren (2019-06-22 02:54:47)
> Hi Stephen,
> hi Mike,
>=20
> Am 13.06.19 um 06:31 schrieb Stefan Wahren:
> > Hi Florian,
> > hi Stephen,
> >
> > Am 13.06.19 um 05:31 schrieb Florian Fainelli:
> >> On 6/12/2019 11:24 AM, Nicolas Saenz Julienne wrote:
> >>> Hi all,
> >>> this aims at adding cpufreq support to the Raspberry Pi family of
> >>> boards.
> >>>
> >>> The series first factors out 'pllb' from clk-bcm2385 and creates a new
> >>> clk driver that operates it over RPi's firmware interface[1]. We are
> >>> forced to do so as the firmware 'owns' the pll and we're not allowed =
to
> >>> change through the register interface directly as we might race with =
the
> >>> over-temperature and under-voltage protections provided by the firmwa=
re.
> >>>
> >>> Next it creates a minimal cpufreq driver that populates the CPU's opp
> >>> table, and registers cpufreq-dt. Which is needed as the firmware
> >>> controls the max and min frequencies available.
> >>>
> >>> This was tested on a RPi3b+ and RPI2b, both using multi_v7_defconfig =
and
> >>> arm64's defconfig.
> >> How do we go about merging this? Stefan, will you pick up patch 3, 6 a=
nd
> >> 7 and submit them for 5.3/5.4? Viresh has already picked up patch 4.
> > is it possible to let patches 1,2, 3 and 5 go via clk-tree?
> >
> > I would take care of 6 and 7.
> >
> > Stefan
> are you fine with the series, since Viresh already picked up patch 4?
>=20
> are you okay with my suggestion above?
>=20

Oh I missed this. I can apply the clk patches most likely assuming it
doesn't break anything bisection-wise.

