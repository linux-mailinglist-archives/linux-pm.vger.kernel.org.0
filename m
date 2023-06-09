Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF157290D4
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jun 2023 09:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjFIHUZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jun 2023 03:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238333AbjFIHUY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2023 03:20:24 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299F31712
        for <linux-pm@vger.kernel.org>; Fri,  9 Jun 2023 00:20:23 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bab8f66d3a2so1423737276.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Jun 2023 00:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686295222; x=1688887222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNZBVVP7JndHPOZxf9bAlKS1XeMLsUa6gJUiQeAwW6I=;
        b=zCcyyvSukjhEDwNuBb6wmktcq/UDITOEvfnI8PyYQjcRhKV4srphoHFwiCxqrhVA5q
         VHVcwlCC0/Zv/Zb+Ii3wa/0kMlRQrLokAb9uyiIXjoIwF/Cn8mab3BHWBjmWhwX3VqZq
         QV32sIRVJadgcxMNUrtK92NVEXeddFeOV6fEUB84dnHxyFmLNmYYUeF1TVOW7cerOKv9
         y9I9HtfV6i3bpjy/FUr4YRNJYGEolnhCpsx4vxs3C5Pp8g+FtI8X+vlqoAo7lTkAN/CI
         vMX6xZjsL9yslYEJi8YlLQT6hWzbBsQbtX66q7bm6xjzDAMH21t/fpO8Y4UwlV8MK5iF
         DuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295222; x=1688887222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNZBVVP7JndHPOZxf9bAlKS1XeMLsUa6gJUiQeAwW6I=;
        b=inGE9JthuzBT/U0Fxu66iZ1FOQ2P85R+IXiNar2LS1KM3xweobfrWWrOclGwI9ziTB
         aDjLbgUKnZZHWX4ZY2qL71bnEspsbLoxqjV6MhK8M4A8dVICvvOxNXDT5ixfP+UmqZJp
         WK22Pi8WQXIdVTJ/m6i4v0r83fkmkuSLyibwEYqVNhnlBQxgxSkAR8LVR4yiLnY+xyXQ
         B4a9NSWsNoDfxwpDlJOHoh3L+FMHigKQE+XIZsD/bJUwtyohs1wOCIIi8RM1FBlkHDSw
         W5iIFcE0xGdePQrN6NbEOsM5/JX32uSh8MTJti/G1BdnGPPKsrfAuirFjpkBcfqWfT1+
         O5mw==
X-Gm-Message-State: AC+VfDx/7roYr9GZFBPoGT1ToDerChZuVJaaaor4+KoOSs4FjKROeQPa
        kx6eXWSexHOzrvQMMnGi/ipAv+zNa2O/u2zZ8Qalgw==
X-Google-Smtp-Source: ACHHUZ5BLm8h+zwKDubwqcGeuDV0Th4rhBNr2usnCf58DvcB3K79R2ksO2UJa1K05qt+BlvxUQlBsxuinEOngdQz0yw=
X-Received: by 2002:a25:1f57:0:b0:bb3:8f5d:23f9 with SMTP id
 f84-20020a251f57000000b00bb38f5d23f9mr323386ybf.22.1686295222340; Fri, 09 Jun
 2023 00:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230602073025.22884-1-mario.limonciello@amd.com> <20230602073025.22884-3-mario.limonciello@amd.com>
In-Reply-To: <20230602073025.22884-3-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 09:20:11 +0200
Message-ID: <CACRpkdaefaapvdn3pw8dUJ_JOb-wE3kF0WM1C8XYUZVEqyd6EA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] pinctrl: amd: Use pm_pr_dbg to show debugging messages
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Rafael Wysocki <rafael@kernel.org>, hdegoede@redhat.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, Basavaraj.Natikar@amd.com,
        Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 2, 2023 at 9:32=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> To make the GPIO tracking around suspend easier for end users to
> use, link it with pm_debug_messages.  This will make discovering
> sources of spurious GPIOs around suspend easier.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

If the PM people merge the other patches they can take this too because
of the dependency.

Yours,
Linus Walleij
