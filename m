Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6CE4EB605
	for <lists+linux-pm@lfdr.de>; Wed, 30 Mar 2022 00:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbiC2Wb7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Mar 2022 18:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbiC2Wb7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2022 18:31:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60E57EB36
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2022 15:30:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w21so22226328wra.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2022 15:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=NeB6xF66me+hZ6sXlQLm/fuUcsOHM/R2pQY+5Tk6w5oAVDj99+tlFcumRJv6Ry7PXi
         ERG0GOPCo6Q01hhJ+Lv66BLgcvlGLnM74ss1vP6gbF/T5QPdo6xYCWFvff6+ESPqUc5q
         1nX5QrMAvqSNIRtjOMFzcYqnJs1gLzQR4dnId9uy86PTUHG5J2ipCRxrrM5jxat+Sv/N
         kfxdCj/+49MNAImaNhIMqP50dPynrcGpU/V6nDHccpvgYua5WWVq2hkaIF5A6SDrOet/
         IX3viaEDjYbX1mEm3OHGAVTx8Fc2qXrv7bmqaLD/LaYV5/FTNIm6cZZmVlL7K80ssPcl
         OFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=10nAdTopO76ZPTgNmERfUrc0ItJuyc8DW+R80WWvgnxUjETmZwz18YMLsm9u9YhAMB
         pcaTROsX8cxUBSVDkWWPBhway4JiJsDrWBNmNOe3ojVTIcwWQtDUPUXrpQ39E+hTyl9n
         cnBK49WmaHvdzDtkscy2D/DtlVe7gfMcafnVsLvAB49bPNWNaXJM+q9jbr0SgV14K2d5
         Jyjn+QCv8zYyh/iFZqjR0dWLD5kEcKaTvvniFNyDhodBn1ibE2td4vcsF+92n/QRD9L9
         Wot9A+pURMEDJs0qU71fujVwIopmd+DwaSRm0TA/iT4WSZ0GB8z8QenbMwbBFgErk6mQ
         4Yow==
X-Gm-Message-State: AOAM530B7OvT39bqVKNzxcE7fn8LW5tIDyk5g/kQvJmi8FoIH+1ldGSW
        uj544VYUQJeMRhNawWVgEng=
X-Google-Smtp-Source: ABdhPJytGSXS/wkmEV+tFeMi1WhNwanvgdMzpUVFrX21Duwa4ThxWbGSnoG2ZZ9rt1qlZbsb67+3AA==
X-Received: by 2002:a5d:6daf:0:b0:204:12b6:a15 with SMTP id u15-20020a5d6daf000000b0020412b60a15mr34551501wrs.340.1648593014403;
        Tue, 29 Mar 2022 15:30:14 -0700 (PDT)
Received: from [172.20.10.4] ([102.91.4.187])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d48d0000000b00205cf199abcsm2851970wrs.46.2022.03.29.15.30.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 15:30:14 -0700 (PDT)
Message-ID: <62438876.1c69fb81.a7286.bce9@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Gefeliciteerd, er is geld aan je gedoneerd
To:     Recipients <adeboyejofolashade55@gmail.com>
From:   adeboyejofolashade55@gmail.com
Date:   Tue, 29 Mar 2022 23:30:05 +0100
Reply-To: mike.weirsky.foundation003@gmail.com
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Beste begunstigde,

 Je hebt een liefdadigheidsdonatie van ($ 10.000.000,00) van Mr. Mike Weirs=
ky, een winnaar van een powerball-jackpotloterij van $ 273 miljoen.  Ik don=
eer aan 5 willekeurige personen als je deze e-mail ontvangt, dan is je e-ma=
il geselecteerd na een spin-ball. Ik heb vrijwillig besloten om het bedrag =
van $ 10 miljoen USD aan jou te doneren als een van de geselecteerde 5, om =
mijn winst te verifi=EBren
 =

  Vriendelijk antwoord op: mike.weirsky.foundation003@gmail.com
 Voor uw claim.
