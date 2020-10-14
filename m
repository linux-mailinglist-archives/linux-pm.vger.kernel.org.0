Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139A028DD23
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 11:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgJNJWj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 05:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731108AbgJNJU6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 05:20:58 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A08AC041E66
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 21:20:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x13so1162611pgp.7
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 21:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sRC19ocsAAL1mtJ2J1c/RGp/arfOqOhnEUa8vMBSrp4=;
        b=GW9Pn8lwtiFpiNXWvRKpr1sRlcOS/g/NDsIbw9YjLuG0R2lkqK4AEazOizqZQ4K0NL
         IlKYMWncUI7oHCT0MNl2QwX0bsC6kBtnmDUPOuvMFx6xS/Q0CaLY3nNAaAQjYtPEl93h
         YuCkHLk4mhh6kMHwF+EC5RqYI5rQkXluO/qZ4aV/ggF+CcutvMuRjFa7FJxhX0i5Lnlu
         oVCLTbvksoQmBXRTWFEyXS8S4Gn66GpbzT4zsnqAf7PhwKUk5lmz6KinofDv1rsrHB9B
         2V0MrjxVWPer+JQqO6qg/TOD6tvExFz2VW4V70gYXFV5NLGwDM88KLc7EPHEgvhCiwQq
         aLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sRC19ocsAAL1mtJ2J1c/RGp/arfOqOhnEUa8vMBSrp4=;
        b=Mi8pL0HV0iU/izdNevQzd5QDSxtErP7G3EePyXmLXoshcAhVPf9GlI0rjRGdpqo6b6
         rY/hHKCWKTqeo1+KJmdRCiGwinWWsmyI6U3NJZfb/RiA9IrRKIQvg8uFUtKXEptZ0KwF
         f3KncmOnnCyBF6RQiq/GY0GZIm1OHiaVbYCEcRBkKBLOwscsFvOt/PrQRSC0z1ostlxv
         KN8wXIEe6a1v9jlf8KxBSNOZEuI5N1LQ0tL3H869nS+hpMZ0WqhFfW/qYLGH1wwIK+wc
         OHbBB8V6Qiu1tPP13SzrmlDfcxulOTCywfjxdryYgiN7yBxGYOZ9J2bePLO8pfyshzWI
         0f2A==
X-Gm-Message-State: AOAM530EsT4RCcgh9ffc1G+Zfjm1+SNyFDuDscZQMKD9ySXxePSfJ8ln
        3yuLFSelaCYBT/J31LLvBvYV3Q==
X-Google-Smtp-Source: ABdhPJxwwBZkPJwYyNWVBoXOO7FKu6S+l6w0Y4TBNKBUp23Gr0IwwNVWP1f990BT75JWgTy0taYkng==
X-Received: by 2002:a63:1e21:: with SMTP id e33mr2318898pge.270.1602649236190;
        Tue, 13 Oct 2020 21:20:36 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id l13sm1383186pgq.33.2020.10.13.21.20.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2020 21:20:35 -0700 (PDT)
Date:   Wed, 14 Oct 2020 09:50:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        sudeep.holla@arm.com, chris.redpath@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201014042033.tmsbanj5xgh2lmul@vireshk-i7>
References: <20200924095347.32148-1-nicola.mazzucato@arm.com>
 <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7>
 <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
 <6a739b1b-e345-fa09-d815-6e9601aff5f6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a739b1b-e345-fa09-d815-6e9601aff5f6@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-10-20, 14:53, Lukasz Luba wrote:
> I've started wondering based on the OPP code if this is a good solution.
> We would end up with one (?) instance of opp_table and list of devices
> pinned to it, in: opp_table->dev_list
> It can be seen e.g. in function dev_pm_opp_get_sharing_cpus(),
> where we retrieve the cpumask simply looping through the devices:
> 
> list_for_each_entry(opp_dev, &opp_table->dev_list, node)
> 	cpumask_set_cpu(opp_dev->dev->id, cpumask);
> 
> 
> This means we have a single OPP table for all pinned CPUs.
> I wonder if this is not too strong assumption for still being compliant
> with SCMI spec, when in theory performance levels might differ...
> (please correct me here it that would never happen)
> 
> There is also 2nd function dev_pm_opp_of_get_sharing_cpus() which looks
> more promising. But I still don't know if the framework will allow us
> to have private OPP tables when we use 'shared' in DT.
> 
> Could you clarify if we would get 'private' opp table for each CPU,
> which could be then populated independently, but still 2nd function will
> work?

I think there is some misunderstanding here in your part. The
opp-table in the code is shared between CPUs only when the
"opp-shared" property is present in the OPP table. If that property
isn't available, even if same DT opp-table is pointed at by all the
CPUs, the code will have separate copies of the OPP table.

Though in your case (with performance-levels) it shouldn't matter as
code will never create an OPP table I suppose.

-- 
viresh
