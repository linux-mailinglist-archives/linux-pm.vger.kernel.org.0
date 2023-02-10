Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8F9691F28
	for <lists+linux-pm@lfdr.de>; Fri, 10 Feb 2023 13:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjBJMcE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Feb 2023 07:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjBJMcC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2023 07:32:02 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABFE34F65
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 04:32:00 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so5549773wms.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 04:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=457K0OQcFU+Mf/NlBJdllWWKxYfOeLEOLKqEjT+jQjg=;
        b=ishE2imgqGch/Bo9yb6+PzaIL8KrOoC824wjuHY/Aofe5uO2ORN9X7DCB//gEtIpwy
         M7g3UDPDmuZ3thsJaSRLPrZ6g5LZYT6Ogp01txJfy5+i/R1WA4TDHBXodb8YV4+B7Q2a
         iKmFxAfB/NPO/fAuRJseiYdtTdgzHhQxLw0c0YYB+bpBFlozcw05bd7jfpCuYeU30hyD
         fAo/3iAOzAKn1xtYl91wxopsNaILwVHCt/873LK/1WKX+kZI7GlagUQ6ZJKba98ZX3PJ
         XBMTXw559wKgf5LKQMtmfbfs4Zxpwd1AWy7ucKDmBHnYsAxtzO8x01jBESVdWUfvpU+X
         PhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=457K0OQcFU+Mf/NlBJdllWWKxYfOeLEOLKqEjT+jQjg=;
        b=lb+qiJ5UiU/KEt33+7XV4uyBs70ekg9nWcBMmvKUU+HT/6XiNiZf0WNa2BA+v2wZic
         HksgGk0IryqgS0aEofAV82QDhtLQKO+0s6SQA1N1AZhsqpFFPKP5roZnP9QveVo4eKAG
         1Kh8CinsPc40UPhQ19S9n4tOPuI43LDvX9vSiCj/+vDmEzccaf/Lc3GkaMNKXRqxsco4
         MLl+QEE8RlrLjZd48/kRyZJk2BylEKuDmKTJi3hji5ClT24NLl9VtM96B1LJnrEG1vUc
         SV0wIBLyxpdGWicTsuu1f/YmGBBKMVWmYUyqNlGRaiqKbXWu4VOBl9eZExBJy1tGXFJc
         smow==
X-Gm-Message-State: AO0yUKVWr5TkuPUWdv3T1ZFi98CdAsOxMLqGip2TusgjRRZu0M3GCRoO
        TuP0yJJx1Z0V3dbOnZ9cgi0knA==
X-Google-Smtp-Source: AK7set8ovpVxLHos403TsEJL64cbVUGXv9tSiZl66sZgluZFqUbnuuU6j49IceJzvVVdKxy2dm4Tiw==
X-Received: by 2002:a05:600c:a695:b0:3da:1f6a:7b36 with SMTP id ip21-20020a05600ca69500b003da1f6a7b36mr16719972wmb.0.1676032318637;
        Fri, 10 Feb 2023 04:31:58 -0800 (PST)
Received: from linaro.org (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.gmail.com with ESMTPSA id i3-20020adffc03000000b002c53d69a8easm3011056wrr.92.2023.02.10.04.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 04:31:58 -0800 (PST)
Date:   Fri, 10 Feb 2023 13:31:56 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: Add support for cooling device bind/unbind
 operations
Message-ID: <20230210123156.GE175687@linaro.org>
References: <20230209163555.1993557-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230209163555.1993557-1-thierry.reding@gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 09, 2023 at 05:35:54PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Drivers for cooling devices can implement these operations when they
> need to perform extra work at the time when a cooling device is bound to
> a given thermal zone.

The approach is not correct.

I'll react to the initial email:

Re: thermal/drivers/tegra: Getting rid of the get_thermal_instance() usage

https://lore.kernel.org/all/Y9J4WAFyXyV%2FnqlG@orome/


 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
