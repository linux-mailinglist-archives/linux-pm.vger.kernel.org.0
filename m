Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9151E540C
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 04:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgE1CkJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 22:40:09 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:40218 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1CkJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 22:40:09 -0400
Received: by mail-il1-f175.google.com with SMTP id a18so8892726ilp.7;
        Wed, 27 May 2020 19:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q/b8+vil2c5/mUJG0KmMizu2N1xJ207ZEvkbx+vGTLM=;
        b=iDE9OscS5FTs/yv8wHBM1co4T8K5dLl5xvDZsFXkIDidulHIncgb3jlMy3FTRzGuq3
         owQIBZk+9joJVKm0GCg0xba+uT3Huxj1Eq1h8HqLB1QrvRI8ipmj1Jhhu6yvVqcYlG0u
         E6MRGrEtG4MSiQ6JufRKmlWPddTuyWGm4fUMT7uQXSdVGl/jMYR+0bMvqtytkCJUzuCk
         qCybZqq7decT2cT5/6sn4JRPf+Y3iRx0idfVaUxcnoYuOYU4t4nuZ1oUm9617AdIwy0w
         KFs3ZdaE6xyFzjCJhf/7r5RYz8+hJJSuvyFm3aQYQOCITZd78+R37VAv3A1QEs+vUhmy
         Yx3w==
X-Gm-Message-State: AOAM531j9CyNwI/SVNRqhXcTFOdEc6pF7PrP5bX4YZEe3WXzDR/FQuuK
        KYKxmm/PScxS3B07JhalBQ==
X-Google-Smtp-Source: ABdhPJwYBCuH/4rhSMVSlk4sAIWXL1+/RSzIHHx+Yhr9XE/1CjMAqyOYGFESKnuRN8k4rahiKF4fgw==
X-Received: by 2002:a92:8c8a:: with SMTP id s10mr1094610ill.14.1590633606866;
        Wed, 27 May 2020 19:40:06 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l3sm2162132iow.55.2020.05.27.19.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:40:05 -0700 (PDT)
Received: (nullmailer pid 3258363 invoked by uid 1000);
        Thu, 28 May 2020 02:40:04 -0000
Date:   Wed, 27 May 2020 20:40:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv1 19/19] dt-bindings: power: sbs-battery: Convert to yaml
Message-ID: <20200528024004.GA3258314@bogus>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
 <20200513185615.508236-20-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513185615.508236-20-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 13 May 2020 20:56:15 +0200, Sebastian Reichel wrote:
> Convert sbs-battery bindings to YAML.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../power/supply/sbs,sbs-battery.yaml         | 83 +++++++++++++++++++
>  .../bindings/power/supply/sbs_sbs-battery.txt | 30 -------
>  2 files changed, 83 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
