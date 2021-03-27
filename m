Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C1634B8A8
	for <lists+linux-pm@lfdr.de>; Sat, 27 Mar 2021 18:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhC0R6Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Mar 2021 13:58:25 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35361 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhC0R6E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Mar 2021 13:58:04 -0400
Received: by mail-oi1-f170.google.com with SMTP id x2so9112155oiv.2;
        Sat, 27 Mar 2021 10:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ozKLLA7yDbkQCLx/+4eOXAPun75AO1oJzOLxqsjOT8w=;
        b=iHK2W8Zm5xKalrkX04fxs8iQCgO9Nyh7EddySEPX3MI0sia8nI4M2eIpKFWxrY8NYb
         d1FCGGHR4QL+ghrbD8owAupq8bI2cEDCCo/1TRSARRew30CB3xINTE/joBn/HFAbWxh+
         UZ6lRWY3LMq/3AhTMr4kMqKPqtk7wks8tHNVM9IcF16wjcOYHJqe/clyeSTsunEdW2o6
         HqDCES2kWrA6R/MvtATy+PE/bXkcDsLuXYjqXe032MCNZ83yvLub1CFk/Dj+2Z4veNFf
         S+U0hrUWIIEXvsMP60s5wdWzPhYnhwAerRxwfe6ZLjE++mexhWpfvFicYXKFDoI2uJhL
         xVRQ==
X-Gm-Message-State: AOAM5330NBvc8ANM1C+HOrDOeIYH9Ui3oKEdMIceHX86/1OsUgnQoI2X
        w1RRMPFxEem8+IKKObnLXg==
X-Google-Smtp-Source: ABdhPJzOuiI/VGQJh5708waZStlsiXvecENnKkT1BGVJZ0ogVzpf8bB2aa4saHfW59f91pJI0RLowA==
X-Received: by 2002:aca:408a:: with SMTP id n132mr14082074oia.70.1616867884374;
        Sat, 27 Mar 2021 10:58:04 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.107.88])
        by smtp.gmail.com with ESMTPSA id u8sm2670285oot.24.2021.03.27.10.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:58:03 -0700 (PDT)
Received: (nullmailer pid 320909 invoked by uid 1000);
        Sat, 27 Mar 2021 17:57:59 -0000
Date:   Sat, 27 Mar 2021 11:57:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Seiya Wang <seiya.wang@mediatek.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: mediatek: remove deprecated CLK_INFRA_CA57SEL
 for MT8173 SoC
Message-ID: <20210327175759.GA320861@robh.at.kernel.org>
References: <20210326031227.2357-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326031227.2357-1-seiya.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 26 Mar 2021 11:12:26 +0800, Seiya Wang wrote:
> Remove CLK_INFRA_CA57SEL for MT8173 since it's no longer used.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> ---
>  include/dt-bindings/clock/mt8173-clk.h | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
