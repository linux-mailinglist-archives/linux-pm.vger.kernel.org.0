Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A403DF813
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 00:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhHCWnC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 18:43:02 -0400
Received: from foss.arm.com ([217.140.110.172]:54866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhHCWnB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Aug 2021 18:43:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0552911FB;
        Tue,  3 Aug 2021 15:42:50 -0700 (PDT)
Received: from bogus (unknown [10.57.37.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25AE53F66F;
        Tue,  3 Aug 2021 15:42:47 -0700 (PDT)
Date:   Tue, 3 Aug 2021 23:41:45 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, cristian.marussi@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        nicola.mazzucato@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: arm_scmi: Fix error path when allocation
 failed
Message-ID: <20210803224145.zyr36sliwa7a67xf@bogus>
References: <20210803090744.12143-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803090744.12143-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 03, 2021 at 10:07:44AM +0100, Lukasz Luba wrote:
> Stop the initialization when cpumask allocation failed and return an
> error.
>

Good catch!

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
