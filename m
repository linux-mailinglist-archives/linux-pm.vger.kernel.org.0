Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A691C1C9D
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 20:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgEASJQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 14:09:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34270 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbgEASJQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 14:09:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 041I9EmU044486;
        Fri, 1 May 2020 13:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588356554;
        bh=/fJ9cUbckunoyP/q6SgWpllpclV8rGM29oEsu3Qpm7U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cqgnEPosxzRpln2RxdwTjQBwAWVjM0Fg457BilvJuB3FQM6LajOH1qKdCh8nAV6Cl
         3FMYc13lYCryQVdneIN3X5AE/OOn/zM0E2K8DtDHU12flwnCqkfjyCHIOKLUwsZ8Nz
         wPXZzBUqq+mDyQg5nih/5TjtKKpnzHJToWh96WHA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 041I9EM2052767;
        Fri, 1 May 2020 13:09:14 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 1 May
 2020 13:09:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 1 May 2020 13:09:13 -0500
Received: from [10.250.79.122] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 041I9D64086046;
        Fri, 1 May 2020 13:09:13 -0500
Subject: Re: [RESEND PATCH v5 0/3] BQ25150/155 Charger
To:     Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200304174025.31655-1-r-rivera-matos@ti.com>
 <eb5f0818-21c7-1b84-b0c9-904bce9721be@ti.com>
 <20200501172445.diiccfzbh7kzkxdl@earth.universe>
 <a83b5728-2896-3ec9-00f1-dc611c3aa471@ti.com>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <5e50e9f1-9f5f-cc0b-8df5-fbc7dc09e0cf@ti.com>
Date:   Fri, 1 May 2020 13:09:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a83b5728-2896-3ec9-00f1-dc611c3aa471@ti.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 5/1/20 12:55 PM, Dan Murphy wrote:
> Sebastian
>
> On 5/1/20 12:24 PM, Sebastian Reichel wrote:
>> Hi,
>>
>> I don't see any PATCHv5 (with or without RESEND) for bq25150 and
>> lore does not see anything either:
>>
>> https://lore.kernel.org/linux-pm/?q=PATCH+v5+0%2F3%5D+BQ25150%2F155+Charger 
>>
>
> I posted them for Ricardo.  Maybe he need a lore account.

That is most likely the issue. Sorry for the confusion, all. I am 
setting one up now.
>
> https://lore.kernel.org/patchwork/project/lkml/list/?series=441577
>
> Not sure why his patches did not go through.
>
> Dan
>
