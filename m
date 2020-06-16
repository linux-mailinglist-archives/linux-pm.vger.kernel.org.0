Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAF41FAFA6
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 13:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgFPL5s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 07:57:48 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:40667 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgFPL5q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 07:57:46 -0400
Received: by mail-ej1-f65.google.com with SMTP id q19so21183066eja.7;
        Tue, 16 Jun 2020 04:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+v8uCi/MM/jmen9lx+FKaOy5thFlmFvnrtAkhPsEN2s=;
        b=Kea9gTBuTz9gAlpjaFxFE+HQ0A3C5OA1UCPmqpcnV+orUJP6slNUDP/sEAUvcl7vEi
         GPKo1sxTSHny8UdwdUp289JVYe0q2kQIgZORdowU7ngnMVuTJiyNOanw5o53aRWogpum
         FNdCw/rW6iTYPFTuuLHj37vqtBtLqJDWzJYDRSikz679YnfVgPRlNsCBUGJqg7Nh09rE
         Zv1VwldY5vFkI9UULpznr3/0GMhcojFfQIlIhAA/qwyV+Txz5gI3OA/jwjuX/XW4NNFE
         SjknAb961v1NWcBdnCgLqxwdvQwrvrvFgY8x5FnIDE+rBYcojNq3HImEIRbppJY9JZ3n
         Dkng==
X-Gm-Message-State: AOAM530RfBJx/HfU0PCe5Ovh6S76OcXAh7IPrjI17bIc4xjewU/cvTg/
        9dhRTb2fbSxwPRPhwkQX/70=
X-Google-Smtp-Source: ABdhPJxcQNdV/H7nPWwktJ3WW5sRNLcscw+1S7A9rSCDlEe2uCTezR9VSviWZ9JiV63E3GHfZiF0Jw==
X-Received: by 2002:a17:906:fcb7:: with SMTP id qw23mr2247171ejb.229.1592308664586;
        Tue, 16 Jun 2020 04:57:44 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id h5sm10994714ejp.45.2020.06.16.04.57.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jun 2020 04:57:43 -0700 (PDT)
Date:   Tue, 16 Jun 2020 13:57:41 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Andrew F. Davis" <afd@ti.com>, Pali Roh??r <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@proceq.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: bq27xxx_battery: Notify about all
 battery changes
Message-ID: <20200616115741.GA13274@kozik-lap>
References: <20200525141200.17199-1-krzk@kernel.org>
 <fc59bcd5-1868-8c7a-9fc9-67ad70b477f4@ti.com>
 <20200616105224.GF1718@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616105224.GF1718@bug>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 16, 2020 at 12:52:24PM +0200, Pavel Machek wrote:
> On Tue 2020-05-26 21:24:39, Andrew F. Davis wrote:
> > On 5/25/20 10:11 AM, Krzysztof Kozlowski wrote:
> > > All battery related data could be important for user-space.  For example
> > > time-to-full could be shown to user on the screen or health could be
> > > monitored for any issues.  Instead of comparing few selected old/new
> > > values, just check if anything changed in the cache.
> > > 
> > 
> > 
> > At least some value will change every time we poll the battery, are we
> > okay with having power_supply_changed() called every time?
> 
> I believe that's very bad idea. AFAICT that would wake up userspace every
> 5 seconds, eating power in unexpected way, and without easy ability of opting
> out. IOW a regression.

It won't be 5 seconds but poll_interval which is 360 seconds by default.
It can be 5 seconds if user-space changes this time or if user-space
keeps asking for get_property. In first case: user-space kind of decided
about it... In second: user-space is already woken-up since it polls get
properties.

However I understand that this is quite intrusive change and maybe in
such case user-space should just keep polling (if it wants all data to
be provided every n-seconds).

Best regards,
Krzysztof

