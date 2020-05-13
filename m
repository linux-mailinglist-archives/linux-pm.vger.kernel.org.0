Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21F91D0962
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 09:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgEMHBK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 03:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbgEMHBI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 03:01:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB2FC061A0F
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 00:01:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so6462092plt.5
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 00:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xht2lyYjw3RWBPZeMoeAYqlmyNVt9OCwJ+waHrDKeEg=;
        b=gc7Z967+/+x+Rsbye80nih3OeRQBVS5NToLQHZqZX+ApJYFJOElSd40Ra1HZnEg0Ph
         Rx2a25ItsdZYotcejlAzUajOLBv0Vnw5ZBenOEJq38l9jyTu8H/YRIH6kNiTvovcXWi+
         ozcgLpWi6yUqbLk8B4b0HtezRWolYau49baOajAyrR11aE5vDgJAEV4M5R2XXlFHGrE+
         zXaBEMliC1qhG+8pH8YW8gH4LhQW+5/gUBaFAIDJQHDyQB0YxQMBzfkSXtKHxlIR2hFU
         L/oJ4yD0kfAZ4LdFXX7JxBEcAeCXRMAksgQ6Svtqo6gbrQF5F/89tu1uxZ7CMWW7+Hz3
         Yh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xht2lyYjw3RWBPZeMoeAYqlmyNVt9OCwJ+waHrDKeEg=;
        b=E7m2l0FKVNoA23qbohfpLKwtG/eslI5zIUElTM8I6hKe7PdczvNtOnk/L6VFfIysGT
         srlau5+wK3DnSsng1dszGWBjPB6hJAjsHAaw+Waf8NqY9+6Cg1NlI/F4VC3i3uKSCzY8
         X1POxLdba1zVWqk9D6kJSvLCw9f2E90fkzuKidWaggGSpQV/cYBMJJhT2h+gCLss3weJ
         qVjCR8OnUGGUViHZl1S1nDQxWjooVp+dbKEtuqkryzTqzpfKMrnsgNVUFsDruh1NqJ05
         ShVEqOFlC/oQbYVed8bmT8J6+fIBscFkx+qJq6NH/gFu9JIBTPc9QMhzL/HL3LI5CsAr
         aSlw==
X-Gm-Message-State: AOAM531sBMd3cCdfH3PkyA8rI9WABiu2miAnpwhycigIvYlQIk87kYJJ
        LDA67/Zn7Bedl8hZWJ+CTYJPNg==
X-Google-Smtp-Source: ABdhPJyaJmFj2yG8v3BmrLqGILiIpuTEKtwTuXWHIP84gKlaqkfpLJBdd+LiwbV9iYkBev0bjFD1og==
X-Received: by 2002:a17:90a:bb81:: with SMTP id v1mr1808779pjr.168.1589353266968;
        Wed, 13 May 2020 00:01:06 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id p190sm14234819pfp.207.2020.05.13.00.01.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 00:01:06 -0700 (PDT)
Date:   Wed, 13 May 2020 12:31:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org,
        robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/10] OPP: Add support for parsing interconnect
 bandwidth
Message-ID: <20200513070104.yr4jtfu3pyib2qts@vireshk-i7>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200512125327.1868-5-georgi.djakov@linaro.org>
 <20200513064139.5kxjjddcooqcvny3@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513064139.5kxjjddcooqcvny3@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-05-20, 12:11, Viresh Kumar wrote:
> On 12-05-20, 15:53, Georgi Djakov wrote:
> > The OPP bindings now support bandwidth values, so add support to parse it
> > from device tree and store it into the new dev_pm_opp_icc_bw struct, which
> > is part of the dev_pm_opp.
> > 
> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > ---
> > v8:
> > * Drop bandwidth requests and free memory in _opp_table_kref_release.
> > * Take into account the supply_count in struct size calculations.
> > * Free the temporary arrays for peak and average bandwidth.
> > * Fix the check for opp-level.
> > * Use dev_warn insted of dev_dbg.
> > * Rename _of_find_icc_paths to _of_find_icc_paths.
> > * Rename the variable count to supply_count.
> 
> Added this delta to this patch:

+this :)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 15f30ed70bbc..06e38f95116c 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -336,7 +336,7 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
                                 struct opp_table *opp_table)
 {
        struct device_node *np;
-       int ret, i, count, num_paths;
+       int ret = 0, i, count, num_paths;
        struct icc_path **paths;
 
        np = of_node_get(dev->of_node);
@@ -375,10 +375,9 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
        if (opp_table) {
                opp_table->paths = paths;
                opp_table->path_count = num_paths;
+               return 0;
        }
 
-       return 0;
-
 err:
        while (i--)
                icc_put(paths[i]);

-- 
viresh
