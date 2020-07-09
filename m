Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7AB21A3D4
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGIPfa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 11:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgGIPf3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 11:35:29 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC764C08C5DD
        for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2020 08:35:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g67so1126405pgc.8
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2020 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0q/rCvNt3k405F9K/TajOpXPAtgojFFtnqWJkLPEMF4=;
        b=OWbz3/CqrDpo/Wcvq2r+CzFCtoWft8EU3UQBsM0iXshdZeW30DCs/+vWW/pDAXePHh
         2oLzG8kSev55DDnOpuoGAbRzEEmpYfdKukcFXVxGuDNbCFFMWbv25beCD/NtvTEk6R1c
         g7W7jqGUm4nzWI01J6Ul1JxZcEbMXqtZSar7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0q/rCvNt3k405F9K/TajOpXPAtgojFFtnqWJkLPEMF4=;
        b=To1Hqdk7WJeRNooh6HMTshbhL/w/VlSYr+5fsJTABSakzygKTsIa0AQKQ3zO1Y1eYl
         ztilgJh1KWDWBtAc2djv/4rqvtsiKLoWgVNUiyznlabU0VLXyENHEyEWJ9miBnXrONbz
         DCaD9Q4BiVCLssaUlxJwgzYl9SqHAP6P17XiefJu5CvWdMBw5YbwZc8tVTfXW7n2cX2E
         NH1EcJLf+hNA+kGJpAVCPafQib35HJ5DZoP+fSdoGxYMvYBHKOWHb4dcJR5XkQZ1OCnM
         4PDVdEO7nMJxNWU7zTPKYJOKrViflZVjCAlPbBFb906caHjMEgl7AHZSu+MzsdN/Z7qA
         jpOw==
X-Gm-Message-State: AOAM532o8/j1YdmrA40P0tnZkhGwmAG63RgmE+YTfREAPV1j92Vmh0Nr
        3F6V6LEhZ/vz0qbCHCKw5e9qRA==
X-Google-Smtp-Source: ABdhPJxezNzU/FHc9DH0NCqtmmgu7yFn9tCxihSQrSv2FyCRlXKSWOfUQMA/NNJhOf+7Z3KfioxOBA==
X-Received: by 2002:a62:a217:: with SMTP id m23mr27037150pff.291.1594308929281;
        Thu, 09 Jul 2020 08:35:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id b8sm3221741pjm.31.2020.07.09.08.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 08:35:28 -0700 (PDT)
Date:   Thu, 9 Jul 2020 08:35:27 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mike Tipton <mdtipton@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, agross@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add generic qcom bindings
Message-ID: <20200709153527.GJ3191083@google.com>
References: <20200623040515.23317-1-mdtipton@codeaurora.org>
 <20200623040515.23317-2-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623040515.23317-2-mdtipton@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 22, 2020 at 09:05:14PM -0700, Mike Tipton wrote:
> Add generic qcom interconnect bindings that are common across platforms. In
> particular, these include QCOM_ICC_TAG_* macros that clients can use when
> calling icc_set_tag().
> 
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> ---
>  include/dt-bindings/interconnect/qcom,icc.h | 26 +++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,icc.h
> 
> diff --git a/include/dt-bindings/interconnect/qcom,icc.h b/include/dt-bindings/interconnect/qcom,icc.h
> new file mode 100644
> index 000000000000..cd34f36daaaa
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,icc.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_ICC_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_ICC_H
> +
> +/*
> + * The AMC bucket denotes constraints that are applied to hardware when
> + * icc_set_bw() completes, whereas the WAKE and SLEEP constraints are applied
> + * when the execution environment transitions between active and low power mode.
> + */
> +#define QCOM_ICC_BUCKET_AMC		0
> +#define QCOM_ICC_BUCKET_WAKE		1
> +#define QCOM_ICC_BUCKET_SLEEP		2
> +#define QCOM_ICC_NUM_BUCKETS		3
> +
> +#define QCOM_ICC_TAG_AMC		(1 << QCOM_ICC_BUCKET_AMC)
> +#define QCOM_ICC_TAG_WAKE		(1 << QCOM_ICC_BUCKET_WAKE)
> +#define QCOM_ICC_TAG_SLEEP		(1 << QCOM_ICC_BUCKET_SLEEP)
> +#define QCOM_ICC_TAG_ACTIVE_ONLY	(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE)
> +#define QCOM_ICC_TAG_ALWAYS		(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE |\
> +					 QCOM_ICC_TAG_SLEEP)
> +
> +#endif

Would it make sense to squash the two patches of this series into a
single patch? This would make it more evident that this was moved
from drivers/interconnect/qcom/icc-rpmh.h and avoid duplicate
definitions if only this patch was applied.
