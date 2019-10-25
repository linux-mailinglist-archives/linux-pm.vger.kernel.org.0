Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6FBE51B7
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633177AbfJYQ54 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 12:57:56 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42913 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633153AbfJYQ5z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2019 12:57:55 -0400
Received: by mail-oi1-f195.google.com with SMTP id i185so2051530oif.9;
        Fri, 25 Oct 2019 09:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hq9rx4uZQsLcywYZ8a8zWtFe+JHQBE/zXzg6s+nJ+pU=;
        b=QZii1/sNkjEdJvTbUEVCUGWHcco6FXaW7JDf9Ex2l7BVlJy1MmI8qTGs0rhF1+yqNJ
         IXTPcbR0mkQ/8roolQEa1bMEywbq4/+cG7T0e/NfvvGmpE5FYfzUOLuYn9FTudQaOnPv
         JKDgSV3ZuRc9FruOiKRCqnFswlE1SaDROKlko4pLKdiaBXja8CgORvNVt6n2Pamxf4PG
         bUYimdL1IXRf/iyg008bjTZMLd+cdNHs2/bVu3AWNhhLX/TAiajqhldkw7Cl+Pv733t9
         k/1tFYOwM0G6F5W7xR6me4LvEUswVVRCRH+MM9bJBfWrSckjT1EcNNk/vHnxrmSNha0U
         CPSg==
X-Gm-Message-State: APjAAAWY0J8aNhbT0M5v1kVds72FmMSYVjjXuz6u9nJowsl3m06Ojm9H
        cepsRrC2Pg+7C/XLy2CS0bbhvpI=
X-Google-Smtp-Source: APXvYqyAkVeN+VUGzwpWfNbuaHqU75wGHHJARoXofxTxatKCJ0VHMOLlyBDlykfgv602riq0RIfVgQ==
X-Received: by 2002:aca:2b10:: with SMTP id i16mr3694345oik.43.1572022674653;
        Fri, 25 Oct 2019 09:57:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t18sm867806otm.8.2019.10.25.09.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:57:54 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:57:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 3/6] dt-bindings: power: max77650: convert the binding
 document to yaml
Message-ID: <20191025165753.GA28678@bogus>
References: <20191021124428.2541-1-brgl@bgdev.pl>
 <20191021124428.2541-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021124428.2541-4-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 21 Oct 2019 14:44:25 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Convert the binding document for MAX77650 charger module to YAML.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../power/supply/max77650-charger.txt         | 28 ---------------
>  .../power/supply/max77650-charger.yaml        | 34 +++++++++++++++++++
>  2 files changed, 34 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
