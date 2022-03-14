Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1364D7FAE
	for <lists+linux-pm@lfdr.de>; Mon, 14 Mar 2022 11:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbiCNKTS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Mar 2022 06:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238468AbiCNKTR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2022 06:19:17 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3E12409C
        for <linux-pm@vger.kernel.org>; Mon, 14 Mar 2022 03:18:07 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-2db569555d6so156347797b3.12
        for <linux-pm@vger.kernel.org>; Mon, 14 Mar 2022 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=s9IGPqOTuFEFxKMxMPq1P/MfyJrhGXNasZNiCUUGkGw=;
        b=QLLsRy/dmyqoI0RxbutlRZI/KB6PQe9IvOCU+8CAeBQGMyqmF6/tAgeCdcEdZZWTQR
         +lM4dx52NBCcTyQ2m0WfXEwW0vNy/Q2h5+2c+HanumuiwHWZmSKPKFlw44pXKTJtml+R
         dwkeF3hAq1OG1XPpJqiioazUaaQX+JYj0dZPXjKsK11KQt1mm6NBeApJvW01vlTwCTmr
         0zavqxu3N8bMBLwVdJob1TzN3h9Ad2e2PR9EIiqawtuU/tja8f0QInngMnTjQrwOBH97
         yAIfAPxmHT/edHFTmHy/X6VQzKIXHrAJ5+snD7BUcPM2WrhmxfSgG3hq1NGxgIWRcIi2
         0/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=s9IGPqOTuFEFxKMxMPq1P/MfyJrhGXNasZNiCUUGkGw=;
        b=cz2tt1vUrWeK+AXxKGomSvK1E+pvMxY/j7GjY3Jjg0ZyG2+JMQE5iLDp0vrbNOsNGu
         Vilyjv0F3nPDKUlFoBK+qNeGilNB9YEP3T1P3P3BgxeBNmGWNViqmPF+0yYO+p/yr55K
         Ng5HCn0AhD+6vEnFf24D3ms/DqtP3pJO343Yvj6YzwozXEO3mri3fc1ecnXwyEiYiG/R
         IlNMTwsBMxZnGCphf3U9r03gXZmHTOA8oUUjQy3QtJx6s+Bn/rg9AFTNMNTHxHk19tS8
         hjZJWWL/e+hDT3yKWW39Re/ZT3YdDCd4n0c+Uu7o1k08NrzUkOI7df+4+oNoCFzM8tkb
         y1/w==
X-Gm-Message-State: AOAM5304OSEM9AMWZ6iAiqZUMnaU8lB8DstNSSLBOAQw84bK1v2ppcqb
        0ki9j14MDfFEFu3PrKvNhqvSkCGuV5omSezqBB8=
X-Google-Smtp-Source: ABdhPJxt3sbAxxrwf4Yfrv8UBK0gVaHR239NIWyNSkIxk2Sc5EP6VOe5GgMUyXsnR38oFmRN2oH1ymMI9cBZdKCj6G0=
X-Received: by 2002:a81:738a:0:b0:2dc:2bf4:76b0 with SMTP id
 o132-20020a81738a000000b002dc2bf476b0mr17333592ywc.296.1647253085893; Mon, 14
 Mar 2022 03:18:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:664e:0:0:0:0 with HTTP; Mon, 14 Mar 2022 03:18:05
 -0700 (PDT)
Reply-To: lawrencetansanco.y@gmail.com
From:   Lawrence Tansanco Yacouba <ltansancoy@gmail.com>
Date:   Mon, 14 Mar 2022 10:18:05 +0000
Message-ID: <CAK5Y89B_nM=NB3F74FU=OkW46S8+sqUpfZMbv5ei+DSF9F90LA@mail.gmail.com>
Subject: THANKS FOR YOUR RESPONSE AND GOD BLESS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1141 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4223]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ltansancoy[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

.
I will like to disclose something very important to you,
get back for more details please.

Regards.
Mr Lawrence Tansanco Y.
