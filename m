Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1119B3E312D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242026AbhHFVgE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:36:04 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:42544 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240733AbhHFVgD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 17:36:03 -0400
Received: by mail-io1-f44.google.com with SMTP id h1so14117027iol.9;
        Fri, 06 Aug 2021 14:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/ik42tPKn0qpoaFiha5BKumK43an0w5BRwfSK/rVvoI=;
        b=rBmkdzqp5l4HESmpCx2PUTnx4ckwnuurRwJpLbM2k39fSv9EAuwMxwpY6H2KpXhRim
         d1PLT6zND6sQRw4bw9KZlJFeDxbk0LCeYbSMBToO/SUFIXVOPy/cYWpZZw3d3Ic9Xw8G
         gljflVsxGN3TE/iL1aHD7dSLZgqRDy2oW3QjlrUXnsoxQSo83L9fbIdsdIPUYHC+9Vjq
         JIvIXdedMZgh1GaFc5xEAZQrLjldSwd3Gm7ZJb6sJ7kfi+gtdTBpi0FAF4SVWfdjyo0j
         vBLfTHB8uH1/lr4hy2wROYIB/L/2VQRZvApJ0+jeiEt5AN8bQ5VdIQeRCKYg5BbZZepO
         DQnA==
X-Gm-Message-State: AOAM531Vw8/XpVqFmYkkZiucZeDbztfzgqUh6fraHVpSl+IAiN4bCZHR
        D+87FFR56jG8rGkl4wIWVQ==
X-Google-Smtp-Source: ABdhPJwNZkQV1Vkfr9LgD4GxoPxbYAhMAFKiMAJzG5oxAPlKU68aUhB0EzPN+ckSJ8auIFksN1rf8g==
X-Received: by 2002:a02:7f12:: with SMTP id r18mr11496411jac.50.1628285746417;
        Fri, 06 Aug 2021 14:35:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c1sm5452519ili.35.2021.08.06.14.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:35:45 -0700 (PDT)
Received: (nullmailer pid 1843011 invoked by uid 1000);
        Fri, 06 Aug 2021 21:35:44 -0000
Date:   Fri, 6 Aug 2021 15:35:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] interconnect: qcom: Add MSM8996 interconnect
 provider driver
Message-ID: <YQ2rMOTLZg5XduFn@robh.at.kernel.org>
References: <20210801152427.475547-1-y.oudjana@protonmail.com>
 <20210801152427.475547-5-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801152427.475547-5-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 01, 2021 at 03:25:28PM +0000, Yassine Oudjana wrote:
> Add a driver for the MSM8996 NoCs. This chip is similar to SDM660 where
> some busses are controlled by RPM, while others directly by the AP with
> writes to QoS registers.
> 
> This driver currently supports all NoCs except a0noc.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  drivers/interconnect/qcom/Kconfig             |   9 +
>  drivers/interconnect/qcom/Makefile            |   2 +
>  drivers/interconnect/qcom/msm8996.c           | 574 ++++++++++++++++++
>  drivers/interconnect/qcom/msm8996.h           | 149 +++++
>  .../dt-bindings/interconnect/qcom,msm8996.h   | 163 +++++

Belongs in the binding patch and should be dual licensed.

>  5 files changed, 897 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/msm8996.c
>  create mode 100644 drivers/interconnect/qcom/msm8996.h
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h
