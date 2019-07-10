Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9029F643CB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 10:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfGJItS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 04:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfGJItS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jul 2019 04:49:18 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581A820838;
        Wed, 10 Jul 2019 08:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562748557;
        bh=/GarYdrcMxeM5bHOVXb/82Dx6rrGHST40qsOH/JO7dI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VpAqo77AKMV0bnMMupSDKh4Js/m9xbV225DTbux5MdPaWX4bZwypgap2jTzMX11Di
         z3krr4QOcAiW3/wVookdooY/x2bEdTj15IXoGZ8X6IRc7Tt1KiNy6/8w19RQfn1zcy
         A3t0NOUr9U1xidVw0Yi2ARyZ2dvhDc0d/EOq8ZdU=
Received: by mail-lj1-f177.google.com with SMTP id m23so1219029lje.12;
        Wed, 10 Jul 2019 01:49:17 -0700 (PDT)
X-Gm-Message-State: APjAAAUTfmrXDcSwdOZWZgY0MzR4bOmnCHr3/ijSKLb8Rzkzk3aBIh9N
        e8uabibf50BcLHb6cd1VJii1aXA+LX0NRbrzYKk=
X-Google-Smtp-Source: APXvYqwyTVlsHSdLLpsPEWVoFz6SokmQ/rj1S3g7ZqViyJPN5NS/AHb07zJ/Ca73uhgL0PCvE621dnCe4KDXi6u+k/M=
X-Received: by 2002:a2e:3008:: with SMTP id w8mr17317554ljw.13.1562748555575;
 Wed, 10 Jul 2019 01:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190705113751.18116-1-angus@akkea.ca>
In-Reply-To: <20190705113751.18116-1-angus@akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 10 Jul 2019 10:49:04 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfWdUuidxSFhRptXaDEH=zkJOcY8FrLjR-nYOpF1eYPbg@mail.gmail.com>
Message-ID: <CAJKOXPfWdUuidxSFhRptXaDEH=zkJOcY8FrLjR-nYOpF1eYPbg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: bq25890_charger: Add the BQ25895 part
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 5 Jul 2019 at 13:38, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> The BQ25895 is almost identical to the BQ25890.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/power/supply/bq25890_charger.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
