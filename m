Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECA06E2A21
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 20:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDNSeG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDNSeG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 14:34:06 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096C7559E
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2023 11:34:02 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33EIXpFT122403;
        Fri, 14 Apr 2023 13:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681497231;
        bh=BD0CkY50IwBlYl+17boio/pHeWfDSupSaMF58t3hwwo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=H1fsvPkxy5YRfVxd+Q33i/bxafE6+BNRgFmHiBboQzG/IMXs5pnDFNI30M7bBWSXt
         p80CffdXNeA8n+cbg48hkl8iKaEyUihI0/DDB49o2nHUS6p7c6YWBNpuVV1vN//CDH
         jzhEv/zRZybIxkHbOvTQTyZ4M1YKsdpbIenoReJM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33EIXpDR009924
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 13:33:51 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 13:33:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 13:33:50 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33EIXo55061195;
        Fri, 14 Apr 2023 13:33:50 -0500
Date:   Fri, 14 Apr 2023 13:33:50 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] soc: ti: smartreflex: Simplify getting the opam_sr
 pointer
Message-ID: <20230414183350.mdvl2gcf6vaere2w@coleslaw>
References: <20221012140032.113363-1-u.kleine-koenig@pengutronix.de>
 <20230412142539.brqexyi5kpac5ltr@pengutronix.de>
 <cb3e16f0-cdef-42da-8761-8e729578e108@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb3e16f0-cdef-42da-8761-8e729578e108@app.fastmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18:04-20230414, Arnd Bergmann wrote:
> On Wed, Apr 12, 2023, at 16:25, Uwe Kleine-König wrote:
> > Hello,
> >
> > [Cc += Tony Lindgren + Arnd Bergmann who did care about the last change
> > to this driver]
> >
> > On Wed, Oct 12, 2022 at 04:00:32PM +0200, Uwe Kleine-König wrote:
> >> The probe function stores the sr_info pointer using
> >> platform_set_drvdata(). Use the corresponding platform_get_drvdata() to
> >> retrieve that pointer in the remove and shutdown functions.
> >> 
> >> This simplifies these functions and makes error handling unnecessary.
> >> This is a good thing as at least for .remove() returning an error code
> >> doesn't have the desired effect.
> >> 
> >> This is a preparation for making platform remove callbacks return void.
> >> 
> >> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >
> > This patch still applies to v6.3-rc1, but I didn't get any feedback
> > since 6 months now. I need this change to eventually make
> > platform_driver's remove callback return void.
> 
> Applied to the soc/drivers branch for 6.4 now.
> 
>      Arnd

Thanks Arnd, Tony.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
