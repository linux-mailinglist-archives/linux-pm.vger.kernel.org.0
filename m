Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FAD2534D1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHZQ0C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 12:26:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:21701 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgHZQ0B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 12:26:01 -0400
IronPort-SDR: HVyb42HM/w1r6PPf5FjMxL+bq8NkEMID4RltH6oPvh6nnfwd21KIYsGfTI6H5A5cw0yMwJNyXH
 I/v73WWWkjTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="143996600"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="143996600"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:26:00 -0700
IronPort-SDR: SzGVEoo0yBQ9+G/otfIWxh49XHzowrTI9qRPFfpArRSmyrg9MovtC0ktnV4krye94kexzglYxD
 hiYfhk9gjUrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="499786658"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 26 Aug 2020 09:25:59 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id 128AB5806C4;
        Wed, 26 Aug 2020 09:25:57 -0700 (PDT)
Message-ID: <c17c75993ebb5512e5a869fbe5b13f5c49685041.camel@gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Guilhem Lettron <guilhem@barpilot.io>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Aug 2020 19:25:56 +0300
In-Reply-To: <72fab2376722c6169549669016933217d3da34a0.camel@gmail.com>
References: <20200826120421.44356-1-guilhem@barpilot.io>
         <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
         <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
         <d0ca671465e6ce72c6c4d5178440ebc1e4814da8.camel@gmail.com>
         <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
         <CAGX5Wg0LrzPwf=2pGrQHAbFMVkOoYDxOoFa+ZmLBYshPvZQUXg@mail.gmail.com>
         <8fa7622dacc03f2fbd67e810f53389e3ede544e8.camel@intel.com>
         <CAGX5Wg0=K5AaTut5KH3R3+oasM5MM7PaJ9Z_L56xSNckMbWC9g@mail.gmail.com>
         <72fab2376722c6169549669016933217d3da34a0.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-08-26 at 19:19 +0300, Artem Bityutskiy wrote:
> May be there is a BIOS update that fixes this problem? May be Windows
> user get it quickly because stuff like this is often well-integrated in
> Windows? Would you please check if there is newer BIOS?

Oh, wait a second. So ACPI_C3 is C6, the deepest C-state one can
request. Sorry, I missed this first. Scratch my questions about Windows
and newer BIOS.

So ACPI does expose the deepest C-state, but something prevents your
system from going into PC10.

