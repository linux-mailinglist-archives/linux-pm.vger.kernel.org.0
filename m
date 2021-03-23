Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F3C345ADC
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 10:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCWJbP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 05:31:15 -0400
Received: from foss.arm.com ([217.140.110.172]:42766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhCWJbD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 05:31:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 143401042;
        Tue, 23 Mar 2021 02:31:03 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F29C3F718;
        Tue, 23 Mar 2021 02:31:01 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, Nicola Mazzucato <nicola.mazzucato@arm.com>,
        rjw@rjwysocki.net, cristian.marussi@arm.com,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, ionela.voinescu@arm.com,
        chris.redpath@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v8 0/3] CPUFreq: Add support for opp-sharing cpus
Date:   Tue, 23 Mar 2021 09:30:54 +0000
Message-Id: <161649160915.287225.16197567717908745920.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218222326.15788-1-nicola.mazzucato@arm.com>
References: <20210218222326.15788-1-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 18 Feb 2021 22:23:23 +0000, Nicola Mazzucato wrote:
> In this V8 I have addressed your comments:
> - correct the goto in patch 1/3
> - improve comment in patch 2/3 for dev_pm_opp_get_opp_count()
> 
> Many thanks,
> Nicola
> 
> [...]

(New commit info after rebase to v5.12-rc2 for obvious reasons)
Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/3] scmi-cpufreq: Remove deferred probe
https://git.kernel.org/sudeep.holla/c/71a37cd6a5
[2/3] scmi-cpufreq: Get opp_shared_cpus from opp-v2 for EM
https://git.kernel.org/sudeep.holla/c/80a064dbd5

--
Regards,
Sudeep

