Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B6B4128C2
	for <lists+linux-pm@lfdr.de>; Tue, 21 Sep 2021 00:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbhITWUn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 18:20:43 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:36402 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhITWSm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 18:18:42 -0400
Received: by mail-oo1-f51.google.com with SMTP id y47-20020a4a9832000000b00290fb9f6d3fso6410841ooi.3;
        Mon, 20 Sep 2021 15:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U6ROm438VaDF/X83yU1GFicSY9rT7GthHqvBSSmCyxc=;
        b=DcQWgr55H0jQIqmYW+lgR9vBn3haKj9etEXNstXs1Cs1aY7V4JKsRBU0RFnDxthQfi
         hp9hxiHkWXmmNhBi8MFeOTTNx2FkCyUiEUn/GsHERO4K5s23G7kTnAVU3qfDxTOCaXON
         tkZzLr2VZYxvSE4lX68DDrg3PZIUY4T2JYJtbcmU3IyYEOhqLVxRyYg+MkmibK/VYRkO
         +/kWWxHPAvMlsN1aGB2sS97XE+8KdH6XWaCyQ0Vxxf/8IF+o/bjst1bZOhpsBHHnGsTk
         9cH44tBWCVc3bzaisQBYHJ686SRKW5xcuJxB0Dv9gW9L7E6jO+TJgvkFZX36okK+t//L
         HOAQ==
X-Gm-Message-State: AOAM531gVX3wxD1q+wHoERh2l9Jawyq2zzyTv/GhQ8/gReUavRKu8VYG
        UDk2Fd8yzgEoT1z/UAd2qg==
X-Google-Smtp-Source: ABdhPJwMqbol2K20SQ5ba77WGRZQj9JVbeaXX0tb6m2bmPHGmYtgVns5mCkIFDzr/wrlskzHsQfIrg==
X-Received: by 2002:a4a:b64b:: with SMTP id f11mr21600944ooo.18.1632176234838;
        Mon, 20 Sep 2021 15:17:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j23sm912423oih.30.2021.09.20.15.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:17:13 -0700 (PDT)
Received: (nullmailer pid 893587 invoked by uid 1000);
        Mon, 20 Sep 2021 22:17:12 -0000
Date:   Mon, 20 Sep 2021 17:17:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rui.zhang@intel.com, heiko@sntech.de,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, amitk@kernel.org,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] dt-bindings: thermal: remove redundant comments
 from rockchip-thermal.yaml
Message-ID: <YUkIaOt7xP1v2vYb@robh.at.kernel.org>
References: <20210906120404.10005-1-jbx6244@gmail.com>
 <20210906120404.10005-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906120404.10005-2-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 06 Sep 2021 14:04:02 +0200, Johan Jonker wrote:
> Remove redundent comments from rockchip-thermal.yaml
> Sort compatibles in alphabetical order.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/thermal/rockchip-thermal.yaml       | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
