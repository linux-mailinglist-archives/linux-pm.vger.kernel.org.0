Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A976FD9AD
	for <lists+linux-pm@lfdr.de>; Wed, 10 May 2023 10:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbjEJIk4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 May 2023 04:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbjEJIkp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 May 2023 04:40:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F925255
        for <linux-pm@vger.kernel.org>; Wed, 10 May 2023 01:40:23 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ac785015d6so74781441fa.0
        for <linux-pm@vger.kernel.org>; Wed, 10 May 2023 01:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683708021; x=1686300021;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opeeHjTpE8hf7IkSOrjrz4V6UTxg/7z0lzjIXtvA3kY=;
        b=mJX5fL+Awdgf/Q3vuVWSv+2p/E0Bk+m/npLqSpztNQ2Q2ZvyIxpkxSYV1Nx7/u4jpw
         fOW/VcyDZkpcwEXd0nRDcb67mY9S3oGILzP8h1p7o+nnY6X6LMthIa/wNx7yJjMXCOpV
         s3zW2/e8UpsWLULP9ECzhoGfK3Zwl7DsZqA0fLK/FLEtFxFCj3c1Yo54KCLQGVAbqRyk
         gHa/d8ZxgnO3G7OH0POBxoTKJnwgoIYSDxHrC2dp9xnOIBx1AJAh6VRBNK04qX0192qb
         3G0chKnOHOp4PdLUIAWz6pbHTOehCKFBAKoSRSGlCSHmgHGOor4zwqxPqwjzsGhRuZIx
         WIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683708021; x=1686300021;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opeeHjTpE8hf7IkSOrjrz4V6UTxg/7z0lzjIXtvA3kY=;
        b=PueReibuSQAiK6fslu6qnQUdY9ajER7dZPeQNVrqbMHTxtT1oeWP/ICMVis9nkUhG7
         hMcn53zvUI94IGh84hVf1c0B9Ou8ujeEuhJ2spDGO81qyAMeVuKTeGYJL8ZWRm9BI2/c
         mx7wRFmTiR3Glxs7W4vORi/A6GFs6xqqq9N/nyp3a5gx1wzezkowrMF6CYJpXTQbX48O
         IKfSmoPzvArhLeSA+L/6ZCoGaNgkizytrk4Mk+PEhEKaeVa9AbrH+AsQtnywa4IcXGl2
         I14GHMzn5UV9a3eAsuqywzxnqmf5LAHwMyUtBr3if5JR1hds4+U/abWkxIj6ykTVrNo7
         8gOQ==
X-Gm-Message-State: AC+VfDyKR/T+sARMNuDQiltR442UZ8qBDSPY2LcSSOrlHcpKXJYIn8zu
        9D2WU8V1HrqhbDA8axbedCpvtLrE/MgucUHGD+I=
X-Google-Smtp-Source: ACHHUZ4q6FFSNrivLBnvkx4ypcvfk6i4jKSSSsTWLmX9P2YL41mqL5f+BogRmQMc+nH0ipNLEotTcfeVc/AGXlvKPe4=
X-Received: by 2002:a05:651c:212:b0:2a8:c75c:96cb with SMTP id
 y18-20020a05651c021200b002a8c75c96cbmr1672897ljn.1.1683708021176; Wed, 10 May
 2023 01:40:21 -0700 (PDT)
MIME-Version: 1.0
Sender: ngountchetiyoa@gmail.com
Received: by 2002:a05:6520:402c:b0:23b:ccd1:499e with HTTP; Wed, 10 May 2023
 01:40:20 -0700 (PDT)
From:   Kayla Manthey <sgtkylamanthey73@gmail.com>
Date:   Wed, 10 May 2023 08:40:20 +0000
X-Google-Sender-Auth: 0zP8wFUDjtI1f9edsCGSxwCjWUg
Message-ID: <CAFDM7BbjGGE6fgP0RxdwEP49Ny58+JXYXBCUhtcUGEpUobmn0Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello, please did you receive my previous email?, thank you.
