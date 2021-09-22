Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E004415067
	for <lists+linux-pm@lfdr.de>; Wed, 22 Sep 2021 21:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbhIVTUo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Sep 2021 15:20:44 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:37639 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhIVTUo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Sep 2021 15:20:44 -0400
Received: by mail-ot1-f52.google.com with SMTP id w64-20020a9d3646000000b0054716b40005so5054543otb.4;
        Wed, 22 Sep 2021 12:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2go1bBxyKUnvbgdrtTt2n0b0j8Fy5wjIbyGl0rGFlTg=;
        b=eFBxUoxoQLNzMwZMkRzGmUU8Q/xIjw1eIqxuXEz4Rx3eYizFC9uk1Nnpv57ZrfH/gW
         C5LHJG07keKQmIp6Rg19H/QPIiIxLFB2TbFIvJqo89P0psf0/mju04A2CPJKA1/HhbID
         ozCIBrAHVAefJrJ4Tw7IE+3pDv/6QauSxeqKxrfdLdB9MSXmB4UGtjkAoDv0TPJwjisH
         nDD5VWusPn4ADruwebKslkJnCxNDkzIu0cf7RcpiBErWCbovrULfVIvz9reu9j2gSUVk
         Jyfc3/LiDkEdlEI9rhaaWt0ufGQ1i6tZEiui+N472JWyBI4M67jkX8IQsme/pDBreHaR
         Z1dg==
X-Gm-Message-State: AOAM533iYz0I3Y2dDDmD67FuWvdNcbiwL33p3cAUqkzQGyEs2HoXr46V
        C/9UwP6UlM8uAP9jRdtQiw==
X-Google-Smtp-Source: ABdhPJyc7dpH7FhP2T7xkrJePYFiN4EyyiITxz3pKUDeqQwDdXCpp+OhKr8/WXKWxm4hzqonvqjjKg==
X-Received: by 2002:a9d:750d:: with SMTP id r13mr714816otk.264.1632338353655;
        Wed, 22 Sep 2021 12:19:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p9sm474331ots.66.2021.09.22.12.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 12:19:12 -0700 (PDT)
Received: (nullmailer pid 1133413 invoked by uid 1000);
        Wed, 22 Sep 2021 19:19:12 -0000
Date:   Wed, 22 Sep 2021 14:19:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, lee.jones@linaro.org,
        heiko@sntech.de, sre@kernel.org, maccraft123mc@gmail.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v4 RESEND 1/4] dt-bindings: Add Rockchip rk817 battery
 charger support
Message-ID: <YUuBsN1sjGI0Xc61@robh.at.kernel.org>
References: <20210916194208.10387-1-macroalpha82@gmail.com>
 <20210916194208.10387-2-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916194208.10387-2-macroalpha82@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 16, 2021 at 02:42:05PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Create dt-binding documentation to document rk817 battery and charger
> usage. New device-tree properties have been added.
> 
> - rockchip,resistor-sense-micro-ohms: The value in microohms of the
>                                       sample resistor.
> - rockchip,sleep-enter-current-microamp: The value in microamps of the
>                                          sleep enter current.
> - rockchip,sleep-filter-current: The value in microamps of the sleep
>                                  filter current.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  .../devicetree/bindings/mfd/rk808.txt         | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)

You've also submitted converting this to schema. Please make the 
dependencies explicit. 

Rob

