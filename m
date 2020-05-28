Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384BA1E5409
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 04:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgE1Cht (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 22:37:49 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:36430 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1Cht (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 22:37:49 -0400
Received: by mail-il1-f173.google.com with SMTP id 17so26190144ilj.3;
        Wed, 27 May 2020 19:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z4hq3G7x3ppxeCNs2d4Tddnb3w+t9fJRDF8t6tEJy78=;
        b=IyopJv4BxIDS690BLE2JVB2YgeANHTReaRiOwf5cG2m7hczqOuLM8pmeGTGQlF9a4V
         vGAJw8anWLeILxKfOImk/DDNqeQDIoAqET8DhCMhJiiHMcS6GTats3SzKSNarMi4rWAu
         s3hmZYa+cHrsnPOf75UhrfJyYRM8R7VEfjfVTwtjhFfwp+HvkXJ5cvcmIUZufAB1lB4f
         q9wMEHQGdU+OWwFHEARkgXYO/Q8w9Y3FsO/e7W+V8nzNUgX3dY/rAoQEs0USUm0nBvnW
         pmHWspVBG1iTWiNbYwVVTIiySLjYlYX/SXcd4/bSHvY+bRHtjRvWZYvoOktedCx7lrCy
         Bxtw==
X-Gm-Message-State: AOAM530cwGReT40jeCCWXFscHoa76NQycqpTPaOLN+J6PpNYSrLpx2+q
        vKc3JBjOtZVOXztOxSjEpw==
X-Google-Smtp-Source: ABdhPJwBxgsdgMbJfm1wkXmxJAFNeJK0GwcD0ZSIcUpww4e79m8N3gPGaWxpZHNuoxuy1YTg8wuMAQ==
X-Received: by 2002:a92:cb91:: with SMTP id z17mr1008436ilo.305.1590633467906;
        Wed, 27 May 2020 19:37:47 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f9sm2570509ile.39.2020.05.27.19.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:37:47 -0700 (PDT)
Received: (nullmailer pid 3255257 invoked by uid 1000);
        Thu, 28 May 2020 02:37:46 -0000
Date:   Wed, 27 May 2020 20:37:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, kernel@collabora.com,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv1 05/19] power: supply: sbs-battery: Add TI BQ20Z65
 support
Message-ID: <20200528023746.GA3255207@bogus>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
 <20200513185615.508236-6-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513185615.508236-6-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 13 May 2020 20:56:01 +0200, Sebastian Reichel wrote:
> Add support for BQ20Z65 manufacturer data to the sbs-battery
> driver. Implementation has been verified using the public TRM
> available from [0] and tested using a GE Flex 3S2P battery.
> 
> [0] http://www.ti.com/lit/pdf/sluu386
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/power/supply/sbs_sbs-battery.txt     |  1 +
>  drivers/power/supply/sbs-battery.c                | 15 ++++++++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
