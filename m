Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA057709FEE
	for <lists+linux-pm@lfdr.de>; Fri, 19 May 2023 21:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjESTd5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 May 2023 15:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjESTd5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 May 2023 15:33:57 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5DEF7
        for <linux-pm@vger.kernel.org>; Fri, 19 May 2023 12:33:56 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-199fd7b5789so2704454fac.2
        for <linux-pm@vger.kernel.org>; Fri, 19 May 2023 12:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684524835; x=1687116835;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mt/sw2kEhkn8ITYu3LMoFive8pxbSEmHnKjoONJjpIc=;
        b=TjrpSQmC61E88PtpXHMAuZb4GJJ6DWESgTuMe0T/mKQXuXjAk93/lc/3OYSdwRf/Mo
         of5e+qNUY8oXM3dWRqW4o5bgBtOMyfrpjqWI1KViFo7lw3VX1828QOOtxCcEh6Uw7c8H
         FmyDg2vCo1ChTKwzlavMhJ16jHhldJxyxgH6vOC6wnWpzfxBqJ64I/ail7gLyAyEytr7
         9LeE+HOJwoCpFDz3OQzzZxJ2ndGx4Uq/B19xOYsMofYiKSgHxxzsbpkTN7VKTTnYjAD4
         lgxUC7Qa8IMX8lNQWu5cvk4gxydpRRTjeq20Ya6xVwxsXQdmNjTRqPT9WwzV9N4nMUzt
         gfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684524835; x=1687116835;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mt/sw2kEhkn8ITYu3LMoFive8pxbSEmHnKjoONJjpIc=;
        b=IaqH5qNWA59owDQrvl9mh8k5trhxLtDLudTII62yow6GRVUyHAp7iXqWH1kVRdKG1u
         p3W8sa0uclzxF72q2ndf942JlEZVkf0r2v2WMbxadXESihcGD2jvpLHPH8NA9zncgTi1
         NvkaQH5uRpQIcgi/oKpMsSI4OyrR6G52GfdwQA9JDFJBNEUs+3tL0VKKhj8tc5EqHY+h
         Jxsh2l5UhC29W+riKJFo/GNiKYebUbmI7bqgIf67/Chhf3leU40kclqLXjTvREJ3Vjx+
         eoVZcyRzKmiRwuAX9tfXit7wRkn3qou2Y9sNQR4GmKxWYynKUP4+CKYRnXfYCWQsEMRv
         nwKg==
X-Gm-Message-State: AC+VfDwHxrEuUlnmKLW1Hxa2KVZl8jtlTBMMTshAxsyoLL5c2PVzdBHq
        hEcDfsjlSDk+FKemdIgF6gIQ/GPbS6zLrbGBHuy2uiR8peGq1w==
X-Google-Smtp-Source: ACHHUZ4ljstyd1wp3iJTipCUB78gjaseoKiVBeaJyKWH58TO2t/o4v/TVsx+tdFoOxqojTx2EOFx3kUZdkKC6cWm2jE=
X-Received: by 2002:a05:6871:542:b0:17f:cf1f:9d8f with SMTP id
 t2-20020a056871054200b0017fcf1f9d8fmr1476567oal.8.1684524835205; Fri, 19 May
 2023 12:33:55 -0700 (PDT)
MIME-Version: 1.0
From:   Vivek yadav <linux.ninja23@gmail.com>
Date:   Sat, 20 May 2023 01:03:44 +0530
Message-ID: <CAO6a-98RO4H4CNvFWxjpYN1o3m==OoLsxmbZoyemz-3+F4ouUQ@mail.gmail.com>
Subject: trying to figure out PM driver call
To:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi linux-pm community,


After seeing this arch/arm64/boot/dts/tesla/fsd.dtsi at line no. 608.

Can I say drivers/soc/samsung/exynos-pmu.c driver's probe is called ??

If true,than inside probe function at line no. 135.

Which pmu_init() function it is calling or from where it is calling ?

I am a newbie. So pardon me. If my question is not clear to you.
