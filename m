Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8338B521062
	for <lists+linux-pm@lfdr.de>; Tue, 10 May 2022 11:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiEJJQM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 May 2022 05:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238438AbiEJJQL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 May 2022 05:16:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4132DA93
        for <linux-pm@vger.kernel.org>; Tue, 10 May 2022 02:12:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id k14so14167822pga.0
        for <linux-pm@vger.kernel.org>; Tue, 10 May 2022 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h0/eXylGNAueAU7FrP3IwXCzMzPqW0qtEOPvWEn2U/M=;
        b=DDh5nMeA6yw8EpZ5Xio66OeElfarNGX6D3MwNsbrwQg5KDtHnLf8dfABDTPQsu9zEC
         d6mUPKf8S7KYg4No/NGrHavkomljB+a98GUyKTMe1GjOHPmhd8T3QoWTAWPbvQ2eV3Ld
         D1HtbikX8cG1Ws2uTs6IfbDhldPnMvNYS8sAyw+HhD0nNJOSRJpF8BipKmQvNFqjjXkS
         9pOECntNvD8itxByuRh6+Z+CoP6fh9eB4taXrK990uU+Vgjei3K5uoJE33MakXUlkHJT
         WFyy6slKYGwxAPF2bNMusmbTv33ZC5iZq90anRHt7AoQleiwNtcSjiM0CPIiBHGWoseq
         MWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h0/eXylGNAueAU7FrP3IwXCzMzPqW0qtEOPvWEn2U/M=;
        b=Q9Yfo0cdYtfG80yDht6nDG9lN3tpSq1W81gZQlh1/hURFulk41NFVTnhFnZb8k8ERR
         +pqPblU986PHUQE7rbwA7MkcmCIVGsbYK28uvvQoRkdJsZNg0ikZwj8oin8MFe0NldMV
         7Wcy6KnYGSS5QPsEQkKARa7hjN2c0wHi6lzv4PkU/O62l8IAYECsLrczZSg+dwG3pqhp
         CbcaOou3nPuiAejqNeV3Y0HcasWx1ejDz7ASwJ76Gdq/gBZJmGOe/O4kOJ/tJKAO+8pG
         D1iUnGOZQ3PAQmyxo9udqjHFsAOZMf2o/r7RS/m0ygu82JeC0irOyEQXwSLZAbg+CIMb
         wc0Q==
X-Gm-Message-State: AOAM530E3ZUOjfGYXjim8hxV32PKvYtA5dh2gWespVrywqQWg1usT44+
        BS56QI7sOfpAKKaSdZeTiUESLA==
X-Google-Smtp-Source: ABdhPJx78FuXlWndkKECQOsIhgGXq9UcykG/wSe+ro44JBVrYFG0rAyOoZd3XA5plb4FlldILbDgPA==
X-Received: by 2002:a63:7450:0:b0:3c6:234f:e70a with SMTP id e16-20020a637450000000b003c6234fe70amr16398793pgn.619.1652173934523;
        Tue, 10 May 2022 02:12:14 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id ob12-20020a17090b390c00b001d95c09f877sm1289808pjb.35.2022.05.10.02.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 02:12:14 -0700 (PDT)
Date:   Tue, 10 May 2022 14:42:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] cpufreq: mediatek: Fix potential deadlock problem in
 mtk_cpufreq_set_target
Message-ID: <20220510091212.olrvvjlx4jtm7zw2@vireshk-i7>
References: <20220510090531.12438-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510090531.12438-1-wanjiabing@vivo.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-05-22, 17:05, Wan Jiabing wrote:
> Fix following coccichek error:
> ./drivers/cpufreq/mediatek-cpufreq.c:199:2-8: preceding lock on line
> ./drivers/cpufreq/mediatek-cpufreq.c:208:2-8: preceding lock on line
> 
> mutex_lock is acquired but not released before return.
> Use 'goto out' to help releasing the mutex_lock.
> 
> Fixes: c210063b40ac ("cpufreq: mediatek: Add opp notification support")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

You should have added the review tag you received.

Applied. Thanks.

-- 
viresh
