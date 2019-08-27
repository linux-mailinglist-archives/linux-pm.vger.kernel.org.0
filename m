Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9789EC80
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfH0P0V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 11:26:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37399 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfH0P0U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 11:26:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id f17so19077458otq.4;
        Tue, 27 Aug 2019 08:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cx5A9kmsqXyCRtIPjR+drsX0vo8kNVTlvMzHwdHDI2U=;
        b=RIg7e4bu1WhuS2qovk0SJsoVFdIJYNfO+Qda2jHs2m2tMGat7k5hbzULRSUl3rd21A
         Wz86/famYzFxNMh/HyUyeEccHJTVZ7I954tNxLIwFTlbDnarHTY5BkVYgAZ8FPtzZHIE
         3BWNhlzKIwX0D0inRycVRFrTkjJ7VEn2oyz51urWzTAKAhLiQ/Vga/9Q9K68dTHnv4yt
         y1n4U/5ZFGC/n7xNIRAttQ1HDM0CmVkpsHAxZXkjXpjP/iLml8M1r143yluOuU/XjFmj
         HP3gYvYFi21ZAUMj5iKvuyoVBWDUou0OKhbR2gctH2y9mo/g6uS8s/QGVWxM2LSnTju7
         JVkw==
X-Gm-Message-State: APjAAAXqcKrUjQ2LbWLp+3oCQwmnfneennTThiaW7BgDxrxYmZpOQlb+
        19u5YcfZg6BlNdXHiUKPUw==
X-Google-Smtp-Source: APXvYqwSeY1/zyQlliXFGLvmROu9EUOrSjDGZJ/u1Ovb3jw9fy9cQ2GnzE/ll0sd4/G7GJ44D+KuNA==
X-Received: by 2002:a05:6830:42:: with SMTP id d2mr19950752otp.123.1566919579411;
        Tue, 27 Aug 2019 08:26:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i16sm5354376otc.65.2019.08.27.08.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 08:26:18 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:26:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH v5 10/18] dt-bindings: thermal: add binding document for
 h3 thermal controller
Message-ID: <20190827152617.GA24677@bogus>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
 <20190810052829.6032-11-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810052829.6032-11-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 10 Aug 2019 05:28:21 +0000, Yangtao Li wrote:
> This patch adds binding document for allwinner h3 thermal controller.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  .../bindings/thermal/sun8i-thermal.yaml       | 81 ++++++++++++++++++-
>  1 file changed, 78 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
