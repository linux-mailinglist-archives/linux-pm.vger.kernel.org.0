Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C74A5F5A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 04:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfICCiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 22:38:08 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:34411 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfICCiI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 22:38:08 -0400
Received: by mail-pf1-f171.google.com with SMTP id b24so9863551pfp.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2019 19:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TykruW08gxsHottILv6wZLApbrw58dBi1Sm7GLELtVc=;
        b=OU1rAQ6MyxwizT5LQlK4y8PF7ERsS5swZWcZVv+oE43xR9ueU/Xl1fM6osKpoPiC3p
         L08572w5BL9Kknkw/LiMl5xBCnjhTNfKm4UVxeRJm5nvZ90QBBEbczkj3Pj1aGgujOI4
         y2Tu1c/KvGQ710mtttohxhXF8+h1TqWJB2Z6F7xCLpqzgLaBbvrJEwb4QfAKVy3rr0Th
         0PV1mmyap9FJk3bYBxytRgPbbzQRGp3UstdJabi3v5F6OMYpL4vRWf+RjpIJuL/T/wcy
         3dmhidW99+rLy3BuGu+69+l+hU7nHejzOEM9EPTAOfCTvZW2SXzktGyiY6Xw5X3rHqp8
         RyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TykruW08gxsHottILv6wZLApbrw58dBi1Sm7GLELtVc=;
        b=ge60JkdflIriRjXLuoRgQgWD5cNzuDhbOPpeoWEJBNHfQyt+xmmcxQ0hvGYGlm4Ty3
         5dNSiquf594GdK2HWn2T1MZuIZqhZawLIj15wupQlyRu9+IhjacHPOG8NUZXVh8HUiHv
         5oZk5nGBOu0cKXKVciMgoYOFfXYGKQlRQqOAfXjNARquncp/nNa66ZKgP4FZ3N0MyEku
         sFMbnyt1d5ON7Jkg/WXuS2UXckLKpbb0KuGKSAAafFx7t/bWJcCm0KS2h8fIseMGoYaX
         BkAGS1wXqAFosvhmcuN/DTlac9mH/1ON8xTkPKP1Xip1q+ibtvWUkzDZis837bKmbbVk
         RyJg==
X-Gm-Message-State: APjAAAVk+okfggHtU6aOVgXFuzWwfbvU3r/4n1E+5ppH0IkheUGYymbd
        a96PD7WA3bE6Ov7TcrkiOsX9Ww==
X-Google-Smtp-Source: APXvYqzirogE3TaSvuqgm0AxpWfj/w/STl3K/IswnilDHL0q4CxFjOTzfIvQAJMR+T4KEnD5JJtkFA==
X-Received: by 2002:a62:7e11:: with SMTP id z17mr36320477pfc.211.1567478287856;
        Mon, 02 Sep 2019 19:38:07 -0700 (PDT)
Received: from localhost ([122.167.132.221])
        by smtp.gmail.com with ESMTPSA id a4sm16568338pfi.55.2019.09.02.19.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 19:38:07 -0700 (PDT)
Date:   Tue, 3 Sep 2019 08:08:05 +0530
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
Message-ID: <20190903023805.qum23m7tge3zkb5a@vireshk-i7>
References: <cover.1567421750.git.hns@goldelico.com>
 <d0dc1623ed6b1bd657f169dc2b4482b269bdba37.1567421751.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0dc1623ed6b1bd657f169dc2b4482b269bdba37.1567421751.git.hns@goldelico.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-09-19, 12:55, H. Nikolaus Schaller wrote:
> +		opp1-125000000 {
> +			opp-hz = /bits/ 64 <125000000>;
> +			// we currently only select the max voltage from table Table 3-3 of the omap3530 Data sheet (SPRS507F)
> +			// <target min max> could also be single <target>
> +			opp-microvolt = <975000 975000 975000>;
> +			// first value is silicon revision, second one 720MHz Device Identification

> +			opp-supported-hw = <0xffffffff 3>;

I don't see the driver changes using this field, am I missing
something ?

-- 
viresh
