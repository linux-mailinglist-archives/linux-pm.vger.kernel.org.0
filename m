Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FF829D94E
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgJ1WuD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:50:03 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39865 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389458AbgJ1WtQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:49:16 -0400
Received: by mail-ua1-f66.google.com with SMTP id t15so188445ual.6;
        Wed, 28 Oct 2020 15:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QX0ENcNCRgqoRwA+YusJr6c818KTH5LROqERQdCNVs8=;
        b=eYi/gNGqW3L/aL3r8BxdxzPw+5CvtA96dkSqAy2O7BPeeGsEYeE2MWy03BT1/FvBtN
         6bBmCNAq04tpaSuAlZcjd9412MiUEOgGuCpgM3lojvXZundsqS5Mutob9hxRpQGulSVU
         DKVBVtBCKINYj/owHeuf63IAu4pLsexArsREUNY/5RJ4ImgHR8Odt3F74oLfX3sYKZo1
         aJH9MChccurJNwiZO+hO53LdUicPbyH/9D/LH0t9ftDWy53rnt2mFGh7f13TeFKWi0GC
         hnkW7LNCx4I6IhQzSS9Q3Ey0+9vyukNDN1IP8IUpWB4x/uQmquzBkYKY9MjLqDEH0Io4
         B7ug==
X-Gm-Message-State: AOAM533pfI5njsXu8u5JUH3Kmekl5qJEsFfSajMstaNQuUs6QXC50TmM
        Q1NFEdIDMcDA/QmQly7iDhbtNRz3+g==
X-Google-Smtp-Source: ABdhPJyYAHXqPlvZ5xX1GDoTkHk3tTpQd2ChQUyWIgVIOlXap+r02KTeFGDxbyhKGUnxb6HGIN5QrQ==
X-Received: by 2002:a4a:c68d:: with SMTP id m13mr6136474ooq.64.1603898794592;
        Wed, 28 Oct 2020 08:26:34 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f13sm2572772oij.0.2020.10.28.08.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:26:33 -0700 (PDT)
Received: (nullmailer pid 4054817 invoked by uid 1000);
        Wed, 28 Oct 2020 15:26:32 -0000
Date:   Wed, 28 Oct 2020 10:26:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 08/52] dt-bindings: memory: tegra20: emc: Document
 mfd-simple compatible and statistics sub-device
Message-ID: <20201028152632.GA4051913@bogus>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-9-digetx@gmail.com>
 <20201027090212.GG4244@kozik-lap>
 <1cce314a-1eab-61c9-099d-54f987b03761@gmail.com>
 <20201027194457.GD140636@kozik-lap>
 <ae06bd70-93f5-abe8-64d9-e5e991cd8ff8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae06bd70-93f5-abe8-64d9-e5e991cd8ff8@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 11:18:34PM +0300, Dmitry Osipenko wrote:
> 27.10.2020 22:44, Krzysztof Kozlowski пишет:
> > On Tue, Oct 27, 2020 at 10:22:19PM +0300, Dmitry Osipenko wrote:
> >> 27.10.2020 12:02, Krzysztof Kozlowski пишет:
> >>>> @@ -31,17 +32,34 @@ Example:
> >>>>  		...
> >>>>  	};
> >>>>  
> >>>> +	emc_bw_dfs_opp_table: emc_opp_table1 {
> >>> Hyphens for node name.
> >>
> >> We already use underscores for the Tegra CPU OPP table.
> >>
> >> https://elixir.bootlin.com/linux/v5.10-rc1/source/arch/arm/boot/dts/tegra20-cpu-opp.dtsi#L4
> >>
> >> What makes you think that hyphens will be a better choice? Is it a
> >> documented naming convention?
> > 
> > Unfortunately that's the source of confusion also for me because
> > Devicetree spec mentions both of them (and does not specify preferences).
> > 
> > The choice of dashes/hyphens comes now explicitly from all dtschema
> > files.  Previously, the documentation were emails from Rob. :)
> 
> Okay, I'll change it in v7. So far I haven't seen warnings about it from
> the schema-checker.

dtc with W=2 will warn.

The bigger issue is the name should be generic.

Rob

