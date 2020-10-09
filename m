Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F1628880E
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 13:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbgJILtb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 07:49:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36082 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732520AbgJILtb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2020 07:49:31 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 099BnRhc064285;
        Fri, 9 Oct 2020 06:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602244167;
        bh=Oe5D3SKMrXUM4HIPvwGyg+OfHl4fD87Z+41Z7rnESFw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bX0OskGqgdRGcttvsr94RpWHJ8syCtHrg5AvNL8XbwYTFtLHUz5tWVmZp/aJjXaIP
         N+nY7mPR1oouEjJzl9J4ZjQwY+tsiHLYrhqyKeKEYcW0uQJjbn6cWQ3A6hcdy4LuMI
         U63jEBgi4Q4+XIeyuyJpGWZtsdug+qi95XeE+L+0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 099BnR97105210
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Oct 2020 06:49:27 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 9 Oct
 2020 06:49:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 9 Oct 2020 06:49:27 -0500
Received: from [10.250.67.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 099BnRag130703;
        Fri, 9 Oct 2020 06:49:27 -0500
Subject: Re: power: supply: bq25980: Add support for the BQ259xx family
To:     Sebastian Reichel <sre@kernel.org>
CC:     Colin Ian King <colin.king@canonical.com>,
        <linux-pm@vger.kernel.org>
References: <af1a1044-5f45-ecaf-244e-90650f17ff17@canonical.com>
 <20201008220431.kv4kwh3vz5zkfdp4@earth.universe>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <b025bfdb-a715-1689-c102-5e294df9e9a2@ti.com>
Date:   Fri, 9 Oct 2020 06:49:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008220431.kv4kwh3vz5zkfdp4@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 10/8/20 5:04 PM, Sebastian Reichel wrote:
> Hi Dan,
>
> Can you please look into this:

I have a patch for the over run and this patch should also fix the 
sparse warning just need to finish testing it I should be posting it today

Dan


