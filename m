Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EF42924D5
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 11:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgJSJqh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgJSJqh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 05:46:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B9EC0613D0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 02:46:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so5670775pfa.10
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ALbYyyA0vpv6/f61rJ6bmvtZlE3FbVb82jHAFZ5GC0I=;
        b=gNmfIv1inQXz9rCn0kzNxaTJfeiqhPY344N9yQARhoFrspEFbTMOyD8Mo5+q2laVTJ
         dljirSBQuIb1CJ16xkvkUsCLBj78B6xo1SpzN8eK1jE+s0R0H16YvGlqei3S0YjzB3HW
         NDdyFFHsI7xQbUASKP01Lq/il8wFrj1oz5+efq0Z8Ek97jLxzyU9uloR6XPI4P4ckP7Q
         6Ng8Eg7G4DwGn77Jzw3YLbqyv/aSe48taPsYmLP/FS0te1Q5/sFC262rrLjlx8TclVho
         oHNzzVwsCfLCDt9WyeEKfWX0Lzmmj/ClvM7h55PLJ63qVYtWBtxYU9TZC5TPOWkIPxKL
         2/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ALbYyyA0vpv6/f61rJ6bmvtZlE3FbVb82jHAFZ5GC0I=;
        b=O1dJUNjXbF5zyw8GsU8dWBWJzChL1fiv9jxRHjL79ZFudYAMziD6K6sDkakexW9+nh
         krhtP/AAbgIz1x1MhiaFEoGNGTWj5InANbd2gkHiAER4BwJZ5e7eQcN3iG0TBQ/U73fG
         QCBdv+la+iVknnEURsjAzqp0OzweRFL33fTE9nXFxgroSXwSFa1+866n6sVMUUy4eulb
         ckIIELoGAtWyH8XtB67u5H0MvNXyFRpX2EQymWsI6d0+yOjk61v0emaWNm9CUA1IGX8U
         OmRXgEtxBFNDqX95D21LZm060MSIpO0VivdWMUDQXKDKnDu5vu01BMQTeaBiT9mOcIok
         Qx1g==
X-Gm-Message-State: AOAM531NTJrXeusZjBuROJ/3N7qo4YI8b/9zQ3aJF4I0/MvPq/5gJjVp
        xOEe6M16aboM3bgDzydOOp+sOg==
X-Google-Smtp-Source: ABdhPJyaEAc/o30BN9mNATaHSTN/x9ARHeUEKpl/yCRpC2Ii3rE+ByZ0EptJ4B/QdXGCoslVP9l/+Q==
X-Received: by 2002:a63:5005:: with SMTP id e5mr13885873pgb.236.1603100796064;
        Mon, 19 Oct 2020 02:46:36 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id e23sm11252135pfi.191.2020.10.19.02.46.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 02:46:35 -0700 (PDT)
Date:   Mon, 19 Oct 2020 15:16:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        chris.redpath@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201019094633.m3yvxurfm2xwsb6a@vireshk-i7>
References: <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7>
 <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
 <20201012154915.GD16519@bogus>
 <20201012165219.GA3573@arm.com>
 <17819d4d-9e7e-9a38-4227-d0d10a0749f1@arm.com>
 <20201014042531.r7iykzygkvmpsqck@vireshk-i7>
 <503af305-77a4-964a-ed17-8df8b4e3a546@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <503af305-77a4-964a-ed17-8df8b4e3a546@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-10-20, 09:50, Nicola Mazzucato wrote:
> Hi Viresh,
> 
> thank you for your suggestion on using 'opp-shared'.
> I think it could work for most of the cases we explained earlier.
> 
> Summarising, there are two parts of this entire proposal:
> 1) where/how to get the information: now we are focusing on taking advantage of
> 'opp-shared' within an empty opp table
> 2) and how/where this information will be consumed
> 
> Further details below:
> 
> 1) a CPUFreq driver that takes the OPPs from firmware, can call
> dev_pm_opp_of_get_sharing_cpus like you suggested. When doing so, a provided
> cpumaksk will be populated with the corresponding cpus that share the same
> (empty) table opp in DT.
> All good so far.

Great.

> The current opp core is not expecting an empty table and therefore some errors
> are thrown when this happens.
> Since we are now allowing this corner-case, I am presenting below where I think
> some minor corrections may be needed:
> 
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>         struct device_node *required_np, *np;
>         int count, i;
> 
>         /* Traversing the first OPP node is all we need */
>         np = of_get_next_available_child(opp_np, NULL);
>         if (!np) {
> -               dev_err(dev, "Empty OPP table\n");
> +               dev_warn(dev, "Empty OPP table\n");
> +
> +               /*
> +                * With empty table we remove shared_opp. This is to leave the
> +                * responsibility to decide which opp are shared to the opp users
> +                */
> +               opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
> +
>                 return;
>         }
> 
> @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
>         int ret, i, count, num_paths;
>         struct icc_path **paths;
> 
>         ret = _bandwidth_supported(dev, opp_table);
> -       if (ret <= 0)
> +       if (ret == -EINVAL)
> +               return 0; /* Empty OPP table is a valid corner-case, let's not
> fail */
> +       else if (ret <= 0)
>                 return ret;
> 
> The above are not 'strictly' necessary to achieve the intended goal, but they
> make clearer that an empty table is now allowed and not an error anymore.
> What it is your point of view on this?

Why is this stuff getting called in your case ? We shouldn't be trying
to create an OPP table here and it should still be an error in the
code if we are asked to parse an empty OPP table.

> In addition, I think it would also be appropriate to update the documentation
> (Documentation/devicetree/bindings/opp/opp.txt) to reflect this new case
> (required properties etc).
> Any different thoughts?

Yes, this needs a small update in the required-opps section.

> 2) Once the driver gets the 'performance dependencies' by
> dev_pm_opp_of_get_sharing_cpus(), this information will have to be shared with
> EAS, thermal, etc.. The natural way to do so would be to add a new cpumask like
> I proposed in this RFC.
> I see this as an improvement for the whole subsystem and a scalable choice since
> we can unambiguously provide the correct information to whoever needs it, given
> that we don't enforce "hw dependencies" for related_cpus.
> The changes would be trivial (it's in the original RFC).
> On the other hand, we can't unload this h/w detail into related_cpus IMO as we
> are dealing with per-cpu systems in this context.
> Hope it makes sense?

I will have another look at this stuff, honestly I haven't looked at
this in detail yet. But I do understand that we can't really use
related-cpu here without changing its earlier meaning.

-- 
viresh
