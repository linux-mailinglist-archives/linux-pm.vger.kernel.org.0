Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FBA50D764
	for <lists+linux-pm@lfdr.de>; Mon, 25 Apr 2022 05:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiDYDNx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Apr 2022 23:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiDYDNd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Apr 2022 23:13:33 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F2051334
        for <linux-pm@vger.kernel.org>; Sun, 24 Apr 2022 20:10:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id g9so12273135pgc.10
        for <linux-pm@vger.kernel.org>; Sun, 24 Apr 2022 20:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vETeJvQjX0RH1IGmgZeN4JIryPyrxoAwCmbGuC0BOx0=;
        b=Jmt8TQIIptvoAEOVITJkxviHnCha3FLobEnNYRwKrCE7YNvksMnB9gGc3HGfW2k+Dm
         vU40K9ksXrqP8hBOToCEixzDTkB3Mr8oeUCsB+fgFQb8siFyIb4gGdqHEKArwIjGHpif
         xIyC3KAy0EyMsY4eyiG6Y4dOMf/R60tpRWyJAxXJrRTPlmNC1RMt7zgqa4N4LBa3ALXG
         A/CeHlJbg6ZfgSiIXWGkSvEmpNQLwt0oDEUl6j53VA0BLCGZMW/qhSDFXSkRDnmb+5Iv
         +um/scm1ZhXoAt8JRQoGrInvFNWycjW45iK8CLHli65DRY1SKeLqPtSEx159MX8J8T49
         O/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vETeJvQjX0RH1IGmgZeN4JIryPyrxoAwCmbGuC0BOx0=;
        b=qqydVnCQImFMA8iDt03qqmcJ1j683Iysxtm49pL5r9uaajTbQxRQ3gWWEMX089Nc0E
         F3DZFZYeQrJdEyFp+GCe33zBpifYaoG5FJtR71Q6VCRFeath8Xupswi1Ni1boq3vEzku
         55DqLcalLB5Bv+96vtxc6wN59+sSJEHw3UsXZj9sE0leBQqUdGLfIRU0eftqrM60/WPQ
         /27drZF0AX1U9Wr3QEiUIN3qQy6nZTXNariTMVMo6pq3JsCBHydueQ5cCqtX7syWbKIM
         5HRSA7byfAjwvGgUdEXgrVmTAE/AwCbHf67/Sa3m0PZ33f52AQtw3+cMmhliHtWOL6SU
         Rxrw==
X-Gm-Message-State: AOAM5311JVGPEavfEr9wwg6qmSXKDHQOo0MezZ1sbm2kK2TDrBQ2CGCW
        bnzCtmgwFwK6bk/nKV4uDH6NHnnF29asPQ==
X-Google-Smtp-Source: ABdhPJzeUPYwdGHfiI4ExfiZee11IlcChs/CBZ/u64f+VZt5b/UCpOtFu1EcibqHAbA0/ZUy2GZehw==
X-Received: by 2002:a65:6e0e:0:b0:399:26d7:a224 with SMTP id bd14-20020a656e0e000000b0039926d7a224mr13375257pgb.437.1650856227663;
        Sun, 24 Apr 2022 20:10:27 -0700 (PDT)
Received: from localhost ([122.171.250.232])
        by smtp.gmail.com with ESMTPSA id k198-20020a633dcf000000b003aa9116ba17sm8023960pga.35.2022.04.24.20.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 20:10:27 -0700 (PDT)
Date:   Mon, 25 Apr 2022 08:40:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts
Message-ID: <20220425031024.wzfp6cajlmpkgjcz@vireshk-i7>
References: <20220407200919.3054189-1-vladimir.zapolskiy@linaro.org>
 <c2af9682-f773-8530-9262-edea1dbe595a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2af9682-f773-8530-9262-edea1dbe595a@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-04-22, 22:42, Vladimir Zapolskiy wrote:
> I believe this fix of a critical bug is intended to be included into the next
> release, could you please share your review? Thank you in advance.

I was waiting for Bjorn to Ack it.

-- 
viresh
