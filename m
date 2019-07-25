Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C8B74E14
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 14:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfGYMV4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 08:21:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35446 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGYMV4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 08:21:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so50583238wrm.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8/wvc0WureKNtxeBX4xKzjM6p1k0k3v7vDz7PwmMihg=;
        b=xwD8+kGFQN4TrY0AmtoOYNnSFqePZc/1IPqhIIlFG3eWCx+GZQBJY/pIKkNCfpJBCS
         peQGDfp1vwHqkrJe5wxM4Qxgag8c5ctv1OO0xDBYe8zhTPdvLPJW6xrhNZ7i29tPYtMW
         Jwr1Gf8yzvvMpJO6EDbZr1QIBd1qXuS0h9iw4GJuXfFNS93ToRPC9/LsUEl2KUmhc60j
         Jd+LGiRjcX7p+mPWWNEZayxNe0LJyKVS+NWWHsJajnDJPdQKQ0/XyDcuh9bhlfB+sl3u
         KYLuqjhiqLm9B2oMn0KjR6GXHjYsJfXKb4eUoJclc6dnmGad9d0b/FtX+kz0B/r+qUS9
         YMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8/wvc0WureKNtxeBX4xKzjM6p1k0k3v7vDz7PwmMihg=;
        b=NnjdIkZFnDNYKfb6+zjLoWJxLsaaAR6Jb4NM3sgcoN8yA4EBmrREz4/5O7I0ni7KHD
         EOpU8HePhYwz/nlU/Z/uJSS5jfFtOk0jMcG+F450I9oY1vty94SL2p2vi8E9CbvWmbHc
         4GGzSQ3j9w4t+eZGNkW5r6QQLjfKhXBawqaTiyQsMxWsEv0rdqCwkivk3b9kUrSsIsur
         QnPG+GJImLkvOA0nev8tyM7INFgKyojJLFlT29ycnltAN57o7vNWxblw0WmyLobt+TYJ
         WMD+wkIe9L8eTPw/BhtfAb+KL8hXr3dzi8x9EOyYlo1QJsERYxytZghajrDnqa73gAcz
         NEwQ==
X-Gm-Message-State: APjAAAXVB7kPFtCqQrKL7VQNMv1HmBR+DoxDyjs/uIwRHEEIJl+Rq60J
        KhZbCWO4T2T5gubbNYMS16u95H3G+Ko=
X-Google-Smtp-Source: APXvYqxyJI8DKFlWjprGdQfvA8WroDaw2sDrEe2mop88xU2pVgPYcdT3+AaTvEVj5EZN90UQwwtBXQ==
X-Received: by 2002:a5d:4ecc:: with SMTP id s12mr97366887wrv.157.1564057313793;
        Thu, 25 Jul 2019 05:21:53 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id w67sm62323556wma.24.2019.07.25.05.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 05:21:53 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:21:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: db8500: Finalize device tree conversion
Message-ID: <20190725122142.GI23883@dell>
References: <20190717063222.5902-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190717063222.5902-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 17 Jul 2019, Linus Walleij wrote:

> At some point there was an attempt to convert the DB8500
> thermal sensor to device tree: a probe path was added
> and the device tree was augmented for the Snowball board.
> The switchover was never completed: instead the thermal
> devices came from from the PRCMU MFD device and the probe
> on the Snowball was confused as another set of configuration
> appeared from the device tree.
> 
> Move over to a device-tree only approach, as we fixed up
> the device trees.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Lee: it'd be great if you could ACK this, it is a file
> with low change rate so we should likely not see any
> collisions.
> ---
>  drivers/mfd/db8500-prcmu.c                   | 53 +-------------------
>  drivers/thermal/Kconfig                      |  2 +-
>  drivers/thermal/db8500_thermal.c             | 30 +++++------
>  include/linux/platform_data/db8500_thermal.h | 29 -----------
>  4 files changed, 17 insertions(+), 97 deletions(-)
>  delete mode 100644 include/linux/platform_data/db8500_thermal.h

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
