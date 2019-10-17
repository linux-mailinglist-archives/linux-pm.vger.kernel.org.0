Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3042DDB63E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 20:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438498AbfJQSeb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 14:34:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36244 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfJQSeb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 14:34:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id 67so2781263oto.3;
        Thu, 17 Oct 2019 11:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5eCgFcw6lb1zQQJyjOQaKaJ+Cs4fF/tvcbuIThPKlE0=;
        b=MbUNSVvFgOwGciXFi5HeuqZzA8a7MsjgXfCLELhpnBHrCQS4XNyTGylT9VACRbTRaN
         mZ8SOBsnlzb03UjQZXZQzjerGeaAoNhtCdTr5VRrNNL8Bzd5nKFbK4ovqKOUwfyegrYE
         HnUxNiM7DmTAoOvA3+z84lzBB2T9OJH9G9cylXeb2FwwW7t/GWMhKSvE6r5EEqelHqTN
         eo2RKzu5/rUxvaPGzQGfWt4GQM0gsptd0SM8Egx5mmddsBSBp2XUNMI6GX/1unW2tka+
         hbo2uisSsYYaDX7x+apFWQjIr/KzIaSkjqKQSWg4wzxEdri15/TA5oCyhRO4u/z+MJ2s
         cEBA==
X-Gm-Message-State: APjAAAWd9Z8xWnkaw2Jz6/31ku+8qv7hUbrq6S1R0DZvov0gjtC/khT0
        q9wZvlcmgm8SvYBMBVikdQ==
X-Google-Smtp-Source: APXvYqyXxeK2Dtv+dJVDFp/N2w5lBEv2g/xlgdneBsYke+4BStuNidl4FvEfWZh1lkb/6+P5CMQG6A==
X-Received: by 2002:a05:6830:10cc:: with SMTP id z12mr4332737oto.110.1571337270649;
        Thu, 17 Oct 2019 11:34:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 91sm824744otn.36.2019.10.17.11.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:34:30 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:34:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: input: max77650: convert the binding
 document to yaml
Message-ID: <20191017183429.GA28159@bogus>
References: <20191017071234.8719-1-brgl@bgdev.pl>
 <20191017071234.8719-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017071234.8719-3-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 17 Oct 2019 09:12:30 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Convert the binding document for MAX77650 onkey module to YAML.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../bindings/input/max77650-onkey.txt         | 26 --------------
>  .../bindings/input/max77650-onkey.yaml        | 35 +++++++++++++++++++
>  2 files changed, 35 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
>  create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
