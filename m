Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B2BF6F72
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 09:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKKIIu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 03:08:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55473 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfKKIIs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 03:08:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so12203073wmb.5
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2019 00:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=L3adQNG+/hxoajCHfb6EoDmmTT7W+dDlfD3Fz0vzm7c=;
        b=N3NT49MXSpaS4htlbCzGibfT5QOaRtUcTgMKFzsLb2Tib2Z6P9pcJqi397Dvn6YP4f
         J+o7N6J+oOSicQ+PBFkRuQlvWxbhKxNPdKyV08Wrh8gPB/yrMy8pLZ6Zxad2mgfKt63n
         ogkHsJYocck6VVBrNoLp7nV7TGB3VwImhpkJ4yDk3pjf4leGqqq+mmXBLhm2ywUtUnFW
         22SVUJo16tKawT9xiVAwgdyCyXpa4298o0Yl5d8s6Y5u/DyxseRGd+9l4usDR906Zwe1
         XK3PaxW8sBaHnnRfKtnUFKIhjqn5WKUYcvtX1R3BsAIIg1PYlogSzsBtp4F5W+0j6bGR
         1CHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L3adQNG+/hxoajCHfb6EoDmmTT7W+dDlfD3Fz0vzm7c=;
        b=Mj8OdTAbZ1JNdGVm9JlbK6+Fvqgz/RUUxCGask9RH00fJclBWBaXdqRNa5eevNK/hK
         PGMx7EZHkUl+E2lqigrt1NmsigSHZj2s/qdyem1IUCQk13eabCJ3GzM6Uv94ccySXGUP
         lp3nrzUZrrqCiPa3cQTpL8ZNZuH8SlFn9U3OhB+5qFFAGHN6RHRLWQJ9rw6rAjDZMgzV
         bzXsARoupQULcLqvCPT5X/TVAZtZYEb2zJYQzpjV1uCd9h/VhncDHNS2KIeAA5CgXyX2
         J3KuvbE6Tlz8B/HFZ5SiX2lLxG/qRHEjYp9bk//YyVvftFw/WDsQ5xNgef+AhMyj3Kb/
         6yZQ==
X-Gm-Message-State: APjAAAUDPe909ZMNMcpn/E9yOneNSyUpONT1tOnAjf4WDphKp0s8+am7
        ZtiYpIO+R6yOYBYI/TJukfd+Tg==
X-Google-Smtp-Source: APXvYqyYb8rJgu+xJm4zJb5VdIdq1kwZM5m0E2HUWvADn6q+tzrpOCxz+FxIkPKzGQcKis8F4cU9BA==
X-Received: by 2002:a1c:814b:: with SMTP id c72mr20247255wmd.167.1573459725396;
        Mon, 11 Nov 2019 00:08:45 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id k125sm19217715wmf.2.2019.11.11.00.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 00:08:44 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:08:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 5/6] dt-bindings: mfd: max77650: convert the binding
 document to yaml
Message-ID: <20191111080837.GF18902@dell>
References: <20191021124428.2541-1-brgl@bgdev.pl>
 <20191021124428.2541-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021124428.2541-6-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 21 Oct 2019, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Convert the binding document for MAX77650 core MFD module to YAML.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/max77650.txt      |  46 ------
>  .../devicetree/bindings/mfd/max77650.yaml     | 149 ++++++++++++++++++
>  2 files changed, 149 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
