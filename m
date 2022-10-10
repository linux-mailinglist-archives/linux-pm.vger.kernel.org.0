Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735135F980E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 08:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiJJGFA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 02:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiJJGE7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 02:04:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D50F22BDF
        for <linux-pm@vger.kernel.org>; Sun,  9 Oct 2022 23:04:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso9526537pjk.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Oct 2022 23:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ze6sWpLp4OvIIrfkLpb2+ilcLI2WvN54fOLaHJtyJQ0=;
        b=brojRUA4twJZbhunUPYWOqEG3kEV1+Dt5K34DHoxqPqdRk7/m1oig7e/E3ZrIjKEm5
         WwwJX5MD/Tt2CNOhQx1slrOGSRpTWRQ0f5og5wJMxA9qRP8OatdepajU6lGlQvTerV5t
         +tGum6VU5yOzWqdv6V7W4E55U6C3LWAassuBs+1VQ4B7Dr46mCY0LmkLZY6QWglhSo1h
         mPq+5W/QRslkKQ8rJajiRu3rIVgS9hAzw5Wvbcs4BQApO4SkRr58PBNmDxLvHT9/zbIX
         zEPNQ3juQycV/tbNxi/ike8VJIfzIxKRdykkRfET/wR/yBJahqydktty3iFLaOmKp4Up
         cdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze6sWpLp4OvIIrfkLpb2+ilcLI2WvN54fOLaHJtyJQ0=;
        b=h8YcPnDjF+9XbVOMkhF0eUX+YHuXaAnI9Og2hRcZ9LkrtupOBA2JwS9IhD+/lSyIrG
         apYj735RRHb9zczHLbOUlN7xwPg3tK1f3AIJPFRm++VZZV8k/UngEaU+u1Le6As2T9iR
         VkZKW9FYM8cpqVAVehFFO7+8BONLWiffRYuPhdYrNlncUx2BZ9XtD7tNJYaOk3GoO3K3
         ViEi7tGZe8+O4XsUT8R/JYf9K93VxxbZX5lf+4IUw+S6wF9sFbNDauuT02gi615j2/lJ
         zY+xBf2a2+L98n8FyTky1CN607fIGDEr3Jxb8Pnm7bBF3NQm9CM15mp6OqRYT19mp880
         hYMA==
X-Gm-Message-State: ACrzQf1AwM3h8waaIAvNet9+W5qcNVi4KBYH8jrZn1OZSPNLJMf+aT2s
        /A4VPIWh9Zyb+pTZbcVviLX/HDsHGdsXKg==
X-Google-Smtp-Source: AMsMyM4Dw8vuxf5zlXz41FyIpJmGE5/yHcnIZmYyUCdgOIk9PW8Q4pogshvbi2TUcY/YN/hvkrBz0A==
X-Received: by 2002:a17:902:ea0c:b0:181:61d1:ac1c with SMTP id s12-20020a170902ea0c00b0018161d1ac1cmr9048198plg.120.1665381897930;
        Sun, 09 Oct 2022 23:04:57 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902784a00b0017dd839f2a5sm5691051pln.38.2022.10.09.23.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 23:04:57 -0700 (PDT)
Date:   Mon, 10 Oct 2022 11:34:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>, Rob Herring <robh@kernel.org>
Cc:     rafael@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com
Subject: Re: [Patch v2] cpufreq: tegra194: Add support for Tegra239
Message-ID: <20221010060455.o3mnc5fx2xm34wpb@vireshk-i7>
References: <20220920110646.27837-1-sumitg@nvidia.com>
 <20221004152714.GA1524940-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004152714.GA1524940-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-10-22, 10:27, Rob Herring wrote:
> On Tue, Sep 20, 2022 at 04:36:46PM +0530, Sumit Gupta wrote:
> > @@ -586,6 +586,7 @@ static int tegra194_cpufreq_remove(struct platform_device *pdev)
> >  static const struct of_device_id tegra194_cpufreq_of_match[] = {
> >  	{ .compatible = "nvidia,tegra194-ccplex", .data = &tegra194_cpufreq_soc },
> >  	{ .compatible = "nvidia,tegra234-ccplex-cluster", .data = &tegra234_cpufreq_soc },
> > +	{ .compatible = "nvidia,tegra239-ccplex-cluster", .data = &tegra239_cpufreq_soc },
> 
> Not documented.

Sumit, can you please send a patch to document this in bindings ?

-- 
viresh
