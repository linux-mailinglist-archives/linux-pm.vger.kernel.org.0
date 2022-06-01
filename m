Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9D953AD6C
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jun 2022 21:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiFATbK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jun 2022 15:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiFATbJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 15:31:09 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2809817CE43
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 12:28:45 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-f2cd424b9cso4023484fac.7
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2022 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=Gk4nfCem3ECRa7Gml0J0mN/3RZoOAdfGaQAqyHPKtiI=;
        b=DxxMd4k8tG1Z+DI+JxuL9225Cp+S+uInl/poXMcuMZiTQV1c8XJNPCuJB0EN9Fm1lJ
         tjqO15tZbiRtkiZc869kqZb+gTGwGsofr4Ks/EzA24HoqZkeukApCRLbeWaJgYbzN6Uj
         DJcyUaN0vgzLiaJiK8SKJwd17XWuJUN7X4OrSO+zy2q+txFdEpb8ifoCAb/ECnGeqxQV
         22+OgKU21rrXICCeKXN25GVJHEIOuX810V30PW3f8Y111fShlwSlQkBARV9N87g0aoLJ
         wQNCoaF08Ng768jLDvSBCHYHS21HkQkWfLc+tM30B/O2SgLendb0dLrFE3BY6UlGqUm0
         gBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=Gk4nfCem3ECRa7Gml0J0mN/3RZoOAdfGaQAqyHPKtiI=;
        b=AKj+VtL/Ikm2rWNw4CpiXeNOWzh5EYcPj0vo04j5pZfNGwUrS9y7j+hizkadOm00kM
         qRhsxd1I4Mdj1D6EZO9TqwXewgMvMsX5WnU4CsBC9PC3kpP9b8PzTJiG4eMS96exghHD
         gAa4Fbg4WUv1WS7rYqPAMR1Nlq+qAhZGxu1wFoIa0AdYxtj/4gnONrK9kvcUBuawLwAh
         VHD5Ih5EhZjizs36LjqBAd3o/pXfaN15RGEb/Sp2pY6neLY9rnuIMYK0JKvncjEEypEn
         F90GkIWdfM2YP2xxZgz4IOxq4KvFkq9/S1LsXkUZiC2EWlNKS9oZ9BvVsnZY9ngjA1+1
         Acpw==
X-Gm-Message-State: AOAM532RMQNlhocURXkKUfM//kkPXOl2G9E0cySFSrWqagyDGLyLJ4nr
        cYkTEGgVW17KC7b7mFpp6Af6KXsVegqxyplwcCwWhU6Dbyk=
X-Google-Smtp-Source: ABdhPJxRHJ7PowqzwP8FVf7Pao2siL9+mp8F+vsKwg9Hvlld1uXwEH8+vzJyu5zLQk9d57eu+g6BtXkHW1P4ce0P3TA=
X-Received: by 2002:a05:6870:4619:b0:f1:e78d:fd54 with SMTP id
 z25-20020a056870461900b000f1e78dfd54mr18175523oao.195.1654111088174; Wed, 01
 Jun 2022 12:18:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:3601:b0:a3:2139:251d with HTTP; Wed, 1 Jun 2022
 12:18:07 -0700 (PDT)
Reply-To: johnwinery@online.ee
In-Reply-To: <CAFqHCSSUC0MpbjYK8d-GCxOG4b6Qbk2uH3+xQDZte6cPBsxLGA@mail.gmail.com>
References: <CAFqHCSSUC0MpbjYK8d-GCxOG4b6Qbk2uH3+xQDZte6cPBsxLGA@mail.gmail.com>
From:   johnwinery <alicejohnson8974@gmail.com>
Date:   Wed, 1 Jun 2022 12:18:07 -0700
Message-ID: <CAFqHCSTLW5uHwBqcyU-qn7_jF2jtwt2-CjgdN8-B9nAn9yi+vg@mail.gmail.com>
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Greeting ,I had written an earlier mail to you but without response
