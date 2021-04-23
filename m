Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64B03694BA
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 16:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhDWOab (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 10:30:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:45478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWOab (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 10:30:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55D45B133;
        Fri, 23 Apr 2021 14:29:53 +0000 (UTC)
Date:   Fri, 23 Apr 2021 16:29:41 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Calvin Walton <calvin.walton@kepstin.ca>
Cc:     Chen Yu <yu.c.chen@intel.com>, Terry Bowman <terry.bowman@amd.com>,
        lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.huang2@amd.com, aros@gmx.com,
        rui.zhang@intel.com
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
Message-ID: <YILZ1aNVrAa9vx79@zn.tnic>
References: <20210419195812.147710-1-terry.bowman@amd.com>
 <20210420020336.GA386151@chenyu-desktop>
 <20210420080701.GA2326@zn.tnic>
 <20210420131541.GA388877@chenyu-desktop>
 <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
 <20210420143754.GA390118@chenyu-desktop>
 <5cf35f3742d1181421d955174b1aa9434d042c96.camel@kepstin.ca>
 <20210423121607.GA426003@chenyu-desktop>
 <20210423121934.GC24710@zn.tnic>
 <23f75aaf3d37cbad6f8ed7bd970434e4a2dc388e.camel@kepstin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23f75aaf3d37cbad6f8ed7bd970434e4a2dc388e.camel@kepstin.ca>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 23, 2021 at 10:00:14AM -0400, Calvin Walton wrote:
> So, there's two problems with that:
>    1. This function needs to be able to return an error value that cannot be
>       confused with a valid MSR. This is currently done by returning a
>       negative number. If an unsigned value is used, a different way of
>       indicating errors needs to be written.
>    2. We are not using CPU instructions to access MSRs direction. Instead
>       they are being read from /dev/msr. So the "offset" value is actually a
>       seek into the /dev/msr file (using pread), and thus is of type off_t.

Ah right, that's the /dev/msr thing. Then off_t is correct, forget what
I said.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
