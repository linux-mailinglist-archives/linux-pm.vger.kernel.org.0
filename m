Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DA93FADF8
	for <lists+linux-pm@lfdr.de>; Sun, 29 Aug 2021 21:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhH2TKx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Aug 2021 15:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhH2TKw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Aug 2021 15:10:52 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095C9C061756
        for <linux-pm@vger.kernel.org>; Sun, 29 Aug 2021 12:09:59 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id d16so21969093ljq.4
        for <linux-pm@vger.kernel.org>; Sun, 29 Aug 2021 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZvGZdT6RSA5Fpa57FNTpKBZHVWz2QTfWSfFBXfNFHU=;
        b=DrCljDdfCo+lBGtGLRmyB4o6rQbv4TeyX4Drm8ehxEz1BJpi+BWVj1E428aI5VjRzT
         qSbqZmAUe9kgyv8l/JRyu4kCf1Uc0B0J7OXpqPXUFuzehoyQI3ZA9PqzaeMaFYO92KZp
         npO/c/TbB/6lA4nSF2O3A0jwhCVxH0kGxZZvXSkdXTVpTBiWHPwe4QU4JTs3v113yhCB
         xPcl1T4UejvU5qHSMoe6n84LYhN1WmQuC4pNoDesszxO63RgVewpD08pv9q47VpAydp7
         TjUt1kxU6P7ALMFcYSUAJ4FSrCJnFTUGdQ+rS8gAKYNwDpQuF8Pq0lRAR0aEqVK/Gs59
         Mfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZvGZdT6RSA5Fpa57FNTpKBZHVWz2QTfWSfFBXfNFHU=;
        b=JFUh67oEVTRG0+wzlTTnEE6bDYriqEDvD1rY6PECgyps9ER7JscQBiL5U0zspUqVog
         1rQkghrcCVgbMZ90yvH5xVYca3at6VdlZdIbmCGePR0O30a3GFfPhYgblBMWabRmAA0f
         OVed2IbSntIm0p84kCmPKd31SOBC8fv80tQ6kKUbqhYN9/+9tOgYuQwAhieop8qVPPz0
         Q8RatdOwR+RM8AYNFo7GXS4B81C4+x70vufw7gK7Wai0OfuZ8kwNWtYunqHoLMvt2QDC
         Yf2FsGNpuKy2uL1qg+cc+W8NSva7l6geAd0t/cl7q34y16kQ5Iairg3F7dI3xqmkR3Z7
         5mVA==
X-Gm-Message-State: AOAM533lr7Cmw2l/gOurswqGZ0QjDbhbdMCdei5z0tBNsA7RU0MO8SVx
        b6r4ohycK7PSgYCcbPBCHxuxbj4BWGMDPNdY9g1Q1Q==
X-Google-Smtp-Source: ABdhPJxCSw20sOvXWZzeD9OCjtvjPdcCMXxl2xVeKRRntI5UnzuFb3gKYb5s+B1HPOovLKmDV45JcGagXUjMkhjkD58=
X-Received: by 2002:a2e:9d88:: with SMTP id c8mr17243245ljj.467.1630264198248;
 Sun, 29 Aug 2021 12:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210806090050.3510671-1-linus.walleij@linaro.org>
In-Reply-To: <20210806090050.3510671-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Aug 2021 21:09:47 +0200
Message-ID: <CACRpkdbdgdpg7CNQ+s4SkJBOsWfuOOWmXTar+cx2Eu_Wt5qNfw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: Bindings for Samsung batteries
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 6, 2021 at 11:02 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> This adds device tree bindings for Samsung SDI batteries.
> Everything can be determined from the product number so the entire
> battery is just a specific compatible string.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Sebastian: can this be merged? I am working on corresponding code
for Linux to populate Samsung batteries from compatible.

Yours,
Linus Walleij
