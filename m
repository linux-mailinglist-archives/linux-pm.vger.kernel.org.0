Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7DF1CF4C2
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgELMsa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 08:48:30 -0400
Received: from foss.arm.com ([217.140.110.172]:54386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbgELMs2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 May 2020 08:48:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94D1F30E;
        Tue, 12 May 2020 05:48:27 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83E933F71E;
        Tue, 12 May 2020 05:48:25 -0700 (PDT)
Subject: Re: [v2] memory/samsung: reduce unnecessary mutex lock area
To:     Markus Elfring <Markus.Elfring@web.de>,
        Bernard Zhao <bernard@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>
References: <edf839ce-cc61-73dc-e017-b49648b94d1c@web.de>
 <c910fa00-c27b-9854-9ab2-6f37c28b87f6@arm.com>
 <5a12fa12-f4e0-c941-b22b-33436723b44e@web.de>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <113c5695-5415-03f2-c99a-b394b3118d33@arm.com>
Date:   Tue, 12 May 2020 13:48:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5a12fa12-f4e0-c941-b22b-33436723b44e@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/12/20 1:32 PM, Markus Elfring wrote:
>> Something like: 'memory/samsung: reduce protected code area in IRQ
>> handler' for the subject header would be better.
>> Then in the message explain (without 'maybe') that it will speed-up a
>> bit this IRQ processing and there is no need to protect return value
>> or printing.
> 
> Do you tend to prefer smaller lock scopes for nicer run time characteristics?

Yes and I am probably not the only one. Of course it consumes time, to
make and test this kind of changes (so it must be in my current scope
of work).

Regards,
Lukasz

> 
> Regards,
> Markus
> 
