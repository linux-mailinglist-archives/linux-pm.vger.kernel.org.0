Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBA13653B6
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 10:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhDTIHh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 04:07:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:56074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229552AbhDTIHh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 04:07:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 302DFB2D8;
        Tue, 20 Apr 2021 08:07:05 +0000 (UTC)
Date:   Tue, 20 Apr 2021 10:07:01 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        calvin.walton@kepstin.ca, wei.huang2@amd.com, aros@gmx.com
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
Message-ID: <20210420080701.GA2326@zn.tnic>
References: <20210419195812.147710-1-terry.bowman@amd.com>
 <20210420020336.GA386151@chenyu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210420020336.GA386151@chenyu-desktop>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 20, 2021 at 10:03:36AM +0800, Chen Yu wrote:
> On Mon, Apr 19, 2021 at 02:58:12PM -0500, Terry Bowman wrote:
> > Turbostat fails to correctly collect and display RAPL summary information
> > on Family 17h and 19h AMD processors. Running turbostat on these processors
> > returns immediately. If turbostat is working correctly then RAPL summary
> > data is displayed until the user provided command completes. If a command
> > is not provided by the user then turbostat is designed to continuously
> > display RAPL information until interrupted.
> > 
> > The issue is due to offset_to_idx() and idx_to_offset() missing support for
> > AMD MSR addresses/offsets. offset_to_idx()'s switch statement is missing
> > cases for AMD MSRs and idx_to_offset() does not include a path to return
> > AMD MSR(s) for any idx.
> > 
> > The solution is add AMD MSR support to offset_to_idx() and idx_to_offset().
> > These functions are split-out and renamed along architecture vendor lines
> > for supporting both AMD and Intel MSRs.
> > 
> > Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Thanks for fixing, Terry, and previously there was a patch for this from Bas Nieuwenhuizen:
> https://lkml.org/lkml/2021/3/12/682
> and it is expected to have been merged in Len's branch already.

Expected?

So is it or is it not?

And can you folks agree on a patch already and give it to Artem for
testing (CCed) because he's triggering it too:

https://bugzilla.kernel.org/show_bug.cgi?id=212357

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
