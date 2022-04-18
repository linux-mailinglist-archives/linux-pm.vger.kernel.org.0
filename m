Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D93505A19
	for <lists+linux-pm@lfdr.de>; Mon, 18 Apr 2022 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiDROkG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Apr 2022 10:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345571AbiDROim (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2022 10:38:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE3157170
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 06:24:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u15so26773407ejf.11
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Zxho+exJKKOKB65wNhmIfElbVOfiLStLlJhCjJN3tgU=;
        b=i2Xxq2kKTqhF+ZuRmpzKZeiWNPvsnKiswZgWoiKK0SoedqjJwj/7TEbbDBeQWJDDEt
         gUvoL6JJRT/0JLGPxJOp1VbQB+jZMjpL+YJ3+GusiJVDcOxAJQKEouEn+myWgK0HVQIh
         rJ+zeF7Huu4bAPrh9fJNDgeGd96sRjEj7pjK/5Sw3Cf/CeJsRZJoZlYB9q51wr1bNAN3
         tSCBEGg0BpTM4PCdmKnExgioS7Y5FBKkwFD/GKoiegRNYcrYwJYphFQQtQXEHyF5PnHT
         FuND+3ieFEI5L/w4Uek35CRP+6fJi8qRyimOmkjc87Mm1zFtvRFDOK2g2HfpmB5T59X2
         CHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Zxho+exJKKOKB65wNhmIfElbVOfiLStLlJhCjJN3tgU=;
        b=mjcYVjjPifmsXORvcWfY/N3VcOOt0f4QdLyVbeDLO5d+epGTrwMELCd+pzZPJo05DR
         Zkfiwhz0bjq5roe41pUPonodYMs0vNc2rFV64C1gIRRjhKa5PCrHA2fwxkVNmlI/iREn
         +UPC3ERIg3o/WSOINbTSwsfki7dHxbPyxxQJ+L6/RbO+6aAVP1jmeMaPlyLXv5nxJHlx
         KR/5vmrV1RJaJ2Co0FSWMLobyqU85mIcQ8iDOlZ0p0cnhIq/PrYHf0CFmWKMRQEwmUIp
         ng41fA7yLocq0rT0j84vis8nxPL1NF1S6GpEtvnRZgShCr99/SwHpiJdYZYi3N1hvqSX
         pCgw==
X-Gm-Message-State: AOAM533IeiPAsuoToBjTpzPIrf7SK1a7yKlgr6n264bZUeL/9xGAqqIb
        KPjBah4M+u3p86dyKi1gwwKFXQ/IagayNrPR+PU=
X-Google-Smtp-Source: ABdhPJyfFLYQ1nNwUCtzPRKUDabieLr1JWzM39/Su02t9YXBpuIcrDnuAJGuaxAZ7Z+SiRKJGbuiELx6vbe2cQIWhK0=
X-Received: by 2002:a17:907:dab:b0:6df:e51a:b990 with SMTP id
 go43-20020a1709070dab00b006dfe51ab990mr8756832ejc.573.1650288255102; Mon, 18
 Apr 2022 06:24:15 -0700 (PDT)
MIME-Version: 1.0
Sender: lila.lucass112@gmail.com
Received: by 2002:a17:907:6d96:0:0:0:0 with HTTP; Mon, 18 Apr 2022 06:24:13
 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Mon, 18 Apr 2022 15:24:13 +0200
X-Google-Sender-Auth: wUsgmFtuqxDgPaZwhFTbp5J2Lsg
Message-ID: <CAPvtrUeAnepKjptjT-H8G8nXpFJe=cW4zDaTnOp5m8GYdO9VQg@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HK_RANDOM_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello ,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs. Sophia Erick, I am diagnosed
with ovarian cancer which my doctor have confirmed that I have only
some weeks to live so I have decided you handover the sum of(Eleven
Million Dollars) through I decided handover the money in my account to
you for help of the orphanage homes and the needy once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my details to you please
assure me that you will only take 30%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs Sophia Erick.
