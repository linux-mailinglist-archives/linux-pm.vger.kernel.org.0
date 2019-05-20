Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B2C22CBB
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 09:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfETHPM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 03:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfETHPL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 May 2019 03:15:11 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 563A52081C;
        Mon, 20 May 2019 07:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558336511;
        bh=9Ws2DvYBg8/lRkMwUR/N+FNcmhvVHWsnSL7L2wc1H0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DMGZXzSweW9P9nn+k3NVg4QRhte4ublBQOGA/yf3I6zYyphGuasDy9bVTciFU/lgG
         yJKzzEgomkntyFOodMCbj+kOaVDOUo4GLuhKajN450YJBjkpE2dzXyfDHu1jIZf0FY
         EHHENrURaK6wpVxGlCdUtKl9lhFMi8Bs2XclVRBs=
Date:   Mon, 20 May 2019 15:14:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
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
Subject: Re: [PATCH v4 0/5] cpufreq: Add imx-cpufreq-dt driver for speed
 grading
Message-ID: <20190520071417.GU15856@dragon>
References: <cover.1557742902.git.leonard.crestez@nxp.com>
 <20190514071322.avosfk4fzz2hzzx6@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514071322.avosfk4fzz2hzzx6@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 14, 2019 at 12:43:22PM +0530, Viresh Kumar wrote:
> On 13-05-19, 11:01, Leonard Crestez wrote:
> > Right now in upstream imx8m cpufreq support just lists a common subset
> > of OPPs because the higher ones should only be attempted after checking
> > speed grading in fuses.
> > 
> > Driver reads from nvmem and calls dev_pm_opp_set_supported_hw before
> > registering cpufreq-dt.
> 
> Who will apply patches 3-5 ?

Me.  Will apply them after the first two get applied.

Shawn
