Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0424F249BC
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 10:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfEUIGh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 04:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfEUIGh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 May 2019 04:06:37 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE0E02173C;
        Tue, 21 May 2019 08:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558425996;
        bh=MQ3McYQXBfnnitV5UugimIm9+g/BgiQEMZ2KBhgW8k4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rtjVCR1QXT45KERGeG+d2YG5BbJgTSTUpxDwHUPhnNHdAjoi7Nc0/Ez18NF+f2riA
         96qPsj4+Sacz1uw8zytBRs2JY+y52BmZkyajF77/uffgxEQf0+I/4yYPhrk/SECY4Z
         D2UVmIStfK5UzXgmyMRUmpiaF8ve5nBeZFpsm5Zo=
Date:   Tue, 21 May 2019 16:05:36 +0800
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
Subject: Re: [PATCH v4 5/5] arm64: defconfig: ARM_IMX_CPUFREQ_DT=m
Message-ID: <20190521080535.GA15856@dragon>
References: <cover.1557742902.git.leonard.crestez@nxp.com>
 <675eb0dd54855126ea6f70804c84372d386878bb.1557742902.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675eb0dd54855126ea6f70804c84372d386878bb.1557742902.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 11:01:44AM +0000, Leonard Crestez wrote:
> For imx8m we need a separate small driver to read "speed grading"
> information from fuses and determine which OPPs are supported.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
