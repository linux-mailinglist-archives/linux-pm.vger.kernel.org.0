Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15537AC183
	for <lists+linux-pm@lfdr.de>; Sat, 23 Sep 2023 13:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjIWLxW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Sep 2023 07:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjIWLxV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Sep 2023 07:53:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0E019C
        for <linux-pm@vger.kernel.org>; Sat, 23 Sep 2023 04:53:13 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-404fbfac998so40287195e9.3
        for <linux-pm@vger.kernel.org>; Sat, 23 Sep 2023 04:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695469992; x=1696074792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3d5pmOOCIND7qyeTJ3pOcwo3gfbFjfEepazgokxHfLQ=;
        b=oyz/0Q6lcUlKwE3hpsFmYRuaf+Ei3K9VceE9gBuWbsfq0r+k2g7nmSox9gtMqPQbNd
         8j+ZDdKiyAm8WXFoJVLfVYHpUeJQvyCZwn4PFB+26Q6eD1nEzSKcq7NtVObjeZ+9puZ5
         /uRCOYURk6fYqEu2e/QnO8rv1ZJ34NfSdcTj2PQJDrtdNMP8W7UjxNXpxvl9a8pIgk3j
         LWCJmTEm3ZVHVbVBCb7rlMjwFJ8gEYz31YC3+zNH4U7/3tFUf2kbrcEVbh4VOICt7e5i
         RGqbuE4/Oqyvqj2gE+yH+fNSzrhh0qGcf/gS8aPynEGWXS4Jm0uq6AVgyMvC77IbHjPn
         Nfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695469992; x=1696074792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d5pmOOCIND7qyeTJ3pOcwo3gfbFjfEepazgokxHfLQ=;
        b=QOppuzuwMnHuRoh+dzz2f0GhgonVk0sc0eRDqwh/rjRBRRpGDMyw7mKCBWm3PQg8tE
         utZ7FnlppLdBFVsHmfA8JNyY7W4Og8MUSFYT1Rq+YE+GT2YlldMA4UFIxUQxbZ6Z+22+
         ePlDoKLwKg4oVBxEUB6SU8ISVqon6qWAJ2weuz/a8MKgWg8AhgAzmLqPJBpxOGVRQUQ/
         UI1UYIApS3yFPQ1drZn6DGHPF00PSFOfFa6lkQBLB0prmiCY3fFH3l/kwPK3FJnkViFw
         UzhwK85G6wURs87nuyMTYD7QywA9vI03R46KPbUg/oPFdaVEsrR0/U6dTt+iJkl2B9n2
         dN8w==
X-Gm-Message-State: AOJu0YxsD29exkiT9p55TAXSarABBm6MMnsfz+DwCJw5QBdPEGwVkFL3
        DkZ0Oyp9UKwosBcGu8JoCrb5Jmwv9J0nk52NOo7Hqg==
X-Google-Smtp-Source: AGHT+IF4XGCwpkj6yUqhCVKCTqCbbxiWSdlKFPjv6nmIC+D62Q0cQIWdN015fF+kMYWd8bch4IFE0Q==
X-Received: by 2002:adf:f4cc:0:b0:320:4d1:d5f3 with SMTP id h12-20020adff4cc000000b0032004d1d5f3mr1860254wrp.6.1695469991650;
        Sat, 23 Sep 2023 04:53:11 -0700 (PDT)
Received: from linaro.org ([86.120.16.169])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c215400b00401b242e2e6sm4420957wml.47.2023.09.23.04.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 04:53:11 -0700 (PDT)
Date:   Sat, 23 Sep 2023 14:53:09 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RESEND v3 0/5] PM: domains: Add control for switching back and
 forth to HW control
Message-ID: <ZQ7RpWxGZU1lMNPE@linaro.org>
References: <20230923114950.1697701-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923114950.1697701-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-09-23 14:49:45, Abel Vesa wrote:
> This is just a resend of v3:
> https://lore.kernel.org/lkml/20230823114528.3677667-1-abel.vesa@linaro.org/
> 
> Just added Ulf's R-b tag to the 2nd patch. No other changes.
> 

Urgh, for some reason, only cover letter was sent. Please see full
patchset here:

https://lore.kernel.org/all/20230923115008.1698384-1-abel.vesa@linaro.org/

> Abel Vesa (1):
>   PM: domains: Add the domain HW-managed mode to the summary
> 
> Jagadeesh Kona (3):
>   clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
>   clk: qcom: Use HW_CTRL_TRIGGER flag to switch video GDSC to HW mode
>   venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode
> 
> Ulf Hansson (1):
>   PM: domains: Allow devices attached to genpd to be managed by HW
> 
>  drivers/base/power/domain.c                   | 84 ++++++++++++++++++-
>  drivers/clk/qcom/gdsc.c                       | 32 +++++++
>  drivers/clk/qcom/gdsc.h                       |  1 +
>  drivers/clk/qcom/videocc-sc7180.c             |  2 +-
>  drivers/clk/qcom/videocc-sc7280.c             |  2 +-
>  drivers/clk/qcom/videocc-sdm845.c             |  4 +-
>  drivers/clk/qcom/videocc-sm8250.c             |  4 +-
>  drivers/clk/qcom/videocc-sm8550.c             |  4 +-
>  drivers/media/platform/qcom/venus/core.c      |  4 +
>  drivers/media/platform/qcom/venus/core.h      |  1 +
>  .../media/platform/qcom/venus/pm_helpers.c    | 47 +++++------
>  include/linux/pm_domain.h                     | 17 ++++
>  12 files changed, 165 insertions(+), 37 deletions(-)
> 
> -- 
> 2.34.1
> 
