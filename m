Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC366EC483
	for <lists+linux-pm@lfdr.de>; Mon, 24 Apr 2023 06:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjDXEs3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Apr 2023 00:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjDXEs3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Apr 2023 00:48:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F702D50
        for <linux-pm@vger.kernel.org>; Sun, 23 Apr 2023 21:48:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24736992dd3so2631446a91.1
        for <linux-pm@vger.kernel.org>; Sun, 23 Apr 2023 21:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682311707; x=1684903707;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=S4MWetVyGuJkR+d2b+kETuR4GYLUQPumm3RGwW47pRXQFQOdLJT3+LLUxm17PBTJXE
         C0bYbI64FWeQ/yT8FygGREvqUm3QQ/zjWDMJs/4QE55jDPon2nR6Nm8Q08UAzIsXw/iy
         A/qMAu/+q0J/Jj4CLpdC8yjnSEIrFk6uQubGvqbgjDsruaSeaew6Ap+UhqZzmjvWjk9I
         aCRnfVP5fiGGdWRV6fRFx/WguBhuFsOg8/MvvMIjS6c+gOuOqluL12bzxAU2Ac+9O2to
         5/T6O+opC5niw0hh8v4g2B2MUz+/R3MBW5+5ANBM7s6tqFzymT0BkiqtRaTXcfymPbnt
         tQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682311707; x=1684903707;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=kb6tThx/uIo9BpTl0/IVtsaFAgBLdOQQvt6julvNB1QvAlE1Ut56TM8OX9vaUAjHtp
         ybOfuMUduw2akNqa2z9sK55UveMFo889IyAxs3uulaUFJSqifSONbYJBQbI84XD1BOSg
         3hcisyyRjL5CUq/LM0c153qog04WmWqeFbppdsj5QUi0Md5h0qv++/sXkDYchMSZXggq
         2aJT26JtU3vziaGXWzN6TWmdelaNl3AZy0S9QTHbBUgynd3FK6U1DJ7a8Ps5ajW7MPHu
         TThGBxFsaGdxeVOah/HfHgTTKz24ZNqEWQUIbA4N93ms9QqilnkjWyVN9WBsHIaYdI2h
         yYNw==
X-Gm-Message-State: AAQBX9fhdHxhb1n83EjsrOxbSS0jYmhlVVh2JYPy11kBqG5pO6BoRmZC
        a8TbBubslRSFe32z6cPM/6wLT0s5HkyfL9XpJpI=
X-Google-Smtp-Source: AKy350ZoU4KjhhZ9bPPVymKEBwfYeN78cJHFsMrwLq87pewV4tMsahjBH7xnnM/ELOxol9uZPb8MmhASER0FLWBXiek=
X-Received: by 2002:a17:90b:4d91:b0:23a:333c:6bab with SMTP id
 oj17-20020a17090b4d9100b0023a333c6babmr11588222pjb.23.1682311706870; Sun, 23
 Apr 2023 21:48:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:234e:b0:49c:a5fa:37b5 with HTTP; Sun, 23 Apr 2023
 21:48:26 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <ninacoulibaly004@gmail.com>
Date:   Sun, 23 Apr 2023 21:48:26 -0700
Message-ID: <CANcht-S5UB0CB3nXVDvrxwLeZv1bWbFSPSDtZ3uw_3kPuoq9BQ@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear,

I am interested to invest with you in your country with total trust
and i hope you will give me total support, sincerity and commitment.
Please get back to me as soon as possible so that i can give you my
proposed details of funding and others.

Best Regards.

Mrs Nina Coulibaly
