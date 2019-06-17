Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA96495BB
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 01:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFQXOS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 19:14:18 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64487 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfFQXOS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 19:14:18 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id a2a8451e21f77331; Tue, 18 Jun 2019 01:14:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/5] PM / QOS: Pass request type to dev_pm_qos_read_value()
Date:   Tue, 18 Jun 2019 01:14:15 +0200
Message-ID: <6646229.IQO0cWAbFE@kreacher>
In-Reply-To: <b414d788faf4c6f87d01086248db4d2e86635180.1560163748.git.viresh.kumar@linaro.org>
References: <cover.1560163748.git.viresh.kumar@linaro.org> <b414d788faf4c6f87d01086248db4d2e86635180.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, June 10, 2019 12:51:33 PM CEST Viresh Kumar wrote:
> In order to use dev_pm_qos_read_value(), and other internal routines to
> it, to read values for different QoS requests, pass request type as a
> parameter to these routines.
> 
> For now, it only supports resume-latency request type.

I don't quite like the structure by which the type arg is passed through the
entire call chain until the switch in dep_pm_qos_raw_read_value().

There is only one direct user of dev_pm_qos_raw_read_value() AFAICS which
is cpuidle. It shouldn't need to suffer the general case overhead, so I would
rename that function to dev_pm_qos_raw_resume_latency() and update cpuidle
accordingly.

Moreover, the callers of __dev_pm_qos_read_value() are interested in the
resume latency value too, so it might make sense to rename this as
__dev_pm_qos_resume_latency(), update its callers and put the switch
into dev_pm_qos_read_value().

Plus the changelog should explain the broader rationale of this change like
for the first patch IMO.



