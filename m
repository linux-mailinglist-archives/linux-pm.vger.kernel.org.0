Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC3F5919EC
	for <lists+linux-pm@lfdr.de>; Sat, 13 Aug 2022 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbiHMKqF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Aug 2022 06:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbiHMKqE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Aug 2022 06:46:04 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7072E2870C
        for <linux-pm@vger.kernel.org>; Sat, 13 Aug 2022 03:46:03 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h8so2309808qvs.6
        for <linux-pm@vger.kernel.org>; Sat, 13 Aug 2022 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=A1VNfuRWR8pma+kSe3R7cOA9ndnCA46Uj5r0k1c5ixQIqJD4HgAhxYwxVojTxwLPp1
         g805nv5YY5rNKr+zjRA6aUwgpvI/t+nZw7LoVxvruAUSi5vSQyWvO8xCjbsnM5jxVrFZ
         zdGlwGYs0f2GaMzRyYvwxtYFELcRfsi7jnQbueJNHRtm7AFY43OQQUSeKgl4kalNGp7N
         DY0DjFi6XbmZ4AkfUaEwwCs7wGw592Qfo3+cLy2Hen0a+k8GkvEiSaiD9DkARFrYEg4p
         Q+qVr7X8szy+id9Y2MktnjKcWdnsiVG+qHpxd7X+GqoS9kNjG7Y4KNm1ees5etf5i15j
         o5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=CFDJXAqvwMvACG8jPsn8fTq8/Ju6h9no9bAK+22FiF6Sy97MgjaqiabL0NwdlsSI6U
         WKmq0Gry7Xpzu9Xn8pM+nNKyEPXBMfbzluHLrxn2NdmQeMWsfgMiMbiA4Uh8PlsJOdV6
         mBIV8LhyMWW6rE1H3j13mT5z3SWJMGM2xew4KCauscqdJ1QhOfDOm8Pp+zE+MzqQNINZ
         rHqWyD8EN4D4wKLwCDDvIJ2UvrL6YwPFvtgB5qkZnjfTWGMKQdjIe4EGDjDQCs6pFGrL
         l4AZolWll9LuTbGmLzbnPpvf+6akwYuOIR8AvKYgd5CEoRc8TTOkm79E2sodSdN8GnqE
         Ob4A==
X-Gm-Message-State: ACgBeo1bgO7/gp/ev+3p/WsXMDLIwbw0jYWe3xL0Bymyr9l/TYU5b3Rm
        sUt6+qbAHuE4pE3nx9ZQiDdfn8InhaprC4Hd3ls=
X-Google-Smtp-Source: AA6agR6osWa5onEZ2IwEbI+/RoEuoWDQy1KNxhLGno3aVSqGepNOjZMSJ+NldIkxbP1u8GaB2iUWriHohDut5WHIk2E=
X-Received: by 2002:a05:6214:226e:b0:474:9a8b:3853 with SMTP id
 gs14-20020a056214226e00b004749a8b3853mr6655695qvb.85.1660387562433; Sat, 13
 Aug 2022 03:46:02 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: aliwattara123@gmail.com
Received: by 2002:a05:6214:21e4:0:0:0:0 with HTTP; Sat, 13 Aug 2022 03:46:01
 -0700 (PDT)
From:   Zahiri Keen <k78754399@gmail.com>
Date:   Sat, 13 Aug 2022 10:46:01 +0000
X-Google-Sender-Auth: Pb4XgoIwGHcj5tWbKnoiGaGQVqU
Message-ID: <CAHToVsLdp0ssJBA4Rt_5ByhSp9e8zdVJPENZV2dZdw_fF4T-jA@mail.gmail.com>
Subject: Very Urgent Please.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
