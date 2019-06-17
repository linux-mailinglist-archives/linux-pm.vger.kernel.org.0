Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278FB489A7
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 19:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfFQRHd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 13:07:33 -0400
Received: from foss.arm.com ([217.140.110.172]:56760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfFQRHd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Jun 2019 13:07:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 592E228;
        Mon, 17 Jun 2019 10:07:32 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F412C3F246;
        Mon, 17 Jun 2019 10:07:30 -0700 (PDT)
Subject: Re: [PATCH] sched/topology: remove unused sd param from
 arch_scale_cpu_capacity()
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org
Cc:     quentin.perret@arm.com
References: <1560783617-5827-1-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c8030f30-0899-070b-df3c-3839ec7e1909@arm.com>
Date:   Mon, 17 Jun 2019 18:07:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560783617-5827-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 17/06/2019 16:00, Vincent Guittot wrote:
> struct sched_domain *sd parameter is not used anymore in
> arch_scale_cpu_capacity() so we can remove it.
> 

I think it can't hurt to give a bit of background. The *sd parameter used
to be there for smt_gain, which got snipped out by:

  765d0af19f5f ("sched/topology: Remove the ::smt_gain field from 'struct sched_domain'")

I'd appreciate having that commit mentioned in the log.

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Other than that, the changes look fine to me.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

[...]
