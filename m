Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F179274625
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 18:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgIVQGT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 12:06:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57300 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIVQGT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 12:06:19 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08MG6Hhp008709;
        Tue, 22 Sep 2020 11:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600790777;
        bh=qOqYAeqS4BzRHTWSyUFnOQnw+Px2O+bmnnmcnnYt9IM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KXcFpyCrGGSufriJfqiv6ATmBAxuidi3j6fH98jQlKIZA6EXOR022Z+d7rYyeO+C6
         9g6gS/UEcPwq1mtafRm82H/yRnC3QZ1SnAo3sLq+BxvDwFGcJc8cU851EwPX0LMTGz
         TIOmycCQt7S4yjr8GLfNa1NTkoT6M0c8jeFYdlL4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08MG6Hf5089351
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 11:06:17 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Sep 2020 11:06:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Sep 2020 11:06:17 -0500
Received: from [10.250.71.177] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08MG6GJA070402;
        Tue, 22 Sep 2020 11:06:16 -0500
Subject: Re: [PATCH v2 2/2] power: supply: bq25790: Introduce the BQ25790
 charger driver
To:     <sre@kernel.org>, <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <r-rivera-matos@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200817151629.11019-1-dmurphy@ti.com>
 <20200817151629.11019-2-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <64928603-9b3e-cc69-c630-b13d96c37a8d@ti.com>
Date:   Tue, 22 Sep 2020 11:06:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817151629.11019-2-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello

On 8/17/20 10:16 AM, Dan Murphy wrote:
> BQ25790 is a highly integrated switch-mode buck-boost charger
> for 1-4 cell Li-ion battery and Li-polymer battery.
Gentle bump
