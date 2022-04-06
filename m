Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F364F59FA
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 11:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347171AbiDFJbK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580388AbiDFJUz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2022 05:20:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75500140DFE
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 19:26:44 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id yy13so1435709ejb.2
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 19:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVrhTvL07JA+qLuxrHPB76KlfjN/HKd1U84mtNSDmA0=;
        b=T0BGJvEhCp1XVdquKEt/pKpKuXICocX/83Jn1wmpWHLF+zAcgvEjroM6jN40LltZzX
         eMGubAQqVa1BAfUAJ6zJ44VHTiXyP35A/O3aT2a9JHsAVd9eFDNtGArHLbyUm08Qfrok
         /pQJpFIXc2NeHopH7wDHcDYOA8JpjD92gDXmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVrhTvL07JA+qLuxrHPB76KlfjN/HKd1U84mtNSDmA0=;
        b=pU/03RKbz1tOXHVIXKsE6MFFE0g+os3582zoW/pNPq/gEzj/rjCcY+7o9sGXLHW72s
         KNa29+Eax+MNwwwIiWXjr3+BqUO8V47RhYQs2hRYlk9kLycOKua7X3LMC8m6J2PQfOyc
         3AYi3We+/gUQz5BYqU8z5NDEbOd6pB2cU+X/AwSRFY8r3+u4wXpiR3gRG/OloYk2J6dD
         EJhvRhL2ckypKYkT3e/2lS0gAf0u3REXQo2XoMsrwMnO4lmy1CljSenWp8OuhRnh0mKt
         H4BFtvyZtgRT5FTTsEgEi5r2dEVX4PbEVSe6kHlfJF8EJl4kT7+tpGw18hLTObThTGjP
         UAhg==
X-Gm-Message-State: AOAM532DEtmEbhyvMdzfCCdzlleM8+SWLSzC5ptTX4kxKKgMHfTS1Nbq
        dr73x2yqztW2KKH0S/Ie+ehojew2vBzzVEqRrkg=
X-Google-Smtp-Source: ABdhPJxwaI+6tyok/dibu+sKhHJrHZ62liOwd0VlYhnrFC6o9slb/NwffOs+z6HkAecqKWQPIcyUDg==
X-Received: by 2002:a17:907:868a:b0:6e5:e35f:3b99 with SMTP id qa10-20020a170907868a00b006e5e35f3b99mr6381947ejc.33.1649212002678;
        Tue, 05 Apr 2022 19:26:42 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id mp19-20020a1709071b1300b006dfdfe15cf8sm6201142ejc.196.2022.04.05.19.26.42
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 19:26:42 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id b19so1050187wrh.11
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 19:26:42 -0700 (PDT)
X-Received: by 2002:adf:e591:0:b0:206:1202:214 with SMTP id
 l17-20020adfe591000000b0020612020214mr4789813wrm.342.1649212001620; Tue, 05
 Apr 2022 19:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220406014842.2771799-1-briannorris@chromium.org> <20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid>
In-Reply-To: <20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Apr 2022 19:26:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wdp5ax_MhGg-=ocSPS=cs1nUCRcz+E81Z2V-w_YVuzUw@mail.gmail.com>
Message-ID: <CAD=FV=Wdp5ax_MhGg-=ocSPS=cs1nUCRcz+E81Z2V-w_YVuzUw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] PM / devfreq: rk3399_dmc: Block PMU during transitions
To:     Brian Norris <briannorris@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Apr 5, 2022 at 6:49 PM Brian Norris <briannorris@chromium.org> wrote:
>
> See the previous patch ("soc: rockchip: power-domain: Manage resource
> conflicts with firmware") for a thorough explanation of the conflicts.
> While ARM Trusted Firmware may be modifying memory controller and
> power-domain states, we need to block the kernel's power-domain driver.
>
> If the power-domain driver is disabled, there is no resource conflict
> and this becomes a no-op.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  drivers/devfreq/rk3399_dmc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
