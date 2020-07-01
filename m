Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45B221107F
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 18:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgGAQWs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 12:22:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58704 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgGAQWs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 12:22:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061GMjUM026001;
        Wed, 1 Jul 2020 11:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593620565;
        bh=7gTUJwCevpEPSamm9O3eV5tThyMcvRU8VEBQ02ydttY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rUfumGk22q4LJJruNeHZHX95aTgm+n1kGzB8C26aLRjrgy5mZOfv7aozyBA4P9Vfs
         V+DxIWbwdkwQ8NbSG1RzrBxFEq3cwOY6wuRJPlAzSQAgS31IOWLj/Zg3bphYn6ZqSR
         9m5gMGJUqXJmhAg7hkJyx8xbdketr6774Itubnf4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 061GMiKo068018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jul 2020 11:22:45 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 11:22:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 11:22:44 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061GMhWO068161;
        Wed, 1 Jul 2020 11:22:43 -0500
Subject: Re: [PATCH v14 2/4] dt-bindings: power: Convert battery.txt to
 battery.yaml
To:     Joe Perches <joe@perches.com>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>, <sre@kernel.org>,
        <pali@kernel.org>, <robh@kernel.org>
CC:     <afd@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <sspatil@android.com>
References: <20200630215426.26450-1-r-rivera-matos@ti.com>
 <20200630215426.26450-3-r-rivera-matos@ti.com>
 <e0bc6b4fa54612a09f1f05a779b8d506d9e0ac2f.camel@perches.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <98a64a36-2c27-0e49-ce97-66a135c0c185@ti.com>
Date:   Wed, 1 Jul 2020 11:22:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e0bc6b4fa54612a09f1f05a779b8d506d9e0ac2f.camel@perches.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Joe

On 6/30/20 5:32 PM, Joe Perches wrote:
> On Tue, 2020-06-30 at 16:54 -0500, Ricardo Rivera-Matos wrote:
>> bindings/power/supply/battery.txt
> Do any of these also need updating?
>
> Documentation/devicetree/bindings/power/supply/bq24190.txt:  See also Documentation/devicetree/bindings/power/supply/battery.txt
> Documentation/devicetree/bindings/power/supply/bq27xxx.yaml:       See Documentation/devicetree/bindings/power/supply/battery.txt
> Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml:#   See also Documentation/devicetree/bindings/power/supply/battery.txt
> Documentation/devicetree/bindings/power/supply/sc2731_charger.txt:  See Documentation/devicetree/bindings/power/supply/battery.txt
> Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt:  See Documentation/devicetree/bindings/power/supply/battery.txt
> Documentation/power/power_supply_class.rst:Documentation/devicetree/bindings/power/supply/battery.txt. This is
>
Not really.  The verbiage in the battery.txt redirects to the battery.yaml

Maybe after the conversion is accepted then these can be updated when 
touched.


Dan

