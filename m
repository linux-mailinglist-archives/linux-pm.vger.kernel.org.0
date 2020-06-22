Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BED203BAA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 17:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgFVP6K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 11:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgFVP6J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 11:58:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DADC061795
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 08:58:09 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b5so8324812pgm.8
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hqx7rC9HmtHirbGKyHJfb50cjiD/ySJOns5T8xAdcmA=;
        b=Y0YustwI6sqGt3ubIoVtT7pkFHCMGqdSaeU8DfgABVXFCm7esF8Kz3VoXytTPp9Vh1
         yWKiYxye1K+LL++kEuA1k6FFFHOZgvNWUY4ymAAS033Lerg6Nfr3JB2HxdJH5OSbuWEW
         75sXQ0axi7IA3a3hTQKit3yVgVgdot+PQAJcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hqx7rC9HmtHirbGKyHJfb50cjiD/ySJOns5T8xAdcmA=;
        b=YgA0P+rgAVCXezFpHTs40ZpwcUTfOYRudzlHCelIC4iw3U+z4s/NSdzQVCafdf4CfF
         R5uDFPnRQkuH6SmneYhNTS5FAq+ERS3SfSLv8HI6cc2xtP0hG4nJCer8R4fgO+hLzXJj
         HkilViYcRFUGo82bjYy87S/+iwD+z3h48qnEuZ2faiNFIGcjTZD1OYxyfknA4GWPUIgw
         0+hG/lggimu2sMfkfPMPqSpcXcy5ZCStCWNo6NR3gYNEBayGQJdf+GXzzj6dybyDxUVX
         kGlLWN9uoUdZQd8iKAsXdMiVbuFakaZ3av3KCNlYwHWRNCjocadEqbpUD4QhZ2yBdDJE
         JSBg==
X-Gm-Message-State: AOAM531Bk9p17lk86uMGLBsF0966laEvDzMe3Hslr6FNDnMCkcqo6cqU
        5JaG5I+opqwZWyya3i1LXF8m7zrAAt4=
X-Google-Smtp-Source: ABdhPJzYKjvdTbFBrvziiaoyvuftohXyJS7FfaTDWSSJUGHWw1taamvOj/VHPJsiV9By6792NzQeAg==
X-Received: by 2002:a63:be01:: with SMTP id l1mr13730067pgf.32.1592841489272;
        Mon, 22 Jun 2020 08:58:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id d9sm11584719pgg.74.2020.06.22.08.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 08:58:08 -0700 (PDT)
Date:   Mon, 22 Jun 2020 08:58:06 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org
Subject: Re: [PATCH v6 4/5] cpufreq: qcom: Update the bandwidth levels on
 frequency change
Message-ID: <20200622155806.GH4525@google.com>
References: <20200622081649.27280-1-sibis@codeaurora.org>
 <20200622081649.27280-5-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622081649.27280-5-sibis@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 22, 2020 at 01:46:48PM +0530, Sibi Sankar wrote:
> Add support to parse optional OPP table attached to the cpu node when
> the OPP bandwidth values are populated. This allows for scaling of
> DDR/L3 bandwidth levels with frequency change.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
