Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1098E3694C6
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 16:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242540AbhDWOcm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 10:32:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:46860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229871AbhDWOck (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 10:32:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B51DB133;
        Fri, 23 Apr 2021 14:32:02 +0000 (UTC)
Date:   Fri, 23 Apr 2021 16:32:05 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Calvin Walton <calvin.walton@kepstin.ca>,
        Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wei.huang2@amd.com, aros@gmx.com, rui.zhang@intel.com
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
Message-ID: <YILaZTOG9EPaLnJ8@zn.tnic>
References: <20210419195812.147710-1-terry.bowman@amd.com>
 <20210420020336.GA386151@chenyu-desktop>
 <20210420080701.GA2326@zn.tnic>
 <20210420131541.GA388877@chenyu-desktop>
 <4cbb1eff77de1e843912267ade4686cfa1acd610.camel@kepstin.ca>
 <20210420143754.GA390118@chenyu-desktop>
 <5cf35f3742d1181421d955174b1aa9434d042c96.camel@kepstin.ca>
 <20210423121607.GA426003@chenyu-desktop>
 <20210423121934.GC24710@zn.tnic>
 <20210423133430.GA426650@chenyu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210423133430.GA426650@chenyu-desktop>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 23, 2021 at 09:34:30PM +0800, Chen Yu wrote:
> I see, I'll add Calvin's SOB here. Previously I thought the 'From' field might
> be enough to indicate the Author, but it seems to not be the case.

The From: field is used by git to take the author but that's not the
problem. You need the author her/himself to sign off on the work - no
one else can do that.

You can refresh on that here:

Documentation/process/submitting-patches.rst

> Got it. The off_t was derived from old code in this file from get_msr() and alike,
> let me convert this return value to unsigned int.

See my reply to Calvin - it needs to by off_t after all.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
