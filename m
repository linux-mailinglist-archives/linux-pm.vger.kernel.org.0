Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E69156B7D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 16:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfFZODz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jun 2019 10:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfFZODz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Jun 2019 10:03:55 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E61CD21743;
        Wed, 26 Jun 2019 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561557834;
        bh=0EZ735cO6WH/zngCSpQYINiI6lsHShiMasjlVmMZiqE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W2dvXsfmTlJ5ZxCUixGz+eN0toacav4i4Qqfl01vqSuO7PYoLOQNveiYV9Dh01J26
         S0VHWWdYGs0BlZrl/M23HVxxxbttUpAX9x/0kSPspy2JGz2ruC8N77pHWRPgmWJiVI
         Sh8qaOc+cB/bvQKpxEMfcsAIUPx7qjseSy5zm7tQ=
Received: by mail-lf1-f49.google.com with SMTP id a25so1676489lfg.2;
        Wed, 26 Jun 2019 07:03:53 -0700 (PDT)
X-Gm-Message-State: APjAAAV//I9En6iyfRGG4aKmwaefBAgSzV6dcH2MmdK8n7uUDCIEMXYI
        2kdRBzPAYFGjkyjbiqt3AdS7iAhSFXj4T4mcaLk=
X-Google-Smtp-Source: APXvYqyvRHLVun8VIxnYqIMpihADmlhhPWXQ+dcfiSv6kMVGtgzFKGF77U1LP5lSdXe0G6tHdeMBQn2d+loljViWvfA=
X-Received: by 2002:ac2:5601:: with SMTP id v1mr2820771lfd.106.1561557832087;
 Wed, 26 Jun 2019 07:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190605091304eucas1p21e0717cafa17a14de569f1773cc7abe5@eucas1p2.samsung.com>
 <20190605091236.24263-1-l.luba@partner.samsung.com> <20190605091236.24263-5-l.luba@partner.samsung.com>
 <CAGTfZH2kTNWtx=Jp1UJaLN50Qxbq+Q9ThV4vhQ240QbOy1TRMQ@mail.gmail.com> <7498059d-95f7-e154-cf49-bcbc8ee6fdb9@partner.samsung.com>
In-Reply-To: <7498059d-95f7-e154-cf49-bcbc8ee6fdb9@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 26 Jun 2019 16:03:41 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc6304D=HNQnrvhBH6qKxhkf=VQ2Gg6Q2FMP2hYOTYSDQ@mail.gmail.com>
Message-ID: <CAJKOXPc6304D=HNQnrvhBH6qKxhkf=VQ2Gg6Q2FMP2hYOTYSDQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] Documentation: devicetree: add PPMU events description
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     cwchoi00@gmail.com, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 26 Jun 2019 at 15:58, Lukasz Luba <l.luba@partner.samsung.com> wrot=
e:
>
> Hi Chanwoo,
>
> On 6/26/19 10:23 AM, Chanwoo Choi wrote:
> > Hi Lukasz,
> >
> > 2019=EB=85=84 6=EC=9B=94 5=EC=9D=BC (=EC=88=98) 18:14, Lukasz Luba <l.l=
uba@partner.samsung.com
> > <mailto:l.luba@partner.samsung.com>>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> >     Extend the documenation by events description with new 'event-data-=
type'
> >     field. Add example how the event might be defined in DT.
> >
> >     Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com
> >     <mailto:l.luba@partner.samsung.com>>
> >     Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com
> >     <mailto:cw00.choi@samsung.com>>
> >     ---
> >       .../bindings/devfreq/event/exynos-ppmu.txt    | 26 ++++++++++++++=
+++--
> >       1 file changed, 24 insertions(+), 2 deletions(-)
> >
> >
> >
> > Acked-by: Chanwoo Choi <cw00.choi@samsung.com
>
> Thank you for the ACKs for this a 2/5 patch.
> Do you think the v4 could be merged now?

I think you have all necessary acks. I can take the DTS patch (5/5)
although probably for next merge window as I just sent one.

Best regards,
Krzysztof
