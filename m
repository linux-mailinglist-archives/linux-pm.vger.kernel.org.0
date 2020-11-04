Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EAC2A62C9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 11:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgKDK64 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 05:58:56 -0500
Received: from foss.arm.com ([217.140.110.172]:35264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKDK64 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Nov 2020 05:58:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 503241474;
        Wed,  4 Nov 2020 02:58:55 -0800 (PST)
Received: from [10.57.20.87] (unknown [10.57.20.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EF4A3F718;
        Wed,  4 Nov 2020 02:58:45 -0800 (PST)
Subject: Re: [PATCH v4 0/4] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        amitk@kernel.org, corbet@lwn.net, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, dianders@chromium.org, mka@chromium.org,
        rnayak@codeaurora.org, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, sboyd@kernel.org, nm@ti.com
References: <20201103090600.29053-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <9382ea70-cc50-7b78-f5de-716678bdefbf@arm.com>
Date:   Wed, 4 Nov 2020 10:58:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201103090600.29053-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 11/3/20 9:05 AM, Lukasz Luba wrote:
> Hi all,
> 
> The Energy Model supports power values expressed in an abstract scale.
> This has an impact on Intelligent Power Allocation (IPA) and should be
> documented properly. Kernel sub-systems like EAS, IPA and DTPM
> (new comming PowerCap framework) would use the new flag to capture
> potential miss-configuration where the devices have registered different
> power scales, thus cannot operate together.
> 
> There was a discussion below v2 of this patch series, which might help
> you to get context of these changes [2].
> 
> The agreed approach is to have the DT as a source of power values expressed
> always in milli-Watts and the only way to submit with abstract scale values
> is via the em_dev_register_perf_domain() API.
> 
> Changes:
> v4:
> - change bool to int type for 'miliwatts' in struct em_perf_domain
>    (suggested by Quentin)
> - removed one sentence from patch 2/4 in IPA doc power_allocator.rst
>    (suggested by Quentin)
> - added reviewed-by from Quentin to 1/4, 3/4, 4/4 patches

There was no major objections in the v3 and this v4 just addressed
minor comments. The important discussions mostly happen in v2.

Could you take the patches via your tree, please?

Regards,
Lukasz
