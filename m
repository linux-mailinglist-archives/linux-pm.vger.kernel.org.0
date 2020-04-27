Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE601BA128
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 12:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgD0K3Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 06:29:16 -0400
Received: from foss.arm.com ([217.140.110.172]:33302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbgD0K3Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 06:29:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94D601FB;
        Mon, 27 Apr 2020 03:29:15 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BD5F3F68F;
        Mon, 27 Apr 2020 03:29:14 -0700 (PDT)
Date:   Mon, 27 Apr 2020 11:29:11 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "cpu/hotplug: Ignore pm_wakeup_pending() for
 disable_nonboot_cpus()"
Message-ID: <20200427102910.b6iysyumiz5pj4sv@e107158-lin>
References: <20200409112742.3581-1-qais.yousef@arm.com>
 <26038947.HFycnDbHsR@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26038947.HFycnDbHsR@kreacher>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/26/20 17:24, Rafael J. Wysocki wrote:
> I would do this the other way around:
> 
> 1. Make x86 call freeze_secondary_cpus() directly, rename
>    enable_nonboot_cpus() and drop disable_nonboot_cpus().

All of this in a single patch?

> 2. Get rid of __freeze_secondary_cpus().

I guess you're implying to drop the revert too and manually unroll it instead.

Could do.

Thanks

--
Qais Yousef
