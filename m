Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B901871681A
	for <lists+linux-pm@lfdr.de>; Tue, 30 May 2023 17:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjE3PyA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjE3Px6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 11:53:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC6FFE
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 08:53:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-25695bb6461so1232026a91.1
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685462022; x=1688054022;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WNArju2Q8+Sr5dwcNQgGMkuM+vdAY/tBFjavnfU7aAs=;
        b=m6P4SpRmIhLWilK2bwoWEMQsEWk/K6yhndm14R57q2fmXCIxmQD0hmLtubyT0ltNsD
         5mzb/C0TgKgAvGKJRMLkGevN9ywiUjPUBVA17GMkjuXksQd7uKuMPAsayxRi957MlXgz
         VF+5Lk9yteg1zp99/PHovVO1luQYBqZR1begl5GE6xnlUaOH7P8fp/y6TJyqCQrhfJOz
         GmSLlBKjWMEbPAFAhBZaduYCAy/a7mb7dItIGo7O38cxcSSHJ3fi4GVHm5aPyFiNx0y7
         0Ylcwe2+d6CvCscSCSmWp1hLDgSsGszHIHhs0OZ+Ti2EwuimZiT8yf6j1niWNwR5h9Dm
         4p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685462022; x=1688054022;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNArju2Q8+Sr5dwcNQgGMkuM+vdAY/tBFjavnfU7aAs=;
        b=No1JuwgkF92M+OKFJEbVbeh0H2CbDg7m4CRA26RWMqUSQ4yLaMEVfEFaUvRWUP5xAS
         VKiNbZpEVU8XXhyBiSJ6fo6cTCXpjEV4bvpEnKti4vC250tA0EHfG4yYg2E9KiAN/ygE
         cJPOlAbQMUpeX+Ss2ZK6VNHQQqmwmgDEScVmixFAhKXf42f+cfItdb/iD5XVufIT38Ft
         BDOPItkhJ/3kfyLnNoM4goM783ZnASJAPPhXFapBl8x80cg/QDLzMJt/ToNQ5WAVL/pd
         X0dNAfk1PLkbtTLzVOq4RTB32PvJyRARmraaEfQB2AteU4YyQx5mfnnyRRt4SDn4hVDt
         RpuQ==
X-Gm-Message-State: AC+VfDzVf4kY99hxNX15YWhggxRxbakAgyG4czFp69+n9S2NrnboTdi8
        ovq3FF1uyZIkzKp6HnxUcoTY+MQcMKZpsPVDt04=
X-Google-Smtp-Source: ACHHUZ7sn3ztVKnJjhBggbCbONyO+AsW8XNE2yHvSV08ahzB8uFM1wykgNjVYghRFNCNNXUNIoLTKjLnsrfc/pmUUYs=
X-Received: by 2002:a17:90a:bf8c:b0:253:25c3:7a95 with SMTP id
 d12-20020a17090abf8c00b0025325c37a95mr11888507pjs.14.1685462021937; Tue, 30
 May 2023 08:53:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:ba3:b0:65:5d1b:9a16 with HTTP; Tue, 30 May 2023
 08:53:41 -0700 (PDT)
Reply-To: jkirinec101@gmail.com
From:   marine <jessicakirinec1@gmail.com>
Date:   Tue, 30 May 2023 16:53:41 +0100
Message-ID: <CACrLz9RUfqd1XDcU1qQ-MXYbKcZCtOrXa35uzso1LTdRbsO_FQ@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jkirinec101[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jessicakirinec1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jessicakirinec1[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hallo, es tut mir so leid, Ihre Privatsph=C3=A4re zu verletzen. Es hei=C3=
=9Ft:
=E2=80=9EEin Bild sagt mehr als tausend Worte, aber als ich Ihres sah, war =
es
mehr, als Worte erkl=C3=A4ren k=C3=B6nnten.=E2=80=9C Das charmante Profil i=
st
unwiderstehlich, obwohl es eine kleine pers=C3=B6nliche Nachricht ist, aber
Ihr Aussehen verr=C3=A4t viel =C3=BCber eine nette Person ... Also musste i=
ch
der charmanten Person mit diesem tollen Profil eine Nachricht
hinterlassen. Ich glaube, es ist die Neugier, die mich in einer
solchen Zeit zu Ihnen f=C3=BChrt. Ich muss noch einmal sagen, dass es mir
leid tut, wenn das Schreiben an Sie Ihrer moralischen Ethik
widerspricht. Ich m=C3=B6chte dich einfach besser kennenlernen und ein
Freund sein oder mehr. Ich hoffe, irgendwann von Ihnen zu h=C3=B6ren.
