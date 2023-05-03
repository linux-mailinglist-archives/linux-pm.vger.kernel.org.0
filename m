Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725B26F6059
	for <lists+linux-pm@lfdr.de>; Wed,  3 May 2023 22:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjECU5q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 May 2023 16:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjECU5p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 May 2023 16:57:45 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C028A5F
        for <linux-pm@vger.kernel.org>; Wed,  3 May 2023 13:57:34 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-61b60d0c5b8so14777166d6.0
        for <linux-pm@vger.kernel.org>; Wed, 03 May 2023 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683147454; x=1685739454;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aEWlsfNSaHivuvKCXmCc098S+ABIR70t/k+CsvM7IN8=;
        b=YjLZyIlp1g7VdpQO15cs5sJy2uRdZvkIsAz7UkZeQ4pXxILweLRkCJ2jlZhuchlYUf
         eQvDfJI7nh/aUKDtYKRDJ9XJFFRd+CCBLpuK6GGKRetqzYJMMhhY4FoD9kegjAVPfkH0
         n31u40eJ28NWjosI0B8AWEogcuH8rgnzdvVZC+fKs5tNHC3WVrURjFKjZrIEgrKpEmj7
         4o/VHHsOakxw4nWR/BFaxhosRIVHgCC85Uh7F60/MFPcWk+lqHl0Bye1DPPnggdisaF/
         SooOsfJoqh+MdYFDxn6gn8Kelp5wdL4seT8kRwW/PGOviF+07BPT0XRlt0wSeo0P3IJf
         YsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683147454; x=1685739454;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEWlsfNSaHivuvKCXmCc098S+ABIR70t/k+CsvM7IN8=;
        b=dHBJ0VXb16sEJoufkhprQvxZ3QqOOpqGCxH8lslc2Nj5mgOnoW/s+xEbcTx5I9bEms
         g0ysYN/xJL25w6uYeVHH5HHOS2BtazUbTn4FK5/1HKBSy5khXtfESu0BHYTf4L4E1fBI
         RIlAApK9Ye+fFim3jxZpAP+TSt9HR4pDT/fHHk255cF2f0teRjz1VTmLLEUImKjC+wfl
         LAv/mmXvtXW6lFeUVsRCRxV2DLukS5FXTo3zfbxh3uyPWQdSCTTyk0BgQC1uPSYuFVQf
         bEKFzeribxozBqMMhLGPrbYuZ3F1ZArG4jcU/WsES6ncT8KR0jvGjyfoT+0KYRi/ZReT
         oflQ==
X-Gm-Message-State: AC+VfDzjqH1NkBh/i3dIjyDq+KGCJTBH9q5Dt7Ln7VFAc5HXbweo4bqd
        qxiD7YcoFPunm2uUEPrkqQnvTGPhMrdevyW6G4Hecu7/
X-Google-Smtp-Source: ACHHUZ4zBo9mKNnZ5Q3yhQN2djQu4klt70Gd1x8O4J/iLmNpUBHYg++GnFl52UHBzXTzWJcP0jfo6y/On8dtU1viDT4=
X-Received: by 2002:ad4:5f4a:0:b0:615:a787:6d2a with SMTP id
 p10-20020ad45f4a000000b00615a7876d2amr12459700qvg.3.1683147453267; Wed, 03
 May 2023 13:57:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:e1c8:0:b0:5ef:4eab:adaf with HTTP; Wed, 3 May 2023
 13:57:33 -0700 (PDT)
Reply-To: mrsdominiquethomas7777@gmail.com
From:   Yonce Watson <yoncewatson5@gmail.com>
Date:   Wed, 3 May 2023 08:57:33 -1200
Message-ID: <CAGK_q1KkBE5=TeKjM5ytRELyWg9uUDMfinMHJbDRs_h1UJYVBw@mail.gmail.com>
Subject: PLEASE I NEED YOUR HELP
To:     annetterose702 <annetterose702@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.6 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_GM,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With warm hearts I offer my friendship and my greetings.

I was compelled to write you under a humanitarian ground.

With due respect and humility, I=E2=80=99m sincerely seeking your confidenc=
e
in this matter which I am about to propose with my free mind and as a
woman of integrity.

My name is Mrs. Dominique Thomas, I am 67 years old widow, I am
terminally ill, suffering from long time cancerous tumors, but now
undergoing medical treatment. And from all indications my condition is
really deteriorating and my doctors have courageously advised me that
I may not live all that long; this is because the cancer has reached a
critical stage.

I have some funds I inherited from my late loving husband, which he
deposited in a bank in Europe. I have decided to donate the funds for
a charity project in your town. Because, I shall be undergoing major
operations in less than two weeks from now, and my doctor have said in
confident that I only have 35% chance to survive these operations, due
to my critical stage of the cancer.

I took this decision, since I don't have any child that will inherit
this fund, and I don't want in a way my late husband=E2=80=99s hard earned
money will be misused.

If you assure me that you will use the fund for the intend purpose, my
heart will be at peace. I don=E2=80=99t know though, but I believe that God
Almighty will work through you, because, it is usually through someone
else that he meets our needs, charitable and indulgent to everyone.

I await your response.

Yours truly,
Dominique Thomas
Email:mrsdominiquethomas7777@gmail.com
