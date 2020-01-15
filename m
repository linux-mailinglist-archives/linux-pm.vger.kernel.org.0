Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C38B13C650
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 15:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgAOOjE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 09:39:04 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43788 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgAOOjE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 09:39:04 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so16234349oth.10
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 06:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zVuLMr/lvKJoF5UPfuI+lUQAIQkXCUMqhXcAHAs8ml4=;
        b=lUX0ngfESkeB6q+etnxFA8WjxA3W744Er7S18aKd8hINLAq0EAVX1K/Y7yWE4nN/ZA
         HJrkcldPCVsgqJyDatSIzBhE/zTD7k3MPdW+sudhkDmAzVO5g+tYw9fO8JBlJhzPVV+S
         gYwPyCtywLn7Ifd1a9o4wNO597QGBI5Ib3NZ8it32CofLfYRx7zWhQHzfhiMkc5SQZYv
         ObXKpxqH5kWBSF+GD5zMrlcHD/t+Ybvm3sOo3AuJkHQK9KP/RjeMlos5R0Sa9Li0+qsC
         mqF4rWapfGNbDwqGbMwz8n6XoppQ/h/yQxTPOCDrpap/DRqXTv9olImMbpz5IDwxMGzs
         z9MQ==
X-Gm-Message-State: APjAAAWwTZs65WRSrLfC1pIOShPs8oK1g+/4l9Od6F/kPm6RZZdIcevh
        3pfsM/12gxlvuoCDlAYlF1mJjks=
X-Google-Smtp-Source: APXvYqyPUYlJcxJYcfen/R+X2sbta4yRaaIJxhFepbaSEqsNcJ5qM0TSlM9vnRO2Z2IWKNe03FjWsw==
X-Received: by 2002:a9d:65cb:: with SMTP id z11mr2801495oth.348.1579099143081;
        Wed, 15 Jan 2020 06:39:03 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k26sm5716781oiw.34.2020.01.15.06.39.01
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:39:02 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220379
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 08:39:01 -0600
Date:   Wed, 15 Jan 2020 08:39:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Dai <daidavid1@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, David Dai <daidavid1@codeaurora.org>,
        evgreen@google.com, sboyd@kernel.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: interconnect: Convert qcom,sdm845 to
 DT schema
Message-ID: <20200115143901.GA4664@bogus>
References: <1578630784-962-1-git-send-email-daidavid1@codeaurora.org>
 <1578630784-962-2-git-send-email-daidavid1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578630784-962-2-git-send-email-daidavid1@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu,  9 Jan 2020 20:32:59 -0800, David Dai wrote:
> Convert the qcom,sdm845 interconnect provider binding to DT schema.
> 
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
>  .../bindings/interconnect/qcom,sdm845.txt          | 24 ------------
>  .../bindings/interconnect/qcom,sdm845.yaml         | 43 ++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
