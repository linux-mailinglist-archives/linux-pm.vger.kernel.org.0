Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9386F114FFD
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 12:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfLFLrI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 06:47:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53747 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfLFLrI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 06:47:08 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1idC4d-0003mO-0b; Fri, 06 Dec 2019 12:47:03 +0100
Message-ID: <27b7642917479f9c17af30054abe1a72d0b121f7.camel@pengutronix.de>
Subject: Re: [PATCH v7 00/12] QorIQ TMU multi-sensor and HWMON support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 06 Dec 2019 12:46:59 +0100
In-Reply-To: <20190912012920.29601-1-andrew.smirnov@gmail.com>
References: <20190912012920.29601-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

can this series be considered for mainline inclusion? It has been
tested and works well in our i.MX8M kernel setup.

Regards,
Lucas

On Mi, 2019-09-11 at 18:29 -0700, Andrey Smirnov wrote:
> Everyone:
> 
> This series contains patches adding support for HWMON integration, bug
> fixes and general improvements (hopefully) for TMU driver I made while
> working on it on i.MX8MQ.
> 
> Feedback is welcome!
> 
> Thanks,
> Andrey Smirnov
> 
> Changes since [v6]:
> 
>    - Rebased on top of Zhang's "next" branch
> 
>    - Added "thermal: qoriq: Drop unnecessary drvdata cleanup"
> 
> Changes since [v5]
> 
>     - Rebased on recent linux-next, dropped "thermal: qoriq: Remove
>       unnecessary DT node is NULL check" since it is already in the
>       tree
> 
>     - Dropped dependency on [rfc]
> 
> Changes since [v4]
> 
>     - Collected Tested-by from Lucas
>     
>     - Collected Reviewed-by from Daniel
> 
>     - Converted "thermal: qoriq: Enable all sensors before registering
>       them" to use if instead of switch statement for error checking
> 
> Changes since [v3]
> 
>     - Series reabse on top of [rfc]
>     
>     - Fixed incorrect goto label in "thermal: qoriq: Pass data to
>       qoriq_tmu_calibration()"
>       
>     - Added REGS_TRITSR() register description to "thermal: qoriq: Do
>       not report invalid temperature reading"
>       
>     - Reworded commit message of "thermal: qoriq: Remove unnecessary
>       DT node is NULL check"
> 
> Changes since [v2]
> 
>     - Patches rebased on v5.1-rc1
> 
> Changes since [v1]
> 
>     - Rebased on "linus" branch of
>       git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
>       that included latest chagnes adding multi-sensors support
> 
>     - Dropped
> 
> 	thermal: qoriq: Add support for multiple thremal sites
> 	thermal: qoriq: Be more strict when parsing
> 	thermal: qoriq: Simplify error handling in qoriq_tmu_get_sensor_id()
> 
>       since they are no longer relevant
> 
>     - Added
> 
> 	thermal: qoriq: Don't store struct thermal_zone_device reference
> 	thermal: qoriq: Add local struct qoriq_sensor pointer
> 	thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
> 	thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
> 
>       to simplify latest codebase
> 
>     - Changed "thermal: qoriq: Do not report invalid temperature
>       reading" to use regmap_read_poll_timeout() to make sure that
>       tmu_get_temp() waits for fist sample to be ready before
>       reporting it. This case is triggered on my setup if
>       qoriq_thermal is compiled as a module
> 
> [v1] lore.kernel.org/lkml/20190218191141.3729-1-andrew.smirnov@gmail.com
> [v2] lore.kernel.org/lkml/20190222200508.26325-1-andrew.smirnov@gmail.com
> [v3] lore.kernel.org/lkml/20190401041418.5999-1-andrew.smirnov@gmail.com
> [v4] lore.kernel.org/lkml/20190413082748.29990-1-andrew.smirnov@gmail.com
> [v5] lore.kernel.org/lkml/20190424064830.18179-1-andrew.smirnov@gmail.com
> [v6] lore.kernel.org/lkml/20190821012612.7823-1-andrew.smirnov@gmail.com
> [rfc] lore.kernel.org/lkml/20190404080647.8173-1-daniel.lezcano@linaro.org
> 
> Andrey Smirnov (12):
>   thermal: qoriq: Add local struct device pointer
>   thermal: qoriq: Don't store struct thermal_zone_device reference
>   thermal: qoriq: Add local struct qoriq_sensor pointer
>   thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
>   thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
>   thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
>   thermal: qoriq: Drop unnecessary drvdata cleanup
>   thermal: qoriq: Convert driver to use regmap API
>   thermal: qoriq: Enable all sensors before registering them
>   thermal: qoriq: Do not report invalid temperature reading
>   thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
>   thermal: qoriq: Add hwmon support
> 
>  drivers/thermal/qoriq_thermal.c | 252 +++++++++++++++++---------------
>  drivers/thermal/thermal_hwmon.c |  28 ++++
>  drivers/thermal/thermal_hwmon.h |   7 +
>  3 files changed, 167 insertions(+), 120 deletions(-)
> 

