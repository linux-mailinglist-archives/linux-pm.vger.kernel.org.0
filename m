Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02827365C20
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 17:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhDTPZw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 11:25:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:60704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232836AbhDTPZv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 11:25:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57E9AAFDC;
        Tue, 20 Apr 2021 15:25:19 +0000 (UTC)
Date:   Tue, 20 Apr 2021 17:25:21 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        calvin.walton@kepstin.ca, wei.huang2@amd.com, aros@gmx.com
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
Message-ID: <20210420152521.GG2326@zn.tnic>
References: <20210419195812.147710-1-terry.bowman@amd.com>
 <20210420020336.GA386151@chenyu-desktop>
 <20210420080701.GA2326@zn.tnic>
 <20210420131541.GA388877@chenyu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210420131541.GA388877@chenyu-desktop>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 20, 2021 at 09:15:41PM +0800, Chen Yu wrote:
> This patch was sent to Len and it is not in public repo yet.

If that thing were in a public repo, you'd have the advantage of
pointing people to it and they could be testing patches.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
