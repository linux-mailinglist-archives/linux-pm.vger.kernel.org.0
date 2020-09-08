Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8645262183
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 22:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgIHUy2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 16:54:28 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55778 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIHUy2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 16:54:28 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088KsQs8107270;
        Tue, 8 Sep 2020 15:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599598466;
        bh=E+9QQ1DscF13tPkWOq65brrJgmxAQwKmqNygQNuWZ/c=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=QhUQEaQePJl8Cw2nDK49nFeiH2sQmJRJL4lMhm/bobWMHZin3GbNtTSNn3UCTr2gf
         oliyLXD0KvuR/ezNitAOkL3A3rCcirmlDvTSm8N774Kj86AnkREdYs7Lc+dowb7ttp
         T+G24QFvgx+npn0ViuUI6PB0ThbsRHQpn7GUB3cY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 088KsQND031826
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Sep 2020 15:54:26 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 15:54:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 15:54:26 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088KsQmm046976;
        Tue, 8 Sep 2020 15:54:26 -0500
Subject: Re: [PATCH 2/7] power: supply: bq27xxx: report "not charging" on all
 types
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200908201319.3567-1-krzk@kernel.org>
 <20200908201319.3567-2-krzk@kernel.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <33361ba9-51df-3b09-6744-9806cdf166db@ti.com>
Date:   Tue, 8 Sep 2020 15:54:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908201319.3567-2-krzk@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Krzysztof

On 9/8/20 3:13 PM, Krzysztof Kozlowski wrote:
> Commit 6f24ff97e323 ("power: supply: bq27xxx_battery: Add the
> BQ27Z561 Battery monitor") and commit d74534c27775 ("power:
> bq27xxx_battery: Add support for additional bq27xxx family devices")
> added support for new device types by copying most of the code and
> adding necessary quirks.
>
> However they did not copy the code in bq27xxx_battery_status()
> responsible for returning POWER_SUPPLY_STATUS_NOT_CHARGING.
>
> Unify the bq27xxx_battery_status() so for all types when charger is
> supplied, it will return "not charging" status.

If this is a fix then please populate the Fixes tag.

But not sure how both commits are tied here

Dan


