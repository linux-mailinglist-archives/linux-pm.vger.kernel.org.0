Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA49193C0E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 10:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgCZJiv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 05:38:51 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:33008 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgCZJiu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 05:38:50 -0400
Received: from xps-7390.lan (ip68-111-223-64.sd.sd.cox.net [68.111.223.64])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 48p0Kz4hxzz1T16;
        Thu, 26 Mar 2020 05:38:47 -0400 (EDT)
Date:   Thu, 26 Mar 2020 02:38:46 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Zhang Rui <rui.zhang@intel.com>
cc:     linux-pm@lists.linux-foundation.org, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: Why do I sometimes "lose" the "psys" RAPL counter?
In-Reply-To: <c9a24dfbc765c9c19d87094e5b2044f33431e501.camel@intel.com>
Message-ID: <alpine.DEB.2.21.2003260237130.26874@xps-7390>
References: <alpine.DEB.2.21.2003252212220.2971@xps-7390>  <691eb7a6efd7a954295f234a70f548fd0c81e2f8.camel@intel.com>  <alpine.DEB.2.21.2003252353370.2971@xps-7390>  <7e1562ce93b83a685aa54dd2ae5a5b36c5737cb6.camel@intel.com>
 <c9a24dfbc765c9c19d87094e5b2044f33431e501.camel@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, 26 Mar 2020, Zhang Rui wrote:

> BTW, it is better to get the output of "rdmsr 0x65C" as well.

OK, for the "3 counters" case (as per my last E-mail):

CPU 0 MSR 0x65C value: dd0000
CPU 1 MSR 0x65C value: dd0000
CPU 2 MSR 0x65C value: dd0000
CPU 3 MSR 0x65C value: dd0000
CPU 4 MSR 0x65C value: dd0000
CPU 5 MSR 0x65C value: dd0000
CPU 6 MSR 0x65C value: dd0000
CPU 7 MSR 0x65C value: dd0000

"4 counters" (i.e., with the "psys domain" being found) results coming up soon.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
