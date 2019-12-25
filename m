Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3B412A853
	for <lists+linux-pm@lfdr.de>; Wed, 25 Dec 2019 15:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLYOVk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Dec 2019 09:21:40 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50355 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYOVk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Dec 2019 09:21:40 -0500
Received: from 79.184.254.137.ipv4.supernova.orange.pl (79.184.254.137) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 5c2b67294ee0de42; Wed, 25 Dec 2019 15:21:37 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.c>
Subject: Re: [GIT PULL] devfreq fixes for v5.5-rc4
Date:   Wed, 25 Dec 2019 15:21:37 +0100
Message-ID: <8461635.TD5OI2jaFZ@kreacher>
In-Reply-To: <3400e92c-80bd-b2ac-dba0-dfe61d26b1d0@samsung.com>
References: <CGME20191223053045epcas1p4bbe1dac8d04e2fbc8fa4a50d42177c2c@epcas1p4.samsung.com> <3400e92c-80bd-b2ac-dba0-dfe61d26b1d0@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, December 23, 2019 6:37:30 AM CET Chanwoo Choi wrote:
> Dear Rafael,
> 
> This is devfreq-fixes pull request for v5.5-rc4. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
> - tag name : devfreq-fixes-for-5.5-rc4
> 
> Actually, this pull request doesn't need to contain the patch[1]
> because patch[1] is not critical and urgent. But, build-fix patch[2]
> depends on patch[1]. So, this pull request contains two patches.
> If you think that it is not reasonable, please let me know.
> [1] PM / devfreq: Drop explicit selection of PM_OPP
> [2] PM / devfreq: tegra: Add COMMON_CLK dependency

Pulled, thanks!



