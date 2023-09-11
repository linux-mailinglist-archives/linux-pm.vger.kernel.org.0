Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C66F79BE2C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 02:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjIKXRK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Sep 2023 19:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352402AbjIKVpF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Sep 2023 17:45:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBFE12D66
        for <linux-pm@vger.kernel.org>; Mon, 11 Sep 2023 14:35:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68bed2c786eso4046127b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Sep 2023 14:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694468048; x=1695072848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QF/KJHyY9/xFPzuOnnvTEH4bH3ymUsGSbxLjG3pqY7w=;
        b=nVCTBzeorsrkgwFGShKaryybgxR6F1E+fEMcNC6WOO7CPCsVcnUO1JA8HGtQ36BMFi
         HaLL27Xn/6Bh3MFeyyu5I46rHIPmIFdaOT4Y0eb8JayKSGFQjciP0tjFOmdpwMtImPY2
         Th6g9EXIrmcZXz+KUp88giGD8kF9+gYoLe/hfBGSlPITxG3QgZ61epoOeZL0jpiZkgIs
         cOBKGTMheRKb5VBDvTR03XpLZGRZpwK3QWFkHsZVdtvIXgZlfgmtuTmvwW1YyZZy8q0i
         ytl9jKME100XkSLecL8pxASceFslrnx1xWggQcxxE5GJST2eDsBL68N0gjh+zbpWgNzk
         42uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694468048; x=1695072848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QF/KJHyY9/xFPzuOnnvTEH4bH3ymUsGSbxLjG3pqY7w=;
        b=DNDsgzqAijvkwxJKgmCzu1P8Oe30OvjiR7Jz1nKrNgGWvXPpK08b9eXcSSkgW4MFKO
         4bceN23LjxF8UJbppq+TjKeGt0QDa5ENIw0AgUXvwHoypPdHohzKtVSmSGIY1aSaoOt8
         aDE6r4udHwr6TtlSly9bjrGB0s/A2M/jkmnV+dvmOggyuPxxUwkuq9zQVvvYdOlMBZ7X
         MXdSvHenzFi9uGyoQlYTc4AJ/zMhjSmgWqhEdcYc611JzT4Runv6mfNCC8QL6tcXeWCs
         Uaf02/hDNxfNmgEJiCcW3ereNtt3Xna45miN0/EJ77jokr5PLny20W0WE5kSnZUhucMJ
         2cWw==
X-Gm-Message-State: AOJu0YxhclT8jMqT62NPdAenYkFK0g7WZi9PCfE6WszetlSJuoUcq1Fl
        hYifI8psggJ8qJCDvKTf0yM0rYPJ27Q=
X-Google-Smtp-Source: AGHT+IF5IF+h5UT0Ht/GxBINXzW8EONmxkwPOIAUpzpAeHQ2/vvARDpLTNAKpFn6iMFvfyQmrSgtkA==
X-Received: by 2002:a05:622a:9:b0:403:a9d3:91e3 with SMTP id x9-20020a05622a000900b00403a9d391e3mr13611321qtw.32.1694467233051;
        Mon, 11 Sep 2023 14:20:33 -0700 (PDT)
Received: from udipad-dell.cornell-visitor.cit.cornell.edu (nat-128-84-124-0-446.cit.cornell.edu. [128.84.125.190])
        by smtp.gmail.com with ESMTPSA id s12-20020ac85ecc000000b00405447ee5e8sm2875365qtx.55.2023.09.11.14.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 14:20:32 -0700 (PDT)
From:   Meet Udeshi <mudeshi1209@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] tools/thermal: tmon: Fix sample data update in PID
Date:   Mon, 11 Sep 2023 17:20:31 -0400
Message-Id: <20230911212031.46336-1-mudeshi1209@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822184940.31316-1-mudeshi1209@gmail.com>
References: <20230822184940.31316-1-mudeshi1209@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Wondering if this patch is being reviewed by you (you are delegated for this patch on Patchwork).
I initially only sent this patch to the linux-pm mailing list, but I realised it may not have reached you.

I am new to the Linux patch submission procedure so I apologize for any inconvenience.

Regards,
Meet.

On Tue, 22 Aug 2023 at 14:50, Meet Udeshi <mudeshi1209@gmail.com> wrote:
> Fixed the order of update for `xk_1` and `xk_2` in the PID controller in
> function `controller_handler()`.
> 
> The previous timestep data in the PID controller, `xk_1` and `xk_2`,
> were updated in the wrong order. `xk_1` was overwritten before `xk_2`
> was assigned. This caused both `xk_1` and `xk_2` to take the value of
> `xk` when the function `controller_handler()` was called.
> This means the D-term of the PID controller was simplified from
> a second-order approximation using two previous timesteps to a
> first-order approximation using one previous timestep.
> 
>     xk - 2 * xk_1 + xk_2 => xk - xk_1
> 
> This degraded the performance of the PID controller by making it more
> noisy and less accurate.
> 
> This bug was found by reverse engineering the tmon binary using the
> [REMaQE tool](https://arxiv.org/abs/2305.06902).
> 
> Signed-off-by: Meet Udeshi <mudeshi1209@gmail.com>
> Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsystem")
> ---
>  tools/thermal/tmon/pid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/thermal/tmon/pid.c b/tools/thermal/tmon/pid.c
> index da20088285bd..1c02eb675088 100644
> --- a/tools/thermal/tmon/pid.c
> +++ b/tools/thermal/tmon/pid.c
> @@ -103,8 +103,8 @@ void controller_handler(const double xk, double *yk)
>  	/* compute output */
>  	*yk += p_term + i_term + d_term;
>  	/* update sample data */
> -	xk_1 = xk;
>  	xk_2 = xk_1;
> +	xk_1 = xk;
>  
>  	/* clamp output adjustment range */
>  	if (*yk < -LIMIT_HIGH)
> -- 
> 2.34.1
