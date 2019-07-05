Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A323460423
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfGEKJ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 06:09:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42342 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfGEKJ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 06:09:29 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id d4b39f5ac838d316; Fri, 5 Jul 2019 12:09:26 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM: sleep: Drop dev_pm_skip_next_resume_phases()
Date:   Fri, 05 Jul 2019 12:09:26 +0200
Message-ID: <1670687.Ukx42KFMcm@kreacher>
In-Reply-To: <20190704080120.GH2640@lahna.fi.intel.com>
References: <2100414.Plmip0uhM5@kreacher> <20190704080120.GH2640@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, July 4, 2019 10:01:20 AM CEST Mika Westerberg wrote:
> On Thu, Jul 04, 2019 at 01:05:38AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > After recent hibernation-related changes, there are no more callers
> > of dev_pm_skip_next_resume_phases() except for the PM core itself
> > in which it is more straightforward to run the statements from
> > that function directly, so do that and drop it.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 

Thanks!

Patch queued for 5.3.




