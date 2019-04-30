Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E860F404
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 12:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfD3KOx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 06:14:53 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45056 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfD3KOv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 06:14:51 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 5e98e61ad45a118d; Tue, 30 Apr 2019 12:14:49 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [GIT PULL] OPP changes for 5.2
Date:   Tue, 30 Apr 2019 12:14:49 +0200
Message-ID: <2686367.mYXtsBGFzs@kreacher>
In-Reply-To: <20190429100113.s5pwr6q6rsiebwie@vireshk-i7>
References: <20190429100113.s5pwr6q6rsiebwie@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, April 29, 2019 12:01:13 PM CEST Viresh Kumar wrote:
> Hi Rafael,
> 
> This pull request contains:
> 
> - New helper in OPP core to find best matching frequency for a voltage
>   value.
> 
> --
> viresh
> 
> -------------------------8<-------------------------
> 
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
> 
> for you to fetch changes up to 2f36bde0fc8f1ab79d54bd2caa7c1cf874fd2206:
> 
>   OPP: Introduce dev_pm_opp_find_freq_ceil_by_volt() (2019-04-10 12:13:31 +0530)

Pulled, thanks!



