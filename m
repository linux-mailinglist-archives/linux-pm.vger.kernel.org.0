Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABB820A11C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 16:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405439AbgFYOrE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 10:47:04 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38242 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405367AbgFYOrE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jun 2020 10:47:04 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C1011A04B0;
        Thu, 25 Jun 2020 16:47:01 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E8581A0489;
        Thu, 25 Jun 2020 16:47:01 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7943F205A3;
        Thu, 25 Jun 2020 16:47:01 +0200 (CEST)
Date:   Thu, 25 Jun 2020 17:47:01 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Leonard Crestez <cdleonard@gmail.com>, leonard.crestez@nxp.com,
        Anson.Huang@nxp.com, a.swigon@partner.samsung.com,
        abailon@baylibre.com, aisheng.dong@nxp.com, angus@akkea.ca,
        cw00.choi@samsung.com, devicetree@vger.kernel.org,
        fabio.estevam@nxp.com, georgi.djakov@linaro.org,
        kernel@pengutronix.de, krzk@kernel.org, kyungmin.park@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-pm@vger.kernel.org, mark.rutland@arm.com,
        martink@posteo.de, mka@chromium.org, mturquette@baylibre.com,
        myungjoo.ham@samsung.com, ping.bai@nxp.com, rjw@rjwysocki.net,
        robh@kernel.org, saravanak@google.com, sboyd@kernel.org,
        shawnguo@kernel.org, viresh.kumar@linaro.org
Subject: Re: [PATCH v4 0/6] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
Message-ID: <20200625144701.6xa7sdlm5llr5z3p@fsr-ub1664-175>
References: <cover.1573252696.git.leonard.crestez@nxp.com>
 <20200622135858.15891-1-martin.kepplinger@puri.sm>
 <e8440abf-e51f-9846-f2af-a1a44a7fd89a@gmail.com>
 <b0f712d0-ea83-f073-f987-7bb33150f25d@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f712d0-ea83-f073-f987-7bb33150f25d@puri.sm>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-06-25 08:57:52, Martin Kepplinger wrote:
> hi Leonard,
> 
> On 24.06.20 08:08, Leonard Crestez wrote:
> > On 6/22/20 4:58 PM, Martin Kepplinger wrote:
> >> hi Leondard,
> >>
> >> before using this patchset I'd like to ask: Do you have plans to create
> >> an update and push this forward? It is useful.
> > 
> > Hello.
> > 
> > I am no longer with NXP and don't have access to imx hardware right now.
> 
> I guess it'll get even harder to get the ATF part for devfreq
> implemented now :) Thanks for the update and all the best for your new
> stuff.
> 
> > 
> > However the series that you replied to is very old and was accepted many
> > months ago. You shouldn't have to apply out-of-tree kernel patches.
> > 
> 
> that particular series doesn't seem to be in mainline, see
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Fdrivers%2Fdevfreq%2Fimx8m-ddrc.c%23L283&amp;data=02%7C01%7Cabel.vesa%40nxp.com%7Cb00f437e756d4850238f08d818d51b59%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637286650857331523&amp;sdata=S7%2BN3%2BiTFkUW5YnmVzl36wEBlr%2BkTatGoDDrvY9XfTk%3D&amp;reserved=0
> or do I miss something?
> 
> do you know who at nxp would be likely actively working on devfreq?

Hi Martin,

I will be working on this in the following weeks.

> 
> thanks,
>                            martin
