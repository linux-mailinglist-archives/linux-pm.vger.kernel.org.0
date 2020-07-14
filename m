Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E798121F2F9
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 15:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgGNNt3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 09:49:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:60865 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgGNNt3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jul 2020 09:49:29 -0400
IronPort-SDR: e8y0HAM5Uj+juHzdfj6rBlh2bFEfS0rcc/0K8y3OmDIGsz0vITkpRZ9vE5qKWJ07WDlrT6MSuj
 22OOvkxWd+ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="128973638"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="128973638"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 06:49:28 -0700
IronPort-SDR: wJKIcLXRAfpXMko3n/XfrY2Ex03pnRJCi39OQTEPwK79/gcYLi39SVBT2i2wbuIpg8bf5kkHNS
 vN6olsUy2JLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="459695277"
Received: from unknown (HELO xiongga1-MOBL2.ccr.corp.intel.com) ([10.255.31.222])
  by orsmga005.jf.intel.com with ESMTP; 14 Jul 2020 06:49:26 -0700
Message-ID: <b25d54d35cec777f0dcc5b2bcacce27321d9bd45.camel@intel.com>
Subject: Re: [RFC PATCH 0/4] thermal: Introduce support for monitoring
 falling temperature
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2020 21:49:25 +0800
In-Reply-To: <7437ee89-e76d-0c82-9860-5c6076ad8a30@linaro.org>
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
         <7437ee89-e76d-0c82-9860-5c6076ad8a30@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-07-13 at 17:03 +0200, Daniel Lezcano wrote:
> On 10/07/2020 15:51, Thara Gopinath wrote:
> > Thermal framework today supports monitoring for rising temperatures
> > and
> > subsequently initiating cooling action in case of a thermal trip
> > point
> > being crossed. There are scenarios where a SoC need some warming
> > action to
> > be activated if the temperature falls below a cetain permissible
> > limit.
> > Since warming action can be considered mirror opposite of cooling
> > action,
> > most of the thermal framework can be re-used to achieve this.
> > 
> > This patch series is yet another attempt to add support for
> > monitoring
> > falling temperature in thermal framework. Unlike the first
> > attempt[1]
> > (where a new property was added to thermal trip point binding to
> > indicate
> > direction of temperature monitoring), this series introduces a new
> > trip
> > point type (THERMAL_TRIP_COLD) to indicate a trip point at which
> > falling
> > temperature monitoring must be triggered. This patch series uses
> > Daniel
> > Lezcano's recently added thermal genetlink interface[2] to notify
> > userspace
> > of falling temperature and rising temperature at the cold trip
> > point. This
> > will enable a user space engine to trigger the relevant mitigation
> > for
> > falling temperature. At present, no support is added to any of the
> > thermal
> > governors to monitor and mitigate falling temperature at the cold
> > trip
> > point;rather all governors return doing nothing if triggered for a
> > cold
> > trip point. As future extension, monitoring of falling temperature
> > can be
> > added to the relevant thermal governor. 
> 
> I agree we need a cold trip point in order to introduce the
> functioning
> temperature range in the thermal framework.
> 
> Rui, what is your opinion ?

I agree with the concept of "cold" trip point.
In this patch set, the cold trip point is defined with only netlink
event support. But there are still quite a lot of things unclear,
especially what we should do in thermal framework?

For example, to support this, we can
either
introduce both "cold" trip points and "warming devices", and introduce
new logic in thermal framework and governors to handle them,
Or
introduce "cold" trip point and "warming" device, but only
semantically, and treat them just like normal trip points and cooling
devices. And strictly define cooling state 0 as the state that
generates most heat, and define max cooling state as the state that
generates least heat. Then, say, we have a trip point at -10C, the
"warming" device is set to cooling state 0 when the temperature is
lower than -10C, and in most cases, this thermal zone is always in a
"overheating" state (temperature higher than -10C), and the "warming"
device for this thermal zone is "throttled" to generate as least heat
as possible. And this is pretty much what the current code has always
been doing, right?

I can not say which one is better for now as I don't have the
background of this requirement. It's nice that Thara sent this RFC
series for discussion, but from upstream point of view, I'd prefer to
see a full stack solution, before taking any code.

thanks,
Rui

