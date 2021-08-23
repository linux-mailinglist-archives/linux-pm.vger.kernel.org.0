Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCA53F525D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 22:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhHWUpO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 16:45:14 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41530 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhHWUpN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 16:45:13 -0400
Received: by mail-ot1-f43.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso25039590ota.8;
        Mon, 23 Aug 2021 13:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pnr2xBK6f14eA69KuSvKgWmz6GZszF17FwIvkm7oDPQ=;
        b=TgVKODDU201gj8GFMShejoxGML2gktiRIaYEkEJVYQF5k3erIE8wRqZ+H52kfTqiqZ
         dYPOjs5vN8Gjj30bOqWhwMrWjA0Dgw43qh4lDgmplucCjZAHzzgQ/kp5Cu3K5NKJwIRN
         OylBWQmspH54ZZZABAcI61yYpRY4rRebsJPJTrp+kl9Ff4/SxrfmLmPwHYA0HRL3w0y7
         E0dMV7cvH8BpBCauEpVUDmrj/VIVTmMdbx6ubKTIx7JJuIanmLjsYqJtExcEM3fC9xqa
         9/IYbxV01cC6s9vJf6LQuu0uZfWYmc4v6gYEwkeZXt0gzroOuNZiHN0SdQEHEMyQnXih
         S0qg==
X-Gm-Message-State: AOAM533KsTaxOxbWBxZgY1PdPRaBRdJFCnbPtWeaVx9SA6QEcmKkV9IJ
        5jKw5iOvYr4cyRz6Xq7j/Q==
X-Google-Smtp-Source: ABdhPJymyma9K8zi/fJwYE1whIW0bn8y6+qCPO73H/lWchveQw3/xnjL7fxLXL0v8fKNbN7U/MLrUw==
X-Received: by 2002:a9d:6490:: with SMTP id g16mr29309183otl.184.1629751470513;
        Mon, 23 Aug 2021 13:44:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b2sm3072327ook.46.2021.08.23.13.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:44:28 -0700 (PDT)
Received: (nullmailer pid 2691639 invoked by uid 1000);
        Mon, 23 Aug 2021 20:44:27 -0000
Date:   Mon, 23 Aug 2021 15:44:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     elder@linaro.org, linux-kernel@vger.kernel.org, evgreen@google.com,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, mdtipton@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org,
        seansw@qti.qualcomm.com, saravanak@google.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        Sibi Sankar <sibis@codeaurora.org>, georgi.djakov@linaro.org
Subject: Re: [v7 1/3] dt-bindings: interconnect: Add EPSS L3 DT binding on
 SC7280
Message-ID: <YSQIq3jNK0eRCOaD@robh.at.kernel.org>
References: <1629458622-4915-1-git-send-email-okukatla@codeaurora.org>
 <1629458622-4915-2-git-send-email-okukatla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629458622-4915-2-git-send-email-okukatla@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 20 Aug 2021 16:53:39 +0530, Odelu Kukatla wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on SC7280
> SoCs.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |  9 ++++++++-
>  include/dt-bindings/interconnect/qcom,osm-l3.h                 | 10 +++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
