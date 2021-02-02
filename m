Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612E230BA9F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 10:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhBBJLl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 04:11:41 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:33102 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhBBJHm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 04:07:42 -0500
Received: by mail-ej1-f49.google.com with SMTP id sa23so12464767ejb.0;
        Tue, 02 Feb 2021 01:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xI2vAdqH9GfIl1n8xJBiH8KPT2RKDd5SmnHJU1PsBlA=;
        b=se4m1OA+69vckAF150zdvnaY4f+0wMw/cgcTm9Y0CTVSEG7zp9NHj55YByrtWRFW4p
         zKpTPAMC30kyi8yNd/48LHZWfQidLWYsSbw8A03B19ycYCX7vgzrOxs9vVGSeoUVkBI+
         YdEmHmyN9jS/sYjx+yB6YwLUJthyfWXzjGTslUFijPbPrb8cUnGNrxnmgP11OahOM5Ji
         yJyJZ97h0GPnJyRfenYekq593adJld26Cedg14atbOgNNmFx6z6nz/QIIVOMu9d6y1yH
         PZqfxN7UFEFdvvUFSQVtGwIdBDrXzGQRoeQY8bX6wAugkaA+kgE3mqIXbtgWZQe44Mxm
         H+Tg==
X-Gm-Message-State: AOAM5330q1+YUFgGcIQvGcXgK22SiY1Ws/cfuok7ffDa1d91zMvn/rDu
        Z12GmVrc3MiImVsAETRzoRE=
X-Google-Smtp-Source: ABdhPJwiU14STEFDBbtF/JQMDjTfwg66hcmDIx0cnwstbqVR/HqkbCgENDY5NuRvcFzMkVfB7GUbKw==
X-Received: by 2002:a17:906:a20e:: with SMTP id r14mr21122192ejy.404.1612256820688;
        Tue, 02 Feb 2021 01:07:00 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id bm9sm9206118ejb.14.2021.02.02.01.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:06:59 -0800 (PST)
Date:   Tue, 2 Feb 2021 10:06:58 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     sre@kernel.org, robh+dt@kernel.org, dmurphy@ti.com,
        pali@kernel.org, afd@ti.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com
Subject: Re: [PATCH V2 1/2] power: supply: bq27xxx: Add support for BQ78Z100
Message-ID: <20210202090658.uamrtr5mpvnsmg3x@kozik-lap>
References: <20210202084858.2944-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210202084858.2944-2-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210202084858.2944-2-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 02, 2021 at 08:48:57AM +0000, LI Qingwu wrote:
> Add support for TI BQ78Z100, I2C interface gas gauge.
> It provides a fully integrated safety protection,
> and authentication for 1 to 2-series cell Li-Ion and
> Li-Polymer battery packs.
> 
> The patch was tested with BQ78Z100 equipment.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/power/supply/bq27xxx_battery.c     | 46 +++++++++++++++++++++-
>  drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
>  include/linux/power/bq27xxx_battery.h      |  1 +
>  3 files changed, 48 insertions(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
