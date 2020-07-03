Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE13213C10
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 16:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgGCOuE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 10:50:04 -0400
Received: from foss.arm.com ([217.140.110.172]:41022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgGCOuB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Jul 2020 10:50:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 099E21045;
        Fri,  3 Jul 2020 07:50:01 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B7943F73C;
        Fri,  3 Jul 2020 07:49:59 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicola Mazzucato <nicola.mazzucato@arm.com>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org
Cc:     james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        lukasz.luba@arm.com
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Add fast_switch_possible() api
Date:   Fri,  3 Jul 2020 15:49:48 +0100
Message-Id: <159378754443.7674.9124886575137501969.b4-ty@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <159378764840.7835.7289029317816454363.b4-ty@arm.com>
References: <159378759580.7741.1360234334350850998.b4-ty@arm.com>
 <159378764840.7835.7289029317816454363.b4-ty@arm.com>
In-Reply-To: <20200617094332.8391-1-nicola.mazzucato@arm.com>
References: <20200617094332.8391-1-nicola.mazzucato@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 17 Jun 2020 10:43:31 +0100, Nicola Mazzucato wrote:
> Add a new fast_switch_possible interface to the existing
> perf_ops api to export the information of whether or not
> fast_switch is possible in this driver.
> 
> This can be used by the CPUFreq driver and framework to
> choose proper mechanism for frequency change.


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/2] firmware: arm_scmi: Add fast_switch_possible() interface
      https://git.kernel.org/sudeep.holla/c/1909872ff2
[2/2] cpufreq: arm_scmi: Set fast_switch_possible conditionally
      https://git.kernel.org/sudeep.holla/c/fb3571276b

--
Regards,
Sudeep

