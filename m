Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1629640EA3
	for <lists+linux-pm@lfdr.de>; Fri,  2 Dec 2022 20:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiLBTn0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Dec 2022 14:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiLBTnZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 14:43:25 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43AFC869E
        for <linux-pm@vger.kernel.org>; Fri,  2 Dec 2022 11:43:24 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id fz10so6652518qtb.3
        for <linux-pm@vger.kernel.org>; Fri, 02 Dec 2022 11:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28swQqgNtHazNPDhHL69FVy6h6fBTNTjTyhVemk13g4=;
        b=NsANZpPwygYfEX2QQ7nES+odf6jxpYsnWgklLB3QUnENj4XAdhHo7Opzz8pdyTG8SG
         50/jZ990CkslMvDOlCtpystu7NyUpAARbilj+SahTXLAw93F1YHJ7U+1siCkpdEC9Odh
         XX+vTDd+o6A10cr/BFefSul0/9owFHT8xn9mdYk7z03oKFwWZGctBQLmqIiaczQtHCin
         XQUrdet6weRRPuosb1SJU/znAwkArR+0yQiKR7sDpTBOirtTrxU74f1OFNSVuG75lOSZ
         8wXeXhV+f0fjAclx9KzYNMqDpGH7g4TFOzOSjGe+xydiy/YtIDbQEyl8u6Cgnea0m1VO
         T20Q==
X-Gm-Message-State: ANoB5plEI5Zrmnu3Toa9C+Fj/pI3WQbwI3cNn8uwA3n5fGDaixlFRk0T
        et+40pUmtTIFkMc0B9K9+R0J0rZYF6XS68mjFfFNTW9d
X-Google-Smtp-Source: AA0mqf5H1hBgSzuzIP+PGQirppCRP/HvjsJIlS+oi3SH2pKZHyRDTMHqHsOgDv8wAE5rjEIpUpwL1ivAvvSitcuJv+Y=
X-Received: by 2002:a05:620a:51ca:b0:6ec:fa04:d97c with SMTP id
 cx10-20020a05620a51ca00b006ecfa04d97cmr47231221qkb.764.1670010204102; Fri, 02
 Dec 2022 11:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20221202054510.2dsvqjfxy7vaxfiu@vireshk-i7>
In-Reply-To: <20221202054510.2dsvqjfxy7vaxfiu@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Dec 2022 20:43:13 +0100
Message-ID: <CAJZ5v0jM_KnCp0BSJGrCg5F3sbWGzkmvXaobhwiejdJsyMEgYg@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.2
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 2, 2022 at 6:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit c7e31e36d8a262eb0bc2daf8f9b7481c83284386:
>
>   dt-bindings: opp: Add missing (unevaluated|additional)Properties on child nodes (2022-08-24 11:34:22 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.2
>
> for you to fetch changes up to dba79b78ecc18f7788fd08eb998388e226817fb5:
>
>   dt-bindings: opp-v2: Fix clock-latency-ns prop in example (2022-11-08 09:50:44 +0530)
>
> ----------------------------------------------------------------
> OPP updates for 6.2
>
> - Several DT fixes and code reorganization around opp-microvolt-<named>
>   DT property (Viresh Kumar).
>
> - Allow any of opp-microvolt, opp-microamp, or opp-microwatt properties
>   to be present without the others present (James Calligeros).
>
> - Fix clock-latency-ns prop in DT example (Serge Semin).
>
> ----------------------------------------------------------------
> James Calligeros (1):
>       OPP: decouple dt properties in opp_parse_supplies()
>
> Serge Semin (1):
>       dt-bindings: opp-v2: Fix clock-latency-ns prop in example
>
> Viresh Kumar (4):
>       dt-bindings: opp: Fix usage of current in microwatt property
>       dt-bindings: opp: Fix named microwatt property
>       OPP: Parse named opp-microwatt property too
>       OPP: Simplify opp_parse_supplies() by restructuring it
>
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml |   6 ++--
>  Documentation/devicetree/bindings/opp/opp-v2.yaml      |   2 +-
>  drivers/opp/of.c                                       | 228 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------------------------------------
>  3 files changed, 103 insertions(+), 133 deletions(-)
>
> --

Pulled, thanks!
