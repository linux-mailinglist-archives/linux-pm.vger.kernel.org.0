Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533C13D245B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhGVM2d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Jul 2021 08:28:33 -0400
Received: from foss.arm.com ([217.140.110.172]:52878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232035AbhGVM2d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Jul 2021 08:28:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 653F2113E;
        Thu, 22 Jul 2021 06:09:08 -0700 (PDT)
Received: from [10.57.9.248] (unknown [10.57.9.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1F543F694;
        Thu, 22 Jul 2021 06:09:06 -0700 (PDT)
Subject: Re: [PATCH v4 4/9] PM / EM: Allow skipping inefficient states
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com, mka@chromium.org
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <1625738946-295849-5-git-send-email-vincent.donnefort@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ff15b00c-189c-fcf3-580f-12677e383ca0@arm.com>
Date:   Thu, 22 Jul 2021 14:09:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1625738946-295849-5-git-send-email-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/8/21 11:09 AM, Vincent Donnefort wrote:
> The new performance domain flag EM_PERF_DOMAIN_SKIP_INEFFICIENCIES allows
> to not take into account inefficient states when estimating energy
> consumption. This intends to let the Energy Model know that CPUFreq itself
> will skip inefficiencies and such states don't need to be part of the
> estimation anymore.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 1deb727245be..fe9b90dd0c8c 100644

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
