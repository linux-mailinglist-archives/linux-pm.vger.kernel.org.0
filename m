Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B83945C864
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 16:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhKXPTj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 10:19:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:25861 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233672AbhKXPTi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Nov 2021 10:19:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="235535497"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="235535497"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 07:16:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="457067090"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 24 Nov 2021 07:16:11 -0800
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.32])
        by linux.intel.com (Postfix) with ESMTP id 5E174580AF5;
        Wed, 24 Nov 2021 07:16:10 -0800 (PST)
Message-ID: <2a0ceac56f4e7c43e24d0d0e15f947353a84a2db.camel@gmail.com>
Subject: Re: [PATCH] turbostat: fix PC6 displaying on some systems
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>
Date:   Wed, 24 Nov 2021 17:16:09 +0200
In-Reply-To: <20211004105224.3145916-1-dedekind1@gmail.com>
References: <20211004105224.3145916-1-dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, any feed-back on this patch, or a chance for it to be picked up?

Thanks!

On Mon, 2021-10-04 at 13:52 +0300, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> 'MSR_PKG_CST_CONFIG_CONTROL' encodes the deepest allowed package C-state
> limit,
> and turbostat decodes it.
> 
> Before this patch: turbostat does not recognize value "3" on Ice Lake Xeon
> (ICX), treats it as "unknown", and does not display any package C-states in
> the
> results table.
> 
> After this patch: turbostat recognizes value 3 on ICX, treats it as "PC6", and
> correctly displays package C-states in the results table.
> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>


