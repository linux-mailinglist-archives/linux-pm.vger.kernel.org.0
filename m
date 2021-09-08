Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07951403747
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 11:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348038AbhIHJxO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 05:53:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57212 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347816AbhIHJxN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Sep 2021 05:53:13 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1889pv8q000578;
        Wed, 8 Sep 2021 04:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631094717;
        bh=ZH8pzkbAkHXLm6quT3qHQ6oWLqH4LVeVk9aPRMmCQSM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FA8IhScYdHAssuDCnjUu8S7SQrNVCMqUOhynqzYR5H3ffQXWLmJ0GrVg8wExs0ykx
         WgAyr93FeWrWOaxPF4RRsizDg/9zt+OYIZUl9iMJSBJEy+eEyD02fTKQnTwd1mOuVF
         9md3XxmEGO83zX5hj5Z0doXnL2g/9zsTt7xMmFZw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1889pvdP005838
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Sep 2021 04:51:57 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 8
 Sep 2021 04:51:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 8 Sep 2021 04:51:57 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1889psYj068724;
        Wed, 8 Sep 2021 04:51:55 -0500
Subject: Re: [PATCH 1/3] soc: ti: k3-ringacc: Make use of the helper function
 devm_platform_ioremap_resource_byname()
To:     Cai Huoqing <caihuoqing@baidu.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
References: <20210908071310.432-1-caihuoqing@baidu.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <91d50073-9f23-5e69-6e52-52b11d80071b@ti.com>
Date:   Wed, 8 Sep 2021 12:51:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908071310.432-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 08/09/2021 10:13, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>   drivers/soc/ti/k3-ringacc.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)

Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>


-- 
Best regards,
grygorii
