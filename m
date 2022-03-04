Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E874CD7DD
	for <lists+linux-pm@lfdr.de>; Fri,  4 Mar 2022 16:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbiCDPdb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Mar 2022 10:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbiCDPd3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2022 10:33:29 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E037041626
        for <linux-pm@vger.kernel.org>; Fri,  4 Mar 2022 07:32:39 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id eq12so2140567edb.5
        for <linux-pm@vger.kernel.org>; Fri, 04 Mar 2022 07:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=VSEH8Q3Lr+Mcr/0lsL1VFPftJp7ALZ21MKYEz4sry74=;
        b=VhWUuXiYq4fMyydPuD4+tOqa4uZV0GnfFiNbsEyBzsGSQAymWSUuJiuPv3/bfGMzb+
         Ir3503xuMzl6IRHUQirCL8smYy6dSiwgZ2g76ntYIE9vbtq0mgh1t7POZJMpAZpacAUu
         W2RLSd7rqAQPIu1ndH2Gt7Tnzs9ZNzVJ2GD4AzhOF0zh/vaonlyQ77G+LfejcOCc7riH
         dkfndQWpzxBXs6VnMnYN4HgfllcxaSzymN/Dk9L2VbxolPcunibHloqaDKyb9CkWLtS1
         l9So7YDCTJb8cWu8mmpFjztyqgxTj0jXSnXIDrOwECauQPKqdXng/a3mNzkLmEK7okoB
         HxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=VSEH8Q3Lr+Mcr/0lsL1VFPftJp7ALZ21MKYEz4sry74=;
        b=s/y+Po2tCemNgpt779pn2aq068bx0p7OwmWmxlyBui/TZHIRqShQJE+rDqquCxRTUp
         Q+bh5KOLG7+d16sXZir1Lu6P5ZEbn6wHz5ZN91F4152bOm3RAxzFJFxA+qQHwZaK0gXQ
         sYf+Jw5x4m4noBh/TN4R6Yb/7765VJGF34909Yv8vuEI4jvElkVctYT7CCjuLyoRlKy/
         zJwX7QmcTEaiNxdXzexkmIH9DMSW4YS06mA71UM4CKXIzwDP155iVf/TMxF1XBvHH5sB
         BRi3hdTFM7VxsZDc+F47wspOYowRpd0S2l6iPmob431JvvvUsPdh4dAUSMI95xx+GG2q
         fzGQ==
X-Gm-Message-State: AOAM532swR3n81yp1dAP9rlOa4ahotvMzdiZ01k3Dg6+9NdoZIobzhBL
        dJNfQBSU3K1Z+8Jl6tp6pivwVgBWLcgISi/pu4A=
X-Google-Smtp-Source: ABdhPJwqu5AOBSoGCP5RoOGmEL9pJgzp+Px5HqqmmB4uSQ9T2MsWH+pgl8bj71RS+oa0M33TTIy0mGAyvz66WBslCeI=
X-Received: by 2002:a50:d7c1:0:b0:415:e599:416c with SMTP id
 m1-20020a50d7c1000000b00415e599416cmr7504064edj.37.1646407957538; Fri, 04 Mar
 2022 07:32:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a54:3cc8:0:0:0:0:0 with HTTP; Fri, 4 Mar 2022 07:32:36 -0800 (PST)
Reply-To: christopherdaniel830@gmail.com
From:   Christopher Daniel <cd01100222@gmail.com>
Date:   Fri, 4 Mar 2022 15:32:36 +0000
Message-ID: <CAO=CV9J7j46hj4cyG3NsM0WGGw_nLS6nWoh-qBM=XKm36+eqbw@mail.gmail.com>
Subject: Investment Funding
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
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

.
I wish to invite you to participate in our Investment Funding Program,
get back to me for more details if interested please.

Regards.
Christopher Daniel.
