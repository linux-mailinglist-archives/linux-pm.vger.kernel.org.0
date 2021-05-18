Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45F2386E1C
	for <lists+linux-pm@lfdr.de>; Tue, 18 May 2021 02:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbhERAMv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 20:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbhERAMv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 20:12:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19995C061573
        for <linux-pm@vger.kernel.org>; Mon, 17 May 2021 17:11:34 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z13so11386681lft.1
        for <linux-pm@vger.kernel.org>; Mon, 17 May 2021 17:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TyiwtTG2N+/Hrh4d1d7mHndEUMG7Hm1al5+B6ohKt8I=;
        b=wcWqgiH2lShH7P5gkQbdZ9WuITdhB3Wb3H9tyLh/TwxK4CGtgsHZMOB85MhG4mGdNe
         vEvv2otEumUyFJIuivZVENY5p8MKfijv56mV7dwb5SWQF/OBqTPpOn0RwIhupmbvRYBC
         WaK7i27s/Y0GJl1zJ3dAKjS0jRZ3WavARxzxqe8tU2TCTUsHUApXccMZJ+cWcKqWbRdR
         VaTOdpPaUVtWk4iTjtck6qP5lqIj41Xbx8utsk1HCEK/ZXN0pZd8EirUWtYh1en2y13e
         T0oBeYz+ypPBd7Vv+6CNANgfIuazidbvw4TISOFxN3Mt8SalnDHaDLPwr7ictNgVidUs
         rT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TyiwtTG2N+/Hrh4d1d7mHndEUMG7Hm1al5+B6ohKt8I=;
        b=ZnhCFolL03lSkwsp42njp7BE3s9RNFvE2SL2bFo1yzcLXbIlFAtkoGxLyGdeNZig+M
         /Wvx6zqOKz1nA+U3pcZOd1ff+IYCpZc5Nwx+sxaQVVJO52vMXP9w+7/aJFhxgYP9M5Io
         6yXSJTpPy9HFPuL4JJRTRk0GYYSXGLWYd7/SZLiKdzXhyn7euliHhadaSqQQZEFkb+Qk
         1Mg499cwBv1FFZf6JydwB6Wil/y84jxejjYvTsBsqdEz4SrB/eKgOL4rVonvdc6xkTju
         WZQQ0DWlnQz5XJqfT/S4IklN/Fk92NXGlWExoZJuY5q2xLEUFt701SjnNpCTwklC53pE
         TILA==
X-Gm-Message-State: AOAM53228BVrIlpxvgbhSftX6jQbaRWuoJMSbQvsnFDx1CIhd9LkXBHM
        CHxOjePzgviUmy9LwHTZMPHHdTJWrmbdPd2NZB+MVA==
X-Google-Smtp-Source: ABdhPJzxdpfAJaVPPSlL2ev1Kfw/zmf4ZxSm/rtn6rYv7BBQHOmbJWgGVKf+T8AgzObhV+SBN3nShVbctvVvvqHsy5I=
X-Received: by 2002:a05:6512:11ea:: with SMTP id p10mr1792893lfs.157.1621296692645;
 Mon, 17 May 2021 17:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210412230320.382885-1-sebastian.reichel@collabora.com> <20210412230320.382885-3-sebastian.reichel@collabora.com>
In-Reply-To: <20210412230320.382885-3-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 02:11:21 +0200
Message-ID: <CACRpkdZxOTE7dRXaopqeybYtOx2D3k98VC_JT-VCoiK14oCQ+g@mail.gmail.com>
Subject: Re: [PATCH 2/6] ARM: dts: ux500: Fix interrupt cells
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 13, 2021 at 1:03 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Fix interrupt cells in DT AB8500/AB8505 source files. The
> compiled DTB files will stay the same.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Patch applied to the Ux500 tree, sorry for the delay.

Yours,
Linus Walleij
