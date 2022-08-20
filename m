Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A0959AA60
	for <lists+linux-pm@lfdr.de>; Sat, 20 Aug 2022 03:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244779AbiHTBFZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Aug 2022 21:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiHTBFY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2022 21:05:24 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6F2109758
        for <linux-pm@vger.kernel.org>; Fri, 19 Aug 2022 18:05:23 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g129so2361324pfb.8
        for <linux-pm@vger.kernel.org>; Fri, 19 Aug 2022 18:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=GyIdygXpERIYq0zhovmgdDSjsG4Trhk4Rphv5GwxReI=;
        b=dpJO8IsVYlw6EOWvTEA1nYM74M/9aZkQc6b7f/zCjIDv0NAMtMTIZBOCgynlzXn5B/
         AGSKM8FDuwGxiWg36tbZc6C71SIQfkXXck4AVgactj6E4e3FuBk8GeXbqzbHkcdyX8CU
         pVdrRQj8hACBD7sPWHC4vaqvMAAYYnjAxyi8K3h/iwsCie4Ca23p9dFLAWsbS1pnsefR
         AfLpRxuoWpmmfPEvb0jdQih05r4dJE9lKLeyRT/f8bRiQmhcIfO+cgrZ/lCXijp7I6Vl
         9RgwlDxswqAdKBE92jvLu6ABAcSt2qrWIsaAWi8o4+cLuwcgRzqRv8QKUU7Zbbxf8Dpm
         PJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GyIdygXpERIYq0zhovmgdDSjsG4Trhk4Rphv5GwxReI=;
        b=FdlIYx6fShCFvNs574Io0JAC0pPJCVdADnku3jYwngKC01aFcGtAJLOaXkYYaijZUy
         /b2NpacBahy9XPs/SqR9bRxBJFtGj2sRMV+y9kf8iyK1HIgYzT0huJ94l2DRntnwnWZR
         pKgEbfbRuL1PbKKiNhpwNLpbgLoVETFueeM7eQPCUT0o2zTQzWxkOVQCtpAUxNOidulf
         n9V2CyDc0gOJCYUJmSpsHIuoBjMsOHExWQvNBreOfaYZktZKOWCCm1EbyhX1oVnLRsCF
         VsKZ57bJ1wcvgwPEcn2qBBx5BUb6Lgk/HoWUvT1Ar9P/DnW/qSKj9hImWxdkgsJ8PmwX
         bc0A==
X-Gm-Message-State: ACgBeo3gClhNx62umbzBDWxsLKh8ZeBx4CErk4ub57ZS/Tm4AZEj7pUK
        xEZLY4tFuKP9aVg4SjsQ9o4UpKCZREGHPcl5T2E=
X-Google-Smtp-Source: AA6agR49oMRG4dv5YLOBI9Zqh4LJj/XFGflYKNkg/gFlGVcAREYuQ/FYUGnPZjm3FBVPKwcqKwal+4mNkmg1x6L+8Uw=
X-Received: by 2002:a05:6a00:140d:b0:52a:d561:d991 with SMTP id
 l13-20020a056a00140d00b0052ad561d991mr10470802pfu.46.1660957523315; Fri, 19
 Aug 2022 18:05:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:d4d2:b0:16e:fde3:172d with HTTP; Fri, 19 Aug 2022
 18:05:22 -0700 (PDT)
Reply-To: aseanvietnam55@gmail.com
From:   ASEAN VIETNAM <yawoarouna@gmail.com>
Date:   Sat, 20 Aug 2022 01:05:22 +0000
Message-ID: <CABoxYe0shsKh8HH_Q8eQ=PgHCLBjjysp+pnOZwARzFzz=O3f8w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--=20
Hello,

You have an important message get back to me for more information.

Mr. Le Luong Minh
(Ph=C3=B3 C=E1=BB=A5c Ng=C3=A2n kh=E1=BB=91) Deputy Department of the Treas=
ury
Vietnam.
