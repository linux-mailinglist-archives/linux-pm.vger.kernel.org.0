Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2ABA6163
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 08:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfICG2M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 02:28:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39862 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfICG2L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Sep 2019 02:28:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so8541098pgi.6
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2019 23:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3UjuVbvJVhJAU0IH4ZbNm2Jlx5L7+f9v4Qm0AxsrvR0=;
        b=wL2ybVnw/vZTE94Xlb5xNn6xFzOU0UBcajT5ZX8iLCFCwV0n5PB4oIlQz48eacDYVj
         ytsZyjwjhWQ1OyE6tUH5+Fw3vuDDJRwzLal/K5HBzVBwgrKvvmMe5GeNlWO1WhxyccUV
         TwlIgLZwtVm9qfRHB4O//OKoPLU1wfEtKHfj06We2tjZQBl2SBKGSCKkfScfh/XMv6a3
         Jxwa+zf0f/0wDZhgKmHEzqJdf/zypEzxM+/ZA4H8i6bRuUpTHWUWP8CO2c1uSie3Gvy5
         DPrjLacNZAls6mFBSNsEmMyRo9L784IaV/PYWdAlL4gBtSGkIK6Qvsz1M7uDfjwIDexd
         VLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3UjuVbvJVhJAU0IH4ZbNm2Jlx5L7+f9v4Qm0AxsrvR0=;
        b=svvVFqV/kY2JDSm3/so3RvbzT7lU9M//va1od45g7xp+OvQc5McW+EULGxd6sV3f30
         NsZolzcY01qBTIbNiNyWI6WkBwKxC7FnzwUu3mNl2rYWEFZtr8TJZmHJcbFgaEKcGuFO
         erC7E4cjJPlP8G7oVNkS4eaC9mHy+kNLJMSLdNEXT4BnDr8EA+ZXWcFDHPVWn2cuXQNn
         hVPxggSwJP5JN+78MTaS22/MzCnIv2gBs+NLoy5yGiQyc0dsYEWY1EaqOjrpq5nSVxnz
         d46HKlhCDiJLoeckF+5m0d9eYScItASpQe4fOjAJRrMrKoGdXTLfXOJJUEAJC9vGd4DD
         WuQg==
X-Gm-Message-State: APjAAAU+jZ5zcIJKXw0xD7jvHEH/v6vx41T5hKGs/CowxHGNvElReMBR
        V2Qnqunl1zbA1lJiuLgPz8vTJQ==
X-Google-Smtp-Source: APXvYqwazyPlv855qi7l9Cvtv6Ry/4WLau0L7ow/Xvvtoyuzbt1Tlw+/d8AZcxMClQX/5LVzlajoKw==
X-Received: by 2002:a62:e802:: with SMTP id c2mr2520855pfi.212.1567492090953;
        Mon, 02 Sep 2019 23:28:10 -0700 (PDT)
Received: from localhost ([122.167.132.221])
        by smtp.gmail.com with ESMTPSA id b5sm23696486pfp.38.2019.09.02.23.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 23:28:10 -0700 (PDT)
Date:   Tue, 3 Sep 2019 11:58:08 +0530
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
Subject: Re: [RFC 4/5] ARM: dts: omap3-n950-n9: remove opp-v1 table
Message-ID: <20190903062808.p6jkgwylyqxcjs4z@vireshk-i7>
References: <cover.1567421750.git.hns@goldelico.com>
 <2f978667c1533e46e3a5df58871e9048f3eb74e9.1567421751.git.hns@goldelico.com>
 <20190903023635.44yf32jowpm3hgfp@vireshk-i7>
 <8BC1AEC9-7B24-4C07-8659-16741D018164@goldelico.com>
 <20190903061403.k3d333f54gj2kuxi@vireshk-i7>
 <6B7B0EDB-8A60-48A0-AFAB-8A266358300C@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B7B0EDB-8A60-48A0-AFAB-8A266358300C@goldelico.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-09-19, 08:23, H. Nikolaus Schaller wrote:
> 
> > Am 03.09.2019 um 08:14 schrieb Viresh Kumar <viresh.kumar@linaro.org>:
> > 
> > On 03-09-19, 08:01, H. Nikolaus Schaller wrote:
> >> 
> >>> Am 03.09.2019 um 04:36 schrieb Viresh Kumar <viresh.kumar@linaro.org>:
> >>> 
> >>> On 02-09-19, 12:55, H. Nikolaus Schaller wrote:
> >>>> With opp-v2 in omap36xx.dtsi and ti-cpufreq driver the
> >>>> 1GHz capability is automatically detected.
> >>>> 
> >>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >>>> ---
> >>>> arch/arm/boot/dts/omap3-n950-n9.dtsi | 7 -------
> >>>> 1 file changed, 7 deletions(-)
> >>>> 
> >>>> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> >>>> index 5441e9ffdbb4..e98b0c615f19 100644
> >>>> --- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
> >>>> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> >>>> @@ -11,13 +11,6 @@
> >>>> 	cpus {
> >>>> 		cpu@0 {
> >>>> 			cpu0-supply = <&vcc>;
> >>>> -			operating-points = <
> >>>> -				/* kHz    uV */
> >>>> -				300000  1012500
> >>>> -				600000  1200000
> >>>> -				800000  1325000
> >>>> -				1000000	1375000
> >>>> -			>;
> >>>> 		};
> >>>> 	};
> >>> 
> >>> This should be merged with 2/5 ?
> >> 
> >> Well, it bloats 2/5.
> > 
> > It is logically the right place to do this as that's where we are
> > adding opp-v2.
> 
> Well, sometimes the philosophy of patches is to add something new
> first and remove the old in a second separate patch if the system
> can live with both. This makes it easier to digest single patches
> (because they are smaller) and might also better pinpoint an issue
> by bisect.

Right, but you already removed some of the opp-v1 stuff in patch 2/5.
Why leave this one out ?

> > 
> >> What I hope (I can't test) is that this opp-v1 table
> >> is ignored if an opp-v2 table exists. So that it can be
> >> removed by a separate follow-up patch.
> > 
> > It should work as that's what we are doing in OPP core, but I still
> > feel this better get merged with 2/5.
> 
> Ok, I see. Noted for RFCv2.
> 
> There will also be a big batch of changes for the compatible record
> (omap3530->omap35xx, add omap34xx where needed) of ca. 10 board definition
> DTS files. Should this then also become part of the new 2/5?

Compatible thing should be separate patch anyway, I was just talking
about replacing opp-v1 with v2.

-- 
viresh
