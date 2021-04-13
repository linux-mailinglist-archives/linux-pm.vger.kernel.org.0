Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBF135E2CF
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhDMP1D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Apr 2021 11:27:03 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:42841 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhDMP1D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Apr 2021 11:27:03 -0400
Received: by mail-ot1-f52.google.com with SMTP id 101-20020a9d0d6e0000b02902816815ff62so10556257oti.9;
        Tue, 13 Apr 2021 08:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AuWKAWslMlI8Grf6ZxTnwf76VAE/ysmzZ0573JBvMcA=;
        b=gzYEakGy4cPkfk+fNiGYLODCAZPs/U3h07QcDkWDfITnM6xTmNG0uHxvlglPTFd5rr
         ul/7ptKrxxMQEtX/CIpTcySOmaTv6FFZsovni9/7CTw1TlMvfcnOPQ+V7qN+QLGyctiY
         A7HR64OOJvSl1giii35bJhyIfAPgG0tz1M6m4GTwkXpMctFYIT/0cQlkvn8lwLBHIyTs
         RRkFfGtTN9WneQ82eY4wJD+4wZapXjAmzq8x/yLts49FoZsVa52mv7YZFyGotSwcAc+r
         Ai3bZisylMIty8z7ONfBvCCsV+nliVs6XfIv/E2TJUsqJhqvYHhKBfsDKv7ujJdzT1cf
         hMeQ==
X-Gm-Message-State: AOAM533ETXxlDotR0FA/uLV9WVBC9NOM/FcGwOIK3C7DBmwoLbXO0GQB
        icPgT3o68aNjA87mTESmMQ==
X-Google-Smtp-Source: ABdhPJxTeU0U5D8Wo9YeNu5zF1rct1J09anrMhHJlEIwzYnaZWBfkch02nuFVkyRzSLm4+MvBpbmbw==
X-Received: by 2002:a9d:bc9:: with SMTP id 67mr29574918oth.352.1618327603350;
        Tue, 13 Apr 2021 08:26:43 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a7sm2845889ooo.30.2021.04.13.08.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:26:42 -0700 (PDT)
Received: (nullmailer pid 1707658 invoked by uid 1000);
        Tue, 13 Apr 2021 15:26:41 -0000
Date:   Tue, 13 Apr 2021 10:26:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: power: supply: charger-manager: Convert
 to DT schema format
Message-ID: <20210413152641.GA1707619@robh.at.kernel.org>
References: <20210412230320.382885-1-sebastian.reichel@collabora.com>
 <20210412230320.382885-5-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412230320.382885-5-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 13 Apr 2021 01:03:18 +0200, Sebastian Reichel wrote:
> Convert the binding to DT schema format.
> 
> I slightly modified the binding by allowing regulator-[0-9] and cable-[0-9]
> instead of regulator@[0-9] and cable@[0-9], so that DT compiler does not
> complain about missing 'reg' property. The driver actually ignores the
> nodename and can handle both styles.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/power/supply/charger-manager.txt |  91 --------
>  .../power/supply/charger-manager.yaml         | 215 ++++++++++++++++++
>  2 files changed, 215 insertions(+), 91 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/charger-manager.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/charger-manager.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
