Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2435F6468D2
	for <lists+linux-pm@lfdr.de>; Thu,  8 Dec 2022 07:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLHGCk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Dec 2022 01:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLHGCi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2022 01:02:38 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E02925D2
        for <linux-pm@vger.kernel.org>; Wed,  7 Dec 2022 22:02:36 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id r11so388791oie.13
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2022 22:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=GHvSSOYUYCeAi7vLLpEWjJu17UqiIyRmu1f99SxJAa7Gm7kH2DUpDFcf3ORMUKtxzz
         Y9BMhVkc/D4zILnd0O7NI7dUIQ9XSCQt7yGsZTopRC4vQoY6YYHisaBEnCU5blNQp9/e
         rLapMS/hEsJkNAngbcl1d8zjLDKxkXDoJcFqdPghwqX+TV25ifV1/bFCuZUdWVTw7Fkc
         kXh/V2757HGbhqbUmWX4JH5S48NZd9SmvATbWI8Y/jduWODEyP1O1yCboJlT/IlBUfQT
         O/1XHnMwAXDSLsPnjjLcWQYi0DNdwkjBuGJnLJ1Ta8eeiQ8JiE6JbQNUamHZGzgG60uI
         DWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=6LXqRRbVCfSSv0jnYgUTKgC1YiUXtWFz7BAtYRhZKJ6Pr7OJ+4gWAGhDRYBxGJzdIE
         dGvcr72V7K5YPg0fZe1dzwR4FGDxdUWrhP07Ua1bmPmXdKSN0DbmhAqwIw9wm5Vhr1Rl
         Ee2ZCVIA346QHkwI12yhmcc91CULMEAHgfd0HrbvT6EAVERjGfifie36oXzVeGvDbVuh
         WwyzgtwYerqnyT2yyz37BgIQi+f8KS2VSqJhuYXFpGIn7I0WNuQbQwEd7HVHBSSerIFx
         EG7CgVs2YQA2tXwuBz/PBPsHON2cHtJTmQtdBTysqPqKhOgs/5QiYg1A7fwMSjAnOBN/
         G+Tw==
X-Gm-Message-State: ANoB5pnJiKPsakxESdiIR7cv6F1MlxFEF+OwhqlquiItxvGS3fDU6Uth
        OwINkjzscr89TMs6e9M7PBXiekRAW3xd51fxZyo=
X-Google-Smtp-Source: AA0mqf6jGJ2bUv/Ala6bxbQrpfVp1Sg/WVz2zGdgLqCyhIuJiNJxdlp+fF0ztdLInOBsS5ck+hHgBhTub78dUd0SxJo=
X-Received: by 2002:a05:6808:a99:b0:35a:6f28:1b13 with SMTP id
 q25-20020a0568080a9900b0035a6f281b13mr47323159oij.262.1670479355550; Wed, 07
 Dec 2022 22:02:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:63a2:b0:dd:2e0d:f181 with HTTP; Wed, 7 Dec 2022
 22:02:35 -0800 (PST)
Reply-To: engr.fred_martins@aol.com
From:   "Engr. Fred Martins." <lorir8611@gmail.com>
Date:   Wed, 7 Dec 2022 22:02:35 -0800
Message-ID: <CABJ7TC59dH9CYNwwdiGtZ8MD_w7MGcfYkqoj-VVHpxUrp5GgfQ@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Greetings,

I wonder why you continue neglecting my emails. Please, acknowledge
the receipt of this message in reference to the subject above as I
intend to send to you the details of the mail. Sometimes, try to check
your spam box because most of these correspondences fall out sometimes
in SPAM folder.

Best regards,
