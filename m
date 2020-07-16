Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9259221ADF
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 05:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGPDf1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 23:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgGPDf0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 23:35:26 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF72C08C5DB
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 20:35:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so4161235pgq.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 20:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=32gy8XoX3I4t0JZZ1KUze/2WJB+9G/goHCEZVw/rbtk=;
        b=jsAfm+JTZDUEV5ND1bWDoq+HtV3UNsUmLM88Nto4HvBpKTo4sRJK2E6n8gzy7DOQz8
         ri/kVxRdJRmElrtOD1q6sIWZ3QWiOwkOAeQswW5E7OkjybN8UsUBv4zLWdA7IQ2M8/sK
         b5HvF1VF6bMrPtIiwrQ00JGXYGOsVJlQrPn6JSi7egqM9SrV/1a9SCCzVqnazqxSwzDu
         9OWIdSz7/HDJbcoSwW7CvJoTi2KJS4T5pnlM1DjmvRsfx/WvDEc1yOTpuGW7pLVw+OnQ
         hZQx/pbnHQ7XID4vc+F4sb+arwtMG6eSKL2Am0vTQReYY46vZJ86TDPgGsPi1hUvuoXa
         5uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=32gy8XoX3I4t0JZZ1KUze/2WJB+9G/goHCEZVw/rbtk=;
        b=PtW78y7m/Qlk5sFODILw6YMW8zhaW5btBaXM1ED82JMgoeae+rBjeuHitgHjplzlJZ
         6lHunnMAgJ9txs9XMS0M0yWWeiKJsAjD/bOHKkItjgBzZ1DPZsDsvQdxYxXuVZTF0wk1
         /skEPj7zK16vwyd8pWpv0/+wHc9T+MfgGZ/gtlQJ6RFaIgPew3tioL8K8F0YBXeV3IGb
         8iEbCAH9sFbE0DmaOCOoU7hdbakI2lLB4BsHPL4Sl9P03BO9XgUvlZomgMSAENbUBfI8
         E1716mEGzFoDmP1DqhxMSvDo4M2wb/zSV6dLJg/BZKhVERaYasVWcTLHLoIO49vTx0yF
         NR5Q==
X-Gm-Message-State: AOAM531F0zy8d5DOYP+slXRnAxfm9FD8wLAKtBhv4SeBrXrrnhTL6Bgd
        IqSucHSjotK8UkaJ/OCZhdrTIQ==
X-Google-Smtp-Source: ABdhPJycfZpepHR2R4Un/jr6qjGC1YgjN9Wo9S97UbquF2TaoOW9Luy33E0WLtrPkpArvp2nHxz0CA==
X-Received: by 2002:a05:6a00:15ca:: with SMTP id o10mr1989444pfu.169.1594870525980;
        Wed, 15 Jul 2020 20:35:25 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id o42sm3544975pje.10.2020.07.15.20.35.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 20:35:25 -0700 (PDT)
Date:   Thu, 16 Jul 2020 09:05:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, mirq-linux@rere.qmqm.pl,
        devicetree@vger.kernel.org, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v6 3/3] cpufreq: Add Tegra194 cpufreq
 driver
Message-ID: <20200716033523.fhlfh5m5magifspx@vireshk-i7>
References: <1594819885-31016-1-git-send-email-sumitg@nvidia.com>
 <1594819885-31016-4-git-send-email-sumitg@nvidia.com>
 <d0a4a28a-f471-22bd-273a-dc5c62a79051@nvidia.com>
 <78636522-c433-a015-e4f3-02843ce58139@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78636522-c433-a015-e4f3-02843ce58139@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-07-20, 20:57, Sumit Gupta wrote:
> Sorry, missed to remove this. Will wait if any other comments before
> re-spin.

I don't have any further comments, maybe just send a new version of
this patch alone and name it v6.1.

-- 
viresh
