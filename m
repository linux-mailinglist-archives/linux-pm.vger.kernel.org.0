Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42B27DDB7F
	for <lists+linux-pm@lfdr.de>; Wed,  1 Nov 2023 04:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjKAD0a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Oct 2023 23:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjKAD03 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2023 23:26:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE63F5
        for <linux-pm@vger.kernel.org>; Tue, 31 Oct 2023 20:26:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9adca291f99so930576566b.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Oct 2023 20:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698809181; x=1699413981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Z+lhn55caLP7TtRoVh2z9H+OCXVdsgSBhRJz1eTMhQ=;
        b=IuYP/Q7uvsHh8opI6MqT6UC/3dNc7kbx+uJfbf5i0oN0XRl8KB3rz9GirobHGmA40Y
         vgu9JO0OaQi96qNl+BL3xD+pcPcNoxTHl6rtzGYaBhgkvzoF8mT7Uo4kZyHXQ8xpa3Lf
         4jZ9oIfAD2byzI7luF5tQ3atL+hdAbjjf5PB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698809181; x=1699413981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Z+lhn55caLP7TtRoVh2z9H+OCXVdsgSBhRJz1eTMhQ=;
        b=JMv/RY3tp1NTPN1w6Q7CFtfxMcH6oyrQbFANADEsNk2zL0aDBzTxyCAkiGOH4p3KuI
         x4hzcgUp1V9+WPQf4ZyXx9VuTRKnE0hcPP++4Kt2XseKYkmy4lk2bhh35+vVSEDrixgH
         5n1YXTDVz+SkfZu3sdl7nFhXy7GIB20u2pNOABB2TZOw4A37s9+sx+5S8Mr91y7tkBk5
         mp/3bU+MYTkq09oQRBZnv5Za3nOFM9wT5JKksMtdc8ECLZ0GThoQCXBHFK1JiexjA1Qq
         DTnGxfz0py5yKgY/VY5jLgRMPoiom9XhGzNAX4T+8zHd/qNB13LnmycSoupSEpbc/Zhh
         gSXw==
X-Gm-Message-State: AOJu0YwZZJd6HlnpEoJ8JKnF+/AhrgIfnzCe9y/EhWTDfHWlvXHHkTnZ
        V2aDXtfU8n8nOo/aogKuVP5HoYr2dle1OAHVB5O0KA==
X-Google-Smtp-Source: AGHT+IGkFqQLfpNz2TKIKUHQuAR61ADZyW4xit9XzyyJz3r7Te1xjPm45wEjd4BsjzQ8C51Mu/SoEQ==
X-Received: by 2002:a17:907:d21:b0:9c3:bd63:4245 with SMTP id gn33-20020a1709070d2100b009c3bd634245mr873398ejc.47.1698809180847;
        Tue, 31 Oct 2023 20:26:20 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090611cb00b009b27d4153c0sm1862372eja.178.2023.10.31.20.26.20
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 20:26:20 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso684657766b.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Oct 2023 20:26:20 -0700 (PDT)
X-Received: by 2002:a17:906:fe41:b0:9b6:aac1:6fa5 with SMTP id
 wz1-20020a170906fe4100b009b6aac16fa5mr914782ejb.55.1698809179717; Tue, 31 Oct
 2023 20:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0iBWcy2LyeXE0vxqKZOWBK5yWgofktygEvo4B3=6J8Wjg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iBWcy2LyeXE0vxqKZOWBK5yWgofktygEvo4B3=6J8Wjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Oct 2023 17:26:02 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgYWb+LtHvQM+ULLWjfOLnfGcuDXNLrefEQbwCu=7apGQ@mail.gmail.com>
Message-ID: <CAHk-=wgYWb+LtHvQM+ULLWjfOLnfGcuDXNLrefEQbwCu=7apGQ@mail.gmail.com>
Subject: Re: [GIT PULL] Power management updates for v6.7-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 27 Oct 2023 at 03:52, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Please pull from the tag
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  pm-6.7-rc1
>
> with top-most commit bf224871c27a7c7e2146d667176977ffe3752750

Not sure why this didn't get the pr-tracker-bot attention, but it's
merged, so here's the manual version,

                Linus
