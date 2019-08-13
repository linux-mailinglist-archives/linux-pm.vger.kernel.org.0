Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C028BD33
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 17:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfHMPcw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 11:32:52 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45256 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfHMPcv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 11:32:51 -0400
Received: by mail-ot1-f65.google.com with SMTP id m24so21070296otp.12;
        Tue, 13 Aug 2019 08:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gUxjdv29i/zz0yhsyQQ9tXUj0teXUnXVx5wZn0u8xcY=;
        b=D9X0LvAkKS8YirmXLIbUVWf+FPT6WQ2M/LjspRaVT715+rzo3645LZdlYSUglYkVMk
         ziuODUX1LBT147yztFmPok0Q3RlJFX5mu1T26aFHRfvgmCi41ndBcTNUX4OXxP/iO77J
         psz0bDJf54fgrExMwLvhYUkZ6eMpCoSgnHkjCp2mtSIzkjgIA/g7PBYOiwVLgMDsvyue
         ri/fGWe5O2aceb5E0NFhPa6tTlvHAuK4cG1z7xjp/MQhp9DsS62ceN9+gAEK+amUWz/i
         YmHmDfFTm52378JgBVFHwpBkpruotW/+tUIrPUlAobFJ2L627bTai+zw9qJaFwhVhWEJ
         +9HA==
X-Gm-Message-State: APjAAAUnAvEuckSX5gRr1inN8YQvVGevwD9/uM4mddnVVykfJc8Zgc5a
        oXiHGmuIVKgeBFLXyJn4ijKqfYM=
X-Google-Smtp-Source: APXvYqxixYytzQ0z+Eqgae6XCzjyQXj3k1zO1h3drY1QrnRfI0pQ9tw/0l3ht5LZ+XliX8W5/u4DFw==
X-Received: by 2002:a02:5ec9:: with SMTP id h192mr43818608jab.25.1565710370564;
        Tue, 13 Aug 2019 08:32:50 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id s10sm224695749iod.46.2019.08.13.08.32.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 08:32:49 -0700 (PDT)
Date:   Tue, 13 Aug 2019 09:32:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: interconnect: Add Qualcomm QCS404 DT
 bindings
Message-ID: <20190813153249.GA29326@bogus>
References: <20190723142339.27772-1-georgi.djakov@linaro.org>
 <20190723142339.27772-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723142339.27772-2-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 23 Jul 2019 17:23:35 +0300, Georgi Djakov wrote:
> The Qualcomm QCS404 platform has several buses that could be controlled
> and tuned according to the bandwidth demand.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> v5:
> - Make reg and clocks DT properties required.
> - Remove the _clk suffix from clock names.
> 
> v4:
> - Add the DT header into this patch.
> - Pick Bjorn's r-b.
> 
> v3:
> - Add a reg property and move the interconnect nodes under the "soc" node.
> 
> v2:
> - No changes.
> 
>  .../bindings/interconnect/qcom,qcs404.txt     | 45 ++++++++++
>  .../dt-bindings/interconnect/qcom,qcs404.h    | 88 +++++++++++++++++++
>  2 files changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
>  create mode 100644 include/dt-bindings/interconnect/qcom,qcs404.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
