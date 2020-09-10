Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60982263C4F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 07:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgIJFEB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 01:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgIJFDv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 01:03:51 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AFDC061573
        for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2020 22:03:51 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w186so3588771pgb.8
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2020 22:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZqFRgh97zYu+FiBtzR+Vdczm0u9Myix9WNoAZc4j270=;
        b=NP92OmHMm5OYxrBJAvqsBp+an2H6o2R6aDzTTLrZxaTjAhfBtVUlOpAqSqFbbQqo6X
         54MpqdxDG5zhecLsL02YcQw0qjGWRhq29kn94o2vBOUHWjJLAhLlE9Q6QFMWHrfg7SIu
         3jguHE2y4BA0rFUbFTU/uigpnhhX81BnzQg7PFFvryc+rgdzn40GDqRTXJdOjy4EC0qB
         R8hDzcEbs0y+bmKHuQgBY0dusah5bwmCME3Cb2mEIejaldbh2YLxj2W5sW+fcyt9Npjd
         8s3CpiqA43jZnXxhvbznexwo5RNsychyE1Xg0/d80mOb7KHQ1eGQRtk5a52fQdTRVu5A
         79qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZqFRgh97zYu+FiBtzR+Vdczm0u9Myix9WNoAZc4j270=;
        b=Lpr3JyoShpHdpyog2autWLc9S3r6dCLK7gC0Tz29d2wrPC6F41Xu+qMuwyJDAZoXuL
         8Y4sqctD5Gs+MOjkN8HrCrhRkoF6JTeJGoxyPrlBbIpTNb1VmbwCwJC8ubx7je5SlBa4
         yPaWXeCC1vf0CTO6/5J7wbuTNLnHW/Mw9tmT7hjStqa+3ZxblVE+2mDF6p6seoTZleuy
         bNcCrLFZNkxSH3JBvkQfY9fQA0WD/1TjFdgYD2REEJuxXLYO5RRlFyKbcb150okL56jQ
         g02H41zp90uomsGJbjz4v9/xT79n04vmg+lFmVGfG09cOgLIAU3YE2ga+csBYf9MFG23
         m50w==
X-Gm-Message-State: AOAM531R/2F0wbOF767a9oDU6bHnbEPfrvtCo1/jx+CUIuQ5OSUyDNXW
        BOf/v18H1e9gB08u3QX2sIO/Ug==
X-Google-Smtp-Source: ABdhPJwH/JmaRVcMaXXgABEcKfk5wgZ5e88Hcz2jgqPwYhGXAf90BF9F/3AHEnm7w8Xe2lIp1WsRbA==
X-Received: by 2002:a65:5bcf:: with SMTP id o15mr3080223pgr.126.1599714229100;
        Wed, 09 Sep 2020 22:03:49 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id gb19sm707678pjb.38.2020.09.09.22.03.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 22:03:48 -0700 (PDT)
Date:   Thu, 10 Sep 2020 10:33:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v7] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
Message-ID: <20200910050341.pgyieq3q7ijitosn@vireshk-i7>
References: <1599712262-8819-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599712262-8819-1-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-09-20, 12:31, Hector Yuan wrote:
> The CPUfreq HW present in some Mediatek chipsets offloads the steps necessary for changing the frequency of CPUs. 
> The driver implements the cpufreq driver interface for this hardware engine. 
> 
> This patch depends on the MT6779 DTS patch submitted by Hanks Chen
>  https://lkml.org/lkml/2020/8/4/1094

Thanks for hanging there. Looks good to me. I will apply it once Rob
Ack's the binding patch.

-- 
viresh
