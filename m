Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C274712CB32
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2019 23:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfL2Wps (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Dec 2019 17:45:48 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60152 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfL2Wps (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Dec 2019 17:45:48 -0500
Received: from 79.184.253.116.ipv4.supernova.orange.pl (79.184.253.116) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 81928a0b399995ab; Sun, 29 Dec 2019 23:45:46 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Niklas Cassel <nks@flawful.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/5] qcom-cpr fixes for rjw bleeding-edge
Date:   Sun, 29 Dec 2019 23:45:46 +0100
Message-ID: <3833311.45NX9LJ36M@kreacher>
In-Reply-To: <20191223141934.19837-1-nks@flawful.org>
References: <20191223141934.19837-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, December 23, 2019 3:19:29 PM CET Niklas Cassel wrote:
> Hello Rafael,
> 
> Here comes some bug fixes for qcom-cpr that were detected
> once the driver got some more build testing.
> 
> Patches 1-2 fix warnings detected by the intel test robot.
> 
> Patch 3 fixes an error I detected when doing an allnoconfig
> and enabling simply the qcom-cpr driver.
> 
> Patches 4-5 are only detected when building with W=1.
> However, I decided to fix these as well, in order to hopefully
> avoid any further build test reports.
> 
> The series is based on your bleeding-edge branch.
> Feel free to squash them with the existing commit if you
> so desire.
> 
> Niklas Cassel (5):
>   power: avs: qcom-cpr: fix invalid printk specifier in debug print
>   power: avs: qcom-cpr: fix unsigned expression compared with zero
>   power: avs: qcom-cpr: make sure that regmap is available
>   power: avs: qcom-cpr: remove set but unused variable
>   power: avs: qcom-cpr: make cpr_get_opp_hz_for_req() static
> 
>  drivers/power/avs/Kconfig    |  1 +
>  drivers/power/avs/qcom-cpr.c | 18 ++++++++++--------
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> 

All patches in the series applied as 5.6 material, thanks!




