Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E7FE51B1
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 18:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505768AbfJYQ4j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 12:56:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36445 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbfJYQ4j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2019 12:56:39 -0400
Received: by mail-ot1-f65.google.com with SMTP id c7so2530742otm.3;
        Fri, 25 Oct 2019 09:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n8vqf9dLwTsGTBgK1g33cr8B5xKtZqiaKcIRTMTeyfE=;
        b=oavJJYWy3WnRzalHos5FIRdt6MvtwAucFAsk0QVNIMu9ltn5cOBBenDFgZ4iAwQAda
         SSe5j6WVRCw2UB/XWSgK9O+dK84ggvS2S6RlgdV6BXk+4AvzCXmH6IXCmCB+/PG07TSW
         CqqfyYROJfO0vAltFjplyWmcbgn84Jvt71URcl1/9FwpNGznrK9EWcjYU53Fb/eIsOre
         JWzL7/HakV/EW7QbeKCuV1GBByfBc+gUIJnEDqbM2rc/DW5b8vHrFYaFIYBjiro5xo74
         1QVvBDSLrMqVeQSaBzJ8s4uH3/wI7pRGfVrl5MZAw/y9jdBUqCP52WygZ0wwUB7RmSK0
         bKiw==
X-Gm-Message-State: APjAAAVT0WKxinBtnudUmAX/4Jne5n8fDUgYMwwOtnlS+TN01J591dzW
        u5NcFMnzJycu+yp5zyh9Zw==
X-Google-Smtp-Source: APXvYqzZLlPI7VNCS+rdHZMnC5H/HwwT3QNxyBcZM13Vjm5DqM8M64uqaWorWzBhJ1Tq+kS+k3kfQA==
X-Received: by 2002:a9d:4e98:: with SMTP id v24mr3677564otk.58.1572022598242;
        Fri, 25 Oct 2019 09:56:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c19sm884854otl.6.2019.10.25.09.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:56:36 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:56:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: regulator: max77650: convert the
 binding document to yaml
Message-ID: <20191025165636.GA26878@bogus>
References: <20191021124428.2541-1-brgl@bgdev.pl>
 <20191021124428.2541-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021124428.2541-3-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 21 Oct 2019 14:44:24 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Convert the binding document for MAX77650 regulator module to YAML.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../bindings/regulator/max77650-regulator.txt | 41 -------------------
>  .../regulator/max77650-regulator.yaml         | 31 ++++++++++++++
>  2 files changed, 31 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
