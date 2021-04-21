Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF15C36710A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 19:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbhDURNV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 13:13:21 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:43965 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbhDURNU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 13:13:20 -0400
Received: by mail-ot1-f49.google.com with SMTP id i26-20020a9d625a0000b02902a2119f7613so2778074otk.10;
        Wed, 21 Apr 2021 10:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yqbaxYIX/tUR1NxQbrHflmbrxNCNLXf6m6x/yN/Vj9k=;
        b=hSGttU9+5m+6sdN/vNH7s1+3iJfeF0ZKHihmREiuAE7CJWYWzFlKrYo4I/vhfrNKgM
         j1yp1B3qy/ip7zA528UPTVzJLOJT7MiuqXx8EbMmw2Xw2dLV0wcvAwETBLUh4rO/1WW5
         DULdOrVhtHRLrMcYQrcHv1G+i15ZRPF4SFTjuVZq5mu9IZNcTELRNcXM+YEfzGzeTywW
         5US1bKJnovBI1ot/TMFY0D1uYuWbhreD5FlPBQ8vUOE3fZtKCcYpjSdA5pNrQudMv/QK
         ZjBzTWMNg+gKnG+osOPnoCgwtQTP3yGAOXE9jRSD+XmZesbl6XDjNMsG6KQgyK5lAGeh
         5enw==
X-Gm-Message-State: AOAM532uzDYnEIk1VFylobYZuYhWVvePmPIfIfqNSNhqUxZd/XL6i3h9
        Is/n7PuTPQM7oRDODpweHw==
X-Google-Smtp-Source: ABdhPJyHLiNL+aAjTUdLvXtqPxiy2bmTWGH6q9Bc8OVaFQ/lADiMu2aqjt5v9wv4w6or0ajdevrgGg==
X-Received: by 2002:a9d:65d4:: with SMTP id z20mr15272464oth.80.1619025166551;
        Wed, 21 Apr 2021 10:12:46 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j8sm2056otj.49.2021.04.21.10.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:12:45 -0700 (PDT)
Received: (nullmailer pid 1309858 invoked by uid 1000);
        Wed, 21 Apr 2021 17:12:44 -0000
Date:   Wed, 21 Apr 2021 12:12:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V2] dt-bindings: thermal: brcm,ns-thermal: convert to the
 json-schema
Message-ID: <20210421171244.GA1309813@robh.at.kernel.org>
References: <20210415111655.4273-1-zajec5@gmail.com>
 <20210420210104.10555-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210420210104.10555-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 20 Apr 2021 23:01:04 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Add maxItems to the reg property
> ---
>  .../bindings/thermal/brcm,ns-thermal.txt      | 37 ------------
>  .../bindings/thermal/brcm,ns-thermal.yaml     | 60 +++++++++++++++++++
>  2 files changed, 60 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
