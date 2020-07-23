Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6561722B403
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jul 2020 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGWQ5B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jul 2020 12:57:01 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36214 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGWQ5A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2020 12:57:00 -0400
Received: by mail-il1-f193.google.com with SMTP id x9so4928015ila.3;
        Thu, 23 Jul 2020 09:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qkJiEOkbfEtZ6U8BrzXc3UILmFHYpQckFVC7GGEy+hw=;
        b=foIsvSXdUBOB4URzPaRhOueiGii7r5v5FkeYqgWa7zTtVin7SpGTwwCJi1cBjmcpUz
         NHlniv5STJvVaFn9eAZKJ6O0PhWIASdo0+ukQQy0Rsu/ik91+czKXDSXRFm0AKGsInBQ
         ue4zXfW4aZLh4k/PmOWS9rPvV0JfDYFPDfxlDsV5ygLW19Zhm65YC05auksaZkogHTMw
         YMNQj9jqpu4mBZ75sy0SmJZOHp4IrTE3CZmCyCmdvDBa0O+aPD6P8ZVWSfgt71kSHf9S
         tc9KfFYSSl7mpkxSVrgkb9A+TcMOkLQf6BMu+W/u5CvWJ0gPzl+R7U8yl1Ek3CvmPaLx
         vdeQ==
X-Gm-Message-State: AOAM532bMga4chGsgdCEcmihiTi/CSu8cc2KGiGDCYxchBNKYJoqD1gT
        1PM5SC/OllSujGdEi3VSzA==
X-Google-Smtp-Source: ABdhPJxgpIx7lbszfuOpsa2ooYop0yyX5zAdCCqIFyhijPRxX77gge6X7qbtT5ElRCGaA5Nt9m968Q==
X-Received: by 2002:a92:db01:: with SMTP id b1mr5727944iln.249.1595523420050;
        Thu, 23 Jul 2020 09:57:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v10sm1726967ilj.40.2020.07.23.09.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 09:56:59 -0700 (PDT)
Received: (nullmailer pid 527700 invoked by uid 1000);
        Thu, 23 Jul 2020 16:56:58 -0000
Date:   Thu, 23 Jul 2020 10:56:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     afd@ti.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmurphy@ti.com, sspatil@android.com,
        sre@kernel.org, pali@kernel.org
Subject: Re: [PATCH v17 2/4] dt-bindings: power: Convert battery.txt to
 battery.yaml
Message-ID: <20200723165658.GA527644@bogus>
References: <20200720204400.7351-1-r-rivera-matos@ti.com>
 <20200720204400.7351-3-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720204400.7351-3-r-rivera-matos@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 20 Jul 2020 15:43:58 -0500, Ricardo Rivera-Matos wrote:
> From: Dan Murphy <dmurphy@ti.com>
> 
> Convert the battery.txt file to yaml and fix up the examples.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/power/supply/battery.txt         |  86 +---------
>  .../bindings/power/supply/battery.yaml        | 157 ++++++++++++++++++
>  2 files changed, 158 insertions(+), 85 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
