Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5C3C9259
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jul 2021 22:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhGNUrV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jul 2021 16:47:21 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:41950 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhGNUrU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jul 2021 16:47:20 -0400
Received: by mail-io1-f44.google.com with SMTP id z9so3726536iob.8;
        Wed, 14 Jul 2021 13:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g6H++hBdOFlsPrFG3lRFDsMHXTwNVj5BH9F2OFn1oSM=;
        b=UCspghrCQqBfuGwDWuDZka1OJtN+79AO2RCSS1NZ7g1u1DRmiG/gb3jLZ1FFAssbxa
         exK72aFeNZkFGXMaeoVp6b+RrXGcYocRokTNcb54Ah3WCZrqUr75Tv5Z0JuGKQOg9w30
         2DebuEeZcC4UdcbdBXs6TD/jyOvAqxm7G5PRrMq3sZR90NSwjBU5cLKBd2SgrgAR1Gwn
         aA/nVN5NwZx/egLude5G1g1F4u/S6siUt59V18oqtgwEig/X/xzmtHFlVpng9G1ITIJw
         HS5BGEtk+VkMMDOYzzJYamU0knQDtQZMuEAcNdLluStzc1y8RuCdIBurPzaBVrq8IT5l
         bAXQ==
X-Gm-Message-State: AOAM532UspfPsUE5nsBSj3WzJge4uP23/KTbbxeCWW7U4nODcL2rLzBM
        q3RyDyQB2LV5etBNvJrR7Q==
X-Google-Smtp-Source: ABdhPJwBF3Ms2hTWsmz9XIX3sQ6Uq1h/FsrKa4l+6hTkaM09+VSyZ4uuVDqdoIuhBGn448bKZ6Px+w==
X-Received: by 2002:a05:6638:1316:: with SMTP id r22mr113288jad.89.1626295467444;
        Wed, 14 Jul 2021 13:44:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h24sm181586ioj.32.2021.07.14.13.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:44:27 -0700 (PDT)
Received: (nullmailer pid 3488249 invoked by uid 1000);
        Wed, 14 Jul 2021 20:44:25 -0000
Date:   Wed, 14 Jul 2021 14:44:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] mfd: tps65086: Make interrupt line optional
Message-ID: <20210714204425.GA3488195@robh.at.kernel.org>
References: <20210625224744.1020108-1-kernel@esmil.dk>
 <20210625224744.1020108-3-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625224744.1020108-3-kernel@esmil.dk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 26 Jun 2021 00:47:43 +0200, Emil Renner Berthing wrote:
> The BeagleV Starlight v0.9 board[1] doesn't have the IRQB line routed to
> the SoC, but it is still useful to be able to reach the PMIC over I2C
> for the other functionality it provides.
> 
> [1] https://github.com/beagleboard/beaglev-starlight
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  .../devicetree/bindings/mfd/ti,tps65086.yaml  |  3 ---
>  drivers/mfd/tps65086.c                        | 21 ++++++++++---------
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
