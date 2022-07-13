Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15740573E46
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jul 2022 22:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbiGMUyD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jul 2022 16:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbiGMUx6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2022 16:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12C9FFD12
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2022 13:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657745636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7w7ot88ijPbnC1AT4LUHy9diGggomsBqgUbIEyfXDts=;
        b=jWHXL3SdocT+ug47QGKOJKB+ajseToLpB0xFrV5jGdA+4Xo1qrsT1OxZwtOv0MqJRtJIVK
        uCx3nZ+9p3MD8rfBwY1yGyseEVDtPDh7qvDmLG2dksEgwqScVautsInlSZZUcf5o3RBnwp
        W3G+OoUhVlw1I/EMSvRvoUYUtpgqPig=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-BZAW553dNQ26dOuOBuV79A-1; Wed, 13 Jul 2022 16:53:54 -0400
X-MC-Unique: BZAW553dNQ26dOuOBuV79A-1
Received: by mail-ed1-f71.google.com with SMTP id h17-20020a056402281100b0043aa5c0493dso9184890ede.16
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2022 13:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7w7ot88ijPbnC1AT4LUHy9diGggomsBqgUbIEyfXDts=;
        b=TGk5vRSbfXfheYhCXRwhBG72ppII3gUVbKeUWl6nVJKeNoSvvMUrmNQme700iZc3+8
         5BpjqcVqNRiBVW3s5LwSLafiPFeRto40eDk5NNgrKQUwFkIsQDe5l7OQBHGKndkmt4li
         weoFDzDaOJJhEcXgJnaVdRj570nrL6qIwl/8ISJAy6LbgR67F1ioRZEQH3Zg8OjECdy4
         44rKCATs927W8IB91Ui4Nj/Mz1EoxkLHzAvvKYXG2mMsqougz2ZEs/tSo5OYxj8rXrF5
         dnp2f8jyDbvI4gOsgp2cSIdBttARGi9lqVIVSzaBqJDkCt/PI4YCmpZttq/4tja0V/Ze
         o+4Q==
X-Gm-Message-State: AJIora+ZYOBZcwt/G4P7ms6lIvFbS8MS/PjbPxqjD9iilraAbnNzbJ6b
        8gYv1bg6SzeYcmh/ja2nebDqGsJux9l59EqX8ZanPhVn4TT5oIRAK8So54PacTrlq++r1V3xbez
        E2imJFJTTClSKm+2c88w=
X-Received: by 2002:a05:6402:3708:b0:433:2d3b:ed5 with SMTP id ek8-20020a056402370800b004332d3b0ed5mr7479257edb.246.1657745633674;
        Wed, 13 Jul 2022 13:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vlR6EbNyJesEQMqku98sgLM5hgx+Yvs+X+nBn4vuLAei8AgslBbSskvA81sVT/7Kgffh06BA==
X-Received: by 2002:a05:6402:3708:b0:433:2d3b:ed5 with SMTP id ek8-20020a056402370800b004332d3b0ed5mr7479238edb.246.1657745633446;
        Wed, 13 Jul 2022 13:53:53 -0700 (PDT)
Received: from redhat.com ([2.52.24.42])
        by smtp.gmail.com with ESMTPSA id s17-20020a056402037100b00437938c731fsm8578946edw.97.2022.07.13.13.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 13:53:52 -0700 (PDT)
Date:   Wed, 13 Jul 2022 16:53:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dapeng Mi <dapeng1.mi@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpuidle: Move cpuidle driver forward before acpi driver
 in Makefile
Message-ID: <20220713165237-mutt-send-email-mst@kernel.org>
References: <20220713082426.850911-1-dapeng1.mi@intel.com>
 <CAJZ5v0gsHPav5Ax6+9OMmeApqn7qdJPQmo5MMh=ba6Rtj5NnQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gsHPav5Ax6+9OMmeApqn7qdJPQmo5MMh=ba6Rtj5NnQA@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 13, 2022 at 07:53:13PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 13, 2022 at 10:21 AM Dapeng Mi <dapeng1.mi@intel.com> wrote:
> >
> > As long as Kconfig ACPI_PROCESSOR is enabled, ACPI_PROCESSOR would
> > select ACPI_PROCESSOR_IDLE and acpi_idle driver is enabled. But
> > in current driver loading order acpi_idle driver is always loaded
> > before cpuidle_haltpoll driver. This leads to cpuidle_hatpoll driver
> > has no chance to be loaded when it's enabled.
> >
> > Thus, move cpuidle driver forward before acpi driver and make
> > cpuidle-hatpoll driver has a chance to be run when it's enabled.
> >
> > Signed-off-by: Dapeng Mi <dapeng1.mi@intel.com>
> > ---
> >  drivers/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 9a30842b22c5..921ed481b520 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -26,6 +26,7 @@ obj-y                         += idle/
> >  # IPMI must come before ACPI in order to provide IPMI opregion support
> >  obj-y                          += char/ipmi/
> >
> > +obj-$(CONFIG_CPU_IDLE)         += cpuidle/
> >  obj-$(CONFIG_ACPI)             += acpi/
> >
> >  # PnP must come after ACPI since it will eventually need to check if acpi
> > @@ -126,7 +127,6 @@ obj-$(CONFIG_EDAC)          += edac/
> >  obj-$(CONFIG_EISA)             += eisa/
> >  obj-$(CONFIG_PM_OPP)           += opp/
> >  obj-$(CONFIG_CPU_FREQ)         += cpufreq/
> > -obj-$(CONFIG_CPU_IDLE)         += cpuidle/
> >  obj-y                          += mmc/
> >  obj-y                          += ufs/
> >  obj-$(CONFIG_MEMSTICK)         += memstick/
> > --
> 
> Well, this change doesn't guarantee loading haltpoll before ACPI idle.
> 
> Also what if haltpoll is enabled, but the user wants ACPI idle?

Exactly. For example while on real boxes BIOS might often present broken
ACPI idle, on VMs I am guessing if ACPI is present one can assume it's
actually correct.

-- 
MST

