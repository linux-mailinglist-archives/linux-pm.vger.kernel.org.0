Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7564F55C13E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 14:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbiF0OqA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jun 2022 10:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbiF0Op7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2022 10:45:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDD5DEF4
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2022 07:45:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k22so13409138wrd.6
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2022 07:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hjSlKwprPeElJ8oslDojBpVahMGDbSeGzEJLHr/N81U=;
        b=Sex40FDa1GBjm/3goIlmWXO8PxMCZqyz2UJxrgccKb5gkqYB/u1qF+lktZH7qOomYo
         buW81FrJ24nBiprsm/9JqCe9370PHaMq1Sz+y5Wzlz78z+0jA0Iu4pwnYdg3+YrTjS2J
         +BjUPzCGVZvFSSF0CRWbAMyR4FSCiZqEmm9fePOFm0SklnIMF0+vvkjgSdx1h/6u+FeF
         aqPK0Kz29LJISIvjpM9H7BK2437kntGIJXBtmEiPwRqX5lRkI548HWJr1Q65979uoWYY
         +rvpe6K71fmKk6fG88sYe3ntsYdKFGruyyfQsu9gWLZdpigSZGjKP5q7E73lTpCx+FQk
         z9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hjSlKwprPeElJ8oslDojBpVahMGDbSeGzEJLHr/N81U=;
        b=G1PqHuhzEudfUw8uMjPdbLlEO5qcUztcHT/6So0FlsIXzQ6fv/JF3jNpXy4k4+Q83K
         AXU54xp7ao4y1+KFc+uS9IfgTC4hkmB7xGRAupe4cj/oT5Iv7RhqyUbauferf0ADaYhG
         ESpnVnzAIRYz0IDL/4WJYgXNP9XAbnKL5DaENQ0NX1MbPxvAy7bpjmjMF5mn8plFn44f
         VpJ+65pw815jijxdrDdtCryLoQ3BcRL7ViER85WwE0cZFZ/hhrU9PtVrdH1ScHKnD81I
         Vp45hiGa/Dc9yvR7600ZSY6ylIcu6+0TJccHIellFTJEsg/HcDB7qtCG0vBWkYHsgVMs
         Je2w==
X-Gm-Message-State: AJIora+k2NSlP0YkqVgFzoKouOkhnfIKP3nKFwLJNLvHB5zWIgJSjshZ
        lrZt5tj8CDrQKuNL0s5BfQc8ow==
X-Google-Smtp-Source: AGRyM1uV8cPXQdKc/vgcvRKShRWQVd3WvLKa89SUlHy1jZy8DUQdSygZrUPypSvYQ2i/wvoBdOjWCg==
X-Received: by 2002:a5d:4708:0:b0:21b:8a39:1aa5 with SMTP id y8-20020a5d4708000000b0021b8a391aa5mr12659644wrq.141.1656341156996;
        Mon, 27 Jun 2022 07:45:56 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id q12-20020a5d61cc000000b0021cf31e1f7csm2686798wrv.102.2022.06.27.07.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 07:45:56 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:45:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: mfd: Add mp2733 compatible
Message-ID: <YrnCoiD0OgKxMT6K@google.com>
References: <20220614151722.2194936-1-sravanhome@gmail.com>
 <20220614151722.2194936-2-sravanhome@gmail.com>
 <YqpkXYAtXtvzX44J@google.com>
 <CAL_JsqKg2rv5_ZKqRpNcxQVDqvETOrKXfvWMDvemDRgS57yFqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKg2rv5_ZKqRpNcxQVDqvETOrKXfvWMDvemDRgS57yFqQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 27 Jun 2022, Rob Herring wrote:

> On Wed, Jun 15, 2022 at 4:59 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 14 Jun 2022, Saravanan Sekar wrote:
> >
> > > Add new compatible for mp2733 mfd driver.
> > >
> > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/mps,mp2629.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > Applied, thanks.
> 
> This breaks linux-next. Please apply v3 instead.

Done, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
