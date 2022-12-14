Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEAC64C8CC
	for <lists+linux-pm@lfdr.de>; Wed, 14 Dec 2022 13:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiLNMRG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Dec 2022 07:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237905AbiLNMQd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Dec 2022 07:16:33 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A3223E84
        for <linux-pm@vger.kernel.org>; Wed, 14 Dec 2022 04:13:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a16so22215079edb.9
        for <linux-pm@vger.kernel.org>; Wed, 14 Dec 2022 04:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYg5KuFEQabZdeC10AfIOe5XfJbYs0kKYa96UQmZdEI=;
        b=XDam+7+IEdlLADRJ1HZSFH2kRZP6NCRLlZa61hhFta8gVUmikiyS6nZ7vWr1jxl0SB
         hfMImKkHh4ZD0gJfA7N1wLVW1NAtXcemWpEndBTJAbv3d2zAmniRvE7GxJOoiSN/nJat
         t0WZqHN4tT/6FST8c5NNOlce8B3T4b3t4wx9t7EtY9rLxZjlbIpFR/ArWSj76UZPFb8x
         3YqSOXQoHQcG5SMTmT5BMk9bTOImfUsEeXi4xbLl0jKqnWTgU1Ppe7skI2DPjWnScU8f
         Zri8IqpxS1HqRp25o4DYVGFqFffsuMOYEqgWyOsA20waNyW0uckd2YFEmluVP5nT6iRU
         1Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYg5KuFEQabZdeC10AfIOe5XfJbYs0kKYa96UQmZdEI=;
        b=K1qr6dW1MWQsMYDLW9RzevHZ5feuRsRDShswVY2fmsVcN4rlpyQlcqsp3agdDOCNVN
         ZQ7vZIUcHncAkO3ZTRTxpZjA4fHPPr8IOw9v09pOaRu/6EUukKE7f2pArA8a7OkyFINS
         mZcOPjpHXMNWFU+T8IdaM9UA5saeFXHIvdf3eGiXVesWhkQ0hXljFJWya7MlFxBlY2tP
         u7Q9FkVs/bft38WHf5uqZsPXTWbIMkpoyK+QawYbIxKs+eJ2p3Y74qUTHxtmI4aRXVVE
         4IjVT5bS6cuhyCiG5w7Obu31RTMli8cForwqbcOPoPRzOdY/VLOYhAb344aVZl7+iEbK
         K4QA==
X-Gm-Message-State: ANoB5pkz1PjO/MDjgnNUrzw/Vbc7/JV104B9LjY9FInyZ8W+zWM5uCrp
        hhwVIqf263oE4vMLaO6sH5UOSh/uSJNxEEkvjqc=
X-Google-Smtp-Source: AA0mqf5IoFIgm/I24G/vkOYo7cIUVkMHUa5P5dNS3UqZmLjZjDt89U717pGnTxdCBxJbDOObVOVqjgXErdHGw4F/07U=
X-Received: by 2002:a05:6402:120c:b0:46b:86:20b5 with SMTP id
 c12-20020a056402120c00b0046b008620b5mr47640172edw.130.1671020017953; Wed, 14
 Dec 2022 04:13:37 -0800 (PST)
MIME-Version: 1.0
Reply-To: mrs.maryander1957@gmail.com
Sender: mrsaminamohammed00025@gmail.com
Received: by 2002:a50:390b:0:b0:1ed:ea76:13b5 with HTTP; Wed, 14 Dec 2022
 04:13:37 -0800 (PST)
From:   Mrs Mary Anderson <amrsmary16@gmail.com>
Date:   Wed, 14 Dec 2022 12:13:37 +0000
X-Google-Sender-Auth: 5bJtJAxDtamJC4EhEUdlLwYtlFE
Message-ID: <CAO-RsLvXpcXL0QNwiQppn+89fd1W7UUqVCx-2wbaCb75kEBBDA@mail.gmail.com>
Subject: Dear Beloved,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrsaminamohammed00025[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrs.maryander1957[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [amrsmary16[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

Dear Beloved,

I am Mrs. Mary Anderson, It is understandable that you may be a bit
apprehensive because you do not know me, I found you email address
from a Human resources database and decided to contact you. I would
love to employ you into my charity work, I am ready to donate some
money to you to carry on the Charity work in your country. Please
reply so that i will give you further details and tell you about
myself.

Yours Sincerely
Mrs. Mary Anderson
