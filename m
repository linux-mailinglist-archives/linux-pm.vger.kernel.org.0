Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07584296C15
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 11:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461452AbgJWJ1Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 05:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461367AbgJWJ1X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 05:27:23 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A4EC0613D2
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 02:27:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n16so743978pgv.13
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ucv5oR6DPdGRMnKY0683TdGM4cbhJcd2cZfvbWq/+PU=;
        b=f07s3VLB2MfVm1O3IHZ0eF7bXrbz5q+OMq7d217XRq9up5bkItIWfl7qKlNY+ATmJV
         4DovSd07C399R6SJrO1As9FKrmDERtWx5kJxc8DRoMJ+mxRaMkW0AoM45IF+41hG3rZP
         dKa0tPDvPO/MDNOsapAIMlYh40B5L1H/RKp5Om7zDiBn5DSZptfMyMgU+QpFQlJQWdcI
         Ed+VZC14LdegGJtYX7zFcRF7qKq62X4xqR4cjPePX5kPPD2cbCZWFP3wspS1A/+71EnK
         HG8VbMzQxU33SMfkk4pL55/YNMbLTdglZWjpTUOU1ZN/ohpfdr4UeO2OzSJKxvXWhepm
         Dm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ucv5oR6DPdGRMnKY0683TdGM4cbhJcd2cZfvbWq/+PU=;
        b=N6VME9sEMuIsZHq8OEJ1i2l9ixU+W4fAcDRZHbWjb+rqbl9h99Lck3X9lhSB/IdhHt
         A/0WWnMX7jQJ5Pb32LZ8golI0xBA6UPvgtaCdISuF3l6K9umH4N2i8S/5s+7/nFS96Q9
         2qZuBp5eJZer+g3okzBGAjHEKKHz62o1g9Xm0QR9iZklQXE73UoaIcTfofgKlPUr5xxO
         rOUhLfvdxhDGabg+JT9b5aWGWjp8I7ng9EJC4X8R9z2QCD34o1VpILpfamY5L2LWVzQP
         RxHJReDcPc8xQa2gDUUG8Qp7ulcDe8fvW1bBOCkdzqZf4huogbgR8hxiiT6bkJ02V2RL
         vCqw==
X-Gm-Message-State: AOAM530RqFXB5tEsGAATG1DlR0/bEmyJUuluJt4ekgAcYxkxvVUj7meD
        RIQD6fStVnBmVo2FDfZXknzvSihy4pSWJQ==
X-Google-Smtp-Source: ABdhPJyuPfJLoxrZf/YA+PmXSKVSfNq2TGaMvcJ9QKvWEeZvn/5j5V974zQbFeFOsyw0rCEczr08RA==
X-Received: by 2002:a17:90a:f187:: with SMTP id bv7mr1555398pjb.198.1603445242886;
        Fri, 23 Oct 2020 02:27:22 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id gx20sm1545390pjb.1.2020.10.23.02.27.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 02:27:22 -0700 (PDT)
Date:   Fri, 23 Oct 2020 14:57:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v1] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
Message-ID: <20201023092720.qpws5wivqb4u6fwl@vireshk-i7>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
 <20201023082817.5vp4cvi2lmpaozcn@vireshk-i7>
 <1603444138.20224.19.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603444138.20224.19.camel@mtkswgap22>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-20, 17:08, Hector Yuan wrote:
> On Fri, 2020-10-23 at 13:58 +0530, Viresh Kumar wrote:
> > On 23-10-20, 16:24, Hector Yuan wrote:
> > > This patchset includes 6 patches and depends on the MT6779 DTS patch[1] submitted by Hanks Chen.
> > > The first 3 patches are for CPUFREQ HW driver and device tree binding, which are already sent before separately [2][3]. For binding part, I add a new patch to add property in cpu schema.
> > > Besides, we add three more patches including EM power table, SVS CPU initialize, and cooling device.
> > 
> > And even after so many versions of these you chose to name this V1. It
> > is very difficult for reviewers to find time to review your stuff, and
> > they expect some sort of summary from you on what exactly changed from
> > last version and you also need to name the current version currently.
> > 
> > This should have been V8 and you should have added a "V7->V8 diff:"
> > section here, naming all the changes you did. Please send that as
> > reply to this email, so I can see what really changed.
> > 
> Hi, Viresh
> 
> Sorry for your inconvenience.
> #1~#3 is for cpufreq driver we have reviewed and the bindings which
> separate freq domain to CPU schema.There is no change for the driver
> itself.
>   1. cpufreq: mediatek-hw: Add support for CPUFREQ HW
>   2. dt-bindings: arm: cpus: Document 'mtk,freq-domain' property
>   3. dt-bindings: cpufreq: add bindings for MediaTek cpufreq HW
> 
> #4~#6 is for other CPU features, i.e. SVS [1]
>   4. cpufreq: mediatek-hw: register EM power table
>   5. cpufreq: mediatek-hw: Add SVS CPU initialization
>   6. cpufreq: mediatek-hw: Add cooling dev flag
> 
> I supposed that it could be more clean to separate #4~#6 in another
> patchset.May I know is it okay to you? Or I should merge all of changes
> into v8 like you mentioned? Thank you.

Merge them all together and explain any special features (like SVS) in
the commit log. It will also help in future when people want to
understand your driver. Explain whatever is worth explaining there and
is not straight forward.

Thanks for the details.

-- 
viresh
