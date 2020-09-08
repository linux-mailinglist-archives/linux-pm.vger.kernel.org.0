Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B674B261525
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 18:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbgIHQpK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 12:45:10 -0400
Received: from foss.arm.com ([217.140.110.172]:58012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731775AbgIHQpG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Sep 2020 12:45:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 423B61595;
        Tue,  8 Sep 2020 05:51:16 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 39B9F3F73C;
        Tue,  8 Sep 2020 05:51:15 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] arm_scmi: Constify ops pointers in struct scmi_handle
Date:   Tue,  8 Sep 2020 13:51:09 +0100
Message-Id: <159956941201.2396.12740446851296711190.b4-ty@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
References: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 7 Sep 2020 01:04:49 +0200, Rikard Falkeborn wrote:
> A small patch series aiming to constify static scmi_*_ops structs in
> drivers/firmware/arm_scmi. Since these are not modified, constify them
> to allow the compiler to put them in read-only memory.
> 
> Rikard Falkeborn (3):
>   cpufreq: arm_scmi: Constify scmi_perf_ops pointers
>   firmware: arm_scmi: Constify ops pointers in scmi_handle
>   firmware: arm_scmi: Constify static scmi-ops
> 
> [...]


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/3] cpufreq: arm_scmi: Constify scmi_perf_ops pointers
      https://git.kernel.org/sudeep.holla/c/69ecb3230b
[2/3] firmware: arm_scmi: Constify ops pointers in scmi_handle
      https://git.kernel.org/sudeep.holla/c/82894c1d39
[3/3] firmware: arm_scmi: Constify static scmi-ops
      https://git.kernel.org/sudeep.holla/c/3de7b83017

--

Regards,
Sudeep

