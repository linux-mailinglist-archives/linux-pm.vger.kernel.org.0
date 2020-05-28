Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D6F1E5EB8
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 13:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbgE1Lwg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 07:52:36 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40512 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388480AbgE1Lwg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 07:52:36 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04SBqTh7100508;
        Thu, 28 May 2020 06:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590666749;
        bh=+Bl/RgqFM80J5ZPxiQ9jUxFBvVC4VpLXi511omtcn3U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bb8WmApxzG6vG8QWEBhIvTtt20Gs72sNdWPocwxNIkWhoTUb+Zw1pC/nZN1AlBOlz
         QK48sWREInt5+9B/PEwAnqRscb419BF53gLm+Z01uW+EFuZPHPSYfaPnTpC/YRwcVr
         DQ0Rx7rk9xj9yel/wyLldirvfobixrgdeGcUn8U8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04SBqTYK069626
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 06:52:29 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 May 2020 06:52:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 May 2020 06:52:29 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04SBqRbW095499;
        Thu, 28 May 2020 06:52:28 -0500
Subject: Re: [PATCH v10 1/4] power_supply: Add additional health properties to
 the header
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>, <sre@kernel.org>,
        <pali@kernel.org>, <robh@kernel.org>
CC:     <afd@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <sspatil@android.com>, Guru Das Srinagesh <gurus@codeaurora.org>
References: <20200527231743.18066-1-r-rivera-matos@ti.com>
 <20200527231743.18066-2-r-rivera-matos@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e7474766-f424-4fec-2310-76a29233980d@ti.com>
Date:   Thu, 28 May 2020 06:52:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527231743.18066-2-r-rivera-matos@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebasitan

On 5/27/20 6:17 PM, Ricardo Rivera-Matos wrote:
> From: Dan Murphy <dmurphy@ti.com>
>
> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
>
> HEALTH_WARM, HEALTH_COOL, and HEALTH_HOT properties are taken from the JEITA spec.
>
> Tested-by: Guru Das Srinagesh <gurus@codeaurora.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

What is the possibility of getting this patch applied for 5.8?

We have a few devices in back log waiting to be posted for review but 
they all depend on this header to be available as they use the new 
properties.

Dan

