Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF34198286
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 19:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgC3RkL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 13:40:11 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:55321 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgC3RkK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 13:40:10 -0400
Received: from [192.168.128.0] (71-136-136-204.lightspeed.sntcca.sbcglobal.net [71.136.136.204])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 48rfqT479wz1kTy;
        Mon, 30 Mar 2020 13:40:04 -0400 (EDT)
Date:   Mon, 30 Mar 2020 10:40:03 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Zhang Rui <rui.zhang@intel.com>,
        linux-pm@lists.linux-foundation.org, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, "Liang, Kan" <kan.liang@intel.com>
Subject: Re: Why do I sometimes "lose" the "psys" RAPL counter?
In-Reply-To: <7583412585916da6bb23d9352257c7768c509388.camel@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2003301037470.3728@xps-7390>
References: <alpine.DEB.2.21.2003252212220.2971@xps-7390>  <691eb7a6efd7a954295f234a70f548fd0c81e2f8.camel@intel.com>  <alpine.DEB.2.21.2003252353370.2971@xps-7390>  <7e1562ce93b83a685aa54dd2ae5a5b36c5737cb6.camel@intel.com>  <c9a24dfbc765c9c19d87094e5b2044f33431e501.camel@intel.com>
  <alpine.DEB.2.21.2003260237130.26874@xps-7390>  <alpine.DEB.2.21.2003260311030.2844@xps-7390>  <b772ca4f2c08cca65da9cf09b4a61157854669af.camel@intel.com> <7583412585916da6bb23d9352257c7768c509388.camel@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 30 Mar 2020, Srinivas Pandruvada wrote:

> I could reproduce this. This fails because the Psys MSR read 0. Also
> the counter values are not correct as the incremental values are less
> than package energy counter values.

OK, so the very night I'd asked this question, Dell put out a BIOS update
(BIOS 1.3.1 03/02/2020) that seems to have fixed this issue; I have not
had a missing "psys" domain since updating. Srinivas, can you update the
XPS 7390 you have to this BIOS version and verify this is fixed?

Thanks,

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
