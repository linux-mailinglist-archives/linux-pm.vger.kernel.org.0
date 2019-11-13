Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F64FAF2A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 11:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfKMK76 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 05:59:58 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44367 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMK75 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 05:59:57 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 3c02a0ddd3e176c3; Wed, 13 Nov 2019 11:59:55 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [GIT PULL] OPP changes for 5.5
Date:   Wed, 13 Nov 2019 11:59:55 +0100
Message-ID: <2219222.RYzvWG7SvK@kreacher>
In-Reply-To: <20191111050246.b7vcuhtp25354r2x@vireshk-i7>
References: <20191111050246.b7vcuhtp25354r2x@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, November 11, 2019 6:02:46 AM CET Viresh Kumar wrote:
> Hi Rafael,
> 
> This pull request contains a single patch to allow modification of the
> OPP voltages at run time.
> 
> --
> viresh
> 
> -------------------------8<-------------------------
> The following changes since commit b19c23551be8de0d4e59fe6af70f10763e3cc595:
> 
>   opp: Reinitialize the list_kref before adding the static OPPs again (2019-10-23 10:58:44 +0530)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
> 
> for you to fetch changes up to 25cb20a212a1f989385dfe23230817e69c62bee5:
> 
>   PM / OPP: Support adjusting OPP voltages at runtime (2019-11-11 10:27:15 +0530)
> 
> ----------------------------------------------------------------
> Stephen Boyd (1):
>       PM / OPP: Support adjusting OPP voltages at runtime
> 
>  drivers/opp/core.c     | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h | 13 ++++++++++
>  2 files changed, 82 insertions(+)
> 
> 

Pulled, thanks!



