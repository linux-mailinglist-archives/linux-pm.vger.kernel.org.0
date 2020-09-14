Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAF72694C5
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 20:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgINS0J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 14:26:09 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35904 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgINS0H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 14:26:07 -0400
Received: by mail-il1-f195.google.com with SMTP id t12so532834ilh.3;
        Mon, 14 Sep 2020 11:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rq0hnbPqOkeqlEPTQNm8X9uJmFEAznr4V29mG/gkHQE=;
        b=NoHNgZqNOl7guxY8H+9+i7DGtaRZjtWEdLVuQk6IBpjE/E6p42CI9bIKpcEG6pQeX3
         jx7QKSLxbeEYEhRnv6lnCcsQecxcue8GuX65H+BzC1fehRs+vra2W8YyDpZwCCmvlXjf
         67ahzgVOsSlDJURoZe7lqvuNX+fRwncxkAf4QOSioY3PGM7n6BeHk5fexVI7VOg6aHcc
         CDfpe4ZQPFcJ70jxYPPV8eBAIpfopaicEk2Svkflh66huvnrbw1JmW5Ug+sPswe3Ehiv
         5vrL5CXhXxCIqgaCl240mA9+lUVaKPQ3ZywEhNIzzQDuDkCyNM9D0uFh60LzeMqgEnOo
         sGJQ==
X-Gm-Message-State: AOAM5311P2u4N2n2CthB9A/TrX8pZvYdgworX+2yk41T6NarMqjbS8+z
        k3DH7CB6lFwaTHEdGfSxwA==
X-Google-Smtp-Source: ABdhPJy5SnhRMfGVLJRR5dpLgmyokAyOOBOOBr4KyTye5WZGAkEz2lKRkFbzucuhfGFboDAlpU06OQ==
X-Received: by 2002:a92:d188:: with SMTP id z8mr13300621ilz.292.1600107966859;
        Mon, 14 Sep 2020 11:26:06 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b12sm3356754ilq.53.2020.09.14.11.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 11:26:06 -0700 (PDT)
Received: (nullmailer pid 4187875 invoked by uid 1000);
        Mon, 14 Sep 2020 18:26:04 -0000
Date:   Mon, 14 Sep 2020 12:26:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     sre@kernel.org, r-rivera-matos@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-binding: bq25980: Add the bq25980 flash charger
Message-ID: <20200914182604.GA4187822@bogus>
References: <20200831164849.31313-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831164849.31313-1-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 31 Aug 2020 11:48:48 -0500, Dan Murphy wrote:
> Add yaml for the bq25980 flash charger.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/power/supply/bq25980.yaml        | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq25980.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
