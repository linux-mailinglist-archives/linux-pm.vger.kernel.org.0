Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37D83C5F62
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 17:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhGLPjv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 11:39:51 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:37527 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhGLPjv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 11:39:51 -0400
Received: by mail-il1-f175.google.com with SMTP id o8so9162903ilf.4;
        Mon, 12 Jul 2021 08:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+v/C3HhVpzVh+emkYtSgeszTQ+6xKMpx5E3RKEB3iPM=;
        b=r9SWYg+Q7CkYIQyDKlB759YE8hC9YndXNltax7Ktd5et3CkwGf+Tikn2U9J6qCRiYu
         RozpZ22u4QF/m3E9YFashQvGZ4oCm2/q9TDedZTk265b9EB5BovjQtU7IlTRHBwlRGcM
         lmD2OrPKWSnb/s5txRwszeYw/vGshizHn2szc1/dyk0Bs8TMZN4KeSDau9iGSx0KB/+/
         jOEMY6bo5sirk2wazYlGwskHoMcjUCEzg1EKdugKvxpAXxAbRmpI9O13pdYLmttnZ3Oj
         e2eQeCN2oCEENYOPl7E9GUyOB+F8ykvHm8xLodrbKQycq+sr0NxS+kfkb6a6MgY3UAiA
         Q1SQ==
X-Gm-Message-State: AOAM530bjLdgiA3T0mui8Bhjd+MR6mPM5aI0UQh/kYgJ6zuIJpRjdgGW
        4mfumley1Fxo/fS6BZTfhw==
X-Google-Smtp-Source: ABdhPJzmc51CTY7qWur4uyZR4os11C6oex2SMvWqW2cYkTp5LM+cb9uBLblf3Ze6b3tN+PPkmiJSiQ==
X-Received: by 2002:a92:d083:: with SMTP id h3mr13387917ilh.157.1626104222749;
        Mon, 12 Jul 2021 08:37:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t3sm5039256ilm.87.2021.07.12.08.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 08:37:02 -0700 (PDT)
Received: (nullmailer pid 1980098 invoked by uid 1000);
        Mon, 12 Jul 2021 15:36:59 -0000
Date:   Mon, 12 Jul 2021 09:36:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 01/12] dt-bindings: phy: tegra20-usb-phy: Convert to
 schema
Message-ID: <20210712153659.GA1980043@robh.at.kernel.org>
References: <20210704225433.32029-1-digetx@gmail.com>
 <20210704225433.32029-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210704225433.32029-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 05 Jul 2021 01:54:22 +0300, Dmitry Osipenko wrote:
> Convert NVIDIA Tegra20 USB PHY binding to schema.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/phy/nvidia,tegra20-usb-phy.txt   |  74 ----
>  .../bindings/phy/nvidia,tegra20-usb-phy.yaml  | 357 ++++++++++++++++++
>  2 files changed, 357 insertions(+), 74 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
