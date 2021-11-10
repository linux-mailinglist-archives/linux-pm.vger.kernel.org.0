Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343A844BBD8
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 07:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhKJHAP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 02:00:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:19092 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhKJHAP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Nov 2021 02:00:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="232858807"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="232858807"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 22:57:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="533951198"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 09 Nov 2021 22:57:27 -0800
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.32])
        by linux.intel.com (Postfix) with ESMTP id 6EDA1580699;
        Tue,  9 Nov 2021 22:57:26 -0800 (PST)
Message-ID: <ff68ed136f78de109f467f9fc23493ac7ed14d39.camel@gmail.com>
Subject: Re: [PATCH] turbostat: fix PC6 displaying on some systems
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>
Date:   Wed, 10 Nov 2021 08:57:25 +0200
In-Reply-To: <20211004105224.3145916-1-dedekind1@gmail.com>
References: <20211004105224.3145916-1-dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-10-04 at 13:52 +0300, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> 'MSR_PKG_CST_CONFIG_CONTROL' encodes the deepest allowed package C-state limit,
> and turbostat decodes it.
> 
> Before this patch: turbostat does not recognize value "3" on Ice Lake Xeon
> (ICX), treats it as "unknown", and does not display any package C-states in the
> results table.
> 
> After this patch: turbostat recognizes value 3 on ICX, treats it as "PC6", and
> correctly displays package C-states in the results table.
> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Hi,

any chance for this patch to be picked?

Thanks,
Artem.

