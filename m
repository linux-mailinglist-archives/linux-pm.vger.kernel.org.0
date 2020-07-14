Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2A621FFFE
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 23:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGNVZm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 17:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGNVZm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 17:25:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E802C061755
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 14:25:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so917100wme.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 14:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KSfvDIX/TrKhNfavz9gqT4CkPok883ejJCseRAMUrzQ=;
        b=GtzkgbuGm+CflRAs9y9OQuFQxiZl5hlT9j1xzSijnMFIFq/1ETlmkPrZBx4rPXpZQW
         kQUMvTOCAS3v3gZFeaCvS7AG6Uz/NZz7h9lufDKAjEX6IwrfXF4czGjb56vFo6Brn0zU
         /YR4DgTdYmVAF8I6PT6XGCwBW5JyaGZ4Jbhqlp8sSzGRy+EUiO7zFBs6ud0wuK0YCVRa
         e7WtqO2ymi6k9GOuyREhUvA+khGnFBn8wSLNd8nALFXqS31mo3UzJR7k5xQF2qnIN5IH
         JL3M3M/Qaxkw6nCT79ts/jLodZ0qILcCfE+jFLaGr0w/xkZrF41g8RgjZBulPXFRKI50
         H4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KSfvDIX/TrKhNfavz9gqT4CkPok883ejJCseRAMUrzQ=;
        b=eWXYMZqTOFwINoYsUZFOVRKwmXnDgUa7jVUcFHjas+XKUFTctVCnoMQOUaSMws3L4O
         baZ7vRVbojkQ51hON2NCVBqgPGwBo3QBV6yyqmbQjr8rhWkdvdKk8Y/YkpLakPXIW3YG
         rGgGcwelraVuUFvYsurLxsHeXRthuk1KHIitzZDR52ecDo9Yo+dZTnCiH+FkGUy4ZmCQ
         JpApL60zpxX3WcD1ftga9qODmQWYu4awxS5bWKrzh7NWxzYKVHPro7qphCtf4B0amxSv
         +0jcjCwhyE833FM5ds7YhrC3ATdSck/cchLYtNkT7MGc1382Lp4OkIInxdqFY6XJmNrI
         49BA==
X-Gm-Message-State: AOAM5311YHDfLGIR+q3XQSVUWnNha9K8PRi+JL0EY2AP0FOFS7mf40/d
        joofp0bE9JmDBRlLWBpTtgLhnYqSQWWiYw==
X-Google-Smtp-Source: ABdhPJy0GFscM5m948VgN4h5ukfqjG35G3bXmIQulvRQz8qUJoPyiRdnYmLyFLy/FTP372JkZSxeSQ==
X-Received: by 2002:a1c:3504:: with SMTP id c4mr5580994wma.177.1594760540764;
        Tue, 14 Jul 2020 14:02:20 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id t141sm13313wmt.26.2020.07.14.14.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:02:20 -0700 (PDT)
Date:   Tue, 14 Jul 2020 22:02:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Jacob Shin <jacob.shin@amd.com>
Subject: Re: [PATCH 13/13] cpufreq: amd_freq_sensitivity: Remove unused ID
 structs
Message-ID: <20200714210218.GH1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-14-lee.jones@linaro.org>
 <6101e041-41e9-22bc-488d-38124c139bc7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6101e041-41e9-22bc-488d-38124c139bc7@amd.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 14 Jul 2020, Kim Phillips wrote:

> On 7/14/20 9:50 AM, Lee Jones wrote:
> > Can't see them being used anywhere and the compiler doesn't complain
> > that they're missing, so ...
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/cpufreq/amd_freq_sensitivity.c:147:32: warning: ‘amd_freq_sensitivity_ids’ defined but not used [-Wunused-const-variable=]
> >  147 | static const struct x86_cpu_id amd_freq_sensitivity_ids[] = {
> >  | ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Cc: Jacob Shin <jacob.shin@amd.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> 
> Same comment as for patch 9/13: these are used automatic module loading.

How does that work?

Could you point me to the code which handles that please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
