Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49279482750
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jan 2022 11:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiAAKkx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Jan 2022 05:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiAAKkx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jan 2022 05:40:53 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A02C061574
        for <linux-pm@vger.kernel.org>; Sat,  1 Jan 2022 02:40:53 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id v13-20020a17090a088d00b001b0e3a74cf7so18723656pjc.1
        for <linux-pm@vger.kernel.org>; Sat, 01 Jan 2022 02:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=Xr5jzE1UKpKaqi4Ml91AczoVHAhwYBAtVn3Hu/yU3XBZLOPHROvws+2xOdFgJ1wS4Z
         JMX6lfKfML9HAEgQ+ZRf4HgOu4SwE4+qe5s18GXS2No5kwXYVm8ojB5Nw8+yG28nXuTL
         Rzgm6VS/LWKPiWTLWFDC4lgl5fdqJvjmCvorVenaITD1lQyvEaIOK5hNpfLmPOK75J3Q
         mSsY9ILNrH2WEFBNAr6ZaX36rjQ5dk5LqIhYHGbn5tRiFa224cn/4DO4I6L1zpvncDXB
         BR7HIawTYcHjDsHxWCyIZrvmeSy6cepkVF5lKbpGJbn0xR4pHFENJMafj+KcCWpJmTI4
         r0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=XL09GZpsedhOYJhP467gdhPJDEpxh7FzuwZEGhGaPSULWfclVvG47GId7Nh6CkeTIm
         xaPhTIiLdXecUI6dhFSpU7bi+kanO1v8mEzF/BCQBIIn53K47DwrMkfNSO/PC5CDlDQv
         tDXAQ4yNnv0npRT2JB0JsgXyLdH4P9TjCJfv13SH0pW2u1xmGcNMLJK6b1m+xepv2SQT
         BiZP4qMfaE8mcwFJ3znFFZb+ONncpbtsQmv7MpqqMc5Buk90UM8neibddgPX+VL7YJP8
         fpjuhIuxAcytjzPsYqt4Mew8E5TUOHi0HKTr7TVCcqigfWhJmPj2Av0YmkA2YXTxnJXo
         dXXA==
X-Gm-Message-State: AOAM5304IQ2Zzkc730VSTHx77L4NgxfcfEv0bsf6IlEzHBzkY2BCzqwH
        C0Sizg8l8LMi+byAjY5Wflc=
X-Google-Smtp-Source: ABdhPJz97xsYppQMcR43xJWGycPfTaDGC9NC8MSUuFH6xQg937VN9M+Y6SSPJL7D6EuQlSsda2cQaw==
X-Received: by 2002:a17:90a:7001:: with SMTP id f1mr46900255pjk.70.1641033652607;
        Sat, 01 Jan 2022 02:40:52 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id s35sm26832835pfw.193.2022.01.01.02.40.44
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 02:40:52 -0800 (PST)
Message-ID: <61d02fb4.1c69fb81.dee2a.a940@mx.google.com>
From:   hyaibe56@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 12:40:36 +0200
Reply-To: andres.stemmet1@gmail.com
X-Mailer: TurboMailer 2
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I want to confide in you to finalize this transaction of mutual benefits. I=
t may seem strange to you, but it is real. This is a transaction that has n=
o risk at all, due process shall be followed and it shall be carried out un=
der the ambit of the financial laws. Being the Chief Financial Officer, BP =
Plc. I want to trust and put in your care Eighteen Million British Pounds S=
terling, The funds were acquired from an over-invoiced payment from a past =
contract executed in one of my departments. I can't successfully achieve th=
is transaction without presenting you as foreign contractor who will provid=
e a bank account to receive the funds.

Documentation for the claim of the funds will be legally processed and docu=
mented, so I will need your full cooperation on this matter for our mutual =
benefits. We will discuss details if you are interested to work with me to =
secure this funds. I will appreciate your prompt response in every bit of o=
ur communication. Stay Blessed and Stay Safe.

Best Regards


Tel: +44 7537 185910
Andres  Stemmet
Email: andres.stemmet1@gmail.com  =

Chief financial officer
BP Petroleum p.l.c.

                                                                           =
                        Copyright =A9 1996-2021

