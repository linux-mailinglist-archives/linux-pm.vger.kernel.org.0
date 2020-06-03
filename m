Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C954C1ECD64
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 12:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgFCKWE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 06:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgFCKWD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 06:22:03 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C2FC08C5C1
        for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2020 03:22:03 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p30so1430112pgl.11
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2020 03:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Gywm26xbzcC5sdjTvVeyjB7NiVJ+nJwHGQ5uOCG0NYE=;
        b=vB1J20VFGewR4H/3VgNf96mwVbgrJhCTNOZQToO37jkblxQ8CWkPCmDTeoEzXtdN4r
         lEu9fVYygQXOsv3/MxY/Qr1iSDz8MLdOzcwWAS0gSkZbSPQrzDskkpgkWMJps0ALgL8U
         xbjgGk6Pt4wWNeRYBWKnpIwLU3stXsDJoAqaj0IskXM7acKqvA392vO7ccUDfrNHg7Op
         yYgBhQzWUo13glFGkIqFV7eVPXUq/ZnLHqc3Hhj/fPP/F/QAMCSH/onyKp9VkU7GzzXb
         y/A6JKQLAxf+wQcyOlnA2OD9/JJwQTCnHO49DQnjYDKRr0Eu/WoQ00ZuDbt7+4SenJaH
         gs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Gywm26xbzcC5sdjTvVeyjB7NiVJ+nJwHGQ5uOCG0NYE=;
        b=KyA8K9JOe7is+5hoPr80oa+RTTOtaqN0aPwM8PgIfdAaLiqAEFjx2m/RqPHw5DMRaL
         WeyUtAAjjxhTZrh3twJfGFX+UrWp1m89GRn6IihbpQrbi/LRCmuAcE6Auw6LifUyvLBQ
         QE13HywTpBIAhHApZAQFxq6icXFrG7MytlQuqpdcW840XiHTxhRErdPfw4MWMCJZNT5G
         mYehBGWidTjo9qCE/tgg/+0jed9BfQw3D09g8q4dAP40iO1SVPNSNZjcS1QcmKJ8xi5d
         umSdX5wut2LHQMPjzVWwBCJ0Ihdz2TgM+S9VND+nMjzv1jbStM/l/p9Zcfn9kqZksG3y
         FcLg==
X-Gm-Message-State: AOAM532jFrpyiOogeF18v1SpL8QfQJR4MkNK1IcT0UZuvXZBLqF+4lDO
        RqpiHOi35SosCvVoiR/vfkhBig==
X-Google-Smtp-Source: ABdhPJx7hGed1u73cga8aPJW4199IO02IItfgP1iacq9bOqJEYbhgjOEe5p1iizcRmE3PxyDxJMNRw==
X-Received: by 2002:a63:e550:: with SMTP id z16mr26873816pgj.92.1591179722363;
        Wed, 03 Jun 2020 03:22:02 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id 2sm1561645pfd.163.2020.06.03.03.22.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 03:22:01 -0700 (PDT)
Date:   Wed, 3 Jun 2020 15:51:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, rjw@rjwysocki.net,
        guohanjun@huawei.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU
 is in idle state
Message-ID: <20200603102159.hzctwiqiukwhrpo7@vireshk-i7>
References: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
 <20200603075200.hbyofgcyiwocl565@vireshk-i7>
 <20200603100727.GB7259@bogus>
 <20200603101010.alijrfmte2c6xv5c@vireshk-i7>
 <20200603101753.GC7259@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200603101753.GC7259@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-06-20, 11:17, Sudeep Holla wrote:
> On Wed, Jun 03, 2020 at 03:40:10PM +0530, Viresh Kumar wrote:
> > On 03-06-20, 11:07, Sudeep Holla wrote:
> > > But I have another question. If we can detect that CPPC on some platforms
> > > rely on CPU registers(I assume FFH registers here and not system/io/...
> > > type of GAS registers), can we set dvfs_on_any_cpu(can't recall exact
> > > flag name) to false if not already done to prevent such issues. Or I am
> > > talking non-sense as it may be applicable only for _set operation and
> >
> >           Yes, non-sense :)
> >
> 
> Thanks for confirming 👍.

Hehe.

So, do you agree that we better do the read from the CPUs themselves ?

-- 
viresh
