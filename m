Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3EC1E92BD
	for <lists+linux-pm@lfdr.de>; Sat, 30 May 2020 19:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgE3RBc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 May 2020 13:01:32 -0400
Received: from mail.manjaro.org ([176.9.38.148]:52750 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbgE3RBc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 30 May 2020 13:01:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 467DF3B012A2;
        Sat, 30 May 2020 19:01:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U2dn1F2eBqpz; Sat, 30 May 2020 19:01:29 +0200 (CEST)
Subject: Re: [PATCH v1] power: supply: cw2015: Attach OF ID table to the
 driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>
References: <20200530164030.47884-1-andriy.shevchenko@linux.intel.com>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <6f53c126-c0e2-8869-26c0-c2ba1e8adbf1@manjaro.org>
Date:   Sat, 30 May 2020 19:00:47 +0200
MIME-Version: 1.0
In-Reply-To: <20200530164030.47884-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andy,

> diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
> index 19f62ea957ee..0146f1bfc29b 100644
> --- a/drivers/power/supply/cw2015_battery.c
> +++ b/drivers/power/supply/cw2015_battery.c
> @@ -734,6 +734,7 @@ MODULE_DEVICE_TABLE(of, cw2015_of_match);
>  static struct i2c_driver cw_bat_driver = {
>  	.driver = {
>  		.name = "cw2015",
> +		.of_match_table = cw2015_of_match,
>  		.pm = &cw_bat_pm_ops,
>  	},
>  	.probe_new = cw_bat_probe,
> 

LGTM.

Acked-By: Tobias Schramm <t.schramm@manjaro.org>
Tested-By: Tobias Schramm <t.schramm@manjaro.org>

Thanks,

Tobias
