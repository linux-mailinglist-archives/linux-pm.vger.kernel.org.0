Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24767369E50
	for <lists+linux-pm@lfdr.de>; Sat, 24 Apr 2021 03:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhDXBLa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 21:11:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:38878 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233027AbhDXBLX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 21:11:23 -0400
IronPort-SDR: PH5FwHKe9JQ9ymGoTOFswB8XaMoJW/TCytw8VRNGml3pb+/1Jf/Mv3om8mmWW9W9rNQgavr5ab
 SZMmjrR+UGdw==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="183638112"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="183638112"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 18:10:42 -0700
IronPort-SDR: 8XMWR0NZrlebDXhDFcQl4+7eHFLzWXGvg7OxXxIsy06Ykl2lFC5nfRZ1rett0f9MkYYhv9dPet
 Ied5KjpSFcXw==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="421944962"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 18:10:38 -0700
Date:   Sat, 24 Apr 2021 09:14:26 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Calvin Walton <calvin.walton@kepstin.ca>,
        Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wei.huang2@amd.com, aros@gmx.com, rui.zhang@intel.com
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
Message-ID: <20210424011426.GA432310@chenyu-desktop>
References: <20210420020336.GA386151@chenyu-desktop>
 <20210420080701.GA2326@zn.tnic>
 <20210420131541.GA388877@chenyu-desktop>
 <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
 <20210420143754.GA390118@chenyu-desktop>
 <5cf35f3742d1181421d955174b1aa9434d042c96.camel@kepstin.ca>
 <20210423121607.GA426003@chenyu-desktop>
 <20210423121934.GC24710@zn.tnic>
 <20210423133430.GA426650@chenyu-desktop>
 <YILaZTOG9EPaLnJ8@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YILaZTOG9EPaLnJ8@zn.tnic>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 23, 2021 at 04:32:05PM +0200, Borislav Petkov wrote:
> On Fri, Apr 23, 2021 at 09:34:30PM +0800, Chen Yu wrote:
> > I see, I'll add Calvin's SOB here. Previously I thought the 'From' field might
> > be enough to indicate the Author, but it seems to not be the case.
> 
> The From: field is used by git to take the author but that's not the
> problem. You need the author her/himself to sign off on the work - no
> one else can do that.
>
Thanks for the explanation. 
> You can refresh on that here:
>
> Documentation/process/submitting-patches.rst
> 
> > Got it. The off_t was derived from old code in this file from get_msr() and alike,
> > let me convert this return value to unsigned int.
> 
> See my reply to Calvin - it needs to by off_t after all.
> 
Okay.

Best,
Chenyu
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
