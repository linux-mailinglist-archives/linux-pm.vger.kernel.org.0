Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6190970B697
	for <lists+linux-pm@lfdr.de>; Mon, 22 May 2023 09:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjEVHeb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 May 2023 03:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjEVHea (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2023 03:34:30 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584809E
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2023 00:34:29 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ba71cd7ce7fso8673517276.1
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2023 00:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684740868; x=1687332868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=440FKliaMEptTlq4UtvRU6YU5HW2cqSIFciiwno4GUA=;
        b=cVG70vpxIAu7iWt1YIdjkkeETweAnatAAYfZntYjMdS4IrJKmTHKinqhwpYCFydQWp
         k5GHJmg16yNSZ1D5MyVygcuDnFjBFE9HRFcv1iVPHSwj1FT3kdpoj26qy58lRNqiKpko
         SN7XPWRnSYBR7pzQq3MGWPQWVzC5ZqvVZB4eNZfpVZ7LDyJHiP/Gz/yJR+xIY5kWwYpN
         YM8BYwP+i7N686Te8ie+QjnC0T0sCFjAFn+fP/UQUL4WRfo0+RLKsZGlg/854RSXSMEC
         Qw9scHC1mn71W6QmH44TDpuFW9tjgPHJsEiSvTklxZgz+oSj26NBcI7UCKQ6uOohDcGr
         lFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684740868; x=1687332868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=440FKliaMEptTlq4UtvRU6YU5HW2cqSIFciiwno4GUA=;
        b=cCLUbBwKTAQBSkOXgiRtJ4KX73XhhYCc/95cNr8Gv3+BRKfXWh1WRRJ5o+io2iCdx7
         ZnffPyladUi+dILH1G/rQIdBrrXQbK+FYnqExhwjFsSO58A31qvguOmEZHFkqkicUUT0
         wxnfb0n6w4WWQLg6cTZIiSv0JSAPOdyJNZCgG9poMxpbA60wrvMPUdjpSxJcrhEFYlmP
         x+YWS6Ephb6HuW5nROGglxEBQb90zsmCXsMyfkNBhw+UbkcUfmVecGoFiOIB7guOWeoO
         kFl1VuiK+zmLPfhd8hPGY5DMPLXxKC1UwhEQ4tfvmmHJEVhCdE8MLMehAVkmx4qI/Fnq
         n++Q==
X-Gm-Message-State: AC+VfDyy0jetIdHTJWxZhZkSYoyH4iEtF4e/VbauaX1RgNyx74XAMYxU
        iN6jMgWcoosewUUA+2rIcm2sU50EyPIulNEqEw+5TQ==
X-Google-Smtp-Source: ACHHUZ4wB6drPuAxQtXvuP54NiFxDV/VmgeqrEN+OtgOTyNrVZaW+Pp6etDVB3idQ6Mvl9uwmtZ9wkZygsM2GAbNH84=
X-Received: by 2002:a0d:d74a:0:b0:561:7dd2:6ba0 with SMTP id
 z71-20020a0dd74a000000b005617dd26ba0mr11660764ywd.6.1684740868617; Mon, 22
 May 2023 00:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230516154605.517690-1-arnd@kernel.org> <20230516154605.517690-7-arnd@kernel.org>
In-Reply-To: <20230516154605.517690-7-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2023 09:34:17 +0200
Message-ID: <CACRpkdYyYRVnUHEg_BK7BFRCUquNDZ55oDcLTTZKw-+eiNSzbQ@mail.gmail.com>
Subject: Re: [PATCH 06/16] ARM: tcm: move tcm_init() prototype to asm/tcm.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 16, 2023 at 5:46=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The function definition is in a file that does not include the
> header with the declaration:
>
> arch/arm/kernel/tcm.c:256:13: error: no previous prototype for 'tcm_init'
>
> Move the declaration to a global header where it can actually be
> included.
>
> Fixes: de40614e92bf ("ARM: 7694/1: ARM, TCM: initialize TCM in paging_ini=
t(), instead of setup_arch()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
