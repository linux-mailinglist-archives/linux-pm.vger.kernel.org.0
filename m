Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E0151AD1
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 13:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgBDMx2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Feb 2020 07:53:28 -0500
Received: from foss.arm.com ([217.140.110.172]:36642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbgBDMx2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Feb 2020 07:53:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F0DA30E;
        Tue,  4 Feb 2020 04:53:27 -0800 (PST)
Received: from [10.1.30.218] (e107114-lin.cambridge.arm.com [10.1.30.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7048A3F52E;
        Tue,  4 Feb 2020 04:53:25 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
Subject: Suspect broken frequency transitions on SDM845
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <qperret@google.com>
Message-ID: <eb8c48fb-c9b1-79c1-21b3-cd41ea37e2c6@arm.com>
Date:   Tue, 4 Feb 2020 13:53:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi folks,

We have a simple sanity test that asserts higher frequency leads to more
work done. It's fairly straightforward - we use the userspace governor,
go through increasing frequencies, run sysbench each time and assert the
values we get are increasing monotonically. We do that for one CPU of each
"type" (i.e. once for a LITTLE and once for a big).

We've been getting some sporadic failures on the big CPUs of a Pixel3
running mainline [1], here is an example of a correct run (CPU4):

| frequency (kHz) | sysbench events |
|-----------------+-----------------|
|          825600 |             236 |
|         1286400 |             369 |
|         1689600 |             483 |
|         2092800 |             600 |
|         2476800 |             711 |

and here is a failed one (still CPU4):

| frequency (kHz) | sysbench events |
|-----------------+-----------------|
|          825600 |             234 |
|         1286400 |             369 |
|         1689600 |             449 |
|         2092800 |             600 |
|         2476800 |             355 |


We've encountered something like this in the past with the exact same
test on h960 [2] but it is much harder to reproduce reliably this time
around.

I haven't found much time to dig into this; I did get a run of ~100 
iterations with about ~15 failures, but nothing cpufreq related showed up in
dmesg. I briefly suspected fast-switch, but it's only used by schedutil, so
in this test I would expect the frequency transition to be complete before we
even try to start executing sysbench.

If anyone has the time and will to look into this, that would be much
appreciated.

[1]: https://git.linaro.org/people/amit.pundir/linux.git/log/?h=blueline-mainline-tracking
[2]: https://lore.kernel.org/lkml/d3ede0ab-b635-344c-faba-a9b1531b7f05@arm.com/

Cheers,
Valentin
