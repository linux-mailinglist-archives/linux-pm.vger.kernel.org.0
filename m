Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7DFBD2F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 01:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfKNAxx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 19:53:53 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45957 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfKNAxw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 19:53:52 -0500
Received: by mail-oi1-f193.google.com with SMTP id 14so3649881oir.12;
        Wed, 13 Nov 2019 16:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WiR0ypBh3Fj7NpRPQKyGnCgyTRA5E81l+DOjjcx1SJU=;
        b=Zh9oTnXN0POT0dGSNbI1qfTNvLCWoNOpbFqzKS5eEGwlVtWvs/xdxCRlLrbNQzfFdQ
         z5HqalEw1XdmOzI3wR3tgQJ5GDnItjaJWj1xjz/N85jLwT3Vc+AZdSsF8x8lMn6ut/dl
         gqlhr109IPeTUgOX7w5M/0PBMA15vjrIN4QbuD1qJb6HsAUZ5R1Noz0EGPfTyV1EAGr1
         Blz65TlZNIp3zKfFUFeohIQ2CHEfMquB0MlkAm2KIsFFWagi2baRXYsa0sZk8x7jdy29
         x4ugNIfBXhkow0JNqAqaMDWG7bA1ShrZdGnrs1fdSHjc6eqHgc0S6/k/E3xn5QJHL7mA
         5yqg==
X-Gm-Message-State: APjAAAXXa7jojX2WGCXFUe5xS6I72STXeJhmbvvH3qUTiutI0pFGYt3a
        5Q7MHxn9LSsXHBMSnsKWkaIMlP0=
X-Google-Smtp-Source: APXvYqxvCcVvgVN98761rsnFULS7AIgOklv+HIvmBNh/OmjZZqrKbwHetHnntAnLYFc4Szpeu4eo9w==
X-Received: by 2002:aca:c3cf:: with SMTP id t198mr1358608oif.10.1573692830326;
        Wed, 13 Nov 2019 16:53:50 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b12sm1289988otl.34.2019.11.13.16.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 16:53:49 -0800 (PST)
Date:   Wed, 13 Nov 2019 18:53:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v6 2/5] dt-bindings: power: supply: Max17040: Add DT
 bindings for max17040 fuel gauge
Message-ID: <20191114005349.GA23919@bogus>
References: <20191105095905.GA31721@pi3>
 <20191107031710.5672-1-matheus@castello.eng.br>
 <20191107031710.5672-3-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107031710.5672-3-matheus@castello.eng.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu,  7 Nov 2019 00:17:07 -0300, Matheus Castello wrote:
> Documentation of max17040 based fuel gauge characteristics.
> For configure low level state of charge threshold alert signaled from
> max17043/max17044 we add "maxim,alert-low-soc-level" property.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../power/supply/max17040_battery.txt         | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
