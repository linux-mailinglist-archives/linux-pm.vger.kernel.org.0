Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9817BB211
	for <lists+linux-pm@lfdr.de>; Fri,  6 Oct 2023 09:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjJFHT5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Oct 2023 03:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjJFHT4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2023 03:19:56 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67543CA
        for <linux-pm@vger.kernel.org>; Fri,  6 Oct 2023 00:19:55 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5789ffc8ae0so1293393a12.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Oct 2023 00:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696576795; x=1697181595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QLbD36lfGshKBD/IHq1uy+catxZoLx+hDosAbEWMfB8=;
        b=Y3bTTsyvTMeZqwAzwgfulcmrGMZZ3Fyxv8u4+zdYEeY7ztIF49TzsDyQ92UL1xNSs0
         D0Ni5G4LSjujeUd+nGgvdsRm+oeqgasGRXjv43uLi7RvWQfOd9SAXd8vFiBeFp/Vk35y
         WaxzaAPNfxAvTs4V45Hj7LvlpkYXiuopN8+oy84xt6bCq9E1nDMgg4pbEwNSM23e9kmf
         +PyOZWclODCeVIz7gMtmQkWgTe2a++1nX0TS3l2P+ndcH+LQCOmFsJZEtHd+nGpbxyL6
         e7ThlLD64WSpsXKbmtm79bUT2CcN/f3IAYnmKoi8gdeE7cymKmpwwP+Fo9sxKRo/gfk+
         nwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696576795; x=1697181595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLbD36lfGshKBD/IHq1uy+catxZoLx+hDosAbEWMfB8=;
        b=ANZfaSbuugh22gpKhRTewVXw/Pb9BtxhwDitp5TDkC5VaquDI/aWmWbKp6s/aWcaU/
         4SinZtrK14rUGC3JJufg7gBkyISDzq3fZHmX87dc4CxO2MCfNCP2Er/32yQXQTXAQbCR
         gL1ElpyZE0T9Gz1ZTYKya2Y9vW4gW641YlNj3I+2W4iCdzjChMqdesapP1lAE62ruisH
         sK1ToA+6jE+A5W/Xaw/XK1kzo1ZnFn9u42ugeV7JMxReaCxP14TaX/y0+Evt20OwlmZZ
         a/7TnDzTbUjhWqOWxfnBGIH7uRI8jdlUeVRXlab01vayp6XjnPUuc4nF0+YiJL+coqsc
         fNiA==
X-Gm-Message-State: AOJu0Ywr/BrnZmr+3Qqzg2R/yA6QzARyrKCV00w5D7aeM0U6Pd1XJf11
        gU4A7JYQsK3qHh3XMuejurlxcw==
X-Google-Smtp-Source: AGHT+IEnIZWIPATAMO46x1U1rXCCVIqKIMiKNxn+ZYVTiXHcvpjaRtDDpI08eGoBu+OpT0LvVnZPcQ==
X-Received: by 2002:a17:90b:4c07:b0:262:d661:2963 with SMTP id na7-20020a17090b4c0700b00262d6612963mr7011516pjb.39.1696576794865;
        Fri, 06 Oct 2023 00:19:54 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a035500b002796494b98csm5132242pjf.37.2023.10.06.00.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 00:19:54 -0700 (PDT)
Date:   Fri, 6 Oct 2023 12:49:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, vireshk@kernel.org,
        nm@ti.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        trix@redhat.com, linux-pm@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH] OPP: Fix -Wunsequenced in _of_add_opp_table_v1()
Message-ID: <20231006071952.b43vbnrhax7g6vta@vireshk-i7>
References: <20231005-opp-of-wunsequenced-v1-1-778815980a8d@kernel.org>
 <CAKwvOdmhtS6LAcckceXLftKeqxthdHEEi-zr8EiOW0hRYwsjEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmhtS6LAcckceXLftKeqxthdHEEi-zr8EiOW0hRYwsjEA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-10-23, 11:31, Nick Desaulniers wrote:
> On Thu, Oct 5, 2023 at 10:25 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Clang warns (or errors with CONFIG_WERROR=y):
> >
> >   drivers/opp/of.c:1081:28: error: multiple unsequenced modifications to 'val' [-Werror,-Wunsequenced]
> >    1081 |                         .freq = be32_to_cpup(val++) * 1000,
> >         |                                                 ^
> >    1082 |                         .u_volt = be32_to_cpup(val++),
> >         |                                                   ~~
> >   1 error generated.
> >
> > There is no sequence point in a designated initializer. Move back to
> > separate variables for the creation of the values, so that there are
> > sequence points between each evaluation and increment of val.
> >
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1940
> > Fixes: 75bbc92c09d8 ("OPP: Add dev_pm_opp_add_dynamic() to allow more flexibility")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Applied. Thanks.

-- 
viresh
