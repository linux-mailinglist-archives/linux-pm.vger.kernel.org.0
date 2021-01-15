Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FDA2F7D15
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 14:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbhAONs1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 08:48:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58200 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731315AbhAONsZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2021 08:48:25 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10FDkUo0065901;
        Fri, 15 Jan 2021 07:46:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610718390;
        bh=g7HD7ULQS09G7hiJfcw3OafibAomYsnv2U8SQHZGHIc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xW7T/GF7QsCClzw6Zx567sx7J89omJ1Duf/wkPrh2oUf9nfCZLv9UFkW6mM5pMUZc
         4Gp07bB1wrq5d84zq9SZ8yTpA4s+Cvg+kgfX1Y8KFfLA+Ev9MiQz1ouBUlBQTAemBM
         CnbmLEn/Vf5rNrog3hk1xT0Dqu0zrk1Z13jlakio=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10FDkUOt006225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jan 2021 07:46:30 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 15
 Jan 2021 07:46:30 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 15 Jan 2021 07:46:30 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10FDkUpW124791;
        Fri, 15 Jan 2021 07:46:30 -0600
Date:   Fri, 15 Jan 2021 07:46:28 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v11 1/7] dt-bindings: soc: mediatek: add mtk svs
 dt-bindings
Message-ID: <20210115134628.nzayd3kn6wehkirh@enactment>
References: <20210107024356.583-1-roger.lu@mediatek.com>
 <20210107024356.583-2-roger.lu@mediatek.com>
 <20210112144727.GA321805@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210112144727.GA321805@robh.at.kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08:47-20210112, Rob Herring wrote:
> > +
> > +maintainers:
> > +  - Matthias Brugger <matthias.bgg@gmail.com>
> > +  - Kevin Hilman <khilman@kernel.org>
> > +  - Nishanth Menon <nm@ti.com>
> 
> This should be someone that knows the h/w. Not who applies patches. 
> Perhaps you.

Yes please, I would have no idea what to do with SVS patches. Thanks Rob
for catching it.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
