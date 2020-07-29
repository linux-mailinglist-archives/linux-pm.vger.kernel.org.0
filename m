Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB6A23249A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 20:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgG2S17 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 14:27:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52526 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG2S17 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 14:27:59 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06TIRv1V046046;
        Wed, 29 Jul 2020 13:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596047277;
        bh=I2PiX6CkbWhOhjmDXOI5faxrgxNEmlMOLaPY1aH6Qbg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aBe/j86T4+itKZ/sZCRyLq4hjiG+j1ZxavyWMna7GJtjP4WESwZ6FEVgprBVrZQgy
         Y6gHUFyayMETxYIM3wthZBQXkGISL7ubbe0gJeb4inWbhiho0IRLHkH/VBD6sbehVj
         jfADA2sFygV0LL3+GOcaQKfr3NlQIV/Y5p07IDDk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06TIRvOo039759
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 13:27:57 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 29
 Jul 2020 13:27:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 29 Jul 2020 13:27:57 -0500
Received: from [10.250.35.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06TIRvHJ090376;
        Wed, 29 Jul 2020 13:27:57 -0500
Subject: Re: [PATCH v5 2/4] power: supply: bq27xxx_battery: Add the BQ27z561
 Battery monitor
To:     Sebastian Reichel <sre@kernel.org>
CC:     <afd@ti.com>, <pali@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
References: <20200729120609.22427-1-dmurphy@ti.com>
 <20200729120609.22427-2-dmurphy@ti.com>
 <a757fcf1-0215-3926-f74c-22183457be3e@ti.com>
 <20200729165622.jbncn2dqgugrhykx@earth.universe>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <1acd94b4-bf4b-8529-fd22-45005a6db524@ti.com>
Date:   Wed, 29 Jul 2020 13:27:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729165622.jbncn2dqgugrhykx@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 7/29/20 11:56 AM, Sebastian Reichel wrote:
> Hi,
>
> On Wed, Jul 29, 2020 at 10:55:54AM -0500, Dan Murphy wrote:
>>> +<<<<<<< HEAD
>> Need to remove this artifact from a rebase.
>>
>> Not sure how this got here as it does not appear in my source.
> You don't see it in your source, since you removed it in patch 4.

OK I have v6 ready but I noticed a lot of checkpatch issues.

total: 20 errors, 8 warnings, 1923 lines checked

So I will submit v6 and fix the style issues in a follow up patch

Dan


> -- Sebastian
