Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B1C249A5
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 10:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfEUICK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 04:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfEUICK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 May 2019 04:02:10 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71CBB2173C;
        Tue, 21 May 2019 08:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558425729;
        bh=Fkgm5gp6YL8e+SsgbGZ1KjWAN+q7Ce/D2Uq309+p9Tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sp7G/N3VCOIr9NUSEIxER+8KMkKJMpl44SSWZ0Na1JPVSCJ6K/MVKS7aZc8Q2iO6r
         4cBfraJt+JpOlGt40uybnIHaXKTsKxO5odavSWpqS63wtaws+7MfBgjIOZ21YqN+Fp
         21LosXVlVnyMetR3HZ2rViCVUqJe+3/+KYn+UJsU=
Date:   Tue, 21 May 2019 16:01:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] arm64: dts: imx8mm: Add cpu speed grading and all
 OPPs
Message-ID: <20190521080113.GY15856@dragon>
References: <cover.1557742902.git.leonard.crestez@nxp.com>
 <0c7b08ee090ef1a91dc4d1072482b1ff0d4665fb.1557742902.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c7b08ee090ef1a91dc4d1072482b1ff0d4665fb.1557742902.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 11:01:41AM +0000, Leonard Crestez wrote:
> Add a nvmem cell on cpu node referencing speed grade and the 1.8 Ghz
> cpufreq opp.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks.
