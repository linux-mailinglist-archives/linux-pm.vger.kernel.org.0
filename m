Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9D368C309
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 17:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjBFQUp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 11:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjBFQTl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 11:19:41 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D55170C
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 08:19:15 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id d6-20020a17090ae28600b00230aa72904fso3760841pjz.5
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 08:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHVhY8dH3vvCuDFO4TwW80CMe5kFkYaJGmTv/c0Vd3k=;
        b=Ar/+dZ1sucFR2xKjTng/3DVBU2eNtaBOUrVgQ08R46B5pe64hbjR6v2L8cP3ZSSOEU
         xUKyzyoffU2APptbRbECbQpmwZLfgi7rdNs7OqYHlbVApinh3TkEt4S880OjmaGEUEo1
         FED7g3x7TbbWhHQ5p0+pmnCeduCU6E6LJXBVPVAatDHBNRQexmqnt6wo7ZR9x3YiyVtA
         FYz2D+Xh8lVyY6xbECJCgqHY54xBdJsnFP4djTpobR1K+iSc2gopGF5q3EiKNBK+8aP2
         D80GslngnqXkdRuWkyEPxzjIPzeBTdgitDJ02vubiDNPu8MrdXe0ze3ZM11C2uvzUn3+
         GF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHVhY8dH3vvCuDFO4TwW80CMe5kFkYaJGmTv/c0Vd3k=;
        b=HrsGYt1xK7ibTcttBo/XaIjROFVzuuqgdXMrypjNmFtJgsEGSPUiJ4EbtqJ7grluGx
         32XH4svwKAzAXn1YVwvidtjT93LQi96gktfXnd5rVvPem59k0PuyKi8UhHCi6tSladnt
         fCP91tCA4AhA0Kihso2GtMEorygCOwXEn8TBtNJcPcDbTKSyL8TrVKnyXaWCS3/6nnpi
         2rYOUTF1PPxwDs5aLtitturxpPHLjVNgy4+wEyGciyPhkbYeU9USpgjFwyZX888bNuAT
         R9od/AXM3VK1HZDzjK6UJwtt+YpB7oQGL/NcJpcJ1XSFz/b7eo5f6w79O9aMNVzK5gmy
         oALw==
X-Gm-Message-State: AO0yUKVmHbl6AfmfywiBDtlbHrz3LG6ajMJaaNKhmGj5LJlV59M+dPSs
        QCyD/jptFFJlFNq/BZQtva1b6MduEtE67CiRnM4=
X-Google-Smtp-Source: AK7set+47fwowsl/6WmWbKSZ39n+VQxgbamhRzzTclFEl7vzKPLhvCpKEbqRbRoc7CXzwOBPT+ecyd+EQ37hiqZlr+o=
X-Received: by 2002:a17:90a:2ca4:b0:230:c449:18b with SMTP id
 n33-20020a17090a2ca400b00230c449018bmr38780pjd.85.1675700354750; Mon, 06 Feb
 2023 08:19:14 -0800 (PST)
MIME-Version: 1.0
Sender: kabreibrahim101@gmail.com
Received: by 2002:a05:7300:b993:b0:9b:d0d1:1b55 with HTTP; Mon, 6 Feb 2023
 08:19:14 -0800 (PST)
From:   MRS EVELINE DALINTON <evelinecuypers@gmail.com>
Date:   Mon, 6 Feb 2023 08:19:14 -0800
X-Google-Sender-Auth: SFFF_QTMlqy9g6AqSCg87duKUkg
Message-ID: <CAAbtB7zBJ=7Q+6jFKM9wZDbwhqqj4y7Tm9r18t8_NjnLHOc=tQ@mail.gmail.com>
Subject: My Dearest Beloved One.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY,
        UPPERCASE_75_100 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1042 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5165]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kabreibrahim101[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kabreibrahim101[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 UPPERCASE_75_100 message body is 75-100% uppercase
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  1.9 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MY WARM GREETINGS,

 I AM  MRS EVELINE DALINTON  FROM DENMARK, I DECIDED TO DONATE WHAT I
HAVE TO YOU  FOR INVESTMENT TOWARDS THE GOOD WORK OF CHARITY
ORGANIZATION, AND ALSO  TO HELP THE MOTHERLESS AND THE LESS PRIVILEGED
ONES AND TO CARRY OUT A CHARITABLE WORKS IN YOUR COUNTRY AND AROUND
THE WORLD ON MY BEHALF.

 I AM DIAGNOSING OF OVARIAN CANCER, AND I AM A WIDOW NO CHILD; I
DECIDED TO WILL/DONATE THE SUM OF $10.8 MILLION PRIVILEGE AND ALSO
FORTH ASSISTANCE OF THE WIDOWS.
 PLS KINDLY REPLY URGENTLY IF YOU CAN DO AS I HAVE SAID WITH THIS FUND.

WAITING YOUR REPLY
MRS EVELINE DALINTON
