Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A1B691DAE
	for <lists+linux-pm@lfdr.de>; Fri, 10 Feb 2023 12:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjBJLKT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Feb 2023 06:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjBJLKQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2023 06:10:16 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E48C7101D
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 03:10:12 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b5so6111040plz.5
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 03:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w08RRSiGes/din6ZO5YkmaML7Zeo5YEC2K5kyi9SsfI=;
        b=efslVD1KrwPD0qBV3wNHrJUsqOiXUe7ZKDa8iavIXnG+0xedvqSHcv/p4LSBt58MMs
         oBoiFMNSuBqbKeULYyg68O8/N6qC6g0gjPRB0P6bTTOQLSb5C+Qy4o/L5k4p8tKOx3GY
         Ec8TYw2DHPWsK+JamIw6nxmUiPkYTx+snC0iYhFVCYx4fDH2Me3MqPlm1iJ7pmF23oDC
         9xyQBP0Pj3XYbuNlfiHkAdjYkZGvcEeXB4v+CVYTO+RS2x6Rzemt/0ERZpiP2RIf5eKS
         rBbfp83oqsuDTamqpcvhoYzCujdBPZs65yNKIC4tkwtdr8PEASR6SOwKZn9+DXAswyC1
         9KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w08RRSiGes/din6ZO5YkmaML7Zeo5YEC2K5kyi9SsfI=;
        b=pip34Zqirfz7HsGu0UoG5r13ZoI3HQbZQT4q/mLhAb0VsQZJ9hPJp4VlV14RWKxX8P
         mfdd6QFQaKnFQ3pydqDIekiiNAZQmQA9EBUL/vDBhlwY0+EHjnMiEQ44IIJMpnfMTatU
         VkRR30is0HGCHbf1/G2PQAL93my/0788crBX++ZRN7+YR1fK0ByRUCCqSqWo2CNE63sT
         Kmr8R57ygVv2HtQaD3ZvX50X16WOB82Y3PPYdhwc3JuRCGglSbSvmRQLT1GT2JPs0kRr
         aTTirnlt+xibWFu+IHGaEphjB7dRh+PeEmzIU5psbbrT2yTjBYvqSktf/YWOBeDaL7AQ
         1yAg==
X-Gm-Message-State: AO0yUKVVpttGXaQrpK3pgMzd175GNbdA+YqbfK8LY9zn03YEbonLk3BS
        mp4/qPDYqxzng1ngFmY+2mtVFHaXf65Ad5G5VGs=
X-Google-Smtp-Source: AK7set+sA/RIqlLoK8np+k0F7bcXAt+AIam8ihSU11SucSK2EISYHg0i+o4UnpkkB+r27IGBgsROspsp3RsX4scDDdE=
X-Received: by 2002:a17:90b:8c2:b0:230:e1d0:1eaa with SMTP id
 ds2-20020a17090b08c200b00230e1d01eaamr2594014pjb.11.1676027411886; Fri, 10
 Feb 2023 03:10:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:522:7a44:b0:4c1:9a1f:99c9 with HTTP; Fri, 10 Feb 2023
 03:10:11 -0800 (PST)
Reply-To: ahesterann@gmail.com
From:   Ann Hester <jw7025645@gmail.com>
Date:   Fri, 10 Feb 2023 03:10:11 -0800
Message-ID: <CAK-vev6ZFsFR0TAfc2i-6onw-aJR8bfQvRyrUiTnPjKO1_gRHA@mail.gmail.com>
Subject: URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

-- 

Hello Dear Good Day,

I hope you are doing great,

I have something important to discuss with you

if you give me a listening ear.so that I can

write you in details thank you as i wait for

your reply.

Miss Ann Hester
