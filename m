Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0CC31CD01
	for <lists+linux-pm@lfdr.de>; Tue, 16 Feb 2021 16:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBPPcO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Feb 2021 10:32:14 -0500
Received: from mail.manjaro.org ([176.9.38.148]:39548 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhBPPbv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Feb 2021 10:31:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id ECEBC183325;
        Tue, 16 Feb 2021 16:30:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id baaH7EfB4n54; Tue, 16 Feb 2021 16:30:57 +0100 (CET)
To:     Martin Ashby <martin@ashbysoft.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
References: <20210126213928.136561-1-martin@ashbysoft.com>
 <10574fda-0a3b-a762-7795-f1fb609b0dde@manjaro.org>
From:   Tobias Schramm <t.schramm@manjaro.org>
Subject: Re: [PATCH] Add CHARGE_NOW support to cw2015_battery.c
Message-ID: <322db883-b25d-4f89-c7f9-b0df0407ad44@manjaro.org>
Date:   Tue, 16 Feb 2021 16:30:50 +0100
MIME-Version: 1.0
In-Reply-To: <10574fda-0a3b-a762-7795-f1fb609b0dde@manjaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Martin,

> 
> thanks for the patch. Looks good and tests fine.
> 
eh, scratch that. Didn't have my cup of morning coffee yet. The patch is 
fine as far as the code change goes. However it is missing a 
"Signed-off-by" line, certifying your authorship. git can generate that 
automagically for you with `git commit --signoff`.

>> CHARGE_NOW is expected by some user software (such as waybar)
>> instead of 'CAPACITY', in order to correctly calculate
>> remaining battery life.
>>
There needs to be a "Signed-off-by" line right here.
>> ---
>>   drivers/power/supply/cw2015_battery.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
[ ... ]
> 
> Reviewed-by: Tobias Schramm <t.schramm@manjaro.org>
Review retracted.

Please resend the patch with the "Signed-off-by" line included. Then I 
can mark it as reviewed.


Sorry for the confusion,

Tobias Schramm
