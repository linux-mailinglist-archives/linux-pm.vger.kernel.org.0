Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B181E3003
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 22:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391248AbgEZUaj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 16:30:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50744 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389853AbgEZUaj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 16:30:39 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04QKUbYM016821;
        Tue, 26 May 2020 15:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590525037;
        bh=bUtjmq+vCeN+yyZ2frxjxBtWg3uF+0uE+Hea46w07Yw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mPNejwfIOp7a+O2GHD1Br/NCn66lBhYoz0ZOF/ujiLp+TUMqIDOrZMwRbGfOLMUkK
         E6h3M9hWpDr1CrmRZIkBIL1IclGbQf2tp8m+U+06oEz2O1Ovqpdt8djIDxvixmnCFq
         alg0fADluDVxW5DNsg5bfDsdr4QC58e5kZMLPuJ0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04QKUb4K042829;
        Tue, 26 May 2020 15:30:37 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 26
 May 2020 15:30:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 26 May 2020 15:30:37 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04QKUatA000933;
        Tue, 26 May 2020 15:30:36 -0500
Subject: Re: [PATCH 1/2] dt-bindings: power: Add BQ27561 compatible
To:     <sre@kernel.org>, <afd@ti.com>, <pali@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200515174454.21866-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <2d2a8c1f-8030-20d4-c16a-3bd0965166d3@ti.com>
Date:   Tue, 26 May 2020 15:30:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515174454.21866-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Bump to series

On 5/15/20 12:44 PM, Dan Murphy wrote:
> Add the Texas Instruments bq27561 battery monitor to the bq27xxx
> binding.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> This patch has a dependency on the yaml conversion - https://lore.kernel.org/patchwork/patch/1240876/
>
>   Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> index 03d1020a2e47..51cb1f685dcf 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> @@ -49,6 +49,7 @@ properties:
>         - ti,bq27426
>         - ti,bq27441
>         - ti,bq27621
> +      - ti,bq27561
>   
>     reg:
>       maxItems: 1
