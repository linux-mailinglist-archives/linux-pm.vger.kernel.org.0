Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055F95794AF
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jul 2022 09:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiGSH5s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jul 2022 03:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbiGSH5s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2022 03:57:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC0032078
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2022 00:57:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m8so5033468edd.9
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2022 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZJK2+UHw9IfQSA8Jz9jMJzE6vbq53LySvelY/Wqz4Q=;
        b=TbtXJsdN2sKD6oakm5TuE9Y8jv4K28Vl0MI8OF9L3RV6a0PaLRCf2jiTdvA8WCuiCZ
         NKkzst65SFMbfHFotDaKH0LYahPClkhG0S5r5re9Luc0c1ElQKIegec37Jace4rnX4Eg
         5GuknkNzK8iwSvqWrslLRJ0/h+FcMmOiExBCXfKE/wCOdFSSv8/6U12G+niEo8ZB3cnt
         GrmXKGj8U1ttbkHfe8SZ/IKBffPn9GuTITucqsDDa+j/4ETSkg8e6zwMd4NRb7wyhqig
         7P7IhopEVykaoXfiQBvWnpw/tZ233AZBt/Atd2WNkLTROimVQPs7O1H2QdnSGdkyAgLu
         Y6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZJK2+UHw9IfQSA8Jz9jMJzE6vbq53LySvelY/Wqz4Q=;
        b=FyGxCvT41PwNm9Q9ZN+2LHNBGg+2E4IyRpOthjO1qqQVyBGn6tcxV5h3/QPB6QUZd2
         nJS7dVWF+Kiq8rCfUjJR7lKDwqrb5CVPPV7774szIOfI5QZeJgmcGXfYP1GYlJb8VNgk
         im0nSS9U+eD00ywKBSPfwz7qq3RHBnYIbhQpmu7jmKl9jOQHhmC9+F4TDpiss6niksHq
         CiQ+JhZ/sAMzFC/jaaZeuezEDTbjNNge9JmAtjgQTi7TJ8UUk309Ox2k1HnGmYmIb+Ol
         ckPdxQC7v0wl1E9otANQ/C1zzSb2pbGmLjj9TLMbFPOWflaG4EFunmOL+cD3n8T4RneP
         WarQ==
X-Gm-Message-State: AJIora9nBpLr9t1fgoXdBx5cV/TxROL/UUEPjxD8QtMTgic2FQJ1bE4k
        MoKH6tWR36/JOHgmoWGeAImzsunydFsFv5grT9MxoQ==
X-Google-Smtp-Source: AGRyM1vWwZ3Nnv+ntVGlLCeOSX98ohxnMk2NDo2U3cEwAcSLyo/Glzw/lXPG62CCnWFqy6WGbkf8Cu/xfuKzhrkRunI=
X-Received: by 2002:a05:6402:26c3:b0:43a:a846:b2c1 with SMTP id
 x3-20020a05640226c300b0043aa846b2c1mr42621866edd.133.1658217465302; Tue, 19
 Jul 2022 00:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220719022743.305189-1-trix@redhat.com>
In-Reply-To: <20220719022743.305189-1-trix@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Jul 2022 09:57:34 +0200
Message-ID: <CACRpkdafsWC4VM4c623Q2prkG4uaQPpY0fUkM0wbmWqM0J4TFQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ab8500: remove unused static local variable
To:     Tom Rix <trix@redhat.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 19, 2022 at 4:27 AM Tom Rix <trix@redhat.com> wrote:

> cpp_check reports
> [drivers/power/supply/ab8500_chargalg.c:493]: (style) Variable 'ab8500_chargalg_ex_ac_enable_toggle' is assigned a value that is never used.
>
> From inspection, this variable is never used. So remove it.
>
> Fixes: 6c50a08d9dd3 ("power: supply: ab8500: Drop external charger leftovers")
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks Tom!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
