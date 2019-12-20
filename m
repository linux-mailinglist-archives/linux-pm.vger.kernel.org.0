Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F66C12775F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 09:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfLTIn5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 03:43:57 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38253 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfLTIn4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 03:43:56 -0500
Received: by mail-ed1-f65.google.com with SMTP id i16so7476318edr.5;
        Fri, 20 Dec 2019 00:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IXbuaf/Cq2tGfd6OZrRmEJyDn3Ce5xlbWFBppOEzCYc=;
        b=IulSYQ1S+hyqanhMqs0MDzV+WyUZFvvvbu1tKbfYMlf1QeHAwwh6DWHeSRvL3PGcxM
         1jcPnFr7jhKfymYpL3vD+bsXfIGtwDxpSv/MM0JBIWcbymhg8f70+EQ7ka/PaqWhhTY8
         0oWTNN36K85SieK4b+PHB9qi1IShVZJ2zaQKWMQ4GZ3DHNoEjnk0CKcig3Hc/X3FoyX+
         XI0W4CmglS2sXM66YgTs5JHjWA1wOPCx0P+xlVGLY1M7suoROjmGewgNGXrwW8e0T17H
         VCn6WZOoA+ldUf0o8jNwJJANJThxbxGe6cq7z0Jz+qcOfRjqNKgwAiRPajo3k18y34h7
         4uEA==
X-Gm-Message-State: APjAAAXc7sMA1Us4p3zr0qsywW/FwHzc//OOrAbQdS+CqK//57VanbZR
        52nwmMf8JtciRhuY1+TqUHo=
X-Google-Smtp-Source: APXvYqxp9hgF9PmaT2oTuADAB64PkgIFMZvrclHRsxE6EbN2yuHZHHK9cKtisRYEhpTDGewTtbAR7A==
X-Received: by 2002:a17:906:b797:: with SMTP id dt23mr14655260ejb.241.1576831434074;
        Fri, 20 Dec 2019 00:43:54 -0800 (PST)
Received: from pi3 ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id u23sm842501edq.74.2019.12.20.00.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 00:43:53 -0800 (PST)
Date:   Fri, 20 Dec 2019 09:43:50 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     robh+dt@kernel.org, heiko@sntech.de, leonard.crestez@nxp.com,
        lukasz.luba@arm.com, mark.rutland@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 04/11] dt-bindings: devfreq: exynos-bus: Replace
 deprecated 'devfreq' and 'devfreq-events' property
Message-ID: <20191220084350.GA20583@pi3>
References: <20191220002430.11995-1-cw00.choi@samsung.com>
 <CGME20191220001759epcas1p3051f7916542b7234aac5273e0baab83b@epcas1p3.samsung.com>
 <20191220002430.11995-5-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191220002430.11995-5-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 20, 2019 at 09:24:23AM +0900, Chanwoo Choi wrote:
> In order to remove the deprecated 'devfreq' and 'devfreq-events' property,
> replace with new following properties
> - Replace 'devfreq' with 'exynos,parent-bus' property
> - Replace 'devfreq-events' with 'exynos,ppmu-device' property
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  .../bindings/devfreq/exynos-bus.txt           | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

