Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607E53660F3
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 22:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbhDTUeK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 16:34:10 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40706 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbhDTUeD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 16:34:03 -0400
Received: by mail-ot1-f45.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso4020392otp.7;
        Tue, 20 Apr 2021 13:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DD7/NL5gJzpXCQeXb8QeXwOzocwutpc19YrHhJ83w6s=;
        b=POivqFdWIfya0+Y1SCPc0Pmp5tkkvlCK3+s1J/Z1ke5+tgkIUzjQia7qwXGy5CCbzl
         v3kLrfFsdVoIhqaEHLQHQLq1r6tJaBbkcJawLjl06Li7vx/0B3QBTZn9clSbgfbz4ggn
         3tz29v95aUwCY07gshIPUdr2Y9moW6mjKXQxLnsWBs0stLN/tejer49r2Q3M+CNlKGYO
         8RXLUzFZsP3USErpHoB0a+451zr/y7V6ZAfLsewNSd7v8MQ0vsksPFMKAxM4N5eIPTKW
         BZeYyGksmG1I7E7aL/XCe3D1xbAohOc9RUOmo1Qqc5lpQxAfBwoJVFF4Efzw1c+zRtoW
         UJ9g==
X-Gm-Message-State: AOAM532XcLZZigaCqZ08WBl/ALri/moNFRx8v0GkElUcYAoYvTQzEm1f
        LnWf4qOM+57ppeWhJvfaHg==
X-Google-Smtp-Source: ABdhPJxirUjL80mT5wdFTiFnB3kTym+arpTEAai9wz+jx+d5GDsx7qkghe+QQRd+h1ll2s19tFIWKw==
X-Received: by 2002:a05:6830:1d74:: with SMTP id l20mr20127340oti.211.1618950809972;
        Tue, 20 Apr 2021 13:33:29 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g84sm20943oia.45.2021.04.20.13.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 13:33:29 -0700 (PDT)
Received: (nullmailer pid 3760959 invoked by uid 1000);
        Tue, 20 Apr 2021 20:33:28 -0000
Date:   Tue, 20 Apr 2021 15:33:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: thermal-sensor: require
 "#thermal-sensor-cells"
Message-ID: <20210420203328.GA3760918@robh.at.kernel.org>
References: <20210415112121.4999-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210415112121.4999-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 15 Apr 2021 13:21:21 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This property is required for every thermal sensor as it's used when
> using phandles.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/thermal/thermal-sensor.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
