Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D68A3463D8
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 16:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhCWP4t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 11:56:49 -0400
Received: from foss.arm.com ([217.140.110.172]:48394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232861AbhCWP4W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 11:56:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9780D6E;
        Tue, 23 Mar 2021 08:56:21 -0700 (PDT)
Received: from [10.57.6.111] (unknown [10.57.6.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E155E3F718;
        Tue, 23 Mar 2021 08:56:19 -0700 (PDT)
Subject: Re: [PATCH] powercap/drivers/dtpm: Add dtpm devfreq with energy model
 support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     cwchoi00@gmail.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org
References: <20210319162836.9364-1-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <9a9931f4-ece5-4fe9-5f88-871a2e759200@arm.com>
Date:   Tue, 23 Mar 2021 15:56:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210319162836.9364-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 3/19/21 4:28 PM, Daniel Lezcano wrote:
> Currently the dtpm supports the CPUs via cpufreq and the energy
> model. This change provides the same for the device which supports
> devfreq.
> 
> Each device supporting devfreq and having an energy model can register
> themselves in the list of supported devices.
> 
> The concept is the same as the cpufreq dtpm support: the QoS is used
> to aggregate the requests and the energy model gives the value of the
> instantaneous power consumption ponderated by the load of the device.
> 


I've just started the review, but I have a blocking question:

Why there is no unregister function (like 'dtmp_unregister_devfreq')?
Do you consider any devfreq drivers to be modules?

The code looks like an API that it's going to be called directly in
e.g. GPU driver in it's probe function. In that case probably the
module unloading should call dtmp unregister.

Could you explain this to me please? So I can continue the review.

Regards,
Lukasz
