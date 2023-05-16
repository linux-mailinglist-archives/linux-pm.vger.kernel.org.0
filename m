Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA36705814
	for <lists+linux-pm@lfdr.de>; Tue, 16 May 2023 21:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjEPT4q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 May 2023 15:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjEPT4o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 May 2023 15:56:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B479C76B8
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2023 12:56:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so8298359b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2023 12:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684266999; x=1686858999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QlgAAtiyihh7bx5P71pi2o6dPtZSer+A46AGpW/5WPM=;
        b=kef7EitnyZ6qVVLdsWjYeAdWG/vB35cqybAGBIj/wVTjUV6BlKvSCGjnNbHNOsCEOL
         h+BT20FpTWmXn29KSAWGRqAhQG7dYi4HpAICRT9xWClylv6xSJEyF5aX71CJi1iWwCBV
         AskpSJ9ywL4mhKKAIE30RromysT+Wz3FHQz7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684266999; x=1686858999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlgAAtiyihh7bx5P71pi2o6dPtZSer+A46AGpW/5WPM=;
        b=EwJicXQEY6SwvQrDLklTPJ3qJxFy/hR0FXSbxaqVgCkOALJrng6z/EPd9KwFD0EJnF
         uBgyXWVccdjYXDw9+jSbi+YMAiyutUKWxD6dXc+lezRP2BmrR3soAr2J9dtszpuKmyTh
         fCeNehPxqKXVp8/DB8nVsyJIpqdaXKFvIS1g++dGA/3MI5HTfmav18SG9tN7lY1YayBE
         0rzeW5RafSOwBgqlSJL2JDvjIQHYlg0Hk2Nma09uqbBpedchMyt6d2Jh8nTY3Cg4Bu8e
         imxDlrnBbfqPmXejIOSzeKdYBNGGziJ465pu0B8PJhvvmIYkw3+G1kxBjr+auJCKnVrb
         xU1g==
X-Gm-Message-State: AC+VfDxF8rLX4iBU+fYjHkNX7MDayqW0Mz/7in0PJv+yXKt2QpfcwVXg
        h4H6nZLIrNFcASAGfVJw6gM4Zg==
X-Google-Smtp-Source: ACHHUZ504MnZSV1lW6m3lpadzxSZtXTyWWnmbMDexEhPigrkHEzEuE9njCOaI6ApJ1b+OCtl1rWdcQ==
X-Received: by 2002:a05:6a00:e8f:b0:643:a6d1:b27 with SMTP id bo15-20020a056a000e8f00b00643a6d10b27mr34066068pfb.15.1684266999152;
        Tue, 16 May 2023 12:56:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m3-20020aa79003000000b006466f0af9b2sm14238048pfo.179.2023.05.16.12.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 12:56:38 -0700 (PDT)
Date:   Tue, 16 May 2023 12:56:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/16] ARM: address -Wmissing-prototype warnings
Message-ID: <202305161256.F6C079EAA@keescook>
References: <20230516154605.517690-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 16, 2023 at 05:45:49PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This addresses all arm specific warnings outside of the mach-*/ code,
> which I've submitted separately. The majority of the patches should be
> straightforward, either adding an #include statement to get the right
> header, or ensuring that an unused global function is left out of the
> build when the prototype is hidden.
> 
> The ones that are a bit awkward are those that just add a prototype to
> shut up the warning, but the prototypes are never used for calling the
> function because the only caller is in assembler code. I tried to come
> up with other ways to shut up the compiler, and ideally this would be
> triggered by the 'asmlinkage' keyword as Ard suggested in the past, but
> I could not come up with a way to do this.
> 
> All of the warnings have to be addressed in some form before the
> warning can be enabled by default.

Thanks! These are all long overdue. For the series:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
