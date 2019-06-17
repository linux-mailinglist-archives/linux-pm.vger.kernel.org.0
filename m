Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7142049576
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 00:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfFQWwj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 18:52:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49515 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfFQWwj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 18:52:39 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 8f85b65f7d4e573e; Tue, 18 Jun 2019 00:52:37 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/5] PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
Date:   Tue, 18 Jun 2019 00:52:36 +0200
Message-ID: <1577870.9p1GPmOpaG@kreacher>
In-Reply-To: <c263629a53dba33f9e7190b82172a88cc79654d1.1560163748.git.viresh.kumar@linaro.org>
References: <cover.1560163748.git.viresh.kumar@linaro.org> <c263629a53dba33f9e7190b82172a88cc79654d1.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, June 10, 2019 12:51:32 PM CEST Viresh Kumar wrote:
> In order to use the same set of routines to register notifiers for
> different request types, update the existing
> dev_pm_qos_{add|remove}_notifier() routines with an additional
> parameter: request-type.
> 
> For now, it only supports resume-latency request type.

It would be good to mention the broader rationale of this change in its changelog
(that is, the frequency limits use case).



