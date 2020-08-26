Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E8B25350F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 18:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHZQj3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 12:39:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:46376 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgHZQj2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 12:39:28 -0400
IronPort-SDR: 9pFkQ+noWSconN0OeseWLYyQU28p52u+CJlj3Q7pORhOFZk5L79xnXHiOZhMyHv53bOowntrgN
 303oBD4GZbqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="136397005"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="136397005"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:39:27 -0700
IronPort-SDR: FpgYX9uruP0VLQ+3WHVGGr1JmFIgM7kQvyCKrKKekqguF/nGxs4lLNgtERdLO2Tz64lItS5YmN
 l4JbTc2zaDnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="329286792"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2020 09:39:27 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id B9E215805ED;
        Wed, 26 Aug 2020 09:39:25 -0700 (PDT)
Message-ID: <e9e6823d63fe2b9938e43a14c136b89aec0c503b.camel@gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Guilhem Lettron <guilhem@barpilot.io>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Aug 2020 19:39:24 +0300
In-Reply-To: <CAJZ5v0j4FXH26rZCjM9Csd56skPVbRpM7iFcKYAFMmLFX54+bg@mail.gmail.com>
References: <20200826120421.44356-1-guilhem@barpilot.io>
         <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
         <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
         <d0ca671465e6ce72c6c4d5178440ebc1e4814da8.camel@gmail.com>
         <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
         <CAGX5Wg0LrzPwf=2pGrQHAbFMVkOoYDxOoFa+ZmLBYshPvZQUXg@mail.gmail.com>
         <8fa7622dacc03f2fbd67e810f53389e3ede544e8.camel@intel.com>
         <CAGX5Wg0=K5AaTut5KH3R3+oasM5MM7PaJ9Z_L56xSNckMbWC9g@mail.gmail.com>
         <CAJZ5v0j4FXH26rZCjM9Csd56skPVbRpM7iFcKYAFMmLFX54+bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-08-26 at 18:02 +0200, Rafael J. Wysocki wrote:
> To that end, I would try to upgrade the graphics firmware and see if
> you can get some nonzero PC8 residency then.

I am curious, somehow that patch makes a difference.

Guilhem, what do we actually compare: same kernel, just patched vs
unpached? Or these are 2 different kernels, and one of them was
patched.

What does 'uname -r'  say for the "with" and "without" kernels?

Did you compile both kernels yourself and the only difference between
them is the intel_idle patch?

