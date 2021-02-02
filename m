Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6B930BAA1
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 10:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhBBJLo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 04:11:44 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:42171 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhBBJJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 04:09:09 -0500
Received: by mail-ed1-f44.google.com with SMTP id z22so22014466edb.9;
        Tue, 02 Feb 2021 01:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aCPu/w+IzPBi1cp2MLabRKXq3jYLkdwyiLqfIg+o07Q=;
        b=JkbJo7ZDS1rETS5SyLb4cyt3ixz3FL+ThP+LIzex0DJp7Mcqwc3YEgSJRKyJpPEA8y
         em+EttPCo0viEDkPlKCZGjGOF3SQCIEGbeJO22mTHHKmlDmU/VsQvmTfXIY5QUNWl/jW
         yZ/dPC8PX5uB8CkXfn9Xh9HFowrBWbPl0eD6HMpCGn0XZELTrG8YaRVkR/oMLobg7ha5
         8D/BygaE0rM2kn+gVuZa89oDUEpYtuNznTa8jHiM5SoYYZ5WMgLo235BecGIn88hmAAt
         7IAUnt7qz/rcr5/DRT5JzcLUD8MoyDsQKwjidsGEMlI4GmJ1x9SbIPx0l6q+8DOmIfFO
         Ne9g==
X-Gm-Message-State: AOAM533l1mJG/tUtcCwFc4V0nNMoX1Ypnue5HfVPhmaW4s6PzuUC2w7n
        2Y6t9ULwvyap0CXRFUz3wyxVYiAMhJI=
X-Google-Smtp-Source: ABdhPJwhzXn8rH0/fR08Us7twWk1IEt6G0/IlugvE6AS5UUdjSTQmfS+KWcjEigTr2tprPKeCSE/Ug==
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr22638409edz.89.1612256906112;
        Tue, 02 Feb 2021 01:08:26 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id j27sm9175249ejb.102.2021.02.02.01.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:08:24 -0800 (PST)
Date:   Tue, 2 Feb 2021 10:08:23 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     sre@kernel.org, robh+dt@kernel.org, dmurphy@ti.com,
        pali@kernel.org, afd@ti.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com
Subject: Re: [PATCH V2 2/2] dt-bindings: power: bq27xxx: add bq78z10
Message-ID: <20210202090823.rgah5hxoegsueu54@kozik-lap>
References: <20210202084858.2944-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210202084858.2944-3-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210202084858.2944-3-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 02, 2021 at 08:48:58AM +0000, LI Qingwu wrote:
> Add bindings for TI BQ78Z100. An I2C interface gas gauge.
> It provides a fully integrated safety protection,
> and authentication for 1 to 2-series cell Li-Ion and

No comma before "and".

What does it mean authentication?

In the future, please send the bindings as first patch. The checkpatch
should point this - did you run it?

Best regards,
Krzysztof


> Li-Polymer battery packs.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
