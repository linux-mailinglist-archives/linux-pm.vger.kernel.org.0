Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82447252AD1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 11:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgHZJyW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 05:54:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:14627 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbgHZJyW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 05:54:22 -0400
IronPort-SDR: 2/TTzkZ5gG/wQasxgz+TL1FTFMj8gTg+Q4MwT1uvdUfwfM8T+laC2F16LoqFZUdTY5xF763keg
 uKq/2by4RB8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="153835283"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="153835283"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 02:54:18 -0700
IronPort-SDR: aKZ1nbtpzd2mAGNtCYvZa4u9d31Wtw/GoGfc/vEAuEh7HDFwSdsiBaOSutwoQNSWGqXc2g3v+Y
 6xI71ibo1P8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="373327012"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 26 Aug 2020 02:54:18 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id D064D5806C4;
        Wed, 26 Aug 2020 02:54:16 -0700 (PDT)
Message-ID: <91190a53b9d78ffe08d4b001d021868ad7ba6d1c.camel@gmail.com>
Subject: Re: [PATCH v2 2/5] cpufreq: intel_pstate: Always return last EPP
 value from sysfs
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Date:   Wed, 26 Aug 2020 12:54:15 +0300
In-Reply-To: <CAJZ5v0hkmcAuCsnfjCSWTarr4pkQry2VCtk2aWM74fOW2guzmg@mail.gmail.com>
References: <4169555.5IIHXK4Dsd@kreacher> <2064342.aRc67yb0pC@kreacher>
         <61ea43fce7dd8700d94f12236a86ffec6f76a898.camel@gmail.com>
         <CAJZ5v0hkmcAuCsnfjCSWTarr4pkQry2VCtk2aWM74fOW2guzmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for answer Rafael, it looks like there are 2 different things
now.

1. What kernel returns when I _read_ e_p_p file - truth or "cached" ?

2. How kernel behaves when I _write_ to e_p_p file something it cannot
provide - error or success.

For #1, I think we need to keep it simple and always return true policy
value. Does not matter what someone wrote there. If some process wrote
"powersave", but kernel uses EPP 0 anyway, the other process probably
wants to know the truth and get "performance" when reading e_p_p.

On Tue, 2020-08-25 at 16:51 +0200, Rafael J. Wysocki wrote:
> An alternative is to fail writes to energy_performance_preference if
> the driver works in the active mode and the scaling algorithm for the
> scaling CPU is performance and *then* to make reads from it return the
> value in the register.

Yes, this is #2. This sounds like the _right_ way to do it.

Suppose my script wants to exercise the system with 4 different EPP
policies. It changes the policy and runs measurements, each run takes
few _days_.

Now, my script asks for "powersave". Kernel _knows_ it cannot provide
it (performance+active enabled). Why would it not return error ("can't
do") instead of success ("yes, Sir!")?

Note, I deliberately use simple words like "my script" instead of "a
user-space process" to make it easier to convey the idea.

Anyway, if kernel returns error, I can go and improve my script WRT
controlling the performance+active mode knobs.

