Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A3A5F4FA0
	for <lists+linux-pm@lfdr.de>; Wed,  5 Oct 2022 07:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJEF6C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Oct 2022 01:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJEF6C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Oct 2022 01:58:02 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5650E726B2
        for <linux-pm@vger.kernel.org>; Tue,  4 Oct 2022 22:58:01 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id k6so16822185vsc.8
        for <linux-pm@vger.kernel.org>; Tue, 04 Oct 2022 22:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=OQx//nIMTXIuGES5wdU306SDyqo/9GYHWGhMmpKB5Ag=;
        b=HIJlArLLsxKOeX4ayra4vIhiDsVJG/UDrKsbMCEWvmJtBawwlsve16T/N2idnRvk16
         c8kzdlE2tptx62I4lmASz23cflBpy9GCJOLJsdO9sGBL174CjSXJi/fEQp4s7PlQWdUH
         RVaGCdXlExQeVDl08GVpyFZ9uAPCGnci8UmJLXD1w38+FtX2avf5iQtfccrntLLk9O0Q
         pYtQWMtm94LN1+35GyBtuvBSZ8rqEDYxyB+BnDu6kJVqjTwHgJu6X9DNj4wxiQqWnWky
         naihPesLNXHaW8XQuMM8AOOep6RJY9wX9uZDV8epo9vGqiltpScHdNQrTJ1u3MQ3xtaz
         eGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OQx//nIMTXIuGES5wdU306SDyqo/9GYHWGhMmpKB5Ag=;
        b=A4PS+mC9+8h65snmKjcpk3JwVksdgMCFDifzcfsMXbTSW99kNVFaz7hDIe3uGJBwUr
         pRHsz0hoLWYb9H6TOAqiZRVSm6anqeqen+eG3UzXYikRvy90X7FzDKFDcMCiDgyOBUnv
         Z8bN7sBJyzHFAgaOp2dLEIaEBpcyc12AzL98WCPrwG9Yq42CEc3xWwoeKoap+0ump5Ne
         xh+v771dyVhrCskMhJ+ILb5fLG6G1pkebZpPBMjvUB84W/1ziyRx9A77T0dY7uxRBNxa
         XOdZRBg/8tt6Il3ZtPo9r9pDmAJxUgaUYku19+z0UVBuh2RxYhHfqD6mocf8La6xsjob
         YRpQ==
X-Gm-Message-State: ACrzQf2pJtQDLyF9HhsxbeX/XTvz5evqXtMgBVQMrm2uuTrMT9oJDLXc
        zzORI5edSx4tDpjt8XYjpALFek8yci/MePWWLBA=
X-Google-Smtp-Source: AMsMyM4Apr9VU+170df1ft2wV1yLq4zhXmOismjuG+EfBayqtl2MDEVVFMXxiDfh2Yn7RXByUSGMsNXnucQOYUw9xe8=
X-Received: by 2002:a67:d604:0:b0:3a6:310b:df89 with SMTP id
 n4-20020a67d604000000b003a6310bdf89mr9960154vsj.6.1664949480301; Tue, 04 Oct
 2022 22:58:00 -0700 (PDT)
MIME-Version: 1.0
Sender: mrabuomarhafiza@gmail.com
Received: by 2002:a67:df99:0:0:0:0:0 with HTTP; Tue, 4 Oct 2022 22:57:59 -0700 (PDT)
From:   Hassan Abdul <mimihassan972@gmail.com>
Date:   Wed, 5 Oct 2022 06:57:59 +0100
X-Google-Sender-Auth: Xc-1Vw2xdf_RF2nw_2xAys-CIow
Message-ID: <CADSmb7jH0k10t-SygW5eoE_j3Qj9GPbTD18gyo3j=JvmR_gOng@mail.gmail.com>
Subject: Reply Me
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

i am Mrs Mimi Hassan Abdul Muhammad, and i was diagnosed with  cancer
about 2 years ago,before i go for my surgery i  have to do this by helping the
Less-privileged, with this fund so If you are interested to use the
sum of US17.3Million that is in  a Finance house) in  OUAGADOUGOU
BURKINA FASO to help them, kindly get back to me for more information.
Warm Regards,
Mrs Mimi Hassan Abdul Muhammad
