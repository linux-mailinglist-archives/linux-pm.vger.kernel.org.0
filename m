Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3FAAB0CF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 05:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403866AbfIFDCD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Sep 2019 23:02:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38675 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392094AbfIFDCD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Sep 2019 23:02:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so3319826pfe.5
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2019 20:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fy2sCHO6ksC6gfm/SNdH9QAmaHYMAPiTKwgACIfMK3E=;
        b=XYV34W7Gld+84er7G3MqlpUVPw+yXk9mEYDM09dIIZfYiOCl+/jtyAr/sOGtS1R2+B
         JY6SBfz4uZA5ORR/Qe9Acz/QsUN2aPRDHc/AX9QSNIqSXMsg6rfHlezvfkRwb83KrRYw
         dbTwTWkdVJPFa9BA2aZAwWQz69Y6rBJKYj3pchzlmNOVQvzyg5ixprltJ1pK9LuLHN/7
         3Th3DERsudBcXWB2KHPfSfyuxo1TDnYKgwhvjCbP+oi6hgqynCPPulXjkRV948l6mP7t
         YByt+lDQlhRHqHVw7sJFyndtQjYrgpxQp2rywpVoVhQX/KeRhFhWyE5g0X8Mkbdyds0O
         3gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fy2sCHO6ksC6gfm/SNdH9QAmaHYMAPiTKwgACIfMK3E=;
        b=SzHVIMggzkseBbVgbT/cxB8mcrQOwUxvipmbgiBC75PnsGHWrCk8cS5fj8pLCQas0j
         e+E/oij+ANc6JyJ0YeG8V4IHZn6ncjqaL43u2xtfd4gh0XaL/zVXD0LUC39Agdh9Tfof
         wafYXk3zOdwYprZwzz9oGP8trePf/N3ScJrPi3Y0hnS9QJL2TDBpYkYP1fEeLmpFGIgs
         ho7HYk5xhIB0LysRlAFHyyTK30BgGAuahtBJqJki1M9IOq5lR+RUSeRYxgoLwnTPGo1A
         APpGnfATwmWjvuAlqW3EswnMCkKME5Q+U4v8CAQ3QsB1FdhiBhVg7iBZjXGmzDald6vI
         a8yw==
X-Gm-Message-State: APjAAAXqYiYZHuu5yPabxLsy+oSI+Al8CB+QSUnPzuxoiCSr2Zyu4VOw
        6gPMIncwTd4riGN8vUIUh9QhRQ==
X-Google-Smtp-Source: APXvYqwh1UMtnkLX6kIDmHA80lT5q6jkelT/w00gGqU1+nd+XIYlLSyB0Z5bUQxb1Vwm1xMB3MOHSQ==
X-Received: by 2002:a63:c17:: with SMTP id b23mr6048375pgl.224.1567738922281;
        Thu, 05 Sep 2019 20:02:02 -0700 (PDT)
Received: from localhost ([122.167.132.221])
        by smtp.gmail.com with ESMTPSA id x22sm6714546pfo.180.2019.09.05.20.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 20:02:00 -0700 (PDT)
Date:   Fri, 6 Sep 2019 08:31:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [RFC v2 1/3] cpufreq: ti-cpufreq: add support for omap34xx and
 omap36xx
Message-ID: <20190906030158.leuumg7rwsvowwfx@vireshk-i7>
References: <cover.1567587220.git.hns@goldelico.com>
 <a889b10386bebfbfd6cdb5491367235290d53247.1567587220.git.hns@goldelico.com>
 <20190905143226.GW52127@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905143226.GW52127@atomide.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-09-19, 07:32, Tony Lindgren wrote:
> * H. Nikolaus Schaller <hns@goldelico.com> [190904 08:54]:
> > This adds code and tables to read the silicon revision and
> > eFuse (speed binned / 720 MHz grade) bits for selecting
> > opp-v2 table entries.
> > 
> > Since these bits are not always part of the syscon register
> > range (like for am33xx, am43, dra7), we add code to directly
> > read the register values using ioremap() if syscon access fails.
> 
> This is nice :) Seems to work for me based on a quick test
> on at least omap36xx.
> 
> Looks like n900 produces the following though:
> 
> core: _opp_supported_by_regulators: OPP minuV: 1270000 maxuV: 1270000, not supported by regulator
> cpu cpu0: _opp_add: OPP not supported by regulators (550000000)

That's a DT thing I believe where the voltage doesn't fit what the
regulator can support.

> But presumably that can be further patched. So for this
> patch:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks.

-- 
viresh
