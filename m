Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF834602C60
	for <lists+linux-pm@lfdr.de>; Tue, 18 Oct 2022 15:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJRNGB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Oct 2022 09:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiJRNF5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2022 09:05:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018A3C5129
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2022 06:05:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so17284789pjq.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2022 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIcJSjmyj8wnG5VFs+JiL9G2kqKZBCT633VYrUKLe84=;
        b=VkvQM5gxx4ABLOU9ihZoRTxZlQl2Z51gFfv9JDfTBGRKmqeqOKx2bFPYG84gnYMkYj
         r8rieo3qkPjJ+tb/MudakkOK+636EoLvWCg3p/Zy8oX4nNo8fAGEi7A4CReMW7hjNmF8
         Zziq3bR85k4ILLAQGjxMJ0oQDUhQs+pihpFoJSuHG8s4irtZOs2vOFwA7AvLxySX9p6P
         gP2a9PswWgb+9ckSMDQVgQxOGZIk4HWXe4Iv7qyHOfip49XOkhpJGOawr//i2ueIc0rE
         adIBd7SMQf1//dyRVDoWjiE3myXDnthxUUtC8uTSdbyTyqRYk/tPrP+NohxjATNcQu1W
         LNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIcJSjmyj8wnG5VFs+JiL9G2kqKZBCT633VYrUKLe84=;
        b=xjajwMQyhxGoh/KP8SeGZaCN612XHP2LedevLIK+iCHFNfpxVVGCEFkidr+fvywnoU
         a9ETv1DB7hfHUk3lX4C64VkZB/ld74D7wXBOB9grSgvTTYKVuRwEztpioJzVSe2ZDXWU
         IaSh1qL9MlvevnSsac3v4ZTrFlEvzAgK0VWLT+ha20P4zyTmZbJdksaeJbDLYY+DeyEY
         6L3Vy5kFfMcgVpAFaVXG0D9BDjLo/4dcYHWfWYeYdYmNNlFNzXBO9rMhNbr354giHpkw
         fUxQ3uVSpRZd+tAfL3bt3aZA3pFfkDF62BmPNgM6kCnPPaZ6fprsj4bmJolrvDVQHRPT
         Jalw==
X-Gm-Message-State: ACrzQf2Bi/Go3Qbgwb9nXSFW3Hp77P95jvRKH9nT0XUx6ngxOWEruIx/
        nZhIGBIFWTY/0518G67IiptdKqMTL5Ei08RXZFY=
X-Google-Smtp-Source: AMsMyM6BQ8AjmSi979SJM4C6MR/TasdJr5FRETUrOUUyDFYl/bmySg13MiWqCUMiCDdBS5OXQj7EJq3INK6cZcAl8wc=
X-Received: by 2002:a17:90b:314c:b0:20d:83c1:5297 with SMTP id
 ip12-20020a17090b314c00b0020d83c15297mr3510508pjb.18.1666098352018; Tue, 18
 Oct 2022 06:05:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:d10f:b0:2fc:7351:8c22 with HTTP; Tue, 18 Oct 2022
 06:05:51 -0700 (PDT)
Reply-To: thomasjoycetho12@gmail.com
From:   Joyce Thomas <joycethomasj5@gmail.com>
Date:   Tue, 18 Oct 2022 06:05:51 -0700
Message-ID: <CAG1cWb76dbbjLm6vyDzRjKjPsEFDs099D9kW35f-MvTf=ev97A@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5010]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [thomasjoycetho12[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [joycethomasj5[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [joycethomasj5[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Dearest one,
Good day to you today and how are you doing I hope all is well with
you; please did you receive the mail I sent to you since three days
ago?  Please can you be kindly get back to me  so that I will  know if
you received the mail I sent to you or not.
Best Regards,
Ms Joyce
