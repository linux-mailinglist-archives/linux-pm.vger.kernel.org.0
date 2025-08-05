Return-Path: <linux-pm+bounces-31949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 318CEB1B064
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 10:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3F9189B486
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 08:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44282243376;
	Tue,  5 Aug 2025 08:47:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539232B2D7;
	Tue,  5 Aug 2025 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383649; cv=none; b=TduZhaHLqUBIhmYxHACQ+5nf907pZ8CvuvCqAmPrVOK1pDUVa9aDb+olz1GPl5wq+xhECpME1uqGFpWskqaCWr5a5+k65e51c2atcOurYebcGKBxe1lvcGqULrY19XUwnAZcWsCAvW/ab8cNuwRheH3hxl3vqn8OO2gV+obFw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383649; c=relaxed/simple;
	bh=pePwquksY4iOsn+Bf5NohhRgWpbDyaqG7TEzJH9uMtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGjug6ujuppmCYe+IXuHJFtfhFJyJIlJOXUNX2ZY/eVo8Hy3Y8vosUTiIrU4Eot/cmnoRbDxPhjpg1cVFuMrRpDBCJMUePatU1jTuUDpRnrMTfKE2YkQXfr8WwxC54VrWjt9tZTx2j+W8hEyowsTkcu2rWoLMBL9NpUcOqI6Bk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-539754975f9so548333e0c.3;
        Tue, 05 Aug 2025 01:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754383646; x=1754988446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIECKEJqaOmA/96B0sp5ucDcag2zNSxKtDZBEUl6HN8=;
        b=oF0jRbCdgnnpOlZNcYkiSZjmfmoXlENO7GT4CQ+Vteq+LGEx8Z16GZUOCObjA+1ptK
         krZNh0AVex5U+WWPjXaBavvkp/YXkxNejqtqJi8qmIyQhDlCsbXphq1ivcQx0LfsNL5T
         r78ks6u2u5z3bUvfH15Fe6iAI5TWadepYfip+waNqLAzueiHpLs7O9F6AjPcpPpE3bOM
         kINamSHJ0jcjidaXlpJtrv02wDquiAMwuMNpLbG0QE0BaWBuaIshu0iskwuG536JRkJi
         kvyX9FBOc0uoaUQG2WUDyGUk3DtG2uv1rBoUCYswxJ00zxzlxTOeKfUPltCt3vmg9GmK
         BfLw==
X-Forwarded-Encrypted: i=1; AJvYcCV+4Tn6J3wRQHVRCT0L/A/R6Ij4/Ft+TahKk/oBdZGRlfei9WymZR7uM3UME4NmkqUl23yTxhrM/3e9RQIP@vger.kernel.org, AJvYcCV78yqBxPqByokWfj2vMHDptUe1V/a3E55lUM2WY972OxSlBQK9bbh8ZJdkk6wlJiPK6wRBIa2WcswT@vger.kernel.org, AJvYcCXimFzUm82gTCt3L0UHdhkmYQu0dA4qnLR2DdEeOSQoYUc+h3Lfeh09/XBznjM+6DEHfzA/L+4UDIs=@vger.kernel.org, AJvYcCXp6tC79/fYSXthtai0B+pzJUHJ5sBBSJOjUWDzSPrQqukzLDGd4Hdg2sPCMRAs2TliBvJ6fzOmTh7iIeC8cYEN0pU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9J3XrIwUxa63mOBaEy4WAjCGpND3n90+JDOrcltODtjxUeJtI
	fQNpLIBKpI3qbZQMdLJycKjoFvPH0TLo+Sj/UQNKsnE7btVfdfPeCGy7J+8o6A4a
X-Gm-Gg: ASbGnct9dr3Msw4RhgaFZNHA8+4vIirEbSBwz1Q7c6NgXyV0O5pDC5k9ioQes8NRI4y
	Vj+1Z3H1F3PSIsKeZ8lH5Tdaq8/Jo8IKPh+b60RPt/lUHOTbXY+rbperUVH5wOC4kLugh5+up45
	CnNZhOwsthcGA9n9KFv5/Fd4DeJdq+ISw9+B2Vl79moeBBx7nY5pd31VYOgZ9VPEdvLhfY60KQG
	4ThgWrDg3ctZNd22Yos9L24k45jo7lqT97llmUd6VG+wHvLBkQrKMhw08XzcL3KsyLbZuJtk+Dg
	gzMxlFwJTJOT4DugXXvehDkZaCrDsJKvlioyBhc3p+64D8JHjUKJXLTBvr8hj1ENr0I2GIoQ0kH
	bzIX6vp6nRDeHedtgizSAEV7hAAlipFxIf0zjQpFenJWFJuIjb/9LqcQCzRtNdHGX
