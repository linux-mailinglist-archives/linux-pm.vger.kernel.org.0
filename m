Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7561652D2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 23:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBSWzv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 17:55:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38790 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgBSWzv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 17:55:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id d6so864586pgn.5
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2020 14:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Lxsf5kW7zAx4u4YDWo1NdFtdmCAYIXgVe8+YaAC3Zos=;
        b=HUco0403JkvbPgRhV7hslj1hBa2vX8TSQfPktiFvpuFsot0ggjzTLDzwPHq/JkwsUl
         TnpR+yDtwckD/2kvVFpLQoPvUHT7jEAp2uxVqGTHtEmje67eOupCl5e3Yqg+qk95A9dA
         /nxPF0EjfIup/RxK1f2ufEPXt7q30ef0pA3Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Lxsf5kW7zAx4u4YDWo1NdFtdmCAYIXgVe8+YaAC3Zos=;
        b=lpHi7A2DYOzofuqAwA4/i1/a7JuxSzJmJVkCcTktnOO7p99lpv5YmrHtHvlZZQG91t
         iIdxLuaLOX1JDuw5ITVTVfQG0QfH401jRY7pFvYVnDhv8pR8lhixd+vIlhXLrOeWGGgT
         bsWVr/29xsJZ4rQDLLr9cbfQnTn0ITyxIyKrGXEPE7l2QrWmqSuPshEOAw3gi7f2KUmd
         QHeF6kVIg8kIAqdMHkB0iamPyLnMJnjYIBtKP//VHEo++oG+3raiXJYjx59wz65zrKQj
         xb7yM7Uf81iYIUAWAsJaZGNMtAEm3YsXKq/gsIy64eL2uwnPx/5eRo0F3NB0WyJLpxHc
         9WXg==
X-Gm-Message-State: APjAAAUek4EhHo+jtRd3w5f/RZ/Ls5f4pXc95AtVC/xTFpZvB+GqxNSt
        82fZ16+y0ZcwOd5GsS3pttV5/g==
X-Google-Smtp-Source: APXvYqwavXnk0eDVEhKxJmFmH+FdLraxOHjztu+55YhcmMjl2+Fcrv3IgiSGdm+BFSkL1beVZSqvpQ==
X-Received: by 2002:a63:cf4f:: with SMTP id b15mr7641133pgj.287.1582152950942;
        Wed, 19 Feb 2020 14:55:50 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y16sm634708pfn.177.2020.02.19.14.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:55:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9fa8a4e09b6fcff4b9d4facc9f9e9f8e3c4a41d5.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org> <9fa8a4e09b6fcff4b9d4facc9f9e9f8e3c4a41d5.1582048155.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH v5 4/8] drivers: thermal: tsens: Release device in success path
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaa@codeaurora.org
Date:   Wed, 19 Feb 2020 14:55:49 -0800
Message-ID: <158215294977.184098.9773724834739432956@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2020-02-18 10:12:08)
> We don't currently call put_device in case of successfully initialising
> the device.

Sure, but why is that a problem? Presumably the device is kept pinned
forever?

>=20
> Allow control to fall through so we can use same code for success and
> error paths to put_device.
>=20
> As a part of this fixup, change devm_ioremap_resource to act on the same
> device pointer as that used to allocate regmap memory. That ensures that
> we are free to release op->dev after examining its resources.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
