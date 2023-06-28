Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5405F74161D
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jun 2023 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjF1QOQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jun 2023 12:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF1QOO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2023 12:14:14 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A642D2690
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 09:14:12 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5768a7e3adbso17562597b3.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 09:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687968851; x=1690560851;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5JtQ9d9ThWaTpSmJ1e6zGp7H/OfQzIYzzK0f4gBNZM=;
        b=Zls89fUexLoFHv6GZgnGMRtelH7TLPyfNhmK/cAq1el7R4ncBzKvvA/g85HU4neX5u
         kTK3TejkUJs/0nQiJy9Um8kbtvvM9v/5eYyjZq23dZilOF8oIn5WWuR4vG/JLZHaR4il
         6mF3c6wI5BNo0vKyJy7g+ehAiwA06C6/COKnBBfTgUXD4nEeUeBmV2zhVDAUXebNtw1c
         WMFXpwf5DmEPFt71OQX8Q3H+GdunKKDB7DUwbAoqBW24wgpOqgTtjZIK5YZEnAqm6s73
         8sKnNGpnNaltLwwEmHEfGNpWv7WXTNPhTyXnox+e50nn2hGA1Uuey/JRdYdCQ1b90OLM
         yFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687968851; x=1690560851;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5JtQ9d9ThWaTpSmJ1e6zGp7H/OfQzIYzzK0f4gBNZM=;
        b=ZwSpx7uvO6VWYPziZ4vBx3DYqA/oAqy2WwZnYbXqoGIF4xgVD8QlWGxy+kFqv9E+4i
         fdvb054x8y7Z10X+ruZESUrYItuHf/pCHy9Z+Qcy7/PaP/1KGHnPpCBhOg/4kP6Rj21V
         VPTALK+u3UNfI8W7+uDuUvfevX7KXh1hcpDdU0kY2KpSsmqYKoOZxGeitH3pVHhFQld0
         PAhKAAFwZlAO2g1DEcFlPtLn694/3u6WMGd19SraagEve06bRV0dIEo8JPRXlMVn6kYV
         YUNnZlSzZgnOMmNMURL86wU26WfR2yynNoM4jBH+jAi7/H8YIIMQJU/ufuSwk5TGCTZM
         2R+Q==
X-Gm-Message-State: ABy/qLb5SaiNcNm89ORYFh+316gNKyN2ALuqRen5+xj8lb1BhuKAtnW+
        me7WOfmX9ocNQ2EPQVrq1ZP6D6PREW2761Wv4v0=
X-Google-Smtp-Source: APBJJlGsOFFTHXdGQ7R3CnuIiXnYZop2wt5weMV30lkU8X/gHfL+U+RQ2QXUJ8Kw4q3BOJWQccL1Lzlfzg6rrNSMTas=
X-Received: by 2002:a25:553:0:b0:bc8:42db:2c07 with SMTP id
 80-20020a250553000000b00bc842db2c07mr1746715ybf.25.1687968850071; Wed, 28 Jun
 2023 09:14:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6918:20c6:b0:191:b4a4:6662 with HTTP; Wed, 28 Jun 2023
 09:14:09 -0700 (PDT)
Reply-To: infoconsul03@gmail.com
From:   David Mensah <tinsleylexia257@gmail.com>
Date:   Wed, 28 Jun 2023 09:14:09 -0700
Message-ID: <CAAQ31TOQ7htvXukjFQjtCRuD7PXJ=KTb_jzvaU-0GMxTp-Ci0g@mail.gmail.com>
Subject: RES
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

-- 
Hello my friend, I have some information for you.
