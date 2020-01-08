Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1E0B1347EB
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 17:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgAHQZv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 11:25:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43435 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgAHQZv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 11:25:51 -0500
Received: by mail-oi1-f195.google.com with SMTP id p125so3099731oif.10
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 08:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eh1a1EgozWErHHqGLEoauZ/x7T61NxvHf+uJt4V80kQ=;
        b=CZrDPiW75pomp3J0+WOaTDx/zGhIB1pmsabOfXL0j4nm9JKqpJGiCIQHWfdAqb4PvS
         0/3spvejh+q0WgD4cmF+59JgDIJvSYc8WLXSPNr9O37TXYYmX0vyP1fmHkzrnWwaBPi4
         Dc/EGSaNyWTCIqDBdJDKEKM8aBlEbx4ZlaPJAxbiYtRMW0x6e3uKzg3in3sZu51jZEMf
         8HTKy24P7/upppqSLl+ROFZVUDtrATCF6kuzbqReXfIR60oPkdRiVpUEZpapTmZv3MFs
         JGA3QHT/4rStfQDarEwHhDSQbWxjlAVJKz9l9TEqM1TFL6lqGKfWqjzCkKqox1dtXKD/
         hy/g==
X-Gm-Message-State: APjAAAVD1ni0gu64lI3n2+j9O01VADQp0bjN61OJob4voB9o5Dfp3ycz
        z7XFhq71LytXfLjhF/IPEbx0Tlk=
X-Google-Smtp-Source: APXvYqxo+pDJmtJourOU03W5OOJTMKu8IRdRNiJWAyvbXDC24ITWiT+E4UmwNg4cFq7RAC1JKOPvpA==
X-Received: by 2002:a05:6808:191:: with SMTP id w17mr3577541oic.29.1578500750874;
        Wed, 08 Jan 2020 08:25:50 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w201sm1220509oif.29.2020.01.08.08.25.50
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:25:50 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:25:49 -0600
Date:   Wed, 8 Jan 2020 10:25:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, sivaa@codeaurora.org, manafm@codeaurora.org,
        Rajeshwari <rkambl@codeaurora.org>
Subject: Re: [PATCH 2/2] dt-bindings: thermal: tsens: Add configuration for
 sc7180 in yaml
Message-ID: <20200108162549.GA24298@bogus>
References: <1577106871-19863-1-git-send-email-rkambl@codeaurora.org>
 <1577106871-19863-3-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577106871-19863-3-git-send-email-rkambl@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 23 Dec 2019 18:44:31 +0530, Rajeshwari wrote:
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
