Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D67D8B0D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 10:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388676AbfJPId1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 04:33:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34870 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388364AbfJPId1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 04:33:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id w6so16733672lfl.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKOYOlw144swLoW1bASjxt+2YuF19IE2PHXVrwsgFxI=;
        b=r/HUFUT2hHS1cmWHIYJbEY9FE8fC8Ukn4uYCeAkUEGRVmlhy+ASdQddcDde/8K7taB
         LRB793fgb5pYk/lMH74TNXCvhVmTmm3sV9ww9tYtgdGoxRsu0kNCiba+hwdyaWD1CR8X
         LGmf2ZZ0QrX3ZIkR52njFsp/wTNEJfQlxKJ2LY2WGGwM/FGGrYZHgTKohN9KoVrGiLAW
         FU3IaLUNMAyW624zTk//zndh38HwJ8vaAVhtqYPITabahQmCw9ILH5q7qQfbhri1mD1x
         h5+Kn+46MPImZ6j4sJzf67MFIp2WyhnuY/PlD8YPPhESNI0z9bbTzAK17NCsMaKSytzG
         53ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKOYOlw144swLoW1bASjxt+2YuF19IE2PHXVrwsgFxI=;
        b=MyDLWAn8LOvqCPnQkqvueFw+A8ZqkDtigqqNPoRX8YUbdDM6lVaVONSp5OX4949j3V
         P/TBW0qfo5eK3+4AO97pNF6kZklM77obo9fzEPDASNZhFcv0jJBWxA4Je4BXWQmU+d/1
         0CqN9WHGLPPl/eQunnvHzNTHvYh32UkpNqRaoh/zdejnXOgm8+dNKPedbRG+kv0KKaWW
         W9DJVdaiOke6n4bN8ldcC1ne+aeXEzj2Ty3DKUdzW6enP2oBWMD7FIbtvU+aC5vyK3nV
         V7lB+4VCtuEi8k4bJ4jguxY04obTQXFMwncR/H8vJAfBKoGgnmKAGDyV9t+1ZmRuen9H
         w8bA==
X-Gm-Message-State: APjAAAU5vOV6EoHDzw+UP43J/yg5ffBMjXau5tND3GyEOvk6+456SU1z
        o8YuON6ajmgp/9pDz/s5nUl4HkTphHsEE4tDWQOLxA==
X-Google-Smtp-Source: APXvYqwE179jhrx68mdrGilTO9EwoaHUFNX6nGOxdvUMNXsKDUhHA6fr4aqNzUdV3wN7yf8HZ2tJuwJ0+7mxh/vy7a8=
X-Received: by 2002:a19:ae05:: with SMTP id f5mr23355878lfc.165.1571214804829;
 Wed, 16 Oct 2019 01:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191004150738.6542-1-krzk@kernel.org>
In-Reply-To: <20191004150738.6542-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 10:33:12 +0200
Message-ID: <CACRpkdYSnnOJomJi=Db2nkrrdNQmBnNKny1c7ZpDj6KdmKD9Mg@mail.gmail.com>
Subject: Re: [RFT 1/3] power: supply: ab8500: Cleanup probe in reverse order
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 4, 2019 at 5:07 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> It is logical to cleanup in probe's error path in reverse order to
> previous actions.  It also makes easier to add additional goto labels
> within this error path.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

For all 3 patches:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

The battery charging code is currently disabled on ux500 simply
because no platforms with batteries were available for testing
or supported by any device trees.

This is getting fix: PostmarketOS is brewing patches for enabling
all Ux500-based Samsung phones, all with batteries. So we will
soon be able to test and turn this on.

The patches are fine to merge, however notice that we are
refactoring all drivers using ADC through the IIO tree:
https://lore.kernel.org/linux-iio/20191011071805.5554-4-linus.walleij@linaro.org/
https://lore.kernel.org/linux-iio/20191011071805.5554-2-linus.walleij@linaro.org/
https://lore.kernel.org/linux-iio/20191011071805.5554-3-linus.walleij@linaro.org/

It would be nice if we could avoid colissions.

Yours,
Linus Walleij
