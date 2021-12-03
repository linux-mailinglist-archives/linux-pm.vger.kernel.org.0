Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EDE466F46
	for <lists+linux-pm@lfdr.de>; Fri,  3 Dec 2021 02:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbhLCBxw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Dec 2021 20:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhLCBxw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Dec 2021 20:53:52 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28367C061757
        for <linux-pm@vger.kernel.org>; Thu,  2 Dec 2021 17:50:29 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bj13so2882725oib.4
        for <linux-pm@vger.kernel.org>; Thu, 02 Dec 2021 17:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNwfOn9vmY3VbdnDca+JfZ16hyf72zuU1wTESMaGj7Y=;
        b=YAntr2tAT7sEIv605evLopqYP/xpOtx2dHSl2V0NHNjkGy8RR+F5tjXLmFQXIUVLX/
         HdFEhTBkzzIchrj3sZSsnqicRNOhNXrh0NXsuJeaIXDSQW9IAKOI0AfQNR6d/JNyu8/i
         QOk+EKYEzPP02uFhgkcLLjSph61McgnnSer5a7ApLRudN77ULzy5Uy4qnyetNDjH4ZgS
         gxA5TkDl0AF5WzZSyfV0lH/Hfws/VXLcCJzBL+bvt3YWkFXdg8wLseqHWubH7FWTJEWx
         k5j1rim5sGqc4f9C1kqnPBX7vHDHOPPJE/htVnD+KcxPYVMWvUKRhS/iv+1otnNgVyJz
         5JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNwfOn9vmY3VbdnDca+JfZ16hyf72zuU1wTESMaGj7Y=;
        b=Cq4kJLeaYFnbAw+hJSgC9s7AU7NKVjmnm7tKE0aht7vl/Rv9FIXVDyF0jH4c1DLx50
         FM3x/J7kWdfwSyZATnKGD92CdaDvA5odc0Moj3FbqZc7dlbZExrB463GZ2gItmecGKU4
         zvrImWqma2QgWNdxYL+H/AvsD6YAZ1zwpLz0bh6ZE8wmQl1jnCa1T/0yroJPioqG5sng
         ktzgKF/MYhaF9Mlh7hOSN1RLOsf37cCjPK+kUMzsa8oMy/xbgJvpRvm4k1b+nPd12VvJ
         Cn8SPhUIH6kC/I1l/nmC2+5Xv2mGlHJvBASBBEb6TfZT5wEAEVWtdaF2T+VMp0pt6FKS
         RbQw==
X-Gm-Message-State: AOAM533npQgQymijxxBNlO792Gr7PnON9aPr8MMNSmxVdQ40As2dxa1z
        ZrojatDVb9rGc2KjZ5C06sHwSTKqEjcB4pDbEHdOPw==
X-Google-Smtp-Source: ABdhPJx7nuu2YlyCnPSegJgOpuOgC5CE+wFxLhOMv5rAZOIPRLBb6QItoG/svVYhG6+xrtvREGHlHYeZM0on16MQM/E=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr7264529oih.162.1638496228531;
 Thu, 02 Dec 2021 17:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20211202222732.2453851-1-swboyd@chromium.org> <20211202222732.2453851-29-swboyd@chromium.org>
In-Reply-To: <20211202222732.2453851-29-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Dec 2021 02:50:16 +0100
Message-ID: <CACRpkdZs3cBT_SX3-qAUSmgCdFywJAxGDSCFjoG+FebEojYL6Q@mail.gmail.com>
Subject: Re: [PATCH v4 28/34] power: supply: ab8500: Migrate to aggregate driver
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 2, 2021 at 11:27 PM Stephen Boyd <swboyd@chromium.org> wrote:

> Use an aggregate driver instead of component ops so that we can get
> proper driver probe ordering of the aggregate device with respect to all
> the component devices that make up the aggregate device.
>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> Cc: <linux-pm@vger.kernel.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Pulled in that patches and tested. Works!
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
