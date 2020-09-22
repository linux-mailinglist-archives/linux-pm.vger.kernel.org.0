Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B525274628
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 18:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgIVQGt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 12:06:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57482 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbgIVQGt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 12:06:49 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08MG6lRI009009;
        Tue, 22 Sep 2020 11:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600790807;
        bh=fwBnnCBR4CpbSsAk4csWJ8DO1oh/xfiCJORpRbHF5ME=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RhvMSrGk8zDJ3oauz5zfJZm27loeElvKV854kHOBw5jlTC3c/HGFG5nbx3D2KDr1o
         dk2mYBBFH+W4lTPjL0OrXhwIbDkU4DgKKHWq+tW4/ycPV4M1yGAve4aPpipmlE5haC
         ID8qOVJ9OLKzxOUQDj3qeSewFM+KfY9XSY65P6gw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08MG6lmV027815
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 11:06:47 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Sep 2020 11:06:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Sep 2020 11:06:47 -0500
Received: from [10.250.71.177] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08MG6k0f070715;
        Tue, 22 Sep 2020 11:06:46 -0500
Subject: Re: [PATCH 2/2] power: bq25980: Add support for the BQ259xx family
To:     <sre@kernel.org>, <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <r-rivera-matos@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200831164849.31313-1-dmurphy@ti.com>
 <20200831164849.31313-2-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <699bf615-0f08-2d9b-8e47-25e2604f82ad@ti.com>
Date:   Tue, 22 Sep 2020 11:06:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831164849.31313-2-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello

On 8/31/20 11:48 AM, Dan Murphy wrote:
> Add support for the BQ25980, BQ25975 and BQ25960 family of flash
> chargers.

Gentle Bump


