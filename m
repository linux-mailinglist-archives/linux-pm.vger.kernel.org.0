Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07AC5246F4
	for <lists+linux-pm@lfdr.de>; Thu, 12 May 2022 09:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347557AbiELH2j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 May 2022 03:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350976AbiELH2Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 03:28:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2A813CA26
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 00:28:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id iq10so4422700pjb.0
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qL4PQ9qn9lMBINssvVeNkH0tYWr93CxXJds6Yc5S7R4=;
        b=JI45+O6JYosov4MpvPi9i0QIUkiQvfOTh3ojcwBbNZLO4wxg72RmNAoj7e392HhBtT
         s7WQXRZ8b70gIFTB0AqEMqZMMmxwQ5tMDDnvbHPbB0bEVWGvRwGOwj9wDoglgATJENyO
         vjT7zNgJRUdUXssiXbXVvRgklU5Svtf1hveyWKOIJpsJ8qgZ7x0M7kWtUnh94YLI3k3a
         GmHaF+dE9/gX3em7Rz1zrK81/YpMSGjoWdBjugJaWXbLXagIj9OBVLDE4hyyKWmZ7WWh
         XYHaMYW7hHMk5fTKqAT6ue/8PomkI3wTJVU+JQnqoRFWeG6egwUEpppxMoTydhqFv8pr
         zh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qL4PQ9qn9lMBINssvVeNkH0tYWr93CxXJds6Yc5S7R4=;
        b=iiETf7wWn9/ckb7ukjiFpaHAXu8YDGXpA7KppdFL5vGI2EeZ/TM6n8LcJzP4PQFptz
         sVWS8jYf+eIJPMIi3PlYBLDzGlF73rysbDLTaWnBLMHng4eJPpyVTPUqrWsGqMU7Shxz
         ehi6egYNwEA/8uAXNduZ/XmGp4wL05qw3Wn7hDdJMNQoCAxZGevgnyPukuC4Kw5SuNI8
         IKBJQeqNF034MaZbx0lmQSqJY9NeHh30Gut8/AUIRs6Nd7yBt7uBulrOc+7KGgjqAd58
         IxPCxpFoU8thGKKIVIosy+g28qfV3xkhgnGkqqqcie/XP1b+mUD4CdWdU7M1QiFhZRmp
         ShyA==
X-Gm-Message-State: AOAM532hxQOgPbWrBFtpgG0w2BEyTW1eGsvUi2KKzkK5m2MRJToosHoT
        pRuFjsI4dPS4MV7EUVo1JT/BRA==
X-Google-Smtp-Source: ABdhPJxdedzyCXvhh167lQ0t8fbpoDGXVUGoB2Y2eie9T0L5lwaKBowjgWb8svo60AecZmAdrXVRlA==
X-Received: by 2002:a17:903:4111:b0:15f:3eb3:9666 with SMTP id r17-20020a170903411100b0015f3eb39666mr3507440pld.29.1652340492242;
        Thu, 12 May 2022 00:28:12 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090add4500b001d92e2e5694sm1199945pjv.1.2022.05.12.00.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:28:11 -0700 (PDT)
Date:   Thu, 12 May 2022 12:58:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] cpufreq: Split cpufreq_offline()
Message-ID: <20220512072809.aztba67eummh2amf@vireshk-i7>
References: <5585781.DvuYhMxLoT@kreacher>
 <2258373.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2258373.ElGaqSPkdT@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-05-22, 17:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Split the "core" part running under the policy rwsem out of
> cpufreq_offline() to allow the locking in cpufreq_remove_dev() to be
> rearranged more easily.
> 
> As a side-effect this eliminates the unlock label that's not needed
> any more.
> 
> No expected functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
