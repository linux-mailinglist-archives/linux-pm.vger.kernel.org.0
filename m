Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8F43EBC6F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 21:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhHMTKH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 15:10:07 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:43568 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhHMTKG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 15:10:06 -0400
Received: by mail-oo1-f54.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so3087521oos.10;
        Fri, 13 Aug 2021 12:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bvCe2gQ8eMevcfuaAvscW+4M3MX5WKCt4QJCMjm7/jw=;
        b=KFBOh2AFBwVP1SJzc9XnnPktK/VZ+6210yVeetxm4vpWQlOBOEb4Hysqvx9ERMuAYo
         Q8kxM0DaE+SGpN4ZopcxtyKje5xKaMKAUgZsZ+2/v8UVpqZlrUiUFS2zAKRVdTb69pXQ
         kR/ROHsFZP7VQmZHejCJeYK4LGzqR8YeZ5xbOm665eUFkuB1cHGcQOBIiqHb6yYhZWf9
         sjnYqcq9tWFGY7WUFJWrWQJdhSFM14azB4UPjTs1fE/QWvHp7r6XkMMrGZ819Q7G4m7T
         zjJ8SaJj08fj7DnfL1kiRiLS7AQkJBRBatmwAulWq1xGpqYEXB55WTjAjUl4X/O9WXeX
         prcg==
X-Gm-Message-State: AOAM531TIRmGFdIM6AHG6vZBCDE443rD5KQyy++sY8sCEWmpAg0JTkj6
        Q86PoL8ulKx4i4nX/1ZQmQ==
X-Google-Smtp-Source: ABdhPJwSdu3zEv5fY/yd4TkaejosA0hApvyb5fr8XT8xFfE0ocM6M5a0HxYPx5sQKNIUA+xfUyO7GA==
X-Received: by 2002:a4a:b481:: with SMTP id b1mr2917908ooo.79.1628881779405;
        Fri, 13 Aug 2021 12:09:39 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f16sm498409oiw.29.2021.08.13.12.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 12:09:38 -0700 (PDT)
Received: (nullmailer pid 3883094 invoked by uid 1000);
        Fri, 13 Aug 2021 19:09:37 -0000
Date:   Fri, 13 Aug 2021 14:09:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: Bindings for Samsung batteries
Message-ID: <YRbDccU5IJzBxmLq@robh.at.kernel.org>
References: <20210806090050.3510671-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806090050.3510671-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 06 Aug 2021 11:00:50 +0200, Linus Walleij wrote:
> This adds device tree bindings for Samsung SDI batteries.
> Everything can be determined from the product number so the entire
> battery is just a specific compatible string.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../power/supply/samsung,battery.yaml         | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/samsung,battery.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
