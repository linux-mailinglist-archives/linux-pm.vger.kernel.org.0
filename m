Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2259A3733D1
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 05:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhEEDFt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 23:05:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:26123 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230079AbhEEDFt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 May 2021 23:05:49 -0400
IronPort-SDR: aWySfpvG6YLLVAOPfCQC2Pf6pX/7p2vLGkStJsrZPxvz5PJxx1YMYHICiLpzZfLlvV4Mi7PZjj
 lEflBLfhC4Ow==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="198179093"
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="198179093"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 20:04:53 -0700
IronPort-SDR: eSdL5a60wFebfgQRagO5d8RWIzv8Vwnad4eB1atg/rDzdRg3G5MIDQFf3xiAQ65knE8yIPg0le
 uc/W7OXpbZ9A==
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="433593330"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 20:04:51 -0700
Date:   Wed, 5 May 2021 11:09:32 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] tools/power turbostat: Fix ACPI CState format issue
Message-ID: <20210505030932.GA116899@chenyu-desktop>
References: <20201012100205.2750-1-yu.c.chen@intel.com>
 <CAJvTdK=wGHfNhOBuWFS5VmW+QqdyG+w7HdDrP-Vs1u84dkSiyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJvTdK=wGHfNhOBuWFS5VmW+QqdyG+w7HdDrP-Vs1u84dkSiyw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 04, 2021 at 06:56:00PM -0400, Len Brown wrote:
> On Mon, Oct 12, 2020 at 6:00 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Currently if the system boots with BIOS _CST Cstate information
> > enabled, the turbostat output would have unaligned problems:
> >
> > C1_ACPI C2_ACPI C3_ACPI POLL%   C1_ACPI%        C2_ACPI%        C3_ACPI%        CPU%c1
> > 5       37      138     0.00    0.02    1.30    98.51   0.38    0.00    0.00    99.43
> >
> > The C1_ACPI% is of 8 bytes, so extend the format accordingly if the field name
> > equals to/longer than 8 bytes.
> >
> > After the patch applied:
> >
> > C1_ACPI C2_ACPI C3_ACPI POLL%   C1_ACPI%        C2_ACPI%        C3_ACPI%        CPU%c1
> > 2       42      96      0.00    0.12            2.60            97.09           0.60
> 
> Let's shorten the header fields so that a single tab continues to work.
> this is helpful for processing turbostat output in .TSV format.
>
Okay. BTW it looks like the following patch has already fixed the _CST format issue
and single tab still works:
commit fecb3bc839df64761cc63c9ee9b45c1cad36aee8
Author: David Arcari <darcari@redhat.com>
Date:   Mon Aug 10 10:43:30 2020 -0400

    tools/power turbostat: Fix output formatting for ACPI CST enumeration

thanks,
Chenyu 
