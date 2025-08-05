Return-Path: <linux-pm+bounces-31958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B42B1B145
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 11:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111F4189F3EA
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3432701D6;
	Tue,  5 Aug 2025 09:35:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D47134AC;
	Tue,  5 Aug 2025 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386534; cv=none; b=MGDhl3n8iAKbSuUWOG5sYjF3AK3Br7s6nF78n2rW3FWwaOF7TqKpAGe1/DUtKerqHL010R0iI/mVb5uvgF6rHQVH7DdYasApR+b31v/+htNpmkzumeOLZLI5HZFfpdlfYIeeVWytaH5PPlnbDIwH4qEfUm9EvMn+pyXCmuQmabY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386534; c=relaxed/simple;
	bh=qusNSIcbQGI1rXZqa62J/1BR26z3I4Oa2dRZ9+B8Z8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYCj51OyIlARYEoZv3aH0lvZmc73JrOTCihmrUcDYcITHY3YrLqoFFr8gyZ172NdrGSC30UK6gqW+nb++gsTNs43NMQrx/7+LuyIJwCq6VQqXUKMOsLlMIFefJV4jSu8ZBllgP8ckIzRKEUvoxreyAJnqbQSZ+1bqFDEy/l3z2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-53987d78f0bso470224e0c.2;
        Tue, 05 Aug 2025 02:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754386531; x=1754991331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSnbT0XIAXfQmqgeyBFr4CFfPWqdXisju5F5x0bhLeE=;
        b=fmwL6Rn+7p8uRhBTf9yCY+c0a+nmfpmVVaQYq+VbUvSeH+ZLHxuJ9D0TSxECUQ9YW6
         132xZtkLlIf4sYZ6a6drYj4+uEADnXkZ38YToWtDVIj/g4YB/4TGRpfvXXh9tY8Y3p08
         wYv2f3htvk/OFt8EH6BL7gEVlXsmGnQxmByraFcvPmnQyXJeg2Q5QiuLVxhNJy+r3Moa
         zAvXVcErztjcUjf5qmHWj9QyI1g+CeaXwN8PJGk8GsDx+kvGVSzonjULQTQfDugGFCMi
         uz4OtbRQMYQELk0SfrHY2R/PlsXjXotK4OYlfjdsyaZ2iIcIpbID19f2VUMeFMBAgWCB
         3/Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUQmrOuQOFOcuSGmvivRIYzo5m8F0leO+Rc7e8EK/am+BLWRTV8I13cuvqG2atImXMFAOmuVo+n1wkr@vger.kernel.org, AJvYcCW5vaTQCFIfWGPkyS6YFPaRiXbRzJDt8L4uK3bB0deiFXEm4rO5e/ajnAGMB++fSFYLsJhiytf8vhQ=@vger.kernel.org, AJvYcCXMyMYqW4OEmnwkcOlLpgoed9CIh0gUNI6DYoZFjud8Q/R+hiskTzI759rEHm76R6DPityezX4coM28pOts@vger.kernel.org, AJvYcCXbmwK6/WdQSRaDcnFoj1bx4Sn4RAUJ3fPjhz3uakM64gDv7FxrC6XHSaLYpQqQ5CZaedYrgFS/KayB+JXlgFkIvh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi7LDLM5wg4NkEV0dlfOos860iGS99Yw9J687OzpHj2RkYSNnK
	E2AXJ3XKRbm8qISsf+K56U8skl96lGOMocy+XcnKnEvKXZY1PFAIxCzGeOizPO8h
X-Gm-Gg: ASbGncsBJRAMMEZ8hiCQXo0Nb+z/IlqpwGnuVLthRgMvytfrulp9p3WywqOA9cR1+H2
	SBkMKTyIhJ6B/LWuW/Ic0qoG48peuzd97ffxpHKIwa0sPNtE31qiFTHyERpZFnmsM4kL59JmlwC
	ySxl5t2pz4dy3DsPQKOAsnHe+v7JTEcCCL6xVRwqmvzx5n4Li+wJRq4oZ4SnFSrMh0MWOtMVABV
	99eemY8o7wQdySbbQh71W04Du8seYNssKcB/lEN8cSehXeDAPOBY6O4MKKUJlJBTRAKgn7LqDev
	jlsQBr1K3hL7Tehhrp8aKc6wA/5fkPvJcrstW0DfABbRkE/B2uEwvdCwIgTHBp6PHTDPbSDh+J9
	oi4vH8BALAjdsW7wxWwAGLjLGE4FpFQBuTtJYd2pdOtckOK4mA8mh2OI9uDfKUt6a
