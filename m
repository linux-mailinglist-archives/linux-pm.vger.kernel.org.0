Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2847E3100D2
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 00:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBDXiG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 18:38:06 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:37822 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBDXiE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 18:38:04 -0500
Received: by mail-oi1-f181.google.com with SMTP id y199so3615585oia.4;
        Thu, 04 Feb 2021 15:37:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uL64LrBEhOtQbFbOVO42QBz0dxRr7yZCacVJuNmv3DY=;
        b=f/M66uVNTMFB+DBZ5DL6KrzwekuPt/GYYhCT6yW3NFPeoIH2gFVzJGdl55ObAUoxwL
         uqnb/QM3UdXqtUGhkewjJIS/x9rcBQQuKptI6TVr5zsaBHbqW6kWSCshkvAyPci/dhj8
         hLgKtVSSeN4+ub2DKyjFHNs/mKHySfl+i7odiYr+Yn7oG/eGBC5AVzdUYd6oT0nZwij+
         BUIY9Tzsk2UPvkW2oCkfUT9P0wcLXeBwqWZ16lI/JzJAiTpn2aTYwCXuzeWYG/artdcT
         xALjDbmySKxVRKWfH91GjNFE7Rcb369swTqhDNbA1AISc/B7SSBUF4BBxKwLY5dD1VPe
         E9gA==
X-Gm-Message-State: AOAM532W9hCMaWEgQuHbu2xh5uUCpidvZaWzL8swmREPNym4St7DhvjH
        LxlnWzOwTlB0rBPkQ8fs5A==
X-Google-Smtp-Source: ABdhPJzybQtt7fnokOE2J+E4zLOsLm0MKJd33jJt5324zhw8n6tB8/if8M71xn2qjnon1kRO689/Rg==
X-Received: by 2002:aca:1808:: with SMTP id h8mr1318057oih.150.1612481843639;
        Thu, 04 Feb 2021 15:37:23 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d127sm1454991oib.26.2021.02.04.15.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 15:37:22 -0800 (PST)
Received: (nullmailer pid 1331292 invoked by uid 1000);
        Thu, 04 Feb 2021 23:37:21 -0000
Date:   Thu, 4 Feb 2021 17:37:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     linux-kernel@vger.kernel.org, dmurphy@ti.com,
        linux-pm@vger.kernel.org, sre@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com, krzk@kernel.org,
        pali@kernel.org
Subject: Re: [PATCH V3 1/2] dt-bindings: power: bq27xxx: add bq78z10
Message-ID: <20210204233721.GA1331253@robh.at.kernel.org>
References: <20210203104100.17143-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210203104100.17143-2-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203104100.17143-2-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 03 Feb 2021 10:40:59 +0000, LI Qingwu wrote:
> Add bindings for TI BQ78Z100. An I2C interface gas gauge.
> It provides a fully integrated safety protection
> and authentication for 1 to 2-series cell Li-Ion and
> Li-Polymer battery packs.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
