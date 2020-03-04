Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22D4A179BAA
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 23:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbgCDWUs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 17:20:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388026AbgCDWUs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Mar 2020 17:20:48 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61945214D8;
        Wed,  4 Mar 2020 22:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583360447;
        bh=35qO3hdBPY9XEjY8+pJst4gIXbSd1Nc+th/XaxS/Oa4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WSA0tBMIOTRH8hEsIX+MJ/yoUaOno2LswbdSzPiPUjbnb3vGFwfHvM0OXOYKD+K5Q
         /ukqU/vslEKim/Gj6dkjpQpE7zhJ8ZNfUXqfSKdmxMj6QtB0VoaRlUBFdn/lOGSFP3
         N4u8K76HycFJRpPNivBb0Jzz/wuAWFe78eJPa6rc=
Received: by mail-qk1-f176.google.com with SMTP id m9so3356189qke.4;
        Wed, 04 Mar 2020 14:20:47 -0800 (PST)
X-Gm-Message-State: ANhLgQ1NKnh+4N+8wb4vc3X1CzvX9lEG2/CA+n04HeU/8dTuF/gsD+UE
        mkcNhlU3R2kDRDpNkUi+WTH0S7nz2Dv0X/5a0g==
X-Google-Smtp-Source: ADFU+vvr04r+5wCdzyL6uorYqvlzIlyYxQ3F6iY/L1Osbi5Ca+523kWnCA03Oki4mxIGr2E8cLcEd0RstjX7DQE2aa4=
X-Received: by 2002:a37:2cc6:: with SMTP id s189mr3610073qkh.223.1583360446462;
 Wed, 04 Mar 2020 14:20:46 -0800 (PST)
MIME-Version: 1.0
References: <20200304212600.6172-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200304212600.6172-1-lukas.bulwahn@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 4 Mar 2020 16:20:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKGhpdvrNGbq+yYeM=goOwNUewHYStT8b2PNiBVz+4JPw@mail.gmail.com>
Message-ID: <CAL_JsqKGhpdvrNGbq+yYeM=goOwNUewHYStT8b2PNiBVz+4JPw@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: update ALLWINNER CPUFREQ DRIVER entry
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Yangtao Li <tiny.windzz@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 4, 2020 at 3:26 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit b30d8cf5e171 ("dt-bindings: opp: Convert Allwinner H6 OPP to a
> schema") converted in Documentation/devicetree/bindings/opp/ the file
> sun50i-nvmem-cpufreq.txt to allwinner,sun50i-h6-operating-points.yaml.
>
> Since then, ./scripts/get_maintainer.pl --self-test complains:
>
>   warning: no file matches \
>   F: Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
>
> Adjust the file pattern in the ALLWINNER CPUFREQ DRIVER entry.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Changes to v1:
>   - do not include new maintainers because it is not needed.
>
> Maxime, Chen-Yu, Yangtao, please ack.
> Rob, please pick this patch.

Applied.

Rob
