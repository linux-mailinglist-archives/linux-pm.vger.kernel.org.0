Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0366BBCC
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jan 2023 11:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjAPKeJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Jan 2023 05:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjAPKeF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2023 05:34:05 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4941ABE8
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2023 02:34:03 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4c24993965eso368353607b3.12
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2023 02:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/tYLsguvhNX76zD17hbPH2qZrPUhffkR6haBjKQqeM=;
        b=lOAzNQu8eznDMDQrcDCeg8Fr+f4UMLS1VKaRsPuieAhkt0buE9051t1htqoIaxTiPe
         J2ypkmPum8BdNAzSBXwbQiS/RJgBXZ9uNJNoY9p7/4ECG5i2eJFzWSvxsI7w4VLi95qA
         65cm9Sgww5hrMlBJO/mkMjzNxRTk/Cl+Kalzz/jTRBSAkeoZSnD85r5K9fe5Y427m9Wy
         GvpTxzOk4uy1F9NJo5kgPKyKkrs7kCcWQyuGdxvFOlD7611X+u7Zcgpm/7NGRA8MkNaf
         ZCvdaxDS1JE4r7/uoMTLFgylYdR+JRh1ELrm209maie8TVQlHpLfuGkkkOdZyBAT06X1
         NhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/tYLsguvhNX76zD17hbPH2qZrPUhffkR6haBjKQqeM=;
        b=SPnwCaWUs/jsMP/GoTp/z3ASoHcBq0xf53QW1zY/bHef8XXnnASGxV/eNoev0wiXQx
         OoHhM1ubdWRXu2B0Yr479Cf8Rl/vos2BGcDDNKcnwKGRvk7R59b2GhyPDTvKWYrx0pOU
         KbRPMZVYBA/tl3SyBCcBax2vCdOzFDYM8vSFMV14/U1xzSwdO91z0yzLgIv684CMjOcw
         l32tV1OvdOdi55neIyL3r4M315rtdpb18LHf/Aed4tZn4/xYLoqXSa6zPYJj5KBGS5bn
         hqHnloUVnJczo/gIEKnf5CQZGIdV2HOXEkH0UIhAO2iXKF3aTTaepPxLB0laXv44Izcc
         Deqg==
X-Gm-Message-State: AFqh2kpx9cJwB0ZrHb71SJVUund5uyXc531GBLUa1qFClhMytSeH1aFO
        Ai/ThSX1TTlwEeydIQqd5nomPUIPf2x7FwaZivdeRw==
X-Google-Smtp-Source: AMrXdXtW6TKCnRsDE0wvhiF6XGnwo0I29h/efOhVdU9ndWaVGtkwJJu/nRXufdrfHsXPEx193xkQYwrYct1AIhwg7Gw=
X-Received: by 2002:a81:a084:0:b0:4dd:ff06:1358 with SMTP id
 x126-20020a81a084000000b004ddff061358mr1574748ywg.488.1673865243057; Mon, 16
 Jan 2023 02:34:03 -0800 (PST)
MIME-Version: 1.0
References: <20230112140209.61228-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112140209.61228-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jan 2023 11:33:51 +0100
Message-ID: <CACRpkdZLAOfJ4YHWhK2qfcfC7unex0fHRHdxsCRWhgHmkhacAw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] power: supply: collie_battery: Convert to GPIO
 descriptors (part 2)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 12, 2023 at 3:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Finish the job started by the commit ba940ed83218 ("power: supply:
> collie_battery: Convert to GPIO descriptors"), i.e. convert the use
> of gpio_to_irq() to gpiod_to_irq(). No functional changes intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
