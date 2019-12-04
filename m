Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF9F112386
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 08:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfLDHY2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 02:24:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfLDHY2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Dec 2019 02:24:28 -0500
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 607782073C;
        Wed,  4 Dec 2019 07:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575444267;
        bh=g32jXlk9gooeXc/rEl5GPkIYcA7V982G7RhVOMorfFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WRiK49CYh0zI0iLhQCm6exjjXbXPpLccnPxf6CDHD2GA2QmlgFISIwDjSnWjffkmN
         HtT9tRlq7a3gbqOGLz/79n9/NfLhbqr+ty/Q51PVvl4EInmVuvuDHgLv84dm8X5+Uh
         iMFEqKn1qsZYqBuy0GMPtiIGxFRShs0/htQGq39E=
Received: by mail-lf1-f48.google.com with SMTP id y19so5242832lfl.9;
        Tue, 03 Dec 2019 23:24:27 -0800 (PST)
X-Gm-Message-State: APjAAAUsEufXCWXeyMeqi2ACQQT38LRGK4+9zphM3NUJawg++1sUSCzS
        2F4yvyZrT7MeVpKmuE0k+ERMoEE6mSVPh2rHNEQ=
X-Google-Smtp-Source: APXvYqyZj5hG43avAQDS4diZdVOL2YioF5gDqQQ5VOHxWAKXDYqVS0Q900reo+BNrYF954/v8dguT51I0oxN+c8dzzI=
X-Received: by 2002:ac2:5a1a:: with SMTP id q26mr1171509lfn.33.1575444265597;
 Tue, 03 Dec 2019 23:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20191202152520.27558-1-angus@akkea.ca> <20191202152520.27558-3-angus@akkea.ca>
In-Reply-To: <20191202152520.27558-3-angus@akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Dec 2019 15:24:14 +0800
X-Gmail-Original-Message-ID: <CAJKOXPcWGkkFbKaOx12iUfejRdQF4x_MZiRqTiTpMspuhsAsfg@mail.gmail.com>
Message-ID: <CAJKOXPcWGkkFbKaOx12iUfejRdQF4x_MZiRqTiTpMspuhsAsfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dts: bindings: max17042_battery: add all of the
 compatible strings
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@puri.sm
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2 Dec 2019 at 23:26, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> The bindings are missing documentation for some of the compatible
> strings.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  .../devicetree/bindings/power/supply/max17042_battery.txt   | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
