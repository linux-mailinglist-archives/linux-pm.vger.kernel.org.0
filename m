Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E24392BB2
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 12:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbhE0KYT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 06:24:19 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:46914 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbhE0KYS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 06:24:18 -0400
Received: by mail-lj1-f171.google.com with SMTP id e11so49053ljn.13;
        Thu, 27 May 2021 03:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=4IxwT6jVEBPP1PUK7HR4Lpreyst/kOYfM9RywQLhveM=;
        b=q+AjMj00SHs3oe46KQ9gNDyTmNKACNn40UPqjEhDpoC76+CN5hd2J28v+K9w8kOUO3
         VZ32r6g3ls8UM6DuOzye8FpOoD9cONzhOqFFwUw6BctsIMSbyXaQQ2bCFAoXqtoG4BRJ
         pVyNDp5EvCW6lJunvCnNzXgdhIOWATAGlSD8hB/8VPTH1MttGnwTqSuCoJWcEfMYcNj2
         2hSmqHMLWEXHA/1LAkVZ23cDg0dYN1gL29UtMDF2Qs+XQXwxkccyDMFo2HrTUNmygdK1
         QTrjZX7RdVrTJGeC9pyDW5k5a/NNDMcupwLWpeIv3CO48UhbzQu+LioU0APqTKySidrX
         NZmQ==
X-Gm-Message-State: AOAM530922Ysi1wGL/4nEoP0Lfx0/SuFbHaFYKnmalFXAjO+PcEVuOC8
        GjY89HcSe4vy9tO4OBDnUAiA1gNFiyg=
X-Google-Smtp-Source: ABdhPJxaFl9mwFb0vGOT0FiK2vMVF0nxwV7VWhB90w66M1tlkNgbMPPrIPlKg3ipTF4pRiq5v7PVAA==
X-Received: by 2002:a2e:b6d2:: with SMTP id m18mr1878911ljo.233.1622110963168;
        Thu, 27 May 2021 03:22:43 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id r17sm185818ljp.40.2021.05.27.03.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 03:22:42 -0700 (PDT)
Message-ID: <f650d4944a291197467e594c75103243f9943527.camel@fi.rohmeurope.com>
Subject: Re: [PATCH v4 2/2] power: supply: mt6360_charger: add MT6360
 charger support
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     sre@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, ChiYuan Huang <cy_huang@richtek.com>,
        benjamin.chao@mediatek.com
In-Reply-To: <CAE+NS36skw0XRCnNzHp8KSvdS+YPCAgwBNM-F7Wg=dxuiF5z1w@mail.gmail.com>
References: <1610973703-676-1-git-send-email-gene.chen.richtek@gmail.com>
         <1610973703-676-3-git-send-email-gene.chen.richtek@gmail.com>
         <771c7da0584cf37da6ba370207a89a7401a20c33.camel@fi.rohmeurope.com>
         <CAE+NS35BOC6rr4U9rtBkNph8mZCVV=5MGbh0VQXBvhLRkBaAvQ@mail.gmail.com>
         <a4646a277d692f4b4a04382b7367b641b2ff0fc6.camel@fi.rohmeurope.com>
         <CAE+NS36skw0XRCnNzHp8KSvdS+YPCAgwBNM-F7Wg=dxuiF5z1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Thu, 27 May 2021 13:22:33 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, 2021-05-27 at 17:58 +0800, Gene Chen wrote:
> Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> 於 2021年5月27日 週四
> 下午12:25寫道：
> > 
> > On Wed, 2021-05-26 at 17:40 +0800, Gene Chen wrote:
> > > Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> 於 2021年3月30日
> > > 週二
> > > 下午7:48寫道：
> > > > On Mon, 2021-01-18 at 20:41 +0800, Gene Chen wrote:
> > > > > From: Gene Chen <gene_chen@richtek.com>
> > > > > 
> > > > > Add basic support for the battery charger for MT6360 PMIC
> > > > > 
> > > > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > > > ---
> > > > >  drivers/power/supply/Kconfig          |  10 +
> > > > >  drivers/power/supply/Makefile         |   1 +
> > > > >  drivers/power/supply/mt6360_charger.c | 914
> > > > > ++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 925 insertions(+)
> > > > >  create mode 100644 drivers/power/supply/mt6360_charger.c
> > > > > 
> > > > 
> > > > Thanks for the contribution :)
> > > > 
> > > > Few comments which I am not demanding to be 'fixed' - but which
> > > > might
> > > > be good to be checked. Eg, please consider my comments as
> > > > 'nit's.
> > > > 
> > > > ...
> > > > 
> > > > > +static unsigned int mt6360_map_reg_sel(u32 data, u32 min,
> > > > > u32
> > > > > max,
> > > > > u32 step)
> > > > > +{
> > > > > +     u32 target = 0, max_sel;
> > > > > +
> > > > > +     if (data >= min) {
> > > > > +             target = (data - min) / step;
> > > > > +             max_sel = (max - min) / step;
> > > > > +             if (target > max_sel)
> > > > > +                     target = max_sel;
> > > > > +     }
> > > > > +     return target;
> > > > > +}
> > > > 
> > > > lib/linear_ranges.c might already implement this ...
> > > > 
> > > 
> > > I found we are neither linear_range_get_selector_high or
> > > linear_range_get_selector_low.
> > > When value lower than min_value, choose min_sel. If higher than
> > > max_value, choose max_sel.
> > 
> > Ah, correct.
> > 
> > > Should I create linear_range_get_selector() for this?
> > 
> > My suggestion would be yes, but I am not insisting on it.
> > 
> 
> Maybe this is a special choosing mechanism, I will keep it.
> Could I also keep mt6360_map_real_val?

I think adding generic function to linear range code for others to re-
use would be nice. But if you choose to keep the mt6360_map_reg_sel()
then it I agree that you should also keep the mt6360_map_real_val().

Best regards
	Matti Vaittinen

