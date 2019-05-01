Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27551106F6
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 12:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfEAKZt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 06:25:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53262 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfEAKZt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 06:25:49 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id ec27d28de3b4c5a9; Wed, 1 May 2019 12:25:46 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] PM / Domains: Improve support for multi PM domains
Date:   Wed, 01 May 2019 12:25:46 +0200
Message-ID: <2833844.V0R6nlsLIU@kreacher>
In-Reply-To: <20190418102757.1246-1-ulf.hansson@linaro.org>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, April 18, 2019 12:27:54 PM CEST Ulf Hansson wrote:
> It's been a while since the introduction for the support for multi PM domains
> per device in genpd. In this small series, a couple of different improvement
> are being made to this code in genpd.
> 
> Ulf Hansson (3):
>   PM / Domains: Don't kfree() the virtual device in the error path
>   PM / Domains: Allow OF lookup for multi PM domain case from
>     ->attach_dev()
>   PM / Domains: Enable genpd_dev_pm_attach_by_id|name() for single PM
>     domain
> 
>  drivers/base/power/domain.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

All [1-3/3] applied, thanks!



