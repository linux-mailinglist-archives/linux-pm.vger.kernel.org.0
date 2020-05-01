Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF281C1C8B
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 20:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgEASDw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 14:03:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49070 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgEASDw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 14:03:52 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 041I3nol035250;
        Fri, 1 May 2020 13:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588356229;
        bh=/f2T/5gGoekOKSGJbuC7wezyx3Dx6eGpqW3pvT7eCDA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KGfQLrW5yPv/O/Fv58gSO4YkgdZw9Q0JTEi9jc3luGH7v15kxrnhF6Hn5t5cH3Unl
         g7DQ1pjP0n0WVZep/LmV7LTDteTMYOW4k2zfbGMhyitxPupdvKBhAZoD4hXw6vlaq9
         I8pXYGjaT3AxLX33VM5lyNJC57UGb/xsxiuiTZIs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 041I3nqZ067883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 May 2020 13:03:49 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 1 May
 2020 13:03:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 1 May 2020 13:03:49 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 041I3nE7003992;
        Fri, 1 May 2020 13:03:49 -0500
Subject: Re: [RESEND PATCH v5 0/3] BQ25150/155 Charger
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200304174025.31655-1-r-rivera-matos@ti.com>
 <eb5f0818-21c7-1b84-b0c9-904bce9721be@ti.com>
 <20200501172445.diiccfzbh7kzkxdl@earth.universe>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <a83b5728-2896-3ec9-00f1-dc611c3aa471@ti.com>
Date:   Fri, 1 May 2020 12:55:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501172445.diiccfzbh7kzkxdl@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 5/1/20 12:24 PM, Sebastian Reichel wrote:
> Hi,
>
> I don't see any PATCHv5 (with or without RESEND) for bq25150 and
> lore does not see anything either:
>
> https://lore.kernel.org/linux-pm/?q=PATCH+v5+0%2F3%5D+BQ25150%2F155+Charger

I posted them for Ricardo.  Maybe he need a lore account.

https://lore.kernel.org/patchwork/project/lkml/list/?series=441577

Not sure why his patches did not go through.

Dan

