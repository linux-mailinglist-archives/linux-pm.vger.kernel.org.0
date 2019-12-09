Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E29F1164BB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 02:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLIBQd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Dec 2019 20:16:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbfLIBQd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 8 Dec 2019 20:16:33 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96EF9206DB;
        Mon,  9 Dec 2019 01:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575854192;
        bh=YDwWdATh/SoQPRkS4uTPJ3LnkmG0F6FSkZtyg52ylVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vzbexnPzjIjEtB4qvYgPtBDaALZV7N8FgYqF/kxaygBRnSa8WHU8QWlnbkgxx8vlG
         FxsWK4mYlY/IxiLatWvp8j82bpXEsaP+eW1sO+gnRTTY1nrN10/GgpEFaUdN+WzcYH
         Y5p7rDZMfPz8ErRGHdUblPKM8cDrolBwDpjlOy0I=
Date:   Mon, 9 Dec 2019 09:16:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/5] clk: imx: Mark dram pll on 8mm and 8mn with
 CLK_GET_RATE_NOCACHE
Message-ID: <20191209011614.GR3365@dragon>
References: <cover.1574458460.git.leonard.crestez@nxp.com>
 <9d986ef7a3cb379cea59616ad18e96e3245cbaba.1574458460.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d986ef7a3cb379cea59616ad18e96e3245cbaba.1574458460.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 22, 2019 at 11:45:01PM +0200, Leonard Crestez wrote:
> DRAM frequency switches are executed in firmware and can change the
> configuration of the DRAM PLL outside linux. Mark these CLKs with
> CLK_GET_RATE_NOCACHE so we always read back the PLL config registers and
> recalculate rates.
> 
> In current DRAM frequency tables on 8mm/8mn only the maximum frequency
> uses the PLL so it's always configured in the same way. However reading
> back the PLL configuration is the correct behavior and allows additional
> setpoints in the future.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks.
