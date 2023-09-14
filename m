Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70917A02F8
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 13:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjINLqT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 07:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbjINLqM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 07:46:12 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2848F1FD6
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:46:08 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d7820f9449bso899177276.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694691967; x=1695296767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+t+nzRMHh/MGP5/jvrxD14eYE9j6gVWw5j4hZzdwFE=;
        b=VsyRH4VUyRxVUgpIAnhHojT15gCH7QPJJg3IP7CuZZlIDdCYN8fdEOEV/Qhc6VyX0r
         96k4w3L/Slv32R0pTyPqCo2vOhaz69jeAbbKBKrKke2LUJFs10Kklq2OhBo+DojqRlYL
         0wskSnOstaGno9MYSPZGke4IiJAFsrwk3YdYv4LGvaz2ejh5dabG605e6hK8tXT5g/ZX
         amB4Qw12+Rs0KkWZ8p+NLm9JTHxeNQVPFAoVXNPaQyq6508812K2Nedb4mJrQfRtNwPn
         XlUjX60riYLd/tIu/UjsjpFLZYD8MKpaCn2b8Y5bZ6iXOYK5Z7tS8ZQzclUd6NW+JCsd
         WFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691967; x=1695296767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+t+nzRMHh/MGP5/jvrxD14eYE9j6gVWw5j4hZzdwFE=;
        b=X8B4N3m+KplWFHp6OqU8S6sA+c3L/UL0eUjZjPILtXsyM/ZaVtMwS+AFz26oG9PehX
         kAI+dqWPaUcrBnIkxVpHDh0vt+SQTfMcwFi3sSTWLN7Ct1QUD/f4jkOlSr/8io6grvBl
         T3d7aFtEN3MFyWM3ExVBkr4ES5EApvc+j4YXAY2FI9xEN1JNC6FH4GjMrRsCEkH4BMZZ
         wO4sE73DU/W0P7lBfoF6LzRSKfLMZIf/AE5yZwfXa81T7P5H5cERPp8nrsBu3c+CYNZa
         VHi4s0ROIY8FKk1fsqmDTmMRVOMzaIVEOW/E/VFfTgMwC30lpJgJswEM31jA3u1zSQuu
         ik6Q==
X-Gm-Message-State: AOJu0YzW5e41o+RSKddIOHbqGSpUvRt9ui+QtloGV2DXJjv0wgxh5HT6
        bueM5qDaLQfwv0aLJzwtGcNdzUfIJnaYr98xk1W9RYdSDd3mPi6Y
X-Google-Smtp-Source: AGHT+IGmHBJzyl69gBYwQv4b0mI3Vn+L0mVdmhr8enj4P0ZQl5AwarQm7e57WkCLiFnkBXVbOCqnB5cIPy1TvGjUfMY=
X-Received: by 2002:a5b:b47:0:b0:d1f:6886:854a with SMTP id
 b7-20020a5b0b47000000b00d1f6886854amr4559019ybr.9.1694691967397; Thu, 14 Sep
 2023 04:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230914111855.586724-1-ulf.hansson@linaro.org>
In-Reply-To: <20230914111855.586724-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Sep 2023 13:45:55 +0200
Message-ID: <CACRpkdb-1872T_mqmZY0-s-A4969C5A5CzKfY_hKvXgn4p0_JA@mail.gmail.com>
Subject: Re: [PATCH 12/17] pmdomain: st: Add a Kconfig option for the ux500
 power domain
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 14, 2023 at 1:18=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:

> We shouldn't really use the CONFIG_ARCH_U8500 option directly, but rather
> have our own dedicated Kconfig option, so let's add that.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This looks fine!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
