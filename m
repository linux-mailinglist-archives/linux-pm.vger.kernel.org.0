Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408B0193CC6
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 11:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgCZKPI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 06:15:08 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:61592 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgCZKPI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 06:15:08 -0400
Received: from xps-7390.lan (ip68-111-223-64.sd.sd.cox.net [68.111.223.64])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 48p17r6KsRz1V4G;
        Thu, 26 Mar 2020 06:15:04 -0400 (EDT)
Date:   Thu, 26 Mar 2020 03:15:03 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Zhang Rui <rui.zhang@intel.com>
cc:     linux-pm@lists.linux-foundation.org, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: Why do I sometimes "lose" the "psys" RAPL counter?
In-Reply-To: <alpine.DEB.2.21.2003260237130.26874@xps-7390>
Message-ID: <alpine.DEB.2.21.2003260311030.2844@xps-7390>
References: <alpine.DEB.2.21.2003252212220.2971@xps-7390>  <691eb7a6efd7a954295f234a70f548fd0c81e2f8.camel@intel.com>  <alpine.DEB.2.21.2003252353370.2971@xps-7390>  <7e1562ce93b83a685aa54dd2ae5a5b36c5737cb6.camel@intel.com> <c9a24dfbc765c9c19d87094e5b2044f33431e501.camel@intel.com>
 <alpine.DEB.2.21.2003260237130.26874@xps-7390>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


So I just tested a few shutdown vs. reboot cycles, and if I reboot, I only
get three counters. If I shutdown, then restart, I get 4 counters (including
the "psys domain" one).

I tried it on a few kernels, including the oldest one that comes with my
distro (5.3.0-40-generic) where all the RAPL stuff is made as modules.

So, maybe we're not "clearing" (wild guess here) the "psys" RAPL on a reboot,
something that would happen on a cold boot? (I'm afraid to say the "B-word",
as that would mean it's a Dell issue so I won't hold my breath waiting for
a fix).

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
