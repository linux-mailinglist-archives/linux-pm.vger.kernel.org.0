Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 313ABF3FF
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 12:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfD3KOb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 06:14:31 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49021 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfD3KOa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 06:14:30 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 6ab32b2407bcd582; Tue, 30 Apr 2019 12:14:28 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [GIT PULL] cpufreq/arm changes for 5.2
Date:   Tue, 30 Apr 2019 12:14:28 +0200
Message-ID: <1633557.MMVXyUi1AQ@kreacher>
In-Reply-To: <20190429100613.xuqm3mdxzrc2np6o@vireshk-i7>
References: <20190429100613.xuqm3mdxzrc2np6o@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, April 29, 2019 12:06:13 PM CEST Viresh Kumar wrote:
> Hi Rafael,
> 
> This pull request contains:
> 
> - Fix for possible object reference leak for few drivers (Wen Yang).
> - Fix for armada frequency calculation (Gregory).
> - Code cleanup in maple driver (Viresh).
> 
> This contains some non-ARM bits as well this time as the patches were
> picked up from a series.
> 
> --
> viresh
> 
> -------------------------8<-------------------------
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
> 
> for you to fetch changes up to 8db82563451f976597ab7b282ec655e4390a4088:
> 
>   cpufreq: armada-37xx: fix frequency calculation for opp (2019-04-29 15:22:50 +0530)

Pulled, thanks!



