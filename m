Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C907198A26
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 04:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgCaCt7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 22:49:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:16146 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbgCaCt7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Mar 2020 22:49:59 -0400
IronPort-SDR: tdA9FxxKAXkRk07LoJCML4hXcpCy5cebzMMECkigQBRv/BOAtMA8JM6AdWkADM9FzoCppuaEWS
 9E0TitKBmznA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 19:49:58 -0700
IronPort-SDR: lbo6byzP3+exdTibNq1mOXC2BFSt1UntOW+zCgyarEKWBPbB89/wk9+tooD5VueM87k0MAt0yt
 nn7zvjqqGXpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,326,1580803200"; 
   d="scan'208";a="294795846"
Received: from yanbingl-mobl2.ccr.corp.intel.com ([10.249.171.104])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2020 19:49:56 -0700
Message-ID: <a72bd97c2d0a3d1b9438198db79bfecaaf2918b3.camel@intel.com>
Subject: Re: Why do I sometimes "lose" the "psys" RAPL counter?
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Kenneth R. Crudup" <kenny@panix.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-pm@lists.linux-foundation.org, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, "Liang, Kan" <kan.liang@intel.com>
Date:   Tue, 31 Mar 2020 10:49:55 +0800
In-Reply-To: <alpine.DEB.2.21.2003301037470.3728@xps-7390>
References: <alpine.DEB.2.21.2003252212220.2971@xps-7390>
          <691eb7a6efd7a954295f234a70f548fd0c81e2f8.camel@intel.com>
          <alpine.DEB.2.21.2003252353370.2971@xps-7390>
          <7e1562ce93b83a685aa54dd2ae5a5b36c5737cb6.camel@intel.com>
          <c9a24dfbc765c9c19d87094e5b2044f33431e501.camel@intel.com>
         <alpine.DEB.2.21.2003260237130.26874@xps-7390>
          <alpine.DEB.2.21.2003260311030.2844@xps-7390>
          <b772ca4f2c08cca65da9cf09b4a61157854669af.camel@intel.com>
         <7583412585916da6bb23d9352257c7768c509388.camel@linux.intel.com>
         <alpine.DEB.2.21.2003301037470.3728@xps-7390>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-03-30 at 10:40 -0700, Kenneth R. Crudup wrote:
> On Mon, 30 Mar 2020, Srinivas Pandruvada wrote:
> 
> > I could reproduce this. This fails because the Psys MSR read 0. 

Do you mean MSR_PLATFORM_POWER_LIMIT?
It is not 0 according to previous emails.

> > Also
> > the counter values are not correct as the incremental values are
> > less
> > than package energy counter values.
> 
> OK, so the very night I'd asked this question, Dell put out a BIOS
> update
> (BIOS 1.3.1 03/02/2020) that seems to have fixed this issue; I have
> not
> had a missing "psys" domain since updating. Srinivas, can you update
> the
> XPS 7390 you have to this BIOS version and verify this is fixed?
> 
Good to know.

thanks,
rui


