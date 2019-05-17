Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6C21700
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 12:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfEQKhK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 06:37:10 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:35478 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfEQKhK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 May 2019 06:37:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 3298220250;
        Fri, 17 May 2019 12:37:08 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yx2B3fPUquiJ; Fri, 17 May 2019 12:37:07 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id B5D2F20096;
        Fri, 17 May 2019 12:37:07 +0200 (CEST)
Received: from [10.182.6.138] (10.182.6.138) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 17 May
 2019 12:37:07 +0200
From:   Dennis Wassenberg <dennis.wassenberg@secunet.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dennis.wassenberg@secunet.com; keydata=
 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
 YPsSSSBN/R6Xmw==
Organization: secunet Security Networks AG
To:     Kernel development list <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Question regarding intel_pstate in case of disabled smt
Message-ID: <8d859cb0-0646-4f52-b060-3816d689aade@secunet.com>
Date:   Fri, 17 May 2019 12:24:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: BB456798-2C16-4525-8065-8F28594D0268
X-G-Data-MailSecurity-for-Exchange-ProcessedOnRouted: True
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

I would like to ask a question regarding cpu frequency scaling / cpu performance using intel_pstate with activated HWP.
I think the special CPU doesn't matter. I checked it with i7-8550U and i7-8565U. Currently I am not sure if this is a
bug. Thats why I am asking...

Using intel_pstate default settings (min_perf_pct=10, max_perf_pct=100, no_turbo=0) everything behaves as expected. If I
change max_perf_pct and/or no_turbo i can observe that the cpu frequency doesn't increase that much compared to the
default settings under load.

But if I disable smt, the settings of the pstate driver does not seem to change anything. If I set no_turbo and/or
max_perf_pct to a lower value than 100 I can not notice that there is a change at the cpu frequency scaling. For
example: If I set min_perf_pct=max_perf_pct=5 the cpu frequency of the 4 online cpus will be above 4 GHz in case of smt
is disabled. If smt is enabled the cpu frequency of the 8 cpus is 400 MHz. The same occurred if I disable turbo by
setting no_turbo to 1. If smt is disbaled the frequency will be above 4 GHz in load situations. If smt is enabled the
cpu frequency is 1,80 GHz.

If I use intel_pstate with disabled HWP it behaves the same if smt is enabled or disabled. So, it makes no difference if
smt is enabled or disabled . The cpu frequency will adapt exactly to the configured settings.

So, is this intended that HWP does not consider the pstate settings if smt is disabled?

Thank you & best regards,

Dennis
