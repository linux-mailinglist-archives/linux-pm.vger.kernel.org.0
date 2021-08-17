Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BEA3EF4A8
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 23:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbhHQVJE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 17:09:04 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40620 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHQVJD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 17:09:03 -0400
Received: by mail-ot1-f53.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so84200oth.7;
        Tue, 17 Aug 2021 14:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vVmiL6sO/8PBqKgDbJLK+oYb67QzQfk5U3FNkQ/KB/c=;
        b=O3thdILL0/iN/53jQGn63PRhS44R9PhOTrivBw7hUqKQsQHwtWc3EUMYvwobQHMgr1
         WpDI6c6KeQ/X/Zijb+gyqHW7gSrjuXJ6N1TlM0CW8Ei0CK7R0h1rX0DQNTL7WozGcIPa
         fGPWj/yFO8ccgMrifsWuvW2DSmcwDgKpbSS9oLu6pBYAuhGHsrxps4hK8MBalkRZRxnB
         QS08pKR4MMXAUWwyvG9b9BO+iQMCHbUPQPUKumN3btaUvmU7O1Mc5dhTYaL4qRkCuXtb
         URcQfAwTS1ufxpKMj1hRScrsQgAJOK/JTQKwq1m6sMJZXCoJL/ckVRGoMyFxggEWnuo4
         H+lw==
X-Gm-Message-State: AOAM530LRid36ftvPBeClVrd3nAkvXddGyvbP04BItuWFtzLnwk3IV6N
        pMtRC8jc3tPjy++oKvL2uw==
X-Google-Smtp-Source: ABdhPJyrLsnOoyuZp+dqpbVXvkN4IFmz8gfMFaJvQJ9a5KV3+ozPdKywI8LpYOfjJ5dtIKTGBIxJSw==
X-Received: by 2002:a05:6830:1f54:: with SMTP id u20mr4067346oth.320.1629234509272;
        Tue, 17 Aug 2021 14:08:29 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c75sm651427oob.47.2021.08.17.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:08:28 -0700 (PDT)
Received: (nullmailer pid 842238 invoked by uid 1000);
        Tue, 17 Aug 2021 21:08:28 -0000
Date:   Tue, 17 Aug 2021 16:08:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Georgi Djakov <djakov@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/6] dt-bindings: interconnect: Add Qualcomm MSM8996
 DT bindings
Message-ID: <YRwlTPkLr1lQT2bT@robh.at.kernel.org>
References: <20210811043451.189776-1-y.oudjana@protonmail.com>
 <20210811043451.189776-5-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811043451.189776-5-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 11 Aug 2021 04:37:10 +0000, Yassine Oudjana wrote:
> Add bindings for interconnects on Qualcomm MSM8996.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Changes since v2:
>  - Dual-license qcom,msm8996.h and move it to the dt bindings patch
> 
>  .../bindings/interconnect/qcom,rpm-qos.yaml   |  14 ++
>  .../dt-bindings/interconnect/qcom,msm8996.h   | 163 ++++++++++++++++++
>  2 files changed, 177 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
