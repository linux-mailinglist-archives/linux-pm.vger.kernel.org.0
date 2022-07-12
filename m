Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2D05712CE
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jul 2022 09:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiGLHKi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jul 2022 03:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiGLHKi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2022 03:10:38 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BB9275DE
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 00:10:35 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id t127so6993099vsb.8
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 00:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=VaLdCxxT6H+yQ21ljsJJCI0JVFTWEh1IT2eBGtm6sxQ=;
        b=AYbH/BwwR/3nG5HJ416AGTRe5B1p9pKYSMLF43KI7zJrYd0V1KA/nd5aL4DIJ4NDHX
         T6Pfr4UMzEbzrO/vZVaHr/dHPVzg9EnIIrKPwgJnLzrNADT9tx0JyPgjLC+Q49D5g35X
         LG7xVZ6lD93a9M1xrmbJCrNOqBUv88bzsjkIp2ZYp2mjeB8G9DxSserW6FzcfpXobwfa
         GCv+8uSilJ7xpnUYArhN+MCkp5DcSIXYcpQaOSD0ciGLLLc02wXUJT3gEvdEZlMUenhC
         FOZzyY2gGUylUVyxKcVudwHKSMWt6Zp1dh9+74iOQFWAbOQC+jwIewY6PwgrSZcHjmb7
         zRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=VaLdCxxT6H+yQ21ljsJJCI0JVFTWEh1IT2eBGtm6sxQ=;
        b=IiUYy9pC1/XUF0HB1Dath1RN5N3asZKLVWuDVnOBuNO2tzLLLKUC7I2H1Jv8L5WcUo
         rzTjslmsaKunasheKyAuHLbmnfvcMrWvWAlx7KVEYPQDN90uDl/SLTy9YNu2SF/Q/rUe
         mviOFVkfOfRitvzplWnjZhglulJmykG/tWO6+8A4NmV4uSFpoSZEHcOx8UTkF58ubc8w
         b/cjkxGvkOAljxdGxrbXv0ypZJf5YvwZz1yXX0MvTbtiY1DPWq8YNy5b93OVjCsz+2PG
         Z74SfjS+PKxs8phM5bT9dKFGpYBmz19FIu8suchKuzc55EwtYDXZIaSh6WpsT8KhWa4p
         AUrQ==
X-Gm-Message-State: AJIora+bhEmYqK574GWDz0L16WaP1131newj7OSehKaasY1sdxSsAvW6
        JckZSGImHjOTCOnjt2RvOtLFsOTnJl4a5IPXrQc=
X-Google-Smtp-Source: AGRyM1uyqUPWVt14j7dYrXfyaORAMsp3Hlvjb5JcHaVQ3ByVlPyBjvKYn1pbNYlxVIuQwFZc4r7qrbjOmsJB780qqcg=
X-Received: by 2002:a05:6102:b16:b0:357:5533:ded4 with SMTP id
 b22-20020a0561020b1600b003575533ded4mr3789788vst.36.1657609833809; Tue, 12
 Jul 2022 00:10:33 -0700 (PDT)
MIME-Version: 1.0
Sender: ahaijout@gmail.com
Received: by 2002:a05:612c:210a:b0:2c9:f309:ea94 with HTTP; Tue, 12 Jul 2022
 00:10:33 -0700 (PDT)
From:   "Mrs. Aisha Gaddafi" <aishagaddaf95@gmail.com>
Date:   Tue, 12 Jul 2022 00:10:33 -0700
X-Google-Sender-Auth: z835C80p2D4HsBLOpCKxpoRzhqM
Message-ID: <CAOCce-wkkp4MEzTqqWnYKNZNeYSb2pdFu_MZg7tSnhPpvQgcPg@mail.gmail.com>
Subject: hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5028]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ahaijout[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.5 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

-- 
Please i need your kind Assistance. I will be very glad if you can assist
me to receive this sum of ( $8.5 Million US dollars.) into your bank
account, my name is  princess mercy i am 21years,i need who will help
me save  this fund,
i lost my father and only brother,
Please contact me through my private email:(princessmercy68@yahoo.com),
 for more information
