Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7BBA19A079
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 23:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbgCaVJ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 17:09:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40644 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgCaVJ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 17:09:29 -0400
Received: by mail-io1-f66.google.com with SMTP id k9so23372633iov.7;
        Tue, 31 Mar 2020 14:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qrx7bERZsPzTBRtm42b8khXgzSkWQ172V2LvLfZm2O4=;
        b=qvVqT1hDnVMHZzdj21gKNX2/ufMeOjE6S3rEag1DU/5eBkax7v5JRcdAfbq7itdVLn
         5F5ILexAeCczNNG0aMtCXh/DSFAAY1jEXa67WVTgKaz94WdKLhyO38gjMrEmTbdYjkMV
         25ifiaeDdIA52VY/rmjYbc3VXe/eO6iI50opzouWXs8XBxH35JVTgvInScCe/IFXDvoc
         RRGcTYNdI9ibsBrwK0RMH6uilq+vFqKhYXrIsJgDRbgFckXYlceovWbeUCS0fI+fXDc4
         3RXkHo6JzBRthweSGuX8xR11Ofe7JPIB6ESYAki+S22cPqnhKDZ1+8VFKjJEoGRKiAU1
         tw8Q==
X-Gm-Message-State: ANhLgQ1nLRAcBS/BZN6+AbkA+m0KKRhelQ6izBoB1m3emfY7zHZPZTtz
        pJsLYq0w5Cb9Tg6qF6HM0w==
X-Google-Smtp-Source: ADFU+vsftvgaJaA5MmHE1ynk0h7BvPOPvcdp5cB2X/N7eZyz+Zp7rH6PR11JRoGjZVyAOwkyg3fQxA==
X-Received: by 2002:a5d:8c8a:: with SMTP id g10mr11152138ion.201.1585688966743;
        Tue, 31 Mar 2020 14:09:26 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j70sm13465ilf.17.2020.03.31.14.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:09:26 -0700 (PDT)
Received: (nullmailer pid 14928 invoked by uid 1000);
        Tue, 31 Mar 2020 21:09:23 -0000
Date:   Tue, 31 Mar 2020 15:09:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: thermal: tsens: Set
 'additionalProperties: false'
Message-ID: <20200331210923.GB12554@bogus>
References: <20200324180513.3882-1-robh@kernel.org>
 <20200324180513.3882-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324180513.3882-2-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 24 Mar 2020 12:05:13 -0600, Rob Herring wrote:
> Ensure the node only contains the properties listed in the schema by
> setting 'additionalProperties: false'. Doing this requires reworking the
> interrupt properties schemas so that they are defined in the main
> 'properties' section.
> 
> Fixes: a877e768f655 ("dt-bindings: thermal: tsens: Convert over to a yaml schema")
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 28 ++++++++++++-------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 

Applied, thanks.

Rob
