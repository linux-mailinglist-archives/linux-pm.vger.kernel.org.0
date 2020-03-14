Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 337CC1858BB
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 03:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgCOCWm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Mar 2020 22:22:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36220 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgCOCWm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Mar 2020 22:22:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id g12so14803331ljj.3;
        Sat, 14 Mar 2020 19:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RT8FmRt2d7Rka6jKT65g4BGk8bfqytImFl8noTm1BK4=;
        b=nI2UvQvxztyIygR3fKKCeZrdVW/FekgHfNldJp8F3ydIkwpt+zZY+KN2X0Y93bL06F
         evZ8VRQvH7+1EQ9bdO5Nx0HtqB4A1ELb+Tqr8VSLjFANQiFu8V+kS6WtqqQy3BhW5J32
         0EvbYgHHtfxgVVcjIKfd5FFhjGbo6FSLQ3eh4uDqz3oNGXoMAVLxlmBZkcRLlSD3+9Ss
         ADhafAYswm4i6ga4uhEdmpRxp1dbt9H0y6ez5mo79FM/adAZZDe2Xc6KZMJYKi13G/EN
         8lMD5UTACDed4J8M/diHShTxjJYXG/Ad3ZabrgZ+sBvGoiXB1/hBIR2J9OJGblPYvq/l
         0iHQ==
X-Gm-Message-State: ANhLgQ2lS/n8xmc0gi17+caNkTaiZXUDEIX/BY5rn+O25MyKsUqrA6v9
        W5uEZU4u2WhOVuoxpZMcOlbqzPum
X-Google-Smtp-Source: ADFU+vvbkxSkdqCqcPo+U3Yio95VswK+VbzKdme+wYLTCVgtcJgbzm90XyCTacwfZ7hhf0DuyIQPIQ==
X-Received: by 2002:a17:906:3502:: with SMTP id r2mr16238993eja.67.1584211322632;
        Sat, 14 Mar 2020 11:42:02 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id g5sm4110658edn.9.2020.03.14.11.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Mar 2020 11:42:01 -0700 (PDT)
Date:   Sat, 14 Mar 2020 19:41:55 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] regulator: max14577: Add proper dt-compatible strings
Message-ID: <20200314184155.GC17580@kozik-lap>
References: <CGME20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45@eucas1p2.samsung.com>
 <20200220145127.21273-1-m.szyprowski@samsung.com>
 <20200220165614.GD3926@sirena.org.uk>
 <964b8c4c-36ca-203d-e62b-4a8fc970e23d@samsung.com>
 <20200221123813.GB5546@sirena.org.uk>
 <b52332cd-1dec-fdfe-51fc-8605d94abe7d@samsung.com>
 <20200221171342.GI5546@sirena.org.uk>
 <61dc8192-e313-021f-9e23-928257a66984@samsung.com>
 <20200224201256.GA8060@kozik-lap>
 <791edb65-4471-3e54-6806-4af2876fea19@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <791edb65-4471-3e54-6806-4af2876fea19@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 06, 2020 at 02:51:22PM +0100, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 24.02.2020 21:12, Krzysztof Kozlowski wrote:
> > On Mon, Feb 24, 2020 at 03:08:05PM +0100, Marek Szyprowski wrote:
> >> On 21.02.2020 18:13, Mark Brown wrote:
> >>> On Fri, Feb 21, 2020 at 02:23:57PM +0100, Marek Szyprowski wrote:
> >>>> On 21.02.2020 13:38, Mark Brown wrote:
> >>>>> We could just remove the compatible strings from the binding
> >>>>> documentation, they won't do any harm if we don't use them.
> >>>> Frankly I have no strong opinion on this. I've just wanted to fix the
> >>>> broken autoloading of the drivers compiled as modules.
> >>> Shouldn't adding the relevant module table for the platform devices work
> >>> just as well for that?  Possibly also deleting the of_compatible bits in
> >>> the MFD as well, ISTR that's needed to make the platform device work.
> >> Right. This will work too. MFD cells will match to their drivers by the
> >> name and modalias strings will be correct. The question is which
> >> approach is preffered? Krzysztof? I've checked other mfd drivers, but I
> >> cannot find any pattern in this area.
> > I would guess that adding MODULE_DEVICE_TABLE() for OF-matches in main
> > MFD driver would fix the issue... otherwise the same problem we have
> > with max77693 (also MUIC/extcon/regulator/charger).
> 
> Indeed, there is a same problem with max77963:
> 
> max77963-muic driver lacks compatible and has wrong platform modalias 
> ("extcon-max77963"),
> 
> max77963-charger driver lacks compatible,
> 
> max77963-haptic driver lacks compatible.
> 
> > Some of these drivers (I guess only charger) bind to a OF node so they
> > need a compatible. I think we added this to regulators and extcon for
> > symmetry.
> > Without this binding, the charger would need to read a specific child
> > node from parent. This make them tightly coupled. It seems to me more
> > robust for each component to bind to his own node, when needed.
> 
> Extcon would also need its node when support for it will be added to 
> dwc2 driver. Having compatible strings in the nodes simplifies matching 
> and makes it almost automatic.
> 
> > Another reason of adding compatibles was an idea of reusability of
> > MFD children (between different MFD drivers or even standalone) but it
> > never got implemented (children still depend on parent significantly).
> 
> So far, there is no such case.
> 
> > In general, I like the approach of children with compatibles but I will
> > not argue against changing the drivers. They could really use some
> > cleanup :)
> > Long time I tried to remove the support for platform_data [1] - maybe
> > let's continue?
> >
> > [1] https://lore.kernel.org/lkml/20170217200200.4521-1-krzk@kernel.org/
> 
> Cleanup of the driver is another story, completely independent of fixing 
> this issue imho.
> 
> krzk: could you then specify if you are against or after the proposed 
> changes?

Since we already have compatibles and some of the children require them
(charger), I vote in favor of this patch and for keeping compatibles.

Best regards,
Krzysztof

