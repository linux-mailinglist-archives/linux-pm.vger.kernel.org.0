Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E959E332498
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 13:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCIL7q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 06:59:46 -0500
Received: from foss.arm.com ([217.140.110.172]:52016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhCIL7c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 06:59:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB7711042;
        Tue,  9 Mar 2021 03:59:31 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 65E183F70D;
        Tue,  9 Mar 2021 03:59:30 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        cristian.marussi@arm.com, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vireshk@kernel.org, linux-pm@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, chris.redpath@arm.com,
        morten.rasmussen@arm.com, ionela.voinescu@arm.com
Subject: Re: [PATCH v8 0/3] CPUFreq: Add support for opp-sharing cpus
Date:   Tue,  9 Mar 2021 11:59:18 +0000
Message-Id: <161529100668.14386.8282141106561420272.b4-ty@arm.com>
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


Applied the first 2 patches to sudeep.holla/linux (for-next/scmi), thanks!

[1/3] scmi-cpufreq: Remove deferred probe
      https://git.kernel.org/sudeep.holla/c/2a3390d53b
[2/3] scmi-cpufreq: Get opp_shared_cpus from opp-v2 for EM
      https://git.kernel.org/sudeep.holla/c/dac7a57d2a

--

Regards,
Sudeep

