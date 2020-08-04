Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7170F23B438
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 06:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgHDEhp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 00:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbgHDEhp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 00:37:45 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AF7C06174A
        for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2020 21:37:44 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so21403590pgc.5
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2020 21:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zqowAZufb7b0uKdkmkGlWSQC5Gld+DbUt3HuxK1ZIc4=;
        b=dfIJBc7J6lHjp36VIYX7blXf9z2V2tSLQMdoVnjvBngdeoL6iZ7Jhg+oA5/CheCqbs
         ZRCMZNeC6Dz1t66JAkwLD/Kzsw5QT72CRiDMITe7+Yx6es41aLi5xcl3IIs4Eu834zPR
         hL0o+ziAZRDSw9a6yedGgaNrLyAMbPAkFJnqs/R+DQn02JVl2ag0YGEl8KFxw2o0mS45
         19SeVyhm4H9JrJgBFrJ2zOKfRCdGI4IWNMEtdJjA6zSq60WYQUYIXslJi//TXVlkuB21
         7M/J4AElDdZx9THIamQhp0jk0rwCLHYgaHFol5zODsPuOK2lF4gVbIDWqZWbBuC08YKC
         OQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zqowAZufb7b0uKdkmkGlWSQC5Gld+DbUt3HuxK1ZIc4=;
        b=f4w2HHB9H0H/NyXfcxTuQ+YjUcPVyP7MmwZ+Cryd6Z3JOQXYSbDY9mH+Hl4HBHDGeF
         MHd+VVQitud3j1PfIj7mgLKYanCux5bYEpWCEaMaIkb+05uBMiCqJdp5EIzONmBYrh+4
         qgTlCKP4TQH34dbCyoZVefUbXSy+w3J6WE8hsgkkqFAq4C+Q4app9Gd9x8qHBKU9hhpe
         idDFjb4D7Y2ddmTWw2AJDGgDsr7kpbhcUzyEVc8NEB9ZFNF12JLV1yihbEKZIjObFjxN
         LlSi0u2MVMTDHRfBhk5YRtk/UvEm/m090PYmFmYOhFzlgyeUifzrloHhNcwtWdwknt1U
         Sb1g==
X-Gm-Message-State: AOAM530H9e/Z9JLG3goffP5gv2KIEUGm8OM0KTIDJQeSDtyjEPS140sm
        8jGF7nWavwtzx33Ts2r6bywAtQ==
X-Google-Smtp-Source: ABdhPJyT1eg8U8v7kNE2LdnRYGrpRoiGECTB6MXZ62JuB7qooc12g5BQxjsZsuVcty2ibapVfbv5MQ==
X-Received: by 2002:a62:9256:: with SMTP id o83mr17696174pfd.44.1596515864280;
        Mon, 03 Aug 2020 21:37:44 -0700 (PDT)
Received: from localhost ([122.162.244.227])
        by smtp.gmail.com with ESMTPSA id j130sm139319pgc.76.2020.08.03.21.37.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 21:37:43 -0700 (PDT)
Date:   Tue, 4 Aug 2020 10:07:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: CPPC: simply the code access 'highest_perf'
 value in cppc_perf_caps struct
Message-ID: <20200804043740.cde3ij2uk4xczemh@vireshk-mac-ubuntu>
References: <20200701042007.13333-1-xhao@linux.alibaba.com>
 <8643d122-c069-192e-8f3a-dc18f84eed9a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8643d122-c069-192e-8f3a-dc18f84eed9a@linux.alibaba.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-08-20, 10:37, Xin Hao wrote:
> Hi everyone:
> 
> I want to know why my patch didn't merge into upstream ?

I have sent a pull request earlier today to Rafael and this will get
merged in the next pull request Rafael will send to Linus.

-- 
viresh
