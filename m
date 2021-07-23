Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD853D4288
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jul 2021 00:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhGWVTq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jul 2021 17:19:46 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:39432 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhGWVTp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jul 2021 17:19:45 -0400
Received: by mail-io1-f50.google.com with SMTP id j21so4252281ioo.6;
        Fri, 23 Jul 2021 15:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MTWh9GNzcGwhIzzEDBXlVPGlMvU6+QVJFvc5nUuf30E=;
        b=CVJEFNTJ+JSJeO+ia/p+EbR+I+VnOv4s6rMK0HaNZ5RKvgbGrVk7Tv7QU/XEglYLt+
         bkmN9y6a4cqXlzL/Kg6LFnKDZMZX6TEU3mkGRQ0oIeF+8XmTsvsFL5rvP+XTCJOowpRo
         9ouud81OPLV2nzLWRTxrk+VJkyweNvLlQP4V8DLgyPBmJSCgWI2mnTFnldGMZJ30kcmX
         2M2KbX3jnB3Hkwzvif56v3XM5RB5IEtIt38gQ39sOT8f+Y9j6Jhj4A18dDcbfVvMU/T8
         75WgqKVvgoySvqx+wYsfiHN/EP8JHbkQM3aiF2WyymuvvxOKPvz64g4gPQNwFa10Iq9o
         69Gw==
X-Gm-Message-State: AOAM531memGBDiOuLKbF27MDd5T/ws62KUZYK2Jiy5SNKqbmDebyp8ik
        /eu9npenlMdU3J0p94TJmA==
X-Google-Smtp-Source: ABdhPJxllp71vB3NDLiyNCU/ODJdSpbN93QWeifSeR1h1GneVaqJT8WXQ0jXKNdyfZaim31R+Emibg==
X-Received: by 2002:a5e:8208:: with SMTP id l8mr5455173iom.197.1627077617512;
        Fri, 23 Jul 2021 15:00:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k19sm17223991ilh.60.2021.07.23.15.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 15:00:16 -0700 (PDT)
Received: (nullmailer pid 2669472 invoked by uid 1000);
        Fri, 23 Jul 2021 22:00:14 -0000
Date:   Fri, 23 Jul 2021 16:00:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Frank Rowand <frowand.list@gmail.com>, linux-pm@vger.kernel.org,
        linux-sunxi@googlegroups.com, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 29/54] dt-bindings: power: supply: axp20x-battery: Add
 AXP209 compatible
Message-ID: <20210723220014.GA2669443@robh.at.kernel.org>
References: <20210721140424.725744-1-maxime@cerno.tech>
 <20210721140424.725744-30-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721140424.725744-30-maxime@cerno.tech>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 21 Jul 2021 16:03:59 +0200, Maxime Ripard wrote:
> The AXP209 compatible was used in Device Trees and the driver, but it
> was never documented.
> 
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  .../power/supply/x-powers,axp20x-battery-power-supply.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
