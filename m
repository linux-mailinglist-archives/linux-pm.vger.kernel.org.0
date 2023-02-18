Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EAD69B758
	for <lists+linux-pm@lfdr.de>; Sat, 18 Feb 2023 02:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBRBMr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Feb 2023 20:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRBMr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2023 20:12:47 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364F646166
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2023 17:12:46 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h14so10967088edz.10
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2023 17:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=30mLK80vSZcSwBOrdpYOKvqdrdKJjCkQDSG3S0CWQyQ=;
        b=PoWoEJhFFohzu/W6uY+o8iNV9+bQIgFwNI8aPQWta8w+RdhKftJ7oJpRRU8n/TUOvk
         lRkh/grMuygnV4YpseA4wk1XZOd6rMTrWvTTA3zPuA3lGBvGnRLHBHL+XllTNkHNkbQB
         WrvJGmAWKuOfSExi8UgKp1kJ0QaQiggbXjDbFVKaBMEK2hS3N2KryMwpgDIIfzVDYYEY
         GzSRxTcqwt32ELW7ktD/wmjIGNRH6P1ltgZXmFflINLYzFF1FByGiBQD+SJphYem4IEb
         CD3C7cHoTSQyUye/6r7tTwsccTDtrOeOdod5HmRS/R+TNtgN4nEH/UVuR2UOBSZK5eMH
         IiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30mLK80vSZcSwBOrdpYOKvqdrdKJjCkQDSG3S0CWQyQ=;
        b=TdGZmXofqsm/mYW780Ojko+OlSInQBN+abmBlVXtYMRCEd+0PWEuo2jnLK/mkrTrd2
         ZlJtZuZfu+ARGuxMmSSRikozZ3s9HUO9xs1rwBOX0P22O2P1ZTu+vJK7HieK/0XkNGHF
         MoczZrsNXD7rPjl3ACZD5BzSjjEcw1E9aGDbiqdshc6V+5Ro0fd/MiYRVpscUanWrYFy
         mAVHEvy8C4Nh9kMRQAQ38hlzvRm6LGjPxGQCYw1D2QtzjgekFggPtUizZdlvkkmicTgc
         /AfwKd+z+7bIE+e9HxB527eLpnYatgAKX3B1PhTENoIBvvHLE8JPeKCW7HEmAQGLVSvw
         RxkQ==
X-Gm-Message-State: AO0yUKUZow3pCqLiip9yKZ0IFqztx1KuNZMPagdPcpHv7uPK/9iZfPFa
        bOCdfxn33b54RJ/zqHEbKcTXbQkb3h830LqD0T0=
X-Google-Smtp-Source: AK7set+DZz2NqM4bfQ+/fKXu3olGNY2Aiiu7D8kS0IaKCJM/YSbOduA9MrOWCTb9xRL3WmO++cFullvc4FblRTNuYQA=
X-Received: by 2002:a17:906:869a:b0:879:9c05:f5fb with SMTP id
 g26-20020a170906869a00b008799c05f5fbmr1233629ejx.5.1676682764629; Fri, 17 Feb
 2023 17:12:44 -0800 (PST)
MIME-Version: 1.0
Sender: akondotafa240@gmail.com
Received: by 2002:a05:7208:8799:b0:62:8acd:8a88 with HTTP; Fri, 17 Feb 2023
 17:12:44 -0800 (PST)
From:   Miss Katie <Katiehiggins302@gmail.com>
Date:   Sat, 18 Feb 2023 01:12:44 +0000
X-Google-Sender-Auth: TczFV8PGbXzJuzSy0_Fe4Vb_tyo
Message-ID: <CAM5Ze1tqjiCz6uUmLhi5JebJMPScdmvm_sGDYY0+qbXH4THASw@mail.gmail.com>
Subject: RE: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hallo,

Sie haben meine vorherige Nachricht erhalten? Ich habe Sie schon
einmal kontaktiert, aber die Nachricht ist fehlgeschlagen, also habe
ich beschlossen, noch einmal zu schreiben. Bitte best=C3=A4tigen Sie, ob
Sie dies erhalten, damit ich fortfahren kann.

warte auf deine Antwort.

Gr=C3=BC=C3=9Fe,
Fr=C3=A4ulein Katie
