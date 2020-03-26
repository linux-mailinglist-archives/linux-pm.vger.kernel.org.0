Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7828193C5B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 10:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgCZJ4B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 05:56:01 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:49725 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgCZJ4A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 05:56:00 -0400
Received: from xps-7390.lan (ip68-111-223-64.sd.sd.cox.net [68.111.223.64])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 48p0jn6btTz1TPL;
        Thu, 26 Mar 2020 05:55:57 -0400 (EDT)
Date:   Thu, 26 Mar 2020 02:55:56 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Zhang Rui <rui.zhang@intel.com>
cc:     linux-pm@lists.linux-foundation.org, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: Re: Why do I sometimes "lose" the "psys" RAPL counter?
In-Reply-To: <alpine.DEB.2.21.2003260237130.26874@xps-7390>
Message-ID: <alpine.DEB.2.21.2003260254350.3029@xps-7390>
References: <alpine.DEB.2.21.2003252212220.2971@xps-7390>  <691eb7a6efd7a954295f234a70f548fd0c81e2f8.camel@intel.com>  <alpine.DEB.2.21.2003252353370.2971@xps-7390>  <7e1562ce93b83a685aa54dd2ae5a5b36c5737cb6.camel@intel.com> <c9a24dfbc765c9c19d87094e5b2044f33431e501.camel@intel.com>
 <alpine.DEB.2.21.2003260237130.26874@xps-7390>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, 26 Mar 2020, Zhang Rui wrote:

> > BTW, it is better to get the output of "rdmsr 0x65C" as well.

OK, so here's that for the "4 counters" (with the "psys domain") case:

MSR value on CPU 0 for 0x65C is: dd0000
MSR value on CPU 1 for 0x65C is: dd0000
MSR value on CPU 2 for 0x65C is: dd0000
MSR value on CPU 3 for 0x65C is: dd0000
MSR value on CPU 4 for 0x65C is: dd0000
MSR value on CPU 5 for 0x65C is: dd0000
MSR value on CPU 6 for 0x65C is: dd0000
MSR value on CPU 7 for 0x65C is: dd0000

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
