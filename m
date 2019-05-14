Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 801521D15C
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 23:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfENVfl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 17:35:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49805 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENVfl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2019 17:35:41 -0400
Received: from 79.184.255.148.ipv4.supernova.orange.pl (79.184.255.148) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id ed89e576564268c9; Tue, 14 May 2019 23:35:39 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 0/2] Allow imx6qp PU domain off in suspend
Date:   Tue, 14 May 2019 23:35:38 +0200
Message-ID: <2135871.ArgiegidzK@kreacher>
In-Reply-To: <cover.1556636234.git.leonard.crestez@nxp.com>
References: <cover.1556636234.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, April 30, 2019 5:06:10 PM CEST Leonard Crestez wrote:
> On imx6qp power gating on the PU domain is disabled because of errata
> ERR009619. However power gating during suspend/resume can still be
> performed.
> 
> Changes since V4:
>  * Rename GENPD_FLAG_NO_RUNTIME_OFF to GENPD_FLAG_RPM_ALWAYS_ON
> Link to v4: https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=110829
> 
> Implemented with a new core flag because otherwise distinguishing
> between "runtime off" and "suspend off" is very complicated. Link to
> previous much older attempts:
> 
> v3: https://lkml.org/lkml/2018/7/6/698
> v2: https://lkml.org/lkml/2018/7/5/564
> v1: https://lkml.org/lkml/2018/7/2/357
> 
> Leonard Crestez (2):
>   PM / Domains: Add GENPD_FLAG_RPM_ALWAYS_ON flag
>   soc: imx: gpc: Use GENPD_FLAG_RPM_ALWAYS_ON for ERR009619
> 
>  drivers/base/power/domain.c |  8 ++++++--
>  drivers/soc/imx/gpc.c       | 13 +++++++++++--
>  include/linux/pm_domain.h   |  4 ++++
>  3 files changed, 21 insertions(+), 4 deletions(-)
> 
> -- 

Both patches applied, thanks!



