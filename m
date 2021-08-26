Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C303F866D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 13:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbhHZL1J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 07:27:09 -0400
Received: from foss.arm.com ([217.140.110.172]:44558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242345AbhHZL1B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Aug 2021 07:27:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 005801042;
        Thu, 26 Aug 2021 04:26:13 -0700 (PDT)
Received: from bogus (unknown [10.57.18.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B30B83F5A1;
        Thu, 26 Aug 2021 04:26:08 -0700 (PDT)
Date:   Thu, 26 Aug 2021 12:26:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 7/9] cpufreq: scpi: Use .register_em() to register
 with energy model
Message-ID: <20210826112451.jax5w347hz77sww4@bogus>
References: <cover.1628742634.git.viresh.kumar@linaro.org>
 <a214649dfcbc812ddf6b3906315da166caf01964.1628742634.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a214649dfcbc812ddf6b3906315da166caf01964.1628742634.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 12, 2021 at 10:05:20AM +0530, Viresh Kumar wrote:
> Set the newly added .register_em() callback with
> cpufreq_register_em_with_opp() to register with the EM core.
> 

If not too late,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
