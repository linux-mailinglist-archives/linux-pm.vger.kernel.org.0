Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA5160FA5
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 11:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgBQKLT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 05:11:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39530 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgBQKLS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2020 05:11:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id o15so18165901ljg.6
        for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2020 02:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=A7RKQ4ZTCrIf6WU3LWe0K/rriT2SokS7Kl7BJW+LdTU=;
        b=zEu5MUQlYw63tCjUwdW8VAq2ypF/TDByOzDs29nJi6lY8niYv18kH3ZiYcVpedxtJt
         8ELQSR3Gut612KekflotI0fQxcJbKvKebO+5fxvy6HKX7WCbp4Z5YDuhsDAppe0KCOK0
         2TX5BbsUirQve1UmFY8aDI/qeuqhOamt+BpuWOxtujqCjU6odQGGI5PMGcJZE3XWGBN+
         F4ULFY9yunWDtm9q5hSpxQIQjEnBvfrb7akkICBNChm79+ixtjdnAlHz6Clx1n/xh8tF
         MUf4zMqv0wsxHY2jMecinInGzlv/PSf2aKon6Swl7JFwfeF7OYwshRMZ+gQEhNm5P9Ek
         d05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=A7RKQ4ZTCrIf6WU3LWe0K/rriT2SokS7Kl7BJW+LdTU=;
        b=qeZyaB9vk5yPwtrcBmCVNaDaR3R4P0aisJHMqV/R3sCp6+uQH/C/vb58W+LF7iRaUJ
         YNadZqadRjwdvRny5wUKHmggJa5kFS/zJ+wLSvvcQtoOKo5LSEZpiuK1q3eqSit3y7Vw
         mH27bEK/FfIWj0cySwku1LLWqiwz+mfVZO7Qsaq6hhJTMPuwxMU5aczeeYPXD/b6hSDP
         A/cRCe0vryvikJElv+CxA8Y/NbwBIfojLY/3BPy78SAf24CfbLKW9fqOg7n/iYAYF0FJ
         uXGZDtT34/ukwR7eISAEztWzlLeBR3cqEMDi+fQRgeHofDNfO7jlbZHHfTmV+iEYZzA1
         Yh4g==
X-Gm-Message-State: APjAAAX1YEBsMIu1Lo2NLBeONC3VzAJyUKvAEF1/k/RLXd5JPFoIG5IM
        yP7T2dLO0FsgbPotLKY1gKRfCw==
X-Google-Smtp-Source: APXvYqwXQ5Fdcz23uGi65PcZ1865HLJNfZsVs0bsnqI/YKhJEznIeMRmjQNYnXM/cnAlOQRoalBn2A==
X-Received: by 2002:a2e:9d11:: with SMTP id t17mr9871632lji.169.1581934275777;
        Mon, 17 Feb 2020 02:11:15 -0800 (PST)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id u16sm40913lfi.36.2020.02.17.02.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 02:11:14 -0800 (PST)
Date:   Mon, 17 Feb 2020 11:11:14 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Renesas R-Car thermal drivers
Message-ID: <20200217101114.GO3013231@oden.dyn.berto.se>
References: <20200216130252.125100-1-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdUdBVwAbG8Qicg3_aKvwjq91QJWS5FQwM6NPdgbyP2Wzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUdBVwAbG8Qicg3_aKvwjq91QJWS5FQwM6NPdgbyP2Wzw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your feedback.

On 2020-02-17 09:01:18 +0100, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> On Sun, Feb 16, 2020 at 2:09 PM Niklas Söderlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
> > Add an entry to make myself a maintainer of the Renesas R-Car thermal
> > drivers.
> >
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Thanks for your patch!
> 
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14206,6 +14206,15 @@ F:     Documentation/devicetree/bindings/i2c/renesas,iic.txt
> >  F:     drivers/i2c/busses/i2c-rcar.c
> >  F:     drivers/i2c/busses/i2c-sh_mobile.c
> >
> > +RENESAS R-CAR THERMAL DRIVERS
> > +M:     Niklas Söderlund <niklas.soderlund@ragnatech.se>
> 
> +renesas@???

I have not used the +renesas@ for my other entry in MAINTAINERS for 
R-Car VIN and wish them to be the same. I have do not mind if that is 
with or without the +renesas tag.

@Shimoda-san: What would you and Renesas prefer I use?

> 
> > +L:     linux-renesas-soc@vger.kernel.org
> > +S:     Supported
> > +F:     Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
> > +F:     Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> > +F:     drivers/thermal/rcar_gen3_thermal.c
> > +F:     drivers/thermal/rcar_thermal.c
> > +
> >  RENESAS RIIC DRIVER
> >  M:     Chris Brandt <chris.brandt@renesas.com>
> >  S:     Supported
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Regards,
Niklas Söderlund
