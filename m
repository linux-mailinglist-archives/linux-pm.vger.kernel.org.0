Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD925A44D1
	for <lists+linux-pm@lfdr.de>; Mon, 29 Aug 2022 10:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiH2IRA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Aug 2022 04:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2IQ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Aug 2022 04:16:59 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C9D50067;
        Mon, 29 Aug 2022 01:16:53 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b142so5946689iof.10;
        Mon, 29 Aug 2022 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SR2zs66VfZ+7cR5z7A6IvTd2O6F2fkE2TEOJvg0bu0I=;
        b=PTiQgniWppKvxkEzmd65ZhoEsm6L8mv1pdTOpYZYU0um2dXu20/Ay0lDQZhlb3y7YV
         Z6PrrCJid38YfRz/WBeg9z+M+MgKo2emiGXW7xNTpmnapY2372F06UOxTa8L0IalIx2E
         XG8ccXtuMXVBc6b2RUop8g659t17ZKYoX43+E9LyrD0eao3ydclhyqH1iOfLwMGssORl
         QhUwG0jExizZ3Vd6E2v3Vw7mH+6VbVqhAjFmQnf10oPCcNz0BHn8SKJo8UAg64RLr9G9
         wU6Mw09FG3hk7EXhiaFsVfExIr66P0WWArwI3M9KB8ei62rxRzyLXyPbDHHuqGWbrH/j
         M8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SR2zs66VfZ+7cR5z7A6IvTd2O6F2fkE2TEOJvg0bu0I=;
        b=eGLrxQwOKF3cYJlt7XjzpgaNEV36OoJO2O8LpRGepdi2D0/4Q9NDSa7EDpzfwQvHWh
         YP1lghjxN7Mv/YsqeOUgqPlPFYyaF7OWVoHDBCwKEqs6CWIkkiVzZQyAs/SyeelcvbHE
         I4O4bNg02qMJzCz2auH9FYOVkoUZ+8y7+KG4kR71u/608ClfMCgGhXbZsnRPVcu0neq9
         3ZNhnv7pZV3lqyTvcO3GTr5LJ853Zk7FFPaQ04xji8KtvjpXRjJP1FI6rfTst7EA8rUI
         X+Ee/dIJnTK4IdhbsF5tQJCBcfzniVhpRRZ7BxAVeX7iquyxUddQ+FfzmcV7jj4UgPkC
         18Cg==
X-Gm-Message-State: ACgBeo3Pa6wCI//JR9afVgews4BF8AdyeMimTPMDayPQS+0EQiVbjdBQ
        g/bDlCysTjODc0v61h5Ut66iRt0dzoQjA5I096U=
X-Google-Smtp-Source: AA6agR5w+knSfmVPltVfcUUnZ62s8C1vDjkSljRB9xvXicYviWK7mE+Hfygcmzi/6VAoy72EtqSMkaAc7FqcDgPzgQI=
X-Received: by 2002:a05:6638:4117:b0:346:b5e1:383a with SMTP id
 ay23-20020a056638411700b00346b5e1383amr9940873jab.264.1661761012858; Mon, 29
 Aug 2022 01:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220828192920.805253-3-lkml@vorpal.se> <202208290605.gE9IGbxE-lkp@intel.com>
 <90ae872b-9da6-f5a9-56e0-5a61fe3b84ed@vorpal.se>
In-Reply-To: <90ae872b-9da6-f5a9-56e0-5a61fe3b84ed@vorpal.se>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 29 Aug 2022 10:16:41 +0200
Message-ID: <CANiq72m+PnnVojGx_swBaNF-zVv0XGyXbPn5C71h06jHsTeUpw@mail.gmail.com>
Subject: Re: [PATCH 2/3] platform/x86: Battery charge mode in toshiba_acpi (sysfs)
To:     Arvid Norlander <lkml@vorpal.se>
Cc:     kernel test robot <lkp@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Azael Avalos <coproscefalo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 29, 2022 at 12:50 AM Arvid Norlander <lkml@vorpal.se> wrote:
>
> It would be nice to see these warnings locally, anyone know how to turn them on?

Compiling with W=1 (and possibly with Clang) should show them. Or
doesn't that work for you?

Cheers,
Miguel
