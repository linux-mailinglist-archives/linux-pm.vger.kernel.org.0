Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9299179AED
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 22:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbgCDV3w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 16:29:52 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38863 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388281AbgCDV3w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 16:29:52 -0500
Received: by mail-ed1-f67.google.com with SMTP id e25so4083405edq.5;
        Wed, 04 Mar 2020 13:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZhvV+X/QugBakZftkSm3Y3Vs/NjUYpL1g5J3nO6+eBo=;
        b=BMUSDZuKUJEsB0rx65KmLOfr18pOxTALdV6q709AOz4ACj0OKVgMZ35sKyJ4A/9g0S
         djD3oN6qJ/VOZ+TUE4VK8fvJCkkf5lzPWp9YLyLabXpyEecr3ACz4pb3n8HVLqix0AqJ
         OPf51c0i38VC4SOGVtFGEfiM+KyQ9G9PbL/RPGQ93coVv4KTbTHNCSY8Drwh9qgbFUDl
         Ss8xgqc3fn2UDHd42bebeQGNb4XNGp17J/GsP1gYd0J9BUEvUjSvmhbI1TQAzBbAoHLx
         14wfe2SohwELPdmJMEhWcwSmsbuTys4OsTJUHiDcBjn6blegOJvgQBl7XJdHM/SRYcI0
         jPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZhvV+X/QugBakZftkSm3Y3Vs/NjUYpL1g5J3nO6+eBo=;
        b=aUiwpwgVAWAkY/9jStS+CLbt4Cc+zR7GjJmvOfjGQbC8EgzYvggZ/v+JkdKRvJ5VaW
         renczNoe+Fx6MtU8hB0ekR7GBhGUEsuwYdkOUiLaPgWAwGx0FMQWkVtACCXhpumMD7Gn
         6fZsQtDTj2NbFgp/MeBAI8w4coesmCgpvd3GbTjBKk3kkyIJpGK1YQHrT6xKcbUnYIOp
         Elg4Su0A76jBsV3Jk1Nxw7o6zbDiHgdRJz9Q9gLQINurv3Iok33ocEuhfwnSzV2PCfWm
         hgu3rYKrsHGxlHMcVxq4OW8+YaMhRobuFaR3rzDq0jtB3yGf3FU96t3YRE8AEGpFPzi/
         aBXQ==
X-Gm-Message-State: ANhLgQ0nWFHR+ZMCSqioJt4hi6JMKb64GICveTwSZnIjPvmckXCEmNH7
        7MMbJQqabDiNadRh3wT3xiI=
X-Google-Smtp-Source: ADFU+vsinGfEMDGvYA3rbefP4+LG0EuZ8p5Sjx1gqvFYpYT40aNciRcBN2rt9NVFEdqWu+XwpOzQpQ==
X-Received: by 2002:a05:6402:22e9:: with SMTP id dn9mr4755253edb.165.1583357390388;
        Wed, 04 Mar 2020 13:29:50 -0800 (PST)
Received: from felia ([2001:16b8:2d16:4100:5c62:5f:595c:f76d])
        by smtp.gmail.com with ESMTPSA id g31sm1622644edd.53.2020.03.04.13.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:29:49 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 4 Mar 2020 22:29:48 +0100 (CET)
X-X-Sender: lukas@felia
To:     Chen-Yu Tsai <wens@csie.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: update ALLWINNER CPUFREQ DRIVER entry
In-Reply-To: <CAGb2v66sJ42yaLwHubrOvCNBQQ4sJ1HXYpVmf86oW-sp7bCqGA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2003042226380.2698@felia>
References: <20200304113452.10201-1-lukas.bulwahn@gmail.com> <CAGb2v66sJ42yaLwHubrOvCNBQQ4sJ1HXYpVmf86oW-sp7bCqGA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On Wed, 4 Mar 2020, Chen-Yu Tsai wrote:

> On Wed, Mar 4, 2020 at 7:35 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> >  ALLWINNER CPUFREQ DRIVER
> >  M:     Yangtao Li <tiny.windzz@gmail.com>
> > +M:     Chen-Yu Tsai <wens@csie.org>
> > +M:     Maxime Ripard <mripard@kernel.org>
> 
> There's no need to add us. The Allwinner entry already covers this under sun*i.
> 

Okay. I sent out a PATCH v2 without adding you as extra maintainers:

https://lore.kernel.org/linux-pm/20200304212600.6172-1-lukas.bulwahn@gmail.com/T/#u

An ACK is appreciated. Thanks.

Lukas
