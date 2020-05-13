Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE3A1D08D6
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 08:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgEMGnb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 02:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbgEMGnb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 02:43:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6E4C061A0F
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 23:43:31 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p21so1500067pgm.13
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 23:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SdoodXbLdjJhFKg183MdCLlRCCGhuA/fW4OhYTZuK3Y=;
        b=IpTr+v4AtxYHb9qJtYjdSbMeRxAFkPrQc1IgcLC8xxTq2HVifdgGWE7Xmmkw7wwwy3
         sYiW4+0p17YIZ4e3jZNlYjqt9uOiWjO9gHwFwG30Urgewvt0rvY8UWaoIUCejTk+LDE/
         v8RkrXzyQDsOGX7I8eNruS7haRji//dWg2tIL/0WKKjQ02KTbP/o6Jbv9rSciOoFyXN7
         zwpsD4+vLU3EmP3DNXbV3bxKqvXjRLwYCkpugTB4V1qk07+mYrYJghKEP6fHPDM3ATme
         lltd0tFTM509rztRYMnVL4hsX9M8H6w5m6ug8hPBgaFUKumm6s1yKCrRVSzFffl49FNm
         UxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SdoodXbLdjJhFKg183MdCLlRCCGhuA/fW4OhYTZuK3Y=;
        b=d6lb/ZqAm6TuNqQIz2KvDL8T5cIAsxJ7gHY5TnxS70QVu6pOPcd6lix4xJgLDkEW++
         jijw76Pw+qZGQeKCUDjG/1QMTRv+8gWpmlWNmz9bXDMx7AgNdVd4CJ8n10TQq8L9xIFb
         JA1qcmIgNPqeIFW0FkoV8y4WMCP8RWiZNudxSNfjknxMQkTHvRvhcGB/PigbYYD+9ayl
         u9NbVZrCxV06MJ/6m3NARckPs0P89o7KFDyO7BKZ4/Ipnxm/sFnWRVpgKweXMpZOl8cV
         9ey79pJtsIu/ShCU6thFUog20wgiZattxR41t4NEpY9TB6fPQpizlq8TdLfxjQIl8BWy
         1KJg==
X-Gm-Message-State: AOAM530mLqKLLlRzircHTtxPdLrgU2f3jtp4QjwZOljvDtm2mnFiWCoW
        be+1kgCgVbRW/n41WKyL/az1ww==
X-Google-Smtp-Source: ABdhPJw3lLOIsmu3kb+Bp9x6l+9b+XD5YD6y4cXxxJqgrRlftE2n+3ibNWyKQd/1lelxWfKmdf3Uag==
X-Received: by 2002:a63:4504:: with SMTP id s4mr10046673pga.247.1589352210742;
        Tue, 12 May 2020 23:43:30 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id e12sm11989801pgv.16.2020.05.12.23.43.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 23:43:29 -0700 (PDT)
Date:   Wed, 13 May 2020 12:13:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org,
        robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 10/10] OPP: Add support for setting interconnect-tags
Message-ID: <20200513064328.ycnaal6d6m72d5bi@vireshk-i7>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200512125327.1868-11-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512125327.1868-11-georgi.djakov@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-05-20, 15:53, Georgi Djakov wrote:
> From: Sibi Sankar <sibis@codeaurora.org>
> 
> Add support for setting tags on icc paths associated with
> the opp_table.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---

Applied this delta:

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index f71dc5eb0eba..a4972c94f428 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -346,7 +346,6 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
 
 	count = of_count_phandle_with_args(np, "interconnects",
 					   "#interconnect-cells");
-	of_node_put(np);
 	if (count < 0) {
 		ret = 0;
 		goto put_np;
@@ -380,7 +379,7 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
 		/* Set tag if present */
 		if (!of_property_read_u32_index(np, "interconnect-tags",
 						i, &tag))
-			icc_set_tag(opp_table->paths[i], tag);
+			icc_set_tag(paths[i], tag);
 	}
 
 	if (opp_table) {

-- 
viresh
