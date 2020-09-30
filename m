Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CDB27E52F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgI3Jbw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 05:31:52 -0400
Received: from foss.arm.com ([217.140.110.172]:60818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3Jbw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Sep 2020 05:31:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E493AD6E;
        Wed, 30 Sep 2020 02:31:51 -0700 (PDT)
Received: from bogus (unknown [10.57.47.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8B1D3F70D;
        Wed, 30 Sep 2020 02:31:46 -0700 (PDT)
Date:   Wed, 30 Sep 2020 10:29:54 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] devfreq: qcom: Add L2 Krait Cache devfreq scaling
 driver
Message-ID: <20200930092954.GA7125@bogus>
References: <20200929162926.139-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929162926.139-1-ansuelsmth@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 29, 2020 at 06:29:24PM +0200, Ansuel Smith wrote:
> Qcom L2 Krait CPUs use the generic cpufreq-dt driver and doesn't actually
> scale the Cache frequency when the CPU frequency is changed. This
> devfreq driver register with the cpu notifier and scale the Cache
> based on the max Freq across all core as the CPU cache is shared across
> all of them. If provided this also scale the voltage of the regulator
> attached to the CPU cache. The scaling logic is based on the CPU freq
> and the 3 scaling interval are set by the device dts.
>

I have raised this concern before. I am worried this kind of independent
CPU and cache frequency controls make way for clkscrew kind of attacks.
Why can't the clocks be made parent/child or secondary and automatically
updated when CPU clocks are changed.

-- 
Regards,
Sudeep
