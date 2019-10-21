Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D906CDF61B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 21:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfJUThR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 15:37:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52432 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbfJUThQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 15:37:16 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9LJbD3k071322;
        Mon, 21 Oct 2019 14:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571686633;
        bh=ekjozCXAw6b8U4H+XTTsLy7p9fWE1plsq41QyKEnJfY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uhu8ADmfMLTbK8Fc1tT/Ngqs+VRtp8rNlCN5Ams4IzB3Y3pFN6889fKrb9CHCyVDf
         R4339oSBJY1z6u9uU3OgV6WYTzyH4+FuXiy3mjP7x6ZwxDYycBN+Wk6G9ZFb5b5GM0
         mxshtNvpLpJjnbP2Lkg2iO7cb0etkQFYkQccJ+NU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9LJawLA051959
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Oct 2019 14:36:58 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 21
 Oct 2019 14:36:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 21 Oct 2019 14:36:57 -0500
Received: from [10.250.35.43] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9LJZuPo077548;
        Mon, 21 Oct 2019 14:35:57 -0500
Subject: Re: [PATCH 1/3] power_supply: Add additional health properties to the
 header
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190930143137.21624-1-dmurphy@ti.com>
 <20191020122510.4llflz7s2kogcdbf@earth.universe>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <b354bd2e-3fd8-eef9-6609-75d09210e745@ti.com>
Date:   Mon, 21 Oct 2019 14:35:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020122510.4llflz7s2kogcdbf@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 10/20/19 7:25 AM, Sebastian Reichel wrote:
> Hi,
>
> On Mon, Sep 30, 2019 at 09:31:35AM -0500, Dan Murphy wrote:
>> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
> You used OVERHEAT instead of HOT in the implementation,
> which makes sense to me, so please drop HOT here. Also
> this needs to be documented in the ABI documentation:

Hmm.  To me OVERHEAT and HOT can mean two different things.  I will 
check the implementation but I would

prefer to use HOT.

If a battery or charger is HOT that may be expected to be within the 
heat limits of the device being monitored but that it is hot.

Overheating means the device is above the expected upper thermal limit.  
Or over the heat limit.

The user may want to take action within the hot range to cool the device 
or may expect the device to run hot without over heating.


> Documentation/ABI/testing/sysfs-class-power

ACK

Dan


