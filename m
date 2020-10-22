Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2EE2958C0
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 09:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504821AbgJVHCa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 03:02:30 -0400
Received: from foss.arm.com ([217.140.110.172]:49140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504817AbgJVHCa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Oct 2020 03:02:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84D70D6E;
        Thu, 22 Oct 2020 00:02:29 -0700 (PDT)
Received: from bogus (unknown [10.57.22.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 581C13F66B;
        Thu, 22 Oct 2020 00:02:27 -0700 (PDT)
Date:   Thu, 22 Oct 2020 08:02:19 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Claude Yen <claude.yen@mediatek.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>, wsd_upstream@mediatek.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PM / s2idle: Export s2idle_set_ops
Message-ID: <20201022070154.hqvksoj4nss3er2e@bogus>
References: <20201022061748.13730-1-claude.yen@mediatek.com>
 <20201022061748.13730-2-claude.yen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022061748.13730-2-claude.yen@mediatek.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 02:17:48PM +0800, Claude Yen wrote:
> As suspend_set_ops is exported in commit a5e4fd8783a2
> ("PM / Suspend: Export suspend_set_ops, suspend_valid_only_mem"),
> exporting s2idle_set_ops to make kernel module setup s2idle ops too.
> 
> In this way, kernel module can hook platform suspend
> functions regardless of Suspend-to-Ram(S2R) or
> Suspend-to-Idle(S2I)
>

If this is for arm64 platform, then NACK. You must use PSCI and it will
set the ops and it can't be module.

-- 
Regards,
Sudeep
