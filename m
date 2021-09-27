Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC937418F66
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 08:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhI0Gy0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 02:54:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:29622 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233055AbhI0GyZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Sep 2021 02:54:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="203909721"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="203909721"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 23:52:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="553048688"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2021 23:52:47 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.32])
        by linux.intel.com (Postfix) with ESMTP id 6B9065808A6;
        Sun, 26 Sep 2021 23:52:46 -0700 (PDT)
Message-ID: <d9f4b3591e7a3300015319f11bc8c483e499380e.camel@gmail.com>
Subject: Re: [PATCH v2] intel_idle: remove a couple of useless variables
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>
Date:   Mon, 27 Sep 2021 09:52:45 +0300
In-Reply-To: <CAJZ5v0gn-qAgVLoQXKPttBU5Y1djsT5o5kORJmzEjfbbCV=-YA@mail.gmail.com>
References: <20210924075920.2087149-1-dedekind1@gmail.com>
         <20210924104504.2430239-1-dedekind1@gmail.com>
         <CAJZ5v0gn-qAgVLoQXKPttBU5Y1djsT5o5kORJmzEjfbbCV=-YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-09-24 at 20:19 +0200, Rafael J. Wysocki wrote:
> On Fri, Sep 24, 2021 at 12:45 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
> > 
> > From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > 
> > This patch is a cleanup and has no functional impact.
> 
> Are you sure?

Not anymore. I shouldn't have sent this patch out so quickly, sorry.
Thanks for review.

Artem.


