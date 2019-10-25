Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80EDAE51BF
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 18:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633196AbfJYQ62 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 12:58:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38412 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633165AbfJYQ62 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2019 12:58:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id e11so2521976otl.5;
        Fri, 25 Oct 2019 09:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ElE51MT+I4wmL0/dbESA4ygue4whjmBwMgf68q9obM8=;
        b=A9Y7MldM1yxQATWZg7A522xYmGMkaHuBN3B5ucHR+WoaGxKNGBeIOKH57bOv46SNl4
         v64Qg+ODh4VGtjlneFVdHRWlc+CEXxs5mCiJp7S/C2EBoPT5XmNlqobaLgCu6RjJbDP0
         vXoc+1c1iO6/dC6EMs5+ArbEE7EoomATqTiByKG4Ybd2vzFiSSC05KqiJFJMy0B/981I
         Rq1MJbgW0B/N0eqH6iP+YwZfv+sS5Oi8C7u44fJuXxGxSnHMtDbbBzdb5gSq+4AHm8uM
         IA9bOA2dXaX4vYO0UqrlpXWP9SaR8cvvykCgZyxXzqoBPq4G0Fmu+kBAASz4qk7O/Mn1
         lLGw==
X-Gm-Message-State: APjAAAXcM5l0iKHjVamhbaMPxyX1dfEUJ4B398u93aNaxYgUNk/rneu2
        uLTW2fY1xYNtYynBc904lw==
X-Google-Smtp-Source: APXvYqyavpBxfqAiWsKkQFRqXnw8/pXEhcCRAgBm41Js4z40cOkaPsKiUfJ9gfraMRFXvtrXuB3k1A==
X-Received: by 2002:a9d:70c4:: with SMTP id w4mr3473341otj.45.1572022707363;
        Fri, 25 Oct 2019 09:58:27 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v10sm885905otk.17.2019.10.25.09.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:58:26 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:58:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 4/6] dt-bindings: leds: max77650: convert the binding
 document to yaml
Message-ID: <20191025165826.GA29818@bogus>
References: <20191021124428.2541-1-brgl@bgdev.pl>
 <20191021124428.2541-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021124428.2541-5-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 21 Oct 2019 14:44:26 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Convert the binding document for MAX77650 LED module to YAML.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../bindings/leds/leds-max77650.txt           | 57 -------------------
>  .../bindings/leds/leds-max77650.yaml          | 51 +++++++++++++++++
>  2 files changed, 51 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
