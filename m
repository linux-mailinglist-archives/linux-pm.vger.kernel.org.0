Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C76577DA2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 10:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiGRIi2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jul 2022 04:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiGRIi1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2022 04:38:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EEB193CD
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 01:38:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso11933597pjh.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 01:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JVkcuidRxttdPygTadWD7Fe22FzTLqDp4UoPFTn5PkA=;
        b=AodOse/RzQpy2bTO5unzjrGqsFYYr2zCPzdeN5zld1GlLCcazollxwAgp1uXsrrrcf
         U2u8ve11utTk41vpwELbmO2M0GjoIYWqTzYcTli3Nr7UJJG0jX+FGwJycPN7Mzr8WiGG
         XcpY0QqJ+2AcwHp4MmetLCwx1I/zhNqfk0p5QX2ki+qPOeM3rKIIgsXo/BEcjtNicxiQ
         8v9AHhmOTXdEXvIhmLKbL/6vkf6UIuKD+/bHWsDZ9XIAioYBdfBlRXOfPCygdxzwnV6n
         7v6LQVhL65SQYaoxhBKJCfHGjdN26LQJTU5ubtX438mq3rEJ8VQvO5AyydyFm4EDAylB
         1bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JVkcuidRxttdPygTadWD7Fe22FzTLqDp4UoPFTn5PkA=;
        b=ISDdcPvz9ltPh1ZoFJfjdnuVwYoiQRVwujAvFcT7PRJf/sRciLJuh7KmtFFAdb+zmg
         MgSVH1dKIckLXRlR849VLiJ64HprVpJkaBnf7jy3co84QhlrtV5lZ7WV5WLLYwAh6as/
         XhFGxlgyrzJSw1liYmuRnzn+GYjqLm1TgckcKElOF6GSSwJDShqhZ6lNBqZmBgIkDVii
         v2CnXpOoYftO0klu9MzLTYI/CViXgZC9oMKlR6B03JpsUlnG/Pfz5v1GsI2FdF38pmQ/
         1FjhWyUoggbEUVBdlebwEjtIkG9OPsfjSX3BSwcqm5xx/t7XhN0cUefGtgqeEjS07wBn
         yNSQ==
X-Gm-Message-State: AJIora8K7K4rJo8r9gG+Z6h0spVLQZSk3t1LEdYAlsCIxl73fBmu665/
        DoAeKMYyNo85J74SpPshL/Ce4w==
X-Google-Smtp-Source: AGRyM1t6rrwflq00W9zTsvgHHxpUK9gYQkDNGMY54Zyc0A8wPiOqlIKYVbazFlbVvROI6yNQgBLgfw==
X-Received: by 2002:a17:902:c245:b0:16b:e818:b75c with SMTP id 5-20020a170902c24500b0016be818b75cmr27688971plg.101.1658133505162;
        Mon, 18 Jul 2022 01:38:25 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id r15-20020aa7962f000000b00528e84c3093sm8898403pfg.143.2022.07.18.01.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:38:24 -0700 (PDT)
Date:   Mon, 18 Jul 2022 14:08:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liang He <windhl@126.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix two refcount bugs
Message-ID: <20220718083822.66red4tg2kcli3zu@vireshk-i7>
References: <20220715144712.444104-1-windhl@126.com>
 <20220718070848.s6qziqkr3nmv32fc@vireshk-i7>
 <4af1805a.2b51.182106c170c.Coremail.windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4af1805a.2b51.182106c170c.Coremail.windhl@126.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-07-22, 16:28, Liang He wrote:
> At 2022-07-18 15:08:48, "Viresh Kumar" <viresh.kumar@linaro.org> wrote:
> But is it OK if the two patches change the same file at same time？

Yes.

> I wonder if this will trouble you to merge them later.

If I apply the patches in the same order you send them (based on patch numbers
in subject), it will never be a problem.

> After I read the code, I think it is better to drop opp_table->np in '_opp_table_kref_release'
> just like we do for the 'opp->np' in '_opp_kref_release'.

Yeah, look fine, though a review after the new version will make it more clear.

-- 
viresh
