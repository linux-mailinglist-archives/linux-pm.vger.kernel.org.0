Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FB21CF3DB
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 13:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgELL4y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 07:56:54 -0400
Received: from foss.arm.com ([217.140.110.172]:53370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgELL4x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 May 2020 07:56:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AEAD30E;
        Tue, 12 May 2020 04:56:53 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECEF53F71E;
        Tue, 12 May 2020 04:56:50 -0700 (PDT)
Subject: Re: [PATCH v2] memory/samsung: reduce unnecessary mutex lock area
To:     Markus Elfring <Markus.Elfring@web.de>,
        Bernard Zhao <bernard@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>
References: <edf839ce-cc61-73dc-e017-b49648b94d1c@web.de>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <c910fa00-c27b-9854-9ab2-6f37c28b87f6@arm.com>
Date:   Tue, 12 May 2020 12:56:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <edf839ce-cc61-73dc-e017-b49648b94d1c@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/12/20 12:40 PM, Markus Elfring wrote:
>> Maybe dmc->df->lock seems not needed to protect "if (ret)
>> & dev_warn" branch. Maybe this change speed up the code a bit.
> 
> I suggest to improve also this commit message.
> 
> * Please reduce uncertainty.
> 
> * An imperative wording is probably preferred, isn't it?
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=152036d1379ffd6985262743dcf6b0f9c75f83a4#n151
> 
> * Will it be more appropriate to refer to the transformation “Reduce the lock scope”?
> 
> * Would you like to add the tag “Fixes” to the change description?
> 
> Regards,
> Markus
> 

Thank you Markus for providing to Bernard helpful suggestions.

@Bernard please read the link above and send v3

Something like: 'memory/samsung: reduce protected code area in IRQ
handler' for the subject header would be better.
Then in the message explain (without 'maybe') that it will speed-up a
bit this IRQ processing and there is no need to protect return value or
printing.

Regards,
Lukasz
