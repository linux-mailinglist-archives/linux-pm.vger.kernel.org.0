Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0BCAD17C3
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 20:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfJISvU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 14:51:20 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51734 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729535AbfJISvU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2019 14:51:20 -0400
Received: (qmail 6328 invoked by uid 2102); 9 Oct 2019 14:51:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Oct 2019 14:51:19 -0400
Date:   Wed, 9 Oct 2019 14:51:19 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Tony Lindgren <tony@atomide.com>
cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM / runtime: Add support for wake-up reason for wakeirqs
In-Reply-To: <20191009182803.63742-1-tony@atomide.com>
Message-ID: <Pine.LNX.4.44L0.1910091447510.1603-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 9 Oct 2019, Tony Lindgren wrote:

> With generic wakeirqs we can wake a device, but do not know if the
> device woke to a wakeirq. Let's add pm_runtime_wakeup_is_wakeirq() so
> a device can check the wake-up reason.

People have tried many times over the years to do something like this.  
It's never right.

The problem is simple: It's impossible to know for certain why the
system woke up from suspend.  In fact, there may be many wakeup sources
all active at the same time, and any of them could be the one
responsible for actually waking the system.

All you can do is check to see whether a particular wakeup source is
active at the present moment.  You can't tell whether it was active in
the past (while the system was suspended) or whether it caused the
system to resume.

Alan Stern

