Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941F6563CA6
	for <lists+linux-pm@lfdr.de>; Sat,  2 Jul 2022 01:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiGAXFh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 19:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGAXFg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 19:05:36 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74236D56B
        for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2022 16:05:35 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so5359081fac.13
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2022 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2AFvyrObCHkvwVcACFedAi4cW+Lxc7JfD/cB4klOo0k=;
        b=KU5AH7wyPloGY7DmdCG/+/yg6R1ziE4xLF4VEghfu0kGtEOQnudneqeSxPPbhsyH1W
         /zCl9V/oy0L/WjtYIZAX5X355HtdtR6v0SBC+LO6AsvI387UelKmKw0KfG/kY9QkU+Ab
         IPaPgiGeLFslgq4wJIRYc6qt6cckORrDDyRwaMRr4OdRbRCYFDy9d/G0+/iVMPfsfqhi
         Aa8j+H+Bf4gNu4MoMzWNwHeiBjVr/DuBLj4HgeizSXKIlD2R1nt09ma2mXEa/1p9iA3y
         MAk6QZjjBpxa4pSZOg9IH64U56QuR/s8Ql8z+pVd6bv+EXUeXWukf9uAsjgp2TZ309oa
         LIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=2AFvyrObCHkvwVcACFedAi4cW+Lxc7JfD/cB4klOo0k=;
        b=s9I9GRqY3SK8bNn+hiCHVprFlRNohHaW/RX6lL0NoiO1E7z07l6w8Gr+Mcwx4SykEt
         DZ9KHYsQGhupTWKPL2Yxx0/ivHZAazy01y4rbUSdsG0gwIr1uX0EZZypYJtI7tGFRvaF
         x4HQKz4hYvhHt47A3YfYCX42lQwIsChbjRmJaQV5bzjWh5GF3enY2lmo79ltThH2ZKHz
         b8JkC1bxdTAgoOVznxNo0FSq/xryMrfmjrbB+hLYc4TqITq1S82+affmc80W00qeuvwm
         OqGtV6uXRGG2/Cg60sVuHYRDHYYl8Eica0QwBIYbmxJHCTzb7ApcY2N0149QdkFseYeL
         F3tA==
X-Gm-Message-State: AJIora+PCVZ3QHurdWUgqzs14c8sCgxSZ6rJ0/nKVYoPOt3yBcWSNdOV
        yLlg/ryYeGnge1GWnMMdU9jkDh2mdVnznMFGX2s=
X-Google-Smtp-Source: AGRyM1vBZgcmyjrPQIoCKBPqsFXWmvJ6yYrhxzcc91k4NvK5mxjtlzDP71XqN+c3nggBJMZQlMLFsHC8UTz+EYVmBSg=
X-Received: by 2002:a05:6871:4487:b0:f2:f273:ad3d with SMTP id
 ne7-20020a056871448700b000f2f273ad3dmr10568047oab.138.1656716733893; Fri, 01
 Jul 2022 16:05:33 -0700 (PDT)
MIME-Version: 1.0
Sender: 1joypeters@gmail.com
Received: by 2002:a4a:ea8b:0:0:0:0:0 with HTTP; Fri, 1 Jul 2022 16:05:33 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Fri, 1 Jul 2022 23:05:33 +0000
X-Google-Sender-Auth: _CH5OkpCieoD1pWxccpe1XzoWn0
Message-ID: <CA+F+MbZ4C7VRY9ry=6ce=+hv=HkUdYfaaNU+iKuvLoeEpUx7Rg@mail.gmail.com>
Subject: Please need your urgent assistance,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:31 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5039]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dinamckenna1894[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello My Dear,

Please do not feel disturbed for contacting =C2=A0you in this regards, It
was based on the critical health condition I found myself. =C2=A0My names
are Mrs. Dina Mckenna Howley A widow and am suffering from brain tumor
disease and this illness has gotten to a very bad stage, I
 married my husband for Ten years without any child. =C2=A0My husband died
after a brief illness that lasted for few  days.
Since the death of my husband, I decided not to remarry again, When my
late husband was alive he deposited the sum of =C2=A0($ 11,000,000.00,
Eleven Million Dollars) with the Bank. Presently this money is still
in bank. And My  Doctor told me that I don't have much time to live
because my illness has gotten to a very bad stage, Having known my
condition I  decided to entrust over the deposited fund under your
custody to take care of the less-privileged ones therein your country
or position,
which i believe that you will utilize this money the way I am going to
instruct herein.

However all I need and required from you is your sincerity and ability
to carry out the transaction successfully and fulfill my final wish in
implementing the charitable project as it requires absolute trust and
devotion without any failure and I will be glad to see that the bank
finally release and transfer the fund into your bank account in your
country even before I die here in the hospital, because my present
health condition is very critical at the moment everything needs to be
process rapidly as soon as possible..

It will be my pleasure to compensate you as my Investment
Manager/Partner with 35 % percent of the total fund for your effort in
 handling the transaction, 5 % percent for any expenses or processing
charges fee that will involve during this process while 60% of the
fund will be Invested into the charity project there in your country
for the mutual benefit of the orphans and the less privileges ones.
Meanwhile I am waiting for your prompt respond, if only you are
interested for further details of the transaction and execution of
this  humanitarian project for the glory and honor of God the merciful
compassionate.
May God bless you and your family.

Regards,
Mrs. Dina Mckenna Howley.
written from Hospital.
