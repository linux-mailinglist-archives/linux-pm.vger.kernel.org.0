Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56153F9291
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 05:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244076AbhH0DBN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 23:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244068AbhH0DBM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 23:01:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC708C0613C1
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 20:00:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id e16so4038192pfc.6
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 20:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u9fsl2J395rtxjWdS/JQdfMymBJF011HJL/BAVf+vaQ=;
        b=wt0+lXQptAtx71d1AaFamencx3yC54vtU0e2RDU3G//q+cU4UTJmPk5Ze8jOIdOj2O
         Zar5QDY8yJsXtclYlOBeEcPY84jYRevBwIT7HMLg8RWQ/hK5rAsV/dT5LO35FwFjkFeH
         WztLnYCOTaE/v4IREh3XmSslexYz4jd4LvDJHgyKW8HdfNxG5SP2eyAvllc87DCZa+Dt
         DQT+yBa76HSX8PzAgAWNnZ7G92gaJhEkPuIS0BTdfZOBDdTe2pZSA5dFawWtGu/hCKzH
         CnUnKUw/bErS08W0ZQtW6wx1PGl2nHm2kYfHHRH97qKe6S4RhZFACgKZaHZ3VnZovE3m
         tgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u9fsl2J395rtxjWdS/JQdfMymBJF011HJL/BAVf+vaQ=;
        b=lOyiX0Yz1P9SeyfQ71d23jVNM6jjB8vijdvUDA6lzOdJ294dJgAW+/GyXSecfO05e+
         0IxVTjyY/WD6WbZiDjhT2FKCNMzq0vUgt1Z9dxEIvdaz4ecbNfMbH83khDvT0JgtTPOP
         ZODFAKteKwynecgB9j4Qvk52EFWk7Ql5rpbmxFX3D9M0IWq4vS/LEEM09MuemdUg/UL+
         RfRJk7u7l3zeaOuVHoU9RJWMRrMjBBpB+ZTI5mTUqC6IRQrorzY6sW6bzxHHSMkoV0ck
         YFikJwExIiMhiQ0pzioGrf+H6h5BgZoEWRXyQl0jEySnywTr6L0A0ZqGuRTfmdpGfjXY
         T65g==
X-Gm-Message-State: AOAM533z25e1uhrudHyaE14AZvZo/s9waaM0bZWF912v44sessGvuctD
        tb+Md2goP4qWqPTMnsQCPkcCoQ==
X-Google-Smtp-Source: ABdhPJyTZ9R0K9u4nnfdiatOPsG1Zri2/nz3ZfsEfYSuGeWo5aSKVaFN589cINxjxmSCFfIlqLPt4A==
X-Received: by 2002:aa7:90cd:0:b029:333:baa9:87b7 with SMTP id k13-20020aa790cd0000b0290333baa987b7mr6680196pfk.23.1630033224126;
        Thu, 26 Aug 2021 20:00:24 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id x2sm9980708pjq.35.2021.08.26.20.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 20:00:23 -0700 (PDT)
Date:   Fri, 27 Aug 2021 08:30:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 1/8] opp: Add dev_pm_opp_from_clk_rate()
Message-ID: <20210827030019.blhfh5wp7iyf53a2@vireshk-i7>
References: <20210827013415.24027-1-digetx@gmail.com>
 <20210827013415.24027-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827013415.24027-2-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-08-21, 04:34, Dmitry Osipenko wrote:
> +/**
> + * dev_pm_opp_from_clk_rate() - Get OPP from current clock rate
> + * @dev:	device for which we do this operation
> + *
> + * Get OPP which corresponds to the current clock rate of a device.
> + *
> + * Return: pointer to 'struct dev_pm_opp' on success and errorno otherwise.
> + */
> +struct dev_pm_opp *dev_pm_opp_from_clk_rate(struct device *dev)

I will rather call it dev_pm_opp_get_current(), and do the magic to find the
current OPP here as well. No need to reinvent the wheel.

-- 
viresh
