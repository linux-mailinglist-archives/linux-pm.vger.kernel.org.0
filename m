Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46AB6AF6F6
	for <lists+linux-pm@lfdr.de>; Tue,  7 Mar 2023 21:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCGUwv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 15:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCGUwu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 15:52:50 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4075FAA739
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 12:52:49 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id y144so12699788yby.12
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 12:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678222368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtlzL8PevPLLFXmTlyBP00LAI0VoVwlqLagNnjCZdv4=;
        b=fdlVTqePrrMgmLA0JW6a0Ng4I6EcBFnbxzj1f8rvz9FF7sq40JYQC2DdqpIRaUXwtF
         41DGdXVFgMYIgg/CWadBAkKsiFqZVJDRVcT/G0T0TAkyR2d0ws0jMh8wEQEqQRgq9yoc
         U7COOaBe3VbfqlYczUr2DLpZa2xMBTTfH6ldU7N7JBpUakNOmIgXBMWu9Ffvx/K9Au7n
         VcvKRlDOWPOONtVpSY34SZw0r/Gm2NlMNU77Ll1Hc+M/jMXuZB8+VXbuyHJa/Ox0ZOHE
         Fo2MsvQV/i9CeqRz3ko4u+oTQvEjguxWHtXDnT9NJepNOKFsju2F4Q0Q/HJbvVbtJAgq
         inGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtlzL8PevPLLFXmTlyBP00LAI0VoVwlqLagNnjCZdv4=;
        b=G1uO4eFFdCu0w2BVCZX7EnNKjRdvsGo0ybUsdcfDZs2PcXanH+WN58t358KJSJtcH/
         Pa2EA4KLHpPbnjBXYUW7q5yFq0LOfSaIe0YuC3lL8B0Vt3ruBWcEzM75JcvHZYdqz3v6
         TTPiP5tApcf80IVr5C4HtO28if0QfyOiq7JdOJCd4x0gGULJaEhx9loac9iUX80pMU2d
         X3iO5GSZOY3RFyWtRk706iAD3/u3gthzh0QXXiG4caJKKobCIXuFCRirTEL/B9erTony
         7MW/QCdiWwaQYzT8mExjfPz8BC93RLY7TaewVq5K0wfuY7Ndt2zzUYvGJDxSZzcIBn+9
         dhhg==
X-Gm-Message-State: AO0yUKUJlm/mX6aY2Qbw5IuIvh3fBiXzQnQQZpgCmwDKPCg29Yca6dRW
        6tCoqxa9EyKQNaGzgBT8IoJirQhpUq8uv3WabdlUYw==
X-Google-Smtp-Source: AK7set/rWOufzYEq91GvmMEo7+BJ2m+ocGgid3S1JGWCk/qBjg1hP5yymE1zHmoD9Uvh4Fqvigk7F62XPCO37pxDjKI=
X-Received: by 2002:a25:9281:0:b0:b0a:7108:71e9 with SMTP id
 y1-20020a259281000000b00b0a710871e9mr5325940ybl.4.1678222368490; Tue, 07 Mar
 2023 12:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20230307133735.90772-1-daniel.lezcano@linaro.org> <20230307133735.90772-5-daniel.lezcano@linaro.org>
In-Reply-To: <20230307133735.90772-5-daniel.lezcano@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Mar 2023 21:52:37 +0100
Message-ID: <CACRpkdYqUHVkdTwfoQFLM_mkkb8XkUA1FN8=h04BpioDdQAL3g@mail.gmail.com>
Subject: Re: [PATCH v1 04/11] thermal/drivers/db8500: Use driver dev instead
 of tz->device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 7, 2023 at 2:37=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:

> The db8500 driver uses the thermal zone device instead of the device
> attached to it. In order to prevent the drivers to access the thermal
> zone device structure, replace the thermal zone device by the driver
> to show the debug message.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Yep that's the right thing to do.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