X-Google-Smtp-Source: AGHT+IEcMUpg4IRJa6tMOmYaR0YNGdJsgM/6OrAlixI+P0fFmi7QVp6CU5AtAL4642KBkjSiFMeONw==
X-Received: by 2002:a05:6122:30ac:b0:531:45f1:604d with SMTP id 71dfb90a1353d-5395f2ae17amr5226227e0c.6.1754386530928;
        Tue, 05 Aug 2025 02:35:30 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53936b169ffsm3350536e0c.6.2025.08.05.02.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 02:35:30 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5397c00ad9eso557643e0c.0;
        Tue, 05 Aug 2025 02:35:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAad7dRD1D4amrFC9RD2mRg7zxw04u7qiixhp3Nj/uVt59/dZjEUZrZ/NDZl5YfRg0/SvZvOkkayNU@vger.kernel.org, AJvYcCVNg64lgPFd+hq2w/RQANmTO/CELUnxnfJumfyTwRqW0aHeg9EbtWn3T4/ZVWi0ENaTEvza3fcppmE=@vger.kernel.org, AJvYcCWQO/qz4tdJx5NKq4atuLdGZYTVKamPx5cqAaWBMViWRpwKv2uCSCSZ8dSaPuxehNnMpktG3ca+wUPKOLnsS6KdaQc=@vger.kernel.org, AJvYcCXWmzBJ7FoAyCMaklaxnTMJy/YkJWAaiX6MiBLR2xiU5WpAeXpecM4KH4BKXEid5EagLubRWpK0D1repWCJ@vger.kernel.org
X-Received: by 2002:a05:6122:45a8:b0:539:1154:d12d with SMTP id
 71dfb90a1353d-5395f3d53c5mr6039151e0c.8.1754386530476; Tue, 05 Aug 2025
 02:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com>
 <20250522182252.1593159-4-john.madieu.xa@bp.renesas.com> <CAMuHMdW0CTM+d-N0FgP=dKoSTdmRr2Rpg2Rtzj33gDk8qW+FUw@mail.gmail.com>
 <OSCPR01MB146471D101C6D66C1B81336A1FF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
 <CAMuHMdV2DsJ5_0sW+f6anrqpr5kjLoe9w++E_xKJjdG7TJmGcQ@mail.gmail.com> <OSCPR01MB146472833398C4E61B9C5B160FF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
In-Reply-To: <OSCPR01MB146472833398C4E61B9C5B160FF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Aug 2025 11:35:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXw4XDkwBOqM47TKa8d_jHBMTM1ZGhK9qm5KQWDfGjGSw@mail.gmail.com>
X-Gm-Features: Ac12FXxpv2aIssezzomIJ8wXTe3X5W750Cl4L5fOJJ3Y3hKhZG4oZQOOSu5ZvVo
Message-ID: <CAMuHMdXw4XDkwBOqM47TKa8d_jHBMTM1ZGhK9qm5KQWDfGjGSw@mail.gmail.com>
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

On Tue, 5 Aug 2025 at 11:22, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Tue, 5 Aug 2025 at 10:27, John Madieu <john.madieu.xa@bp.renesas.com>
> > wrote:
> > > > From: Geert Uytterhoeven <geert@linux-m68k.org> On Thu, 22 May 2025
> > > > at 20:23, John Madieu <john.madieu.xa@bp.renesas.com>
> > > > wrote:
> > > > > The RZ/G3E SoC integrates a Temperature Sensor Unit (TSU) block
> > > > > designed to monitor the chip's junction temperature. This sensor
> > > > > is connected to channel 1 of the APB port clock/reset and provides
> > > > temperature measurements.
> > > >
> > > > RZ/V2H and RZ/V2N have a second set of trim values for the second
> > > > TSU instance.  So I guess you want to specify the offset in DT instead.
> > >
> > > What do you think of 'renesas,tsu-channel' property or alike Property
> > > to specify the channel being used ?
> >
> > While I agree instance IDs canbe useful (sometimes), the DT maintainers do
> > not like them very much, cfr. commit 6a57cf210711c068 ("docs: dt:
> > writing-bindings: Document discouraged instance IDs"), which prefers
> > cell/phandle arguments.
> >
> > For this particular case:
> >   1. The instance ID for the single TSU on RZ/G3E would be one, not zero
> >      (oh, the SYS_LSI_OTPTSU1TRMVAL[01] register names do contain "TSU1"),
> >   2. It will break the moment a new SoC is released that stores trim
> >      values at different offsets in the SYSC block.
> >
> > Hence a property containing a SYSC phandle and register offset sounds
> > better to me.
>
> This sounds good to me. I see something like:
>
> renesas,tsu-channel1 = <&sysc off1>;
> renesas,tsu-channel2 = <&sysc off2>; /* Optional, for V2H */
>
> /* or */
>
> renesas,tsu-channel-map = <&sysc off1 off2>;
>
> I would go for the first option to make it easier for V2H
> (while adding support for it later) so it can choose using
> either, or both, regardless of the index.
>
> What do you think ?

As the property would be part of the TSU node, it would always
refer to that specific channel/instance, so e.g.

    renesas,tsu-trim = <&sysc 0x320>;

for the first TSU instance, and

    renesas,tsu-trim = <&sysc 0x330>;

for the second instance.

P.S. Please don't write "V2H" on its own, as both R-Car V2H and RZ/V2H
     exist in the Renesas SoC portfolio ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

