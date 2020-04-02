Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD8219BB84
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 08:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgDBGLU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 02:11:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:59678 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgDBGLU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 02:11:20 -0400
IronPort-SDR: X7OAguWcNgc63dhsQYSMUkZ5/eGYG+nlqj0e+oVGSdqUaHlNa/WE534AeRvPsDu+cuAGfSZca4
 yTcALrSdRXtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 23:11:20 -0700
IronPort-SDR: exkOiveDNLcOjGVtjAPqlsrbMD3aFL+4RW721fQJhvG/MIKPcC5/ny3qLp2ousnrxP/f3IAomf
 tDmQVmGl9eEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,334,1580803200"; 
   d="scan'208";a="396244478"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 23:11:16 -0700
Date:   Thu, 2 Apr 2020 14:10:00 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH][v2] PM / sleep: Add pm_debug_messages boot command
 control
Message-ID: <20200402061000.GA6633@chenyu-office.sh.intel.com>
References: <20200329144640.20536-1-yu.c.chen@intel.com>
 <CAJZ5v0gV2Tn_CQoJiuR92gjJ8-xjzLPY8esAkxgy=W8YkvUNyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gV2Tn_CQoJiuR92gjJ8-xjzLPY8esAkxgy=W8YkvUNyg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,
On Wed, Apr 01, 2020 at 11:43:51AM +0200, Rafael J. Wysocki wrote:
> On Sun, Mar 29, 2020 at 4:48 PM Chen Yu <yu.c.chen@intel.com> wrote:
> > +__setup("pm_debug_message", pm_debug_message_setup);
> 
> I'd call this "pm_debug_messages" (just like the sysfs knob) and
> rename the rest accordingly.
Okay, I'll do in next version.

Thanks,
Chenyu
