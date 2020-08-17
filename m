Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04698246DE1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 19:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389619AbgHQRRa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 13:17:30 -0400
Received: from foss.arm.com ([217.140.110.172]:57932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389620AbgHQRRV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Aug 2020 13:17:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34E0631B;
        Mon, 17 Aug 2020 10:17:11 -0700 (PDT)
Received: from [10.37.12.68] (unknown [10.37.12.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35A973F66B;
        Mon, 17 Aug 2020 10:17:08 -0700 (PDT)
Subject: Re: [PATCH 2/2] ARM: dts: exynos: Remove interrupts from DMC
 controller in Exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
References: <20200708153420.29484-1-lukasz.luba@arm.com>
 <20200708153420.29484-3-lukasz.luba@arm.com>
 <20200817155021.GC15887@kozik-lap>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <2099aea9-5a63-6e5b-d7f9-4e6476584461@arm.com>
Date:   Mon, 17 Aug 2020 18:17:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200817155021.GC15887@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 8/17/20 4:50 PM, Krzysztof Kozlowski wrote:
> On Wed, Jul 08, 2020 at 04:34:20PM +0100, Lukasz Luba wrote:
>> The interrupts in Dynamic Memory Controller in Exynos5422 and Odroid
>> XU3-family boards are no longer needed. They have been used in order
>> to workaround some issues in scheduled work in devfreq. Now when the
>> devfreq framework design is improved, remove the interrupt driven
>> approach and rely on devfreq monitoring mechanism with fixed intervals.
>>
>> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   arch/arm/boot/dts/exynos5420.dtsi | 3 ---
>>   1 file changed, 3 deletions(-)
> 
> I think the dependencies were merged so this can be safely applied
> without bisectability problems?

I have created v2 of that fix and it got merged
via Chanwoo's tree, the commit 4fc9a0470d2dc37028
https://lkml.org/lkml/2020/7/10/1048

That commit switched the driver default mode from 'irq driven' to
new devfreq monitoring mechanism. Furthermore, when the driver is
built as a module, you can try to use the 'irq mode', but for this
you would need the DT IRQs description (this $subject tries to remove).

I would like to keep this IRQ mode for experimentation, as I
described in answers to Bartek's questions:
https://lkml.org/lkml/2020/7/14/315

Unfortunately, I am quite busy and won't make any progress before the
LPC.

Regards,
Lukasz
