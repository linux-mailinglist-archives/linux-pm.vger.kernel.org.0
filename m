Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7C821B9C7
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 17:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgGJPpa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 11:45:30 -0400
Received: from foss.arm.com ([217.140.110.172]:53414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgGJPpa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 11:45:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EA7C1FB;
        Fri, 10 Jul 2020 08:45:29 -0700 (PDT)
Received: from [10.37.12.58] (unknown [10.37.12.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BBB63F8F8;
        Fri, 10 Jul 2020 08:45:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] memory: samsung: exynos5422-dmc: Adjust polling
 interval and uptreshold
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, s.nawrocki@samsung.com, kgene@kernel.org
References: <20200708153420.29484-1-lukasz.luba@arm.com>
 <CGME20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501@epcas1p4.samsung.com>
 <20200708153420.29484-2-lukasz.luba@arm.com>
 <fa3f651a-3c2b-188b-e2dc-4fd05ce4a1b7@samsung.com>
 <a676fc18-6f1f-8502-e8d5-5ad1ccf0eec6@arm.com>
 <c016e256-65a6-8075-d88d-c3fad4815b4d@samsung.com>
 <20200710131921.GA23039@pi3> <4bfa227e-3a6b-dfe2-140b-b402dea52231@arm.com>
 <20200710144947.GB23140@pi3>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <df121ab9-a84e-41ac-057a-e7e9d0cbab48@arm.com>
Date:   Fri, 10 Jul 2020 16:45:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200710144947.GB23140@pi3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/10/20 3:49 PM, Krzysztof Kozlowski wrote:
> On Fri, Jul 10, 2020 at 02:41:28PM +0100, Lukasz Luba wrote:
>>
>>
>> On 7/10/20 2:19 PM, Krzysztof Kozlowski wrote:
>>> On Fri, Jul 10, 2020 at 03:13:18PM +0200, Marek Szyprowski wrote:
>   > In such case, maybe as you said, let's switch to polling mode
>>> unconditionally?
>>
>> I can make happen that the polling mode will be unconditionally
>> set as default.
>>
>> Do you think that the interrupt mode code can still stay in the
>> driver, because maybe in future could be fixed?
> 
> How interrupt mode would exist in such case? Or rather: how would it be
> used? There is no point to keep dead code and code once removed, can be
> easily brought back.

I can make a module param i.e. irq-mode=1, while in default where
the user don't provide param, we use polling mode. Then I don't have to
remove DT interrupts and the related code from the driver.

Regards,
Lukasz
