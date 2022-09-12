Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF75B5ADD
	for <lists+linux-pm@lfdr.de>; Mon, 12 Sep 2022 15:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiILNIc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Sep 2022 09:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiILNIc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2022 09:08:32 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D90529829
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2022 06:08:27 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 9so9586400ljr.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2022 06:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=osSAgKM1j6DRNQcQXA842NXUQk2GubTJs0svjrfNTko=;
        b=dStm6lOrJO7AToXKpBAlpj8MbwpyjCgfRoc3/Tj19HyZapbdxxjbq+ByzUe83LZfI9
         0thg7be7zw5ttafOSGrOfkJIraXqmajGxzDqNrUmrAGtRCZGyJ8ERrCEOleGmlvChj9L
         EgtdLs8r5/jk6wgDY25X+0HJcpRHrMbcZDJ5Xh5GjfO5geWWVWNiPbMoOzkYc9K0v/1m
         /OaZ9qhxRvzCd/YuyxGcM6Rxrdp72Jo5yiYKCwvqtiRLrxX35RLhedPilqiXx9CyDdxx
         8hH8gAGdyRj/pPm15VWjylGwRsqQV0mCix3RzxWXyPtSNBPFAe+hIdEINpywOLIHRapY
         0sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=osSAgKM1j6DRNQcQXA842NXUQk2GubTJs0svjrfNTko=;
        b=5VuI5e60X6+1PFg6YmhZC17SSYg7roM3U2/L4JB3Jk/rxFDa0Ca2mWp8gfBrlTqyC9
         Tka55XtSlgLpeUAuiwZz/tTquHzB9SPeGnO1uYpsQ3zaEndjf/m5ebQFvNJjY+905AEM
         iOjKtmw4oQN1ottZj91KEIDwCitVPqoOzFTpTO1rZskAxfa6WKbW6LPz6q3lg7IEihSc
         VX2X0XdoGlzI0qq00H7RM0+zEiqBQ1bffKg4GpZipV8re5YgkkcrW/Os4o6geKT6M6gI
         V/OHfVMazM394u1mhSt0es+zG5Z7XQfDI8r/eBv7JReP41thuuhJk6NjRIL4ip0czcjM
         UsIg==
X-Gm-Message-State: ACgBeo10PEVz27Xb9eJvPRjLylhcFhLWsJadd5KHGbBjI3mx7hCi9S9M
        etMtKBCUl4nWUj+QklPYwWvUYQzMDPy36I9QPQ==
X-Google-Smtp-Source: AA6agR4p8uo6L7edF+yxAP+dKOVAvjGgi3vx3DvXqJqUPQjmVbWwEHgB8k/Th4amBJH9EPAczX8X+Vh8X/LtQXsS/jE=
X-Received: by 2002:a2e:a812:0:b0:261:8f2d:9530 with SMTP id
 l18-20020a2ea812000000b002618f2d9530mr7328907ljq.251.1662988105586; Mon, 12
 Sep 2022 06:08:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:750:b0:1e7:2f02:63f with HTTP; Mon, 12 Sep 2022
 06:08:24 -0700 (PDT)
Reply-To: michellegoodman035@gmail.com
From:   Michelle Goodman <michellegoodman035@gmail.com>
Date:   Mon, 12 Sep 2022 13:08:24 +0000
Message-ID: <CAPJ5U1-dGwzE6+3YLzd1Ea21Zgs7Oh8qJF3Z8aoLQUbSWb5vQw@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten

Vielen Dank.
Michelle
