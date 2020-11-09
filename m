Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE702AB76C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 12:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgKILpd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 06:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKILpd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 06:45:33 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D9C0613CF;
        Mon,  9 Nov 2020 03:45:33 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id i19so11783753ejx.9;
        Mon, 09 Nov 2020 03:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/yXwjxlb/R7fLQTrA52Uzwgs+Ty2nvGfWq3imMItftg=;
        b=sXCfZVwQ9VfdI69jCYsqb4Loblfu7TmKvK/dXCkUYWck7Ue6XxVHJQZ9tX9PlxM9DE
         acZsLxIEKrQFT2KAdjhC0hfA8Lvxr7UbG51F/2s3KFPzo6fXZKQFh4l8c38GcpvumKTB
         MClpAVD5I8GdOA87/ixOGFmaGACAlqvbuW/0eCOqOLD3iW6+mrA1eFgCFXMNSLUd6hVb
         UtRULTvGG5J6xLtWBjCrILOkljfIViQbWKkVlHirjehRYSgqu7eX6HM+zRdbtoWrpGLQ
         4Du8R1bkAFWY49yJniV4HAzT0QYjWUv9V2og5l2KWwnA26jZ+WT6uA7cgS52Ka49hNNy
         sn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/yXwjxlb/R7fLQTrA52Uzwgs+Ty2nvGfWq3imMItftg=;
        b=ald9y/cndfs5cTjFgCNFCxXsfZL9qIouraC/m6/UtKB3KYnpVd7rjApbsh2rokARNP
         WWWT7RsB1yLpX1kj/4IKL2x7hrRe5Fe4ur5LXugXpVXykVhrmM6tym0JpBvtphKszDw3
         cAevGydKUDOy/yDoIqFu8tpXsR/RqnKVZ9WV8rC+N55YFlDKFm8+RcitaVRi8uICnhC4
         w4q4vM/6ybi5n+cuwDtVhIafAhBwkjixAWL8SiU1emchazUdiSu2879u0xNGZlIdYGdp
         vzaez0ZSS25RQVXhob4hhc/rcWlyk+RLfUMyedeEIJfdTwWbNs5XpTc/3RoMEirC77mA
         wvRg==
X-Gm-Message-State: AOAM530MTz/LMD/FQqUj9O/Cw8WeWLP28WJECeSvU8EDIP8w0IuX9hLf
        naCy6VxEk8BUMXyt/SxVA3ZNR4RYmMGVD7TFqgg=
X-Google-Smtp-Source: ABdhPJz6oMyKZ0dKqB4kDi4EbIy/POPWmbRO06zSRQ1WsUqKbtpGr0zDiz6D545tVpcxd+DEzUuepQN/zqg1Hx6EGFw=
X-Received: by 2002:a17:906:a186:: with SMTP id s6mr15116271ejy.193.1604922332070;
 Mon, 09 Nov 2020 03:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20201109114302.22740-1-frank@allwinnertech.com>
In-Reply-To: <20201109114302.22740-1-frank@allwinnertech.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 9 Nov 2020 19:45:21 +0800
Message-ID: <CAEExFWvXrKS_Ge1vBJoQZFzFn-qv4jpP7Rpp0xkgyAaVWtoRww@mail.gmail.com>
Subject: Re: [PATCH] thermal: sun8i: Use bitmap API instead of open code
To:     Frank Lee <frank@allwinnertech.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I forgot to add "V2", I will resend.

Yangtao
