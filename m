Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A0F468E53
	for <lists+linux-pm@lfdr.de>; Mon,  6 Dec 2021 01:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241644AbhLFAhc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Dec 2021 19:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLFAhc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Dec 2021 19:37:32 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA150C061751
        for <linux-pm@vger.kernel.org>; Sun,  5 Dec 2021 16:34:04 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so11497354oto.13
        for <linux-pm@vger.kernel.org>; Sun, 05 Dec 2021 16:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XONx88F1vof5Ivv3AFiw4orcpR2NGtaO1sOrmAuxGqI=;
        b=oezVON77eKu7Hy/U2MV8oOKvbRFR7FscmCG/QDHP5IAE9i8T1+7q+TsB0AzpE8MwKn
         sgd0qOdVLaQ/QMHN7Nw3ncGaZg6D6zt1RVlJkdYgoEk5XLe7tn+5SXCWL0uyxleY17Yc
         mUtFBknzU+K/DXTj5HlDpeLCfkn9G3xImT/eV+tHBb4VN6PBdKH+jpLnT70BVxECFbP4
         0hmxv06rNWTqFTV5jOOP+BB8a9q5kjjfu62A2l9nHdaa45fAk4l/dE4zAaNhuqYgQM3C
         PpNzo3uIx+rACouAu13oqMLsyFC21pkyS/oXfKEJsbejOplH/6H8Y5faPuvt0+6gnsXs
         Rekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XONx88F1vof5Ivv3AFiw4orcpR2NGtaO1sOrmAuxGqI=;
        b=6k81yXh/xzRztfpF2llZ6xHC3cf5yujolgkg30oKlVaKVLz4F9AxXxvMD8wPuXEE4O
         RMvUXYGlt6Phk77r5kOMqe9kWK3jiMdtXuuSYT9dnsW/5pHkVndHm+dVpiQrsvGpTJS0
         h93dygA/tRSSMo1G7AI5+i4/GNAjm+q++j5lQrOUGlYblBiWHvK+p8c7RhSLVsUvuK2Y
         9/l2fJaGB49WHYrG9pu7AoR/VqtZYrj3KkurM9E56tQIAVlieb41zmwGcBqZfXGKiQza
         FyD+mtuuIu0Fx9iZ+41TCk5mk/oDiizNj/LyamAUI3pCFRmXQW5xdl5WlxGcoWQfhL9l
         7RCA==
X-Gm-Message-State: AOAM531HwS7hTmTJx0kAgBjjpb6Ni7XzZxxBAHnK6CDN5TgRIyZT474e
        1vy6GIJyW795vwv3wk3MhemI4VnQSZvd2TP1LDtSHw==
X-Google-Smtp-Source: ABdhPJwzlJLsVx7wddOQzUlmqtRgn02Xzyxx+QMMluQX0hDNfyYE9Ic1hw5t0hrTVeWbIcFaE05Gl3kiiTQO8i1LNpg=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr25842381otl.237.1638750844149;
 Sun, 05 Dec 2021 16:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20211122234141.3356340-1-linus.walleij@linaro.org>
 <20211122234141.3356340-2-linus.walleij@linaro.org> <20211203205319.aag27knjeapn5d2v@earth.universe>
In-Reply-To: <20211203205319.aag27knjeapn5d2v@earth.universe>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Dec 2021 01:33:52 +0100
Message-ID: <CACRpkdbwTRriophYCztyh_f2RXaftgv1pLPuWYJ+g6EDoHp4eg@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: supply: ab8500: Standardize NTC battery temp
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Marcus Cooper <codekipper@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 3, 2021 at 9:53 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> This LGTM, but let's wait a bit to synchronize with the work
> happening in the AXP driver.

My thinking as encouraged by Guenther is to try to reuse the hwmon
NTC driver for this so I just sent some patches making it possible
to use the hwmon NTC driver in a pretty stand-alone and compact
manner using software firmware nodes for configuration.

Yours,
Linus Walleij
