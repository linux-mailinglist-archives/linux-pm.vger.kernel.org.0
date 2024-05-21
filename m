Return-Path: <linux-pm+bounces-8019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C3E8CAB4D
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 11:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A169E1F218B8
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 09:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0D76A8D2;
	Tue, 21 May 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="UUfABhN3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB9A6BB20;
	Tue, 21 May 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285260; cv=none; b=qIRvMEBfsGIAnkFhLnkPnqNNduxB+RT+MvF2VaUAbGZ7HBUhUjQzdVFhLXfnvL+vuwEnjzeG+yDL38kTVghUkqH1H+Gp07ILAMsMx/fPnDsSlOzSm6TKTJR3qqEtPsYFOExBPjQB/qK2SvJ4ECQwsl/Mo4Sy41ZdsyYRrOlv2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285260; c=relaxed/simple;
	bh=kIBK/TXl0EdrSBki4Xtx0zg3YhBsx/YlEAh607eYTTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwPhaYRnvk4hoKX7lir/dQcFmY0KxWHNEBCLA9Gws0ZeZELktr6hkkc+xK5fq0Qt8pQHfjgyZBgKqF/luSpi1Wyd0e0kJ8TCG0EAZkNBdmFuky5VLJ1q+3B6GXn+Ph9KOwhb1mzQhsg3SiZYR1MnJJbZujMK9hFzB5pGqGWovw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=UUfABhN3; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6E0CC206CE;
	Tue, 21 May 2024 11:54:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1716285248;
	bh=YrMaapKOCmWxZh7K2wOvL1ZSRLa5q+qreSWpLytaCas=; h=From:To:Subject;
	b=UUfABhN3Se2UKhxDPzbGrtxI32ZpyPyoyFZZA62pFnr53HioNzOA7RG8mUAnXACuY
	 gW2Ypyywpc07swpvIvUkGADqzcCmzanqwfI4JzTk+0toWJVp/S9TMQMlQfOqDZ19aL
	 zaoGH0jaBqHpLQESBW+w+wT7pzj69sAGISSSRceIrgBOWwjecAE1W9ha+fqgqKx1SS
	 WpozmnlCGyGD5V8Ofn2tvqsQLdeuemI9qR6aJjgdT8oHc5zE1IrfhRjSBavMTOj703
	 NdyMCoWPHOJlIbej8I4Q1HkmKSIdJL1QIHS7gHJZVRSGq3jeiyM8Y/QO3XmUHZcPPS
	 Nujkt7Hynhx1g==
Date: Tue, 21 May 2024 11:54:02 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Shengjiu Wang <shengjiu.wang@nxp.com>, regressions@lists.linux.dev,
	Stephen Boyd <sboyd@kernel.org>, ulf.hansson@linaro.org
Cc: ulf.hansson@linaro.org, heiko@sntech.de, u.kleine-koenig@pengutronix.de,
	geert+renesas@glider.be, rafael@kernel.org,
	linux-pm@vger.kernel.org, abelvesa@kernel.org, peng.fan@nxp.com,
	mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, shengjiu.wang@gmail.com, frank.li@nxp.com,
	mkl@pengutronix.de, linus.walleij@linaro.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pmdomain: imx: gpcv2: Add delay after power up
 handshake
Message-ID: <20240521095402.GA11937@francesco-nb>
References: <1715396125-3724-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715396125-3724-1-git-send-email-shengjiu.wang@nxp.com>

Hello Stephen and Ulf, 

On Sat, May 11, 2024 at 10:55:25AM +0800, Shengjiu Wang wrote:
> AudioMix BLK-CTRL on i.MX8MP encountered an accessing register issue
> after power up.
> 
> [    2.181035] Kernel panic - not syncing: Asynchronous SError Interrupt
...

> Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for power saving")
> Reported-by: Francesco Dolcini <francesco@dolcini.it>

Any chances to get this into mainline with some priority?

If in your opinion the fix is not correct I can just send a revert of
the buggy commit.

I reported the bug 4 weeks ago, the same day the broken commit was
merged into -next [1], now we have a regression in mainline that is
preventing booting with a kernel panic and because of that our whole CI
is not able to test anything and therefore preventing us to look into
any other regression.

Thanks,
Francesco

[1] https://lore.kernel.org/all/20240424164725.GA18760@francesco-nb/

