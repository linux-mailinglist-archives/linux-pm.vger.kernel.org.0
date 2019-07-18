Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F586C874
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 06:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfGREgD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 00:36:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46469 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGREgD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 00:36:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so13138068plz.13
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 21:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WGpriDmKg5A7CmpDzwHXbW6ZHoMuynu6Flk/8vZcrV4=;
        b=tdM9d/DBJYMDRXBmqCsEwG0Ji9aifj2VKoNdoJhfF/pHOM6IKPiUdRjBC5AaEzz6Q6
         Kjd8huAsSQxOu49t3oV2e6erYFObTSkT5pseVTYwHXJ+uIXbhk4N3Dc6yllJgXfLoDuA
         Cmz1a6J+0vron0h04ZTfruurmpqec2vzltlAtYQAeDItiDyphalOKPvHVAtfV+QssyMd
         F2xQf6FwWGOac0MiHbrikqIwNXyRFLjae5t4FmS+qSfi2K/TMCZDPS/xxICmQxQ9TY3B
         +mLUuCezbFvWz9v7Qwce2DaBzgx6ZLcQsL6xKXbTZRaEU8vDkGcabpR2B52HkblxlX1I
         W3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WGpriDmKg5A7CmpDzwHXbW6ZHoMuynu6Flk/8vZcrV4=;
        b=Yh7Q8FiSdaro/OOdAZtxEVCax+1OhLy1xeTKFuVtAwak4SvgIfiB4Zlrgel55BcgnZ
         uXuK4Ho0DQKj9iyHtcQx863X1cDsQCXq446Eg5hfxeShTfMl2shJu47sNaZzSkess92m
         Y+ZBgvu/m6+FDwakcC3jsaHS8Tq2OsyfmqhVZ/MZDvCs/nh0beF5M+66MVKqjnrjJWi8
         zvkxmCtHFYT+fRV+6CrvkGvyCWajoBXHc96I7amr0at6KazlC/YaJdFTB8nP6OG0zfhU
         uky3NceWTr1u7kAR41MrA1vhM4t5371WxWfFsqxYGfSw/46Yx2e/Rr5CmTaU5Ki5N6kb
         BDUw==
X-Gm-Message-State: APjAAAWyroF6mgtvY0hwxHsMBGCItdywS1s9w3HWAWx9wRFc7r7ow1TI
        k2wMiCXeE5ygCMuzUzrlb0H4Iw==
X-Google-Smtp-Source: APXvYqyMnYIn3TaRAO3QMu/Oxrwx3Xg4Hm0cjdUzW+Ak8+N2c7rzoxUsvLt1u8rE+f/7W7B/iOjqmg==
X-Received: by 2002:a17:902:8689:: with SMTP id g9mr44528906plo.252.1563424562578;
        Wed, 17 Jul 2019 21:36:02 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id s6sm39616477pfs.122.2019.07.17.21.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 21:36:00 -0700 (PDT)
Date:   Thu, 18 Jul 2019 10:05:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
Message-ID: <20190718043558.roi4j6jw5n4zkwky@vireshk-i7>
References: <20190703011020.151615-1-saravanak@google.com>
 <20190703011020.151615-2-saravanak@google.com>
 <20190717075448.xlyg2ddewlci3abg@vireshk-i7>
 <CAGETcx-kUM7MqNYowwNAL1Q0bnFzxPEO6yMg0YTkk16=OnPdmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-kUM7MqNYowwNAL1Q0bnFzxPEO6yMg0YTkk16=OnPdmg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-07-19, 13:29, Saravana Kannan wrote:
> On Wed, Jul 17, 2019 at 12:54 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 02-07-19, 18:10, Saravana Kannan wrote:
> > > Interconnects often quantify their performance points in terms of
> > > bandwidth. So, add opp-peak-KBps (required) and opp-avg-KBps (optional) to
> > > allow specifying Bandwidth OPP tables in DT.
> > >
> > > opp-peak-KBps is a required property that replace opp-hz for Bandwidth OPP
> > > tables.
> > >
> > > opp-avg-KBps is an optional property that can be used in Bandwidth OPP
> > > tables.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  Documentation/devicetree/bindings/opp/opp.txt | 15 ++++++++++++---
> > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > > index 76b6c79604a5..c869e87caa2a 100644
> > > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > > @@ -83,9 +83,14 @@ properties.
> > >
> > >  Required properties:
> > >  - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
> > > -  required property for all device nodes but devices like power domains. The
> > > -  power domain nodes must have another (implementation dependent) property which
> > > -  uniquely identifies the OPP nodes.
> > > +  required property for all device nodes but for devices like power domains or
> > > +  bandwidth opp tables. The power domain nodes must have another (implementation
> > > +  dependent) property which uniquely identifies the OPP nodes. The interconnect
> > > +  opps are required to have the opp-peak-bw property.
> >
> >                                    ??
> 
> Sorry, what's the question? Was this an accidental email?

Too much smartness is too bad sometimes, sorry about that :)

I placed the ?? right below "opp-peak-bw", there is no property like
that. You failed to update it :)

-- 
viresh
