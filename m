Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3415A36F248
	for <lists+linux-pm@lfdr.de>; Thu, 29 Apr 2021 23:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbhD2VsV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Apr 2021 17:48:21 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:40797 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbhD2VsV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Apr 2021 17:48:21 -0400
Received: by mail-ot1-f51.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso29757033otp.7;
        Thu, 29 Apr 2021 14:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iYZ5oLoZi7uuBa979InSeVYHoomOJVsY8rXA4rSMPA8=;
        b=evbOQB5Z4XZEWjH0luau964eOdzT59Ei9Vd/GxMqro5KX4W5ONwR3kq4SXAe8y6frj
         EoT1g/lC9nEJRQrEd7A4/OVn3to8AR5LR/++bqq5M7qfkmdw2/UvNk4CS3XnCQcoYDUp
         sf5Iaf5YpvHCuESXiQZk/VxiLTeVmwVoP3zS7+74DQ95c8Zngr9nmRNQJVkC1gCAnZI3
         xVJYCIwRNarcS4Gt0sel6VR3zIqcPSyK7un9zGGAjm5EtdsoPfLhdafcMJD7OjwX5BEb
         pr85kxPcHcYMoYcqeP+/QDtwj24ALbe0gDVoPX5O24pDiQxg9dbtG8qgu3Ga/6kfgSbP
         CBEg==
X-Gm-Message-State: AOAM532dOhPT6UeJSzvEk92p2doK9z6In7JZ1oI+fY2XTh0VcOad3rjG
        E1k0TM7xNH8DuWQNWX54qQ==
X-Google-Smtp-Source: ABdhPJx4wCmWDLWm7Ngn2tC6FiabHokxGnCA74FpvlurPyQTesW0f/fL5N4VMAHmuTDCDVktu1v+sA==
X-Received: by 2002:a9d:2de3:: with SMTP id g90mr1152246otb.274.1619732852477;
        Thu, 29 Apr 2021 14:47:32 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j3sm265634oie.13.2021.04.29.14.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 14:47:31 -0700 (PDT)
Received: (nullmailer pid 1835596 invoked by uid 1000);
        Thu, 29 Apr 2021 21:47:30 -0000
Date:   Thu, 29 Apr 2021 16:47:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        seansw@qti.qualcomm.com, elder@linaro.org,
        georgi.djakov@linaro.org, linux-arm-msm-owner@vger.kernel.org,
        ilina@codeaurora.org, evgreen@google.com, sboyd@kernel.org
Subject: Re: [1/3] dt-bindings: interconnect: Add EPSS L3 DT binding on SC7280
Message-ID: <20210429214730.GA1835549@robh.at.kernel.org>
References: <1618556290-28303-1-git-send-email-okukatla@codeaurora.org>
 <1618556290-28303-2-git-send-email-okukatla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618556290-28303-2-git-send-email-okukatla@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 16 Apr 2021 12:28:08 +0530, Odelu Kukatla wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on SC7280
> SoCs.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
