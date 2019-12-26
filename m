Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A696B12ABAE
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2019 11:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfLZKoZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Dec 2019 05:44:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44027 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLZKoY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Dec 2019 05:44:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so23324892wre.10;
        Thu, 26 Dec 2019 02:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W6Af4lIIOy516w1HZJv41QRub9HWiIk1RJOzz7dfgEQ=;
        b=RRWj7QJRVGD7qhdqdeqYLZtA3GNeE24HteoqtMAQy9EdtyETZbqpILSloz8G+1S5l3
         Cy8XV31tpQBWog6+NhQ5HZyK+hIMRWTEzlZDq+OY5LOH2PWHZAt54XpNkSFW9VNYvK7+
         qOD+l/zTDhOjfG1WiXgWamWyNGx6mvp/eV7109emFx6+YLbOFGlnsQBka54AfSjekt3u
         5bTHFNQZ7V3MphobXR5/U8bc0spT9mDwNzvS+LweUtl1Fe5JO8PmXYFYJbH3Vq6l48qN
         ua7ud5NKDlQsiX8s1jsxKYZO3y1Qn6lYP536Y1fUhm8GTSH2duSQ/2CNMuBi732zoPwH
         Swdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W6Af4lIIOy516w1HZJv41QRub9HWiIk1RJOzz7dfgEQ=;
        b=WpqReZYAPND0pJcvE72W7t63feEUjMf0zLIivNZG/OA1yiSlfkw6NVniuY5+ZEbrW4
         aInUltIq5S4q0JYmTCcqODEBZDHT4LoTyJKZ0huTnfpQ0vIpmlPH1QKgl4ajCgUf6zws
         O3G2AKTlrtOZmBFSpA6950aTjJHrNKBQuFPvhHPCfVF3yq/sb5SKmi2LUjxg7RvXElFf
         /1saRg91ATeWk/0YPfPjOFafAX35mpsKt+lbra2M+XxSauq5i7I2AKVdew9HYV/BqbGf
         Qz2S9Enwo3MJ93i4bmHYQ9kCH77VDqjutFIXceUrmAR/0qQe3aNmEVrt198v6PBuTgJf
         3X9g==
X-Gm-Message-State: APjAAAW/k0KiNch0+0lH0BHO9QHvQsHlvXX3v0zYa18v/UapCVSokY+a
        Q5Hf8Ei7YzqD0tUlkABXANqdLnNU
X-Google-Smtp-Source: APXvYqzgFYTin+GSIcMwEioDi0ZQwh5k4QJ4YC+vSqSVqZpzHffcKVk3xA1ydLymrJcfkxNAOQOngA==
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr43133454wra.36.1577357062602;
        Thu, 26 Dec 2019 02:44:22 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id y20sm7891048wmi.25.2019.12.26.02.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 02:44:21 -0800 (PST)
Date:   Thu, 26 Dec 2019 11:44:19 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
Message-ID: <20191226104419.GA26677@Red>
References: <20191219172823.1652600-1-anarsoul@gmail.com>
 <20191219173321.bni4tbrhfkkphv7k@gilmour.lan>
 <4015380d-33ef-312c-a886-6e8bf65c976a@linaro.org>
 <20191226092751.dc3boaxsaeivuhw4@hendrix.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226092751.dc3boaxsaeivuhw4@hendrix.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 26, 2019 at 10:27:51AM +0100, Maxime Ripard wrote:
> On Tue, Dec 24, 2019 at 07:30:55PM +0100, Daniel Lezcano wrote:
> > On 19/12/2019 18:33, Maxime Ripard wrote:
> > > Hi,
> > >
> > > On Thu, Dec 19, 2019 at 09:28:16AM -0800, Vasily Khoruzhick wrote:
> > >> This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
> > >> H6 and R40 SoCs.
> > >
> > > Thanks again for working on this.
> > >
> > > I'll merge the DT patches when the driver will have been merged.
> >
> > I've applied patches 1 & 2.
> >
> > They are in the testing branch and will go to the linux-next branch as
> > soon as the kernelci passes.
> 
> I just merged all the other patches (except the patch 6, for the H6,
> as requested by Vasily on IRC).
> 

Hello

Vasily asked to not apply H6 due to my test failling on h6 and since he didnt own any H6 hw.
But it was failling due my fault (a failling build).

So the patchset work perfect on H6 (opi1+, opi3, pineH64 both model A and B) as reported by my answer to this thread.

Regards
