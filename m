Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9A6A3600
	for <lists+linux-pm@lfdr.de>; Mon, 27 Feb 2023 01:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjB0AwU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Feb 2023 19:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB0AwT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Feb 2023 19:52:19 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AB215150
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2023 16:52:19 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id x34so4481681pjj.0
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2023 16:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x4N+ipv4Z0ueanE2uVRFnU+7mwUn4iLsJ/UJ4pQlXTs=;
        b=Ch8RqNy/BXlSvbgs7VPggxxfre1QdO6SNXV/osG20ROx0VWaB8JdUg/ynrMEon3XfK
         MDfwIMQuvyY3ouRZCvvWm9yVDY/nMMizKxbLPqbYAQHXNIEga3/9wzw2Qpl0OwLDoXPK
         CYfnkRwpMq4avCew9zE3iCVcZT7+C4EdFzyJKg/yGBdTdVlvYyKkgeVBRcSett7v+XHZ
         LtwqqyRNqC44wyWk+1M2d/A5jxIY8l7svP4XR2T4bGxTOEGlDwFa59TWaGzPsZY1JSyU
         zxz41aE+nak5MZTr6sZBw8Kt4UXWjjhmmIjNyEIy0JEh5JjZw37KRYKJAoDld/gh/kfk
         Lqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x4N+ipv4Z0ueanE2uVRFnU+7mwUn4iLsJ/UJ4pQlXTs=;
        b=dTW1c9Fa8JGHjBvZ/NZWxQMyEcMncXJKHakaNQsOfjc7hNr9eS9eZJqNbnWWChuu6K
         msUhaPJANdi6tAE+A2hLGmg3E5TWvxEj1Lf0bWKaGZIxiY9vKtdKZkSIlUOtTmNYKnSX
         3+uf7N/B8zbcidGIJZ9siQjXDSfpF1PvrClXHOdQZXqJrgnTn5JX1aSZSZw1MrE4l8IR
         RZOwA1W1FWjX7AmLxjufg0u9KLi05Rna3uwRyCyL2T2C1EnY+8buM7iJ7o7irMdKnzmI
         uNOT/yIre1QK8HqfAsItxs+mty3KhvQuNuFrfjM1HnX6TvC1VAafLuKx9ENiEuN/uQUn
         Tsqw==
X-Gm-Message-State: AO0yUKUJx7ymWL9CGWDAb3dkS122Teti0juFWBBgHPh1FOoDHI3cSrKv
        0mBOtYg8cxnbKmJHNh+K+Tyb1dqhKC11lEue/is=
X-Google-Smtp-Source: AK7set9tbib26ZLo2sv1OIiLXNVwKPLbka5/1n8b2r2D/z0hYC0ETjIGhToKEL5aX+yMJ0NpJPxlbJgxdQygzygxrBI=
X-Received: by 2002:a17:90b:1211:b0:231:1da0:dfce with SMTP id
 gl17-20020a17090b121100b002311da0dfcemr4069475pjb.3.1677459138353; Sun, 26
 Feb 2023 16:52:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:3255:b0:41f:988f:1328 with HTTP; Sun, 26 Feb 2023
 16:52:16 -0800 (PST)
From:   Elisabeth Johanna <elisajoh4992@gmail.com>
Date:   Sun, 26 Feb 2023 16:52:16 -0800
Message-ID: <CALjaFX+HSa9ihT0eBtMc9aAbYsQTp6de+dMefXHCu-FG2DW_Eg@mail.gmail.com>
Subject: We finance viable projects only
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_99,BAYES_999,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Attention: Sir

Our Company is willing, ready to help you grow your network and offer
you Loan funds to complete and fund your existing Projects. We can
send you our Company Terms and Condition after review of your project
plan and executive summary of your project, if you are serious and
Interested contact us for further Information:

Email: elisajoh4992@gmail.com


Best regards,

Elisabeth Johanna
