Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EB7511E9F
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 20:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbiD0QUp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243327AbiD0QTT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 12:19:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D01888C4
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 09:15:57 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q12so1801906pgj.13
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=LIYkXsh8NuZ+kWZJQV6Z3UgDflGRM7baotKUMbx/XVo=;
        b=qo1nsWBAXe85/hzUfFFJOA1q7UumPlcXwqkrBJ6IbTxtPnr5hSay0pApLr0/l9SnhL
         /8DHbXm9KPxIg5hhM/lZRWBRZolLSwpQRuHzX0YP+OB73UdoTFx9sfGs3QIV11yJpP+t
         XjREo+KOdlxtAojCJyPlkt4RuJkfqQzNPoJ6eYuxx6vWBtlxCl3qA6qgAXyM7L5sEqr2
         9cpwGGWSTFzjhSTxjsT2O4oKynICChcO+Mm0y//ZOajEi0MQvAFr1gDbxgNJuPkm6F6A
         G+L+nN4yfK82BpIlq/q3HAPOEXD6zHB6t9UuUchAEOOA7JEFWjh3DUkge0qXknd64qZf
         l/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=LIYkXsh8NuZ+kWZJQV6Z3UgDflGRM7baotKUMbx/XVo=;
        b=gakgjisAbGyPuTkSQKPuu30gJCjKv+sPVIrikww8DOm3TwF1BcxB0kVj0y2BVV3eWq
         Rc4viASiphb2ITuqFBts+tMR3C2sNiUK0PLr7VVTQUkZcozT0sTMXFGWNgDa/juxEEED
         z8KJHPsOvIVSjKdTJf65bDjjNmeQq147QkGn/MdeaVqJ5tvb3x1LE3HC/dME34aac/cr
         NyycyImkqBjtMZGC/Q+xT+1SHvQLxiMdjv6/wxFEE9qrjwMFfkbG7K9PM0HcZS3BpJli
         lar4gJnQV2NNcLmWA5+hBEL3aAIPryJ158hsH/qMoOWWWw8A/Wk0vqwQEvsCm/z5j8Ge
         hWPA==
X-Gm-Message-State: AOAM531ZMMNkX1jRsxBZFhj66S1sgK4U6H/Y5984CkbNmW/OLgcoXg0q
        n3eBL7ldgxVfYtm87VENP/r0peEiQatBkr8EsRk=
X-Google-Smtp-Source: ABdhPJzq7a9CBhwphTt1GdLkp0Vh1DaCipJx0hHBj1ibn2u8+LPC1Vocgyw7NEC5pu04SngDHlCbpcuBRJPD1A5wqH0=
X-Received: by 2002:a05:6a00:ad0:b0:4e1:2d96:2ab0 with SMTP id
 c16-20020a056a000ad000b004e12d962ab0mr30757259pfl.3.1651076134317; Wed, 27
 Apr 2022 09:15:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:534b:b0:59:868b:c470 with HTTP; Wed, 27 Apr 2022
 09:15:33 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Mr. KAbore Aouessian" <kiboraouessian@gmail.com>
Date:   Wed, 27 Apr 2022 09:15:33 -0700
Message-ID: <CALGXYcShy=9dZu-CP3dOHX57dG7MAnfxZ99N9e8wsrm9bOHEMw@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:52b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4890]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kiboraouessian[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

-- 
Greetings,
I'm Mr. KAbore Aouessian, how are you doing hope you are in good
health, the Board irector try to reach you on phone several times
Meanwhile, your number was not connecting. before he ask me to send
you an email to hear from you if you are fine. hope to hear you are in
good Health.

Thanks,
Mr. KAbore Aouessian.
