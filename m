Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9158B6869BF
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 16:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjBAPP6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 10:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjBAPPe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 10:15:34 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD39274B8
        for <linux-pm@vger.kernel.org>; Wed,  1 Feb 2023 07:15:13 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bp15so29698963lfb.13
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 07:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lLX7pM7hqpU4TFyVN86DeJVlh/KarrGEhTFMLvDtTOs=;
        b=hjwajA05EUmyxHZfZu4qw7wCS12SG2M/0HznMKoVMNYUs7IE2wl44TQOqWT2G820xw
         YE/KLGqmLVq2VuzSCCu95XoF/b+FKqKtPMgd2GIMuHWuAli975mt+4ULJLj1DQmc20Xz
         Mbq5uKgwFHJcDKJbrTT/LEaDeNCVRmhXUx+fjIn5z8eQ+gkE3/isLyg5fC6Gdfs6fwRh
         NOOr4NF1zGGuoBJsZVpaauqKp/TPu9OBiyUyOzIucVWL/egrkdTb4zN9xdsvyMCR/XQF
         YqQSX+4D6tqpdl+qQ9Y0HMSnTcM4EPGt5P1H6+tk5YynZ/FLtdw8Zg/br2c7bla12+1x
         UnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLX7pM7hqpU4TFyVN86DeJVlh/KarrGEhTFMLvDtTOs=;
        b=nLuQHAaD1U2gnHuaQ62zIYm9p2I1C4J1hz+XUtS2UizPEYmmj7VDfQ9Hys5OynaT64
         92zF2H1uNnC7ZerE8yMZE7m2Rsmg4vbreF09V13zmgMiKPUfBTyc0hlUnCLVSNSGgA+K
         loxpqpDJ3Wdy0kGmZObrHoMGa9S0U7qpS6kDvErcNmpvE9NsmGccJ4b1IkFRoSNyXQIc
         CXYnbfVBBE3+aRf0rTP+giG2nmCdvYhQg8Al0F+HuI2DR7aWfCX8Rs9y9HfrjZRLfALI
         CNE8jpd8fg1E7EBeMtKgS05jyHr8fGlvpYrVGsfnv/NnT2VJjfczdsn7aI9oMKIHSoxQ
         +0mw==
X-Gm-Message-State: AO0yUKXNaCDSnkEtP1RWjMYY7rsyxUdX+x9mCG61zBzO8m6it+012iJi
        +eLH62edv+avsYbLdgTytoX+aPEhuJO/ZRTfcXJJ25y75O011Q==
X-Google-Smtp-Source: AK7set9FlH3YuQTbPCgh8mr0LjPnk5XhZB1nXXLdBvl7PGkvQMWtqwoUMM40I3hsgJ9TvVKQ6Wl7KoC5IoZD0JPcu+Q=
X-Received: by 2002:ac2:43d0:0:b0:4d2:e530:d53c with SMTP id
 u16-20020ac243d0000000b004d2e530d53cmr434756lfl.8.1675264512162; Wed, 01 Feb
 2023 07:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20230201080227.473547-1-jun.nie@linaro.org> <20230201080227.473547-2-jun.nie@linaro.org>
 <5ecc68a6-2914-1059-460f-752adc1d3d01@kernel.org>
In-Reply-To: <5ecc68a6-2914-1059-460f-752adc1d3d01@kernel.org>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Wed, 1 Feb 2023 23:15:08 +0800
Message-ID: <CABymUCP0sC58vi1nU=0BM9JmwWh2eNTt883_VGwXdoaZ3ZZUJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / devfreq: qcom: Introduce CCI devfreq driver
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, bryan.odonoghue@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  drivers/devfreq/Kconfig    |   9 +++
> >  drivers/devfreq/Makefile   |   1 +
> >  drivers/devfreq/qcom-cci.c | 162 +++++++++++++++++++++++++++++++++++++
>
> Who is going to maintain this file/driver?
>
I will add myself as maintainer of this file.
All other comments will be addressed in next version. Thanks!

- Jun
