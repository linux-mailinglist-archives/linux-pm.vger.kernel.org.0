Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DAE671C8F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 13:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjARMvv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 07:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjARMvf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 07:51:35 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1E9AA5C0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 04:12:40 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id u19so82681644ejm.8
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 04:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJcZxpyrwGsFLd0khHQDpi2RJfK7qh9/a4UC27izsOk=;
        b=At6V6LmpVZCQl1TGLLCGaCq8nvSvnGDown+WFGhJ0CWr7aZoHMRiesTxgBG6ajdw21
         iuU3MXlRWvfzbZSS0VFw0RdIfyeUtjfYHS/IAmRk6lWU+dDrZCMr/qTJJHQ12aQW8suR
         gk8MewMS9bS9WQJu68PePXX4tMJSpEUVsbaGORMO/zBq+owLRYTQl9zD2SspoVAaNPZN
         d9AT8VekWlPSM+CwgiaY1mm+ZZXG0JAwKiWsx9eW04Xx6R9uxa7xdvC+COjNBsz59cU1
         Ja29RThY2FUX/QfqRXkBjL1LQ/iqy5z0nOsfhkmVFu8XICVKC/qStqD4BdNWoRlUpaVg
         EXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJcZxpyrwGsFLd0khHQDpi2RJfK7qh9/a4UC27izsOk=;
        b=bvNG4bjAQ8BwnAAFXZ8N8VCUIL6vCVWE3DFwOfagR8X2lYTOH3EFeGDmiLvTNvAXkO
         eQvDfdOUwYP6BYFdZeYOUWgkPuY8VP+nKzVAuBS3fJZ4dRdo/UJmXedDzzcsMCVQqCya
         xTRvG8n5A0rxp6oe5kuHfzk6WHL1v3FRJXlT87EvktXlWrRmy+U0SwgpzWUAH5yECUzo
         4BDcg52Jiu56zwm5BqmLTzzbNNbbzPkSnMNkmlYXfDv2RTTB03X9Z58PmngM+HMXGvTZ
         cPuHASImCRAGIdggp0dktVEjYVAzI3QUwb41iCvCYe6tdpcctjPA6XgAoykrWpLqDgVy
         /IEw==
X-Gm-Message-State: AFqh2kreTwZEjgQuji+oYQzPwV1xL3n8K53MdhV3/DpFJJzlvle99mFB
        r7nCWFWKlrtY9am7ewU6h7nY30K1eJVIrm22U04=
X-Google-Smtp-Source: AMrXdXtBBaNCK2uM/GK+BilgvXJEf+ppiEwQ990VrL74XgKcaLTs+p+Zndq5y9e/gO/Lg0SEDPRmyv+q4KYpyUt4fz0=
X-Received: by 2002:a17:906:f0c6:b0:7c0:deb6:e13c with SMTP id
 dk6-20020a170906f0c600b007c0deb6e13cmr534873ejb.457.1674043958948; Wed, 18
 Jan 2023 04:12:38 -0800 (PST)
MIME-Version: 1.0
Sender: johncliff888@gmail.com
Received: by 2002:a05:640c:1fca:b0:1a0:53e4:7117 with HTTP; Wed, 18 Jan 2023
 04:12:38 -0800 (PST)
From:   "Mr. Omar Ousman" <mromarousman@gmail.com>
Date:   Wed, 18 Jan 2023 04:12:38 -0800
X-Google-Sender-Auth: fkOPEan5-5fOF_qDNMgHo2pF7KI
Message-ID: <CABmh+1k9zGYdP+eYo6OU+=rmmB1PBYTGZB1r0XqAv9chHZ+v7A@mail.gmail.com>
Subject: GREETINGS TO YOU., ...
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,MONEY_FORM_SHORT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_FILL_THIS_FORM_SHORT,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62d listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8436]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [johncliff888[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [johncliff888[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  0.0 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I'm Mr. Omar a regional managing director (CORIS BANK INTERNATIONAL)
Ouagadougou Burkina Faso, in my department we have US$ 9.5 million
united state dollars, to transfer into your account as a dormant
fund,If you are interested to use this fund to help the orphans around
the world contact me with my email address (mromarousman@gmail.com)
and your personal information's below

Your Full names.
Your Country of origin.
Your Occupation
Your Mobile Number

My Regards
