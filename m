Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E724A77BC0F
	for <lists+linux-pm@lfdr.de>; Mon, 14 Aug 2023 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjHNOwR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Aug 2023 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjHNOvx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Aug 2023 10:51:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C09E73
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2023 07:51:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-317716a4622so3903721f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2023 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1692024711; x=1692629511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKUbWP/5wD+R2VLBW3T27yTkiHC3+pkgzxkv5KBw7oU=;
        b=NWMm8VPXlx1C0KCYzCe2DHfP0ywDplps9vTIQABh7xZoJm7n121tukAMxAJkOEcKO1
         0xqtrcZb5TkS2OkP8NvwgtnoL5TAP072lBKrIlWawF3Ew0KTiF9Kox9etTzy+vL5rZcK
         sCiesV6PZKDzp4Wf53mfDZkd52w9eAFV/TKXBw9fXJ1k4uA+h15fZObpyGfK/HcUssVy
         B5k4eymGhpX0E42pGWsbggffH7svbOgwN5J6MgJBQ2Bws+/JKTEPVFpX09EJFzvp9jwF
         8Im/hZajaQu70a0c4GjxLLdEhXKqo7mNEomTbXuKkRmUM19ggJSLjxvA/cGAMxTEqQOB
         kUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692024711; x=1692629511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKUbWP/5wD+R2VLBW3T27yTkiHC3+pkgzxkv5KBw7oU=;
        b=DhCYpx8esUCp7M0exuGEIsXKVv6+77ne5MfNPvQj3DAjqfFBGrLYwmQ+3uUvLtsvaf
         KoTA3+02eDLVwgxkQRWjiXKAQhPl7Frr/1d/ks/9t/b0FFgtNgfQ3P1EduAWjWgJPznq
         noptfP11RjygUiFL3MyYLyr+h84L1LIctRzjVTP8pzo+55Ixn3OUbcs8Gl5PdFHisFfE
         G6sv5isoI9si20HnjeVNOK4jJySI45e01DtlPPuUQ1ZJjs70GwEaV70K9DvpWw6pF++p
         1CCmg0feVknI8CBjinBA6bJiVckQ92BjbWHL7RjeOd2HMYm9M02DaUoR+X6hmgGSAptP
         1SAg==
X-Gm-Message-State: AOJu0YxL/QFmedPNyT8wrXQBWEqG/zLojnBkI/uC4GIRdm7t3iUbTLtL
        oxs47YYo42P6oeci1dltoiF1ysw3McTtYvud9qB8hg==
X-Google-Smtp-Source: AGHT+IEEW+/30gbtZROsRL2IsI6Cw+bkkZB/Yvn9l+bRXLpl21thcXBP5yldQkoLluhgI/aa/jQxdwaoWF6L50EREuc=
X-Received: by 2002:a5d:618d:0:b0:313:f783:262b with SMTP id
 j13-20020a5d618d000000b00313f783262bmr6915039wru.26.1692024710910; Mon, 14
 Aug 2023 07:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <12275372.O9o76ZdvQC@kreacher>
In-Reply-To: <12275372.O9o76ZdvQC@kreacher>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Mon, 14 Aug 2023 07:51:41 -0700
Message-ID: <CAAYoRsUYrE7gM28VCB0KrP2dCr7NmH2wuDnhT6h1D=S7go6fJA@mail.gmail.com>
Subject: Re: [RFT] [PATCH v2] cpuidle: menu: Skip tick_nohz_get_sleep_length()
 call in some cases
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 10, 2023 at 11:38=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.n=
et> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpuidle: menu: Skip tick_nohz_get_sleep_length() call in=
 some cases
>
> Because the cost of calling tick_nohz_get_sleep_length() may increase
> in the future, reorder the code in menu_select() so it first uses the
> statistics to determine the expected idle duration.  If that value is
> higher than RESIDENCY_THRESHOLD_NS, tick_nohz_get_sleep_length() will
> be called to obtain the time till the closest timer and refine the
> idle duration prediction if necessary.
>
> This causes the governor to always take the full overhead of
> get_typical_interval() with the assumption that the cost will be
> amortized by skipping the tick_nohz_get_sleep_length() call in the
> cases when the predicted idle duration is relatively very small.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I ran the same tests as I did for the teo governor changes.
Nothing of significance to report (well, some minor improvements
in records per second at the long interval end of the sleeping
ebizzy test, with a corresponding slight increase in processor
package power).

Tested-by: Doug Smythies <dsmythies@telus.net>

> ---
>
> v1 -> v2: Add missing max check to get_typical_interval().
>

... Doug
