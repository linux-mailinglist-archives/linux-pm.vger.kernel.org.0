Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B034D7186B3
	for <lists+linux-pm@lfdr.de>; Wed, 31 May 2023 17:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjEaPtY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 May 2023 11:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjEaPtV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2023 11:49:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09E0125
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 08:49:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-25676b4fb78so2292371a91.2
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 08:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685548160; x=1688140160;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGuPs2HAW5Kc9EAlBZmlCe2PoQii+LuASoE3r9n3wKk=;
        b=gW95w+l6CuBmKxEZGzwSJSJ75u4xSmWtE+9eG+sOPythFhqhizzKZfZUWdDNtVu133
         Vic6dc9A3lAr6Gym0NEx2W6cGJY5b/eG07RympiFcJ2VKC3rRTBGQdRNIgQz84BDj4nJ
         5gahzZp1rB8b2rZO2Eu7dMlMo+AV0xNydu6jpyCRtUwqw/2sBi9yvyn2R3IGPR0ttV9M
         OwlPNMN2Xd009J5KoLVHNR668r/ZYa6NVXp9jhPQfm9a0KpMRsevVMuYDJffw5idxpbm
         0mXjjDPKQ+Xgf+NkEOqZd5Iqxqv9MiOyYUFt78fvrgrba/wzxSnZLsm40kua/riijl0T
         IqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685548160; x=1688140160;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGuPs2HAW5Kc9EAlBZmlCe2PoQii+LuASoE3r9n3wKk=;
        b=OaLndt4QfR9D1EUzCoySVAn29QdIi1r4C5ow1+9XfkxyOMcrtCac+pTCFX8tyHScoP
         6ZG7FztVIbY2fuiu+1izdpH9R3r3EyCmdRicPhvTd7y1cxsSavAQrY2X9HGoLY9ypX+l
         NTDyBOvKMVUyc4Vp0dFmVHyO8+9Wyx+PprkMs0EVsB4aVbSeT7WouG3YCZ3MEo4SMlm9
         aPTaTOLv85Jl1OCDSKIWI9qYRVZ0coVoHGNjIqxJ/lTv3z1hCC4TNffdbmwp0ijAgNac
         WlQV+Ux/UrTtZXjVa9cQ3zV5jXsV+j+KT+NtMbNV5oRcQQBMltQLrPzri+/2Wx5EhfJf
         hY6A==
X-Gm-Message-State: AC+VfDz08K7OPH7ugu8Q3MZ/8kjb32ZIcQGb00TwYNmpVWPJ6V+7Sluv
        tO0gIrDEJ3bZ4elIjYNpQ2HUlYuF+TuH2WwlcRU=
X-Google-Smtp-Source: ACHHUZ7U3IpmciYFn2XUD0tH0OIzOLl4ra5iJXVK6fWz/P9G6WairTUjZ8Qpz9Ea+PuBP18St9+V1vMwbBNiOq+dlv8=
X-Received: by 2002:a17:90a:5081:b0:256:82c0:8120 with SMTP id
 s1-20020a17090a508100b0025682c08120mr4791045pjh.13.1685548159896; Wed, 31 May
 2023 08:49:19 -0700 (PDT)
MIME-Version: 1.0
Sender: mrselisabeth.peter77@gmail.com
Received: by 2002:a05:6a11:38e:b0:4a3:2ff8:7a09 with HTTP; Wed, 31 May 2023
 08:49:19 -0700 (PDT)
From:   "Mrs. Lenny Tatiana" <mrslenytati44@gmail.com>
Date:   Wed, 31 May 2023 16:49:19 +0100
X-Google-Sender-Auth: bX9J7hlzwM1JBIXx6XJU4iMH074
Message-ID: <CAErHXnkq4VYEHV_FOyXFmGj92g3Zf8jhd6jujyn2rhfA_SBTvQ@mail.gmail.com>
Subject: Greetings dear friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,
        MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,RISK_FREE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1041 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrslenytati44[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrselisabeth.peter77[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 HK_SCAM No description available.
        *  0.0 RISK_FREE No risk!
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Greetings dear friend,

Calvary Greetings in the name of the LORD Almighty and Our LORD JESUS
CHRIST the giver of every good thing. Good day and compliments of the
seasons, i know this letter will definitely come to you as a huge
surprise, but I implore you to take the time to go through it
carefully as the decision you make will go off a long way to determine
my future and continued existence. I am Mrs. Lenny Tatiana aging widow
of
57 years old suffering from long time illness.I have some funds I
inherited from my late husband, the sum of (19.2Million Dollars) and I
needed a very honest and God fearing who can withdraw this money then
use the funds for Charity works. I WISH TO GIVE THIS FUNDS TO YOU FOR
CHARITY WORKS. I found your email address from the internet after
honest prayers to the LORD to bring me a helper and i decided to
contact you if you may be willing and interested to handle these trust
funds in good faith before anything happens to me.

I accept this decision because I do not have any child who will
inherit this money after I die. I want your urgent reply to me so that
I will give you the deposit receipt which the SECURITY COMPANY issued
to me as next of kin for immediate transfer of the money to your
account in your country, to start the good work of God, I want you to
use the 25/percent of the total amount to help yourself in doing the
project. I am desperately in keen need of assistance and I have
summoned up courage to contact you for this task, you must not fail me
and the millions of the poor people in our todays WORLD. This is no
stolen money and there are no dangers involved,100% RISK FREE with
full legal proof. Please if you would be able to use the funds for the
Charity works kindly let me know immediately.I will appreciate your
utmost confidentiality and trust in this matter to accomplish my heart
desire, as I don't want anything that will jeopardize my last wish.

Please kindly respond quickly for further details.

best Regards,
Mrs. Lenny Tatiana
