Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6226E1320D3
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 09:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgAGIBN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 03:01:13 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46413 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgAGIBN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 03:01:13 -0500
Received: by mail-ed1-f68.google.com with SMTP id m8so49578050edi.13;
        Tue, 07 Jan 2020 00:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17ic3/G09jy7yYXFGdQ26exOrAH82ahIbhZQJdHdte4=;
        b=SpHQZf1Q3omVUc9dR4WfGvMfOJD6R+MaY0qc8DSOv3MsdaIFIyXeCORidLSHD/ch3a
         /PCHcpadCImyTZLqsFzWGiNIm6/hy8JHA1Q45FHmGb3sLF7Q0h8v44jbEGBZ7aXFat2E
         5j23h02dPte9mHRSCme66NA9XhsZGVzcOWdnozuFS+8IBUH1UciCEpFZICAaoeGc4vo5
         6H7ut6nO6lhnzD2AAis3RFoVFrXAAVoBJsPrOQqsDrenX6hDCBp9x/K5SlFH5CuHX5Sy
         ilgVNSQo+nxOe49HeTg/Gk5R6SM6oTEnJNx8gf2nK7QD7fxRnn4nKlgg9gKEira2oj1w
         YlaA==
X-Gm-Message-State: APjAAAWktDpvpoQ1d+owrdkx1AbsdXgqcJO44S5PpAPsTkoo0Avd9glO
        Vu/sF2cUs5OWTLgAonoa4+CcrY/zJOM=
X-Google-Smtp-Source: APXvYqzkjrffx5DSwF/5iaRax5nn5EP1txw6vCxmEui3choX47L614ytWCeIxvdEvsuGPSAM7ZAz1Q==
X-Received: by 2002:a17:906:198b:: with SMTP id g11mr113027594ejd.271.1578384070360;
        Tue, 07 Jan 2020 00:01:10 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id r7sm7449741eds.32.2020.01.07.00.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 00:01:09 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id q9so17847341wmj.5;
        Tue, 07 Jan 2020 00:01:09 -0800 (PST)
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr41183295wmg.66.1578384069457;
 Tue, 07 Jan 2020 00:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20200106174639.20862-1-tiny.windzz@gmail.com> <20200106174639.20862-2-tiny.windzz@gmail.com>
 <20200107075816.ly6exfd4qtvfxxua@gilmour.lan>
In-Reply-To: <20200107075816.ly6exfd4qtvfxxua@gilmour.lan>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 7 Jan 2020 16:00:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v64nLnHbpUyadD9H4ZyMX82v1nMr88dM=UrLhrRnBK7f-g@mail.gmail.com>
Message-ID: <CAGb2v64nLnHbpUyadD9H4ZyMX82v1nMr88dM=UrLhrRnBK7f-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: sun8i-r40: Add thermal sensor and
 thermal zones
To:     Maxime Ripard <mripard@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 7, 2020 at 3:58 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Mon, Jan 06, 2020 at 05:46:39PM +0000, Yangtao Li wrote:
> > There are two sensors, sensor0 for CPU, sensor1 for GPU.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > Tested-on: sun8i-r40-bananapi-m2-ultra
>
> As far as I know, tested-on is not documented anywhere (and isn't
> really used either). I've removed it and applied, thanks!

I normally add it as a comment following the Tested-by. Makes it
easier to track who tested what when patches touch multiple
boards.

ChenYu
