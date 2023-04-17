Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC76E4F92
	for <lists+linux-pm@lfdr.de>; Mon, 17 Apr 2023 19:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjDQRrJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Apr 2023 13:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjDQRrH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2023 13:47:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99B176A8
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 10:47:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u3so14358142ejj.12
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681753623; x=1684345623;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftUK28jNeVbZI1YwnxbSCR+OUeG4rzKxSuPLKinIHUU=;
        b=rGQ+7vUD/ahMLXanrMPXH1HprNU/cZEbztflAzWShO9fgFun9OaHI5LBHP7jbix6jk
         L3Ed5cZcvWzqhiJmAkb6H/H/4aSd1s+XyjBVZHGKZwjU4l+4J8dz2FPr8sOV8xxFuEOa
         0u0OseRsNufJBy1YpR1jupLeJfdMR3JfRP2YQTTQZSBc457oo8omEKUcktMYCBsZ61kH
         zEbHhspbg/dJ9WKKBeSEZdgLYCu7L3yOHe4nNyh9IwPBgWPIB/RtC0ZaOhybx4+SpDaD
         7duJoCa8fitSwg/sQVRfD6C9YPgfVbe4F+fAOJ8ZvyuKA+o7nKY4Wpcdbr3O+klND1Ns
         PrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753623; x=1684345623;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftUK28jNeVbZI1YwnxbSCR+OUeG4rzKxSuPLKinIHUU=;
        b=EyyCHIedQO7VS9Lpjt8mSHyzEvC3o3BKeGNSn03LHWTEi1MYPKZTQNQuHNgBSOtWMP
         6qTjnbUfJdJRwhjEuO78p2e0JdtgviOXfFBdLyhUcyM7zttB0cdLrXb0XHm841+HnbMh
         EgmOldFPEvi2dslxcej3GW/D0rMpzTXQGyXfyGUlKtzFCTTQvQ0iIfAL+eleRxN6E0mw
         2NMK13C7EEZz0mlUKxwycf8leZdgB1355LINACcWnmwyhooBd1bIqZpEbPGW13U/j69G
         A19+Ip7o6HRIna7jtskaT56TDXjxLx2+bbvv8C+ZSzmYRCHwYihe7HE3ADH6uq7B7PVU
         tV4Q==
X-Gm-Message-State: AAQBX9e8HiHm2iTjWbTLdX78n+b4xpHM2/VQ4h24bDFAJK6sbWUHaYDp
        eHXWotbsBpTMwE0cF1pSi5FXd2TjKtVy3X6MH8A=
X-Google-Smtp-Source: AKy350Yllvj8kI8iCCbPaPRdxSeiRmIye2XtCjaBxnecaa9g5xfkxOyf0KghyfCy7x1dwZU9rlTfjR9gxo1ZRZjuSyw=
X-Received: by 2002:a17:907:6e24:b0:94f:8aff:c8ab with SMTP id
 sd36-20020a1709076e2400b0094f8affc8abmr1554990ejc.10.1681753622751; Mon, 17
 Apr 2023 10:47:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a98:8c84:0:b0:1c6:885b:bb8d with HTTP; Mon, 17 Apr 2023
 10:47:01 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <koumbandiayekouba@gmail.com>
Date:   Mon, 17 Apr 2023 17:47:01 +0000
Message-ID: <CAMcBcCVbrdYKJstsVCSAZPOAwmhKGhZoLDJhyDwSQC+NHpQyXw@mail.gmail.com>
Subject: FRIEND
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Good friend i want to know if you are capable for investment project in
your country. please i
need a serious partner with good background, kindly reply
me to discuss details immediately. Thanks and awaiting your quick respond,

Amos?
