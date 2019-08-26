Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA4D9CC79
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfHZJVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 05:21:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41622 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfHZJVN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 05:21:13 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id c30894ed6953de11; Mon, 26 Aug 2019 11:21:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>
Subject: Re: [PATCH v4 0/2] PM / wakeup: Fix wakeup class wrecakge in -next
Date:   Mon, 26 Aug 2019 11:21:11 +0200
Message-ID: <2610837.FtSX2PM0xo@kreacher>
In-Reply-To: <20190819224158.62954-1-swboyd@chromium.org>
References: <20190819224158.62954-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, August 20, 2019 12:41:56 AM CEST Stephen Boyd wrote:
> Resending the patch series to pick up the tags and fix the subject
> on patch #2. I didn't drop the "Fixes" tags even though they're
> just in -next and the patches have been dropped in the latest version.
> Please update them in the future so we know what commit they're fixing
> if the commits change in the pm tree.
> 
> Changes from v3:
>  * Picked up reviewed-by tags from Tri Vo
>  * Fixed Cc tag on patch 2
>  * Fixed subject on patch 2 to speak about proper symbols
> 
> Changes from v2:
>  * Fix logic for not adding the wakeup class from dpm_sysfs_add()
>  * Compile tested on !CONFIG_PM_SLEEP
> 
> Cc: Qian Cai <cai@lca.pw>
> Cc: Tri Vo <trong@android.com>
> 
> Stephen Boyd (2):
>   PM / wakeup: Register wakeup class kobj after device is added
>   PM / wakeup: Unexport wakeup_source_sysfs_{add,remove}()
> 
>  drivers/base/power/power.h        |  9 +++++++++
>  drivers/base/power/sysfs.c        |  6 ++++++
>  drivers/base/power/wakeup.c       | 10 ++++++----
>  drivers/base/power/wakeup_stats.c | 15 +++++++++++++--
>  4 files changed, 34 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 0c3d3d648b3ed72b920a89bc4fd125e9b7aa5f23
> 

Both patches applied, thanks!




