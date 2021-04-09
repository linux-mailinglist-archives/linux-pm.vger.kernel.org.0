Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2E935A5F9
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 20:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhDISmD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 14:42:03 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:38600 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbhDISmC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 14:42:02 -0400
Received: by mail-oi1-f174.google.com with SMTP id 25so5261631oiy.5;
        Fri, 09 Apr 2021 11:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Be/CGte7k2+pzdht/VJSu2yAXKvsFO5z2CA4PlW9wRk=;
        b=GjF1iHltjgw2Mm4rc96WZCXNUcuKiONwj07JIhje30GgQgexS695/9i478rc9qWQJm
         koCzMqQ8y1GB6ejp7gsssLo5vUQJkprurCLKwIbSO+9JBWpnRasz1bHjaMtZlvtefM3V
         ydR9CnrqQ3jm+jNLEHLtvUxlUWzbHXaHsWy9nLQyB50ud4p3USs3uuEFv+ziXqJPkdAg
         lmtIjMnjfQFDcmvGJrsDFdjUz2O1fJwgGVcN72T3wDRfECaeaevbLaZb8fD/ja6WGFOq
         rlw4JLYZUNP95bvU3tvFZFJC6cCIWK9HoAItMhoXAXfI7AMUpQxvxNe1NrxXTpKwHeg3
         5LaA==
X-Gm-Message-State: AOAM531pEZoONfQQUjdcd3FoUc0qAOtl5irsrXB8hVn5+jPUF0wN8VYN
        iwHdgDhCNIASBTZFzbR4lQ==
X-Google-Smtp-Source: ABdhPJxKSP8UJhYi3OWcPGvoRcKB97sjKJNex1pSUCZMF2CENuBOIdO8LLeB7CRM9Nu6Uwi9mPSLfQ==
X-Received: by 2002:aca:4e55:: with SMTP id c82mr10805300oib.43.1617993708908;
        Fri, 09 Apr 2021 11:41:48 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 128sm669713oog.37.2021.04.09.11.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:41:48 -0700 (PDT)
Received: (nullmailer pid 3937739 invoked by uid 1000);
        Fri, 09 Apr 2021 18:41:47 -0000
Date:   Fri, 9 Apr 2021 13:41:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-mediatek@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/6] dt-bindings: usb: mtk-xhci: add wakeup interrupt
Message-ID: <20210409184147.GA3937709@robh.at.kernel.org>
References: <1617874514-12282-1-git-send-email-chunfeng.yun@mediatek.com>
 <1617874514-12282-3-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617874514-12282-3-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 08 Apr 2021 17:35:11 +0800, Chunfeng Yun wrote:
> Add an interrupt which is EINT usually to support runtime PM,
> meanwhile add "interrupt-names" property, for backward
> compatibility, it's optional and used when wakeup interrupt
> exists
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml  | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
