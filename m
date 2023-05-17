Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E22706D52
	for <lists+linux-pm@lfdr.de>; Wed, 17 May 2023 17:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjEQPwi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 May 2023 11:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjEQPwV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2023 11:52:21 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313209EC6
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 08:51:17 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-561ca1918e5so9466577b3.1
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684338674; x=1686930674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/BiToevvpXZU69/oSETGaqYlCzMkDhIUSch995c2x4=;
        b=PxKg2pRCl/MeEqp5uvc8FI6+YOF8ZQ0EzboQ7hpfbuFJX3IIqChekL0/PSY6f6ZBkZ
         urHQTw8B9Qu+ZY/1vJzTnbXCr75YfIhdSyy686/eLISuhgZHB6UQ3EVsl6FD9v625A/w
         tjxES+HrRzg6bCh5g/2aKxK6aL5WAXk6n5hL6cNQ4DLvHOdkJN6i/f12VZINOcSbVDWY
         Ht8TqiZDvyXTZ0hs/EBmu3kHn7bK+REyjKbHcdjwjITX645yBU2SclzoGsnZb8Qs2uwx
         3eg3Vv2wpF9jKUnxeZFE5DWnz2u2DGzEAq8Ck0m/CDBEkeEBn1RCKj2gBMDNc7cK4SzS
         DFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684338674; x=1686930674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/BiToevvpXZU69/oSETGaqYlCzMkDhIUSch995c2x4=;
        b=btpzdDgHoWWtgK+ECwOznIhQLbtIt4t8N5E+L/NGuuNpEJdHmvbrbGnxXqIxG0sFaY
         +IPnRE4oM/Qbc//kIOuvTpk/luXT33TWpOnjem3nNpJyMvuf9+cOLUsBTPgy5DIVRD5+
         IUt9SIEqjkzBgA0uFkXHSRLEwOPqp15aFfu6zVLEBucdV35zWBus8+lzQH4loA5smTsa
         rkCRjvHrCKBMpCQvXWA/ZJGxZZb4IFaLOfPxVb2o6aeHy2cM/ovhWEy7t0Ua2sFwPDbx
         GZ8+9H/ldLTpET9ltyzleLuq02sSyYtrfzHhPPJ0t7zdbMw01Z/43UDdk5UPBfpLQD82
         835w==
X-Gm-Message-State: AC+VfDzgNK0BF34LVecwfvkFp/xqARfEHxp1wqYdgb7UNrAdjyHBM0ny
        gk+X6Bl2EY9t/mKDbMKFc9dzW+WISS8iNbJZBQGm
X-Google-Smtp-Source: ACHHUZ7m7iuWUD5omxnx19xTgvLnN/+5Wgfo2oM56GLLAkTkIZomD+UUzUvvSVfeDFHavflonxguaAqx7fdYrFqY+DA=
X-Received: by 2002:a81:53c5:0:b0:55d:c2c3:fbb8 with SMTP id
 h188-20020a8153c5000000b0055dc2c3fbb8mr34245755ywb.40.1684338674184; Wed, 17
 May 2023 08:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230517131102.934196-5-arnd@kernel.org> <e1a07eed22cb33af2733bdffe42b09f0.paul@paul-moore.com>
 <83422cf8-5d77-4e2f-a854-c2b9a9a94d75@app.fastmail.com>
In-Reply-To: <83422cf8-5d77-4e2f-a854-c2b9a9a94d75@app.fastmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 May 2023 11:51:03 -0400
Message-ID: <CAHC9VhQZyxVhDb0uB-+q7H=e++yq0qEAZGssPjepgnZ3i3_pnA@mail.gmail.com>
Subject: Re: [PATCH 4/14] audit: avoid missing-prototype warnings
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Eric Paris <eparis@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        audit@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 17, 2023 at 10:51=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
> On Wed, May 17, 2023, at 16:33, Paul Moore wrote:
> > On May 17, 2023 Arnd Bergmann <arnd@kernel.org> wrote:
>
> > We probably should move the audit_serial() and auditsc_get_stamp()
> > away from the watch/mark/tree functions, but that isn't your problem.
> >
> > Anyway, this looks okay to me; do you have a problem if I merge this
> > via the audit/next branch or were you hoping to have this go in
> > through a different tree?
>
> Merging it through your tree is probably best, Andrew can either
> pick the ones that nobody else took, or I can resend the rest.

Easy enough, merged to audit/next, thanks.

--=20
paul-moore.com
