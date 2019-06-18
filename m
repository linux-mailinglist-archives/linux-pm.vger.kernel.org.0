Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C046549D8B
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 11:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfFRJho (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 05:37:44 -0400
Received: from foss.arm.com ([217.140.110.172]:59852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbfFRJho (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Jun 2019 05:37:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09D29344;
        Tue, 18 Jun 2019 02:37:44 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7A333F246;
        Tue, 18 Jun 2019 02:37:42 -0700 (PDT)
Subject: Re: [PATCH] sched/topology: remove unused sd param from
 arch_scale_cpu_capacity()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, quentin.perret@arm.com
References: <1560783617-5827-1-git-send-email-vincent.guittot@linaro.org>
 <c8030f30-0899-070b-df3c-3839ec7e1909@arm.com>
 <20190618093453.GN3436@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <40551599-0448-352f-f5d1-e37ab5330d69@arm.com>
Date:   Tue, 18 Jun 2019 10:37:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618093453.GN3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/06/2019 10:34, Peter Zijlstra wrote:
[...]
> The commit log now reads:
> 
> ---
> The 'struct sched_domain *sd' argument to arch_scale_cpu_capacity() is
> unused since commit:
> 
>   765d0af19f5f ("sched/topology: Remove the ::smt_gain field from 'struct sched_domain'")
> 
> remove it.
> ---
> 

Thanks :)
