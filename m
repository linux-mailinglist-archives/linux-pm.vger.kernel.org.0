Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580A029D3DC
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 22:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbgJ1Vr0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 17:47:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44178 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbgJ1VrY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 17:47:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09SLlENC060082;
        Wed, 28 Oct 2020 16:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603921634;
        bh=h/7TUYm8pFIf/Hkg1xDYYuruG/43UdD7rQyzE5uDz/A=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aLtikgMJOgSPhqZxbEHAf+kYRnkEu7pygc+1fCOpenlJBmN2tgMVFbEqbhcCQ4tpn
         Fr/rdbL/7Uv08tuHOIIenom/F3fpSlSGXl4mMiz5p6BbG/c/mnFGGOIkxwEltYT4E3
         Vy9Ie6vXSsWSK/4J6w6P5nTPTPZdEQl1W0UySJV4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09SLlEvE124545
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 16:47:14 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 28
 Oct 2020 16:47:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 28 Oct 2020 16:47:14 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09SLlD3k115294;
        Wed, 28 Oct 2020 16:47:13 -0500
Date:   Wed, 28 Oct 2020 16:47:13 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vireshk@kernel.org>,
        <robh+dt@kernel.org>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <sudeep.holla@arm.com>, <daniel.lezcano@linaro.org>,
        <Dietmar.Eggemann@arm.com>
Subject: Re: [PATCH 1/4] dt-bindings: opp: Introduce opp-sustainable bindings
Message-ID: <20201028214713.zttk47qtua5jhieo@pureness>
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201028140847.1018-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201028140847.1018-2-lukasz.luba@arm.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14:08-20201028, Lukasz Luba wrote:
> Add opp-sustainable as an additional property in the OPP node to describe
> the sustainable performance level of the device. This will help to
> estimate the sustainable performance of the whole system.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 9847dfeeffcb..cd01028de305 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -154,6 +154,10 @@ Optional properties:
>  - opp-suspend: Marks the OPP to be used during device suspend. If multiple OPPs
>    in the table have this, the OPP with highest opp-hz will be used.
>  
> +- opp-sustainable: Marks the OPP as sustainable. This property can be used for
> +  estimating sustainable performance of the whole system. If multiple OPPs in
> +  the table have this, the OPP with highest opp-hz will be used.


By "sustainable", do you mean sustainable across Process, Voltage and
Temperature corners upto the max rated operational Power-ON hours
without IDLE state being achieved on the processor?

OR do you mean to leave it up to interpretation?
> +
>  - opp-supported-hw: This property allows a platform to enable only a subset of
>    the OPPs from the larger set present in the OPP table, based on the current
>    version of the hardware (already known to the operating system).
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
