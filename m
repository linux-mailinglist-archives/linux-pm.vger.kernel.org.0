Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01CD2A5F67
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 04:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfICCjp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 22:39:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41132 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfICCjo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 22:39:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so3192479pfo.8
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2019 19:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iMDW/m3hv6pM+84dygmzOuAaegfuHoNMyS2NH8pm8Tg=;
        b=NfkZw4eyCld6HLQ14Z0yBRk9nQWDeOJzJn3bGZI69PVFoufD62dwEMB2i+VaoSFwST
         xxSVybA3SHPnkk8EGa8GpTs5c7d6IYiOeSnBofD39vIoUZirmiRTKoBhZkeEg30uORP5
         XhMCtZE2WHfl0k5/FsjZy+cw1ZCnKOb6IShidLwJrcKLV7A0WABr/WBwZy4oQsdmCnyM
         Ru0F8hmsIVkOFjKQl8GOBxIxiv/YSgV/3HHLQPqX55Q9x9R8nLHWy7B4YIKjfC05jQZk
         7HhFchFD0OaZjNwAMtpFY7ZWtRk0RQobeY2GvpY7520XLZQBQIRjPSOJzYDg7jceTgLG
         R5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iMDW/m3hv6pM+84dygmzOuAaegfuHoNMyS2NH8pm8Tg=;
        b=qHAjLWfonxU5rJWFjyWXiRPzIKbRw8EiNr5z1bkV+Q7emc4YcGJAhFoV7Dux2KVYkH
         m3lxfJJB4vtp3fLz59i7Uo8iButnVWFOw8H0rT8m342ns3/8za5gMPWjosJHHWpZ93kT
         Uqyuazf4QfGHKej1ZxK9fO2eBok0O5l7PYC2n1m3qE5zpRssIK8KkIsQmaUu3frp1QTW
         rD+WzuDsUC6YoeQigDVMAOjKKNC6ypAPwKAvRroNW0vyXvrYxXZlKymqf5oU7pi98CFE
         Ptvu++B2UFXWjyWSIIar3ApbS+y+ywijolAp+PybBRQFgJhbgvsoV5bIskSMZsA8KQ6J
         k0IA==
X-Gm-Message-State: APjAAAWpDb15qcxpiqPjFznqdeM/M9Qe3TWktEp9JdzyRD4GjHK3WG82
        rLul9FImyc3hWvdlUPZWZcgK1A==
X-Google-Smtp-Source: APXvYqyEZC6bVMU9/I4/7wZb0vVsPM80Gk3t1roo/YA9fCGd/tMfPnLz7IzwHQ2W3GuO5dvE77vpdA==
X-Received: by 2002:a17:90a:148:: with SMTP id z8mr16008922pje.96.1567478384117;
        Mon, 02 Sep 2019 19:39:44 -0700 (PDT)
Received: from localhost ([122.167.132.221])
        by smtp.gmail.com with ESMTPSA id c127sm1785472pfb.5.2019.09.02.19.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 19:39:43 -0700 (PDT)
Date:   Tue, 3 Sep 2019 08:09:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [RFC 2/5] ARM: dts: add support for opp-v2 for omap34xx and
 omap36xx
Message-ID: <20190903023941.pgh24mz4jh325xrc@vireshk-i7>
References: <cover.1567421750.git.hns@goldelico.com>
 <d0dc1623ed6b1bd657f169dc2b4482b269bdba37.1567421751.git.hns@goldelico.com>
 <20190903023805.qum23m7tge3zkb5a@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903023805.qum23m7tge3zkb5a@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-09-19, 08:08, Viresh Kumar wrote:
> On 02-09-19, 12:55, H. Nikolaus Schaller wrote:
> > +		opp1-125000000 {
> > +			opp-hz = /bits/ 64 <125000000>;
> > +			// we currently only select the max voltage from table Table 3-3 of the omap3530 Data sheet (SPRS507F)
> > +			// <target min max> could also be single <target>
> > +			opp-microvolt = <975000 975000 975000>;
> > +			// first value is silicon revision, second one 720MHz Device Identification
> 
> > +			opp-supported-hw = <0xffffffff 3>;
> 
> I don't see the driver changes using this field, am I missing
> something ?

The driver already had them it seems. Hmm..

-- 
viresh