X-Google-Smtp-Source: AGHT+IHNnfmSV5mGe9dwGEknH2zCKRkg+9KD8S8FfdQ593L9a0+e9sVmF5j8a3nceSRg5y3j12MNZg==
X-Received: by 2002:a05:6122:91a:b0:539:3bb5:e4b1 with SMTP id 71dfb90a1353d-5395edf4f89mr5064210e0c.0.1754383645898;
        Tue, 05 Aug 2025 01:47:25 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53936b15ea5sm3330133e0c.5.2025.08.05.01.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 01:47:24 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-539546a2174so868839e0c.0;
        Tue, 05 Aug 2025 01:47:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0Xg5nZzgagtQTReMGnP5dDJCBZCJTFMaJYj/YKmlSKguKK7eamDHVflHuNUl61fcdULGqqhzYpkWzDZGnHn6QwMk=@vger.kernel.org, AJvYcCU6IpPYfmya9mzIq5/K2iqb/nO9kaA+2odUxVb1M9yREXbqOZP9XuU4X9TpYDilNWN7NodxS5CV9zk=@vger.kernel.org, AJvYcCUaQlarKKDAQc64VzsDC5ZMguKrRNeo3hHE5LsSREbf2hmqL08yJjZHXsJoqWb0VaugArqN/aE1ap2b@vger.kernel.org, AJvYcCVpCXRcV+vddrSLmZ15bARSVYKPeMexKWYXhp0Ton3olPkRTJRPzYiY7M6I3DfQXfmgEobVq8LsfKoSjX1L@vger.kernel.org
X-Received: by 2002:a05:6122:91a:b0:539:3bb5:e4b1 with SMTP id
 71dfb90a1353d-5395edf4f89mr5064174e0c.0.1754383644007; Tue, 05 Aug 2025
 01:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com>
 <20250522182252.1593159-4-john.madieu.xa@bp.renesas.com> <CAMuHMdW0CTM+d-N0FgP=dKoSTdmRr2Rpg2Rtzj33gDk8qW+FUw@mail.gmail.com>
 <OSCPR01MB146471D101C6D66C1B81336A1FF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
In-Reply-To: <OSCPR01MB146471D101C6D66C1B81336A1FF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Aug 2025 10:47:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV2DsJ5_0sW+f6anrqpr5kjLoe9w++E_xKJjdG7TJmGcQ@mail.gmail.com>
X-Gm-Features: Ac12FXzLHOIfHH8YoH-bnFQF_adsYpueO6cso7szcci-yHArH4H6xapU-JQjANM
Message-ID: <CAMuHMdV2DsJ5_0sW+f6anrqpr5kjLoe9w++E_xKJjdG7TJmGcQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"rafael@kernel.org" <rafael@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"john.madieu@gmail.com" <john.madieu@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>, "magnus.damm" <magnus.damm@gmail.com>, 
	"robh@kernel.org" <robh@kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, 
	"sboyd@kernel.org" <sboyd@kernel.org>, 
	"niklas.soderlund+renesas@ragnatech.se" <niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Tue, 5 Aug 2025 at 10:27, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Thu, 22 May 2025 at 20:23, John Madieu <john.madieu.xa@bp.renesas.com>
> > wrote:
> > > The RZ/G3E SoC integrates a Temperature Sensor Unit (TSU) block
> > > designed to monitor the chip's junction temperature. This sensor is
> > > connected to channel 1 of the APB port clock/reset and provides
> > temperature measurements.
> > >
> > > It also requires calibration values stored in the system controller
> > > registers for accurate temperature measurement. Add a driver for the
> > Renesas RZ/G3E TSU.
> > >
> > > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > The TSUs in RZ/V2H and RZ/V2N seem to be identical to the one in RZ/G3E.
> > However, RZ/V2H and RZ/V2N have two instances, while RZ/G3 has only one.
>
> This is true.
>
> > > --- /dev/null
> > > +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> > > @@ -0,0 +1,443 @@
> >
> > > +/* SYS Trimming register offsets macro */ #define SYS_TSU_TRMVAL(x)
> > > +(0x330 + (x) * 4)
> >
> > RZ/V2H and RZ/V2N have a second set of trim values for the second TSU
> > instance.  So I guess you want to specify the offset in DT instead.
>
> What do you think of 'renesas,tsu-channel' property or alike
> Property to specify the channel being used ?

While I agree instance IDs canbe useful (sometimes), the DT maintainers
do not like them very much, cfr. commit 6a57cf210711c068 ("docs: dt:
writing-bindings: Document discouraged instance IDs"), which prefers
cell/phandle arguments.

For this particular case:
  1. The instance ID for the single TSU on RZ/G3E would be one, not zero
     (oh, the SYS_LSI_OTPTSU1TRMVAL[01] register names do contain "TSU1"),
  2. It will break the moment a new SoC is released that stores trim
     values at different offsets in the SYSC block.

Hence a property containing a SYSC phandle and register offset sounds
better to me.
Thoughts?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

