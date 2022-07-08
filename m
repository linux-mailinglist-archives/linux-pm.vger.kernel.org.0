Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F9B56BD46
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jul 2022 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbiGHPQq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jul 2022 11:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiGHPQq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jul 2022 11:16:46 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ABD59277
        for <linux-pm@vger.kernel.org>; Fri,  8 Jul 2022 08:16:44 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k15so19999032iok.5
        for <linux-pm@vger.kernel.org>; Fri, 08 Jul 2022 08:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=vrQS/LlIulyYlkXBBH9HRrD0LEcs8mMtInf14LMYorQ=;
        b=BqAQdK1cp7aPF6dkOTpNvCs6Z0niL9fhF6JBqciHT60KkM05Pg/GhLK5Md+XdOV13G
         W80xuIWpw7w7NLH6zpKyNjigmo3+3mVGzQsRaVxSye9+SUbMOhXxC4iXJyvP8Qvr8VHp
         oB72VYK8Y0dsKTvibn/3cU66a4DuGOO5CoCiiM26t6wSUnTEAGlyttHRMI7VTV/CaY2Y
         8VygR7N7SVv1rFXebFNJ1AW4JOjPTcjN2c/Tzp2jfZnhvdbOBAZLhsF933WfdopP0EF7
         W4sU0kpzRr/4A3CVCfpCakuJs7CjXnrCaMJCqHY4MLJSRctLRlWC/ciai7fz+k6KULih
         POFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=vrQS/LlIulyYlkXBBH9HRrD0LEcs8mMtInf14LMYorQ=;
        b=VAR0tSVGHJBofVEWpLwXTX2emjga+FxtD+izzAw7UQSgxrHgczdYC4VpPsrP/5rnne
         RaRanVdCrbA1OFnKO6J7darIylBnX1dhoB+TDJo3RrpVYjycIDHwDROOmpSrTiNEd+87
         uq9sfayBsLba+2xxUMCqtyjyhQ3v1huEbwcGaY1c01Zh8vnl1cLgAEXXOZxvvyuntCqt
         Nqpbb18U2RskvUsow0z3kafxFKipwl6rYYlqa4g4Tbtu1niIhsknEvaw2cN0sD6LGELX
         rZQivAOSd2yZokaxQEwg8bEV+pjn+6QsbetCx7s73rcaPrnEHB2dk/cAayBfrh2PbDQT
         sD1Q==
X-Gm-Message-State: AJIora+xlniJWYC2HGevSys1XfETTBGpuBpoc55opG1a28bEkOaPY/JY
        Ne4XhMcLqOoAWlYBkAR/TE3DSAO8pPG+tEjtDTc=
X-Google-Smtp-Source: AGRyM1tx1vkQPSaQb3uyxDHVuG5BvI3FVaPagnLY5aTIxfaYvaOG/uM7XwrA/bIYUW+l9G39KpOQQ3bUswq5Wu6Twaw=
X-Received: by 2002:a02:6645:0:b0:33e:f553:3a74 with SMTP id
 l5-20020a026645000000b0033ef5533a74mr2460275jaf.0.1657293404355; Fri, 08 Jul
 2022 08:16:44 -0700 (PDT)
MIME-Version: 1.0
Sender: tinaevan101@gmail.com
Received: by 2002:a05:6e02:1605:0:0:0:0 with HTTP; Fri, 8 Jul 2022 08:16:44
 -0700 (PDT)
From:   Mira Thompson <mirathompson1010@gmail.com>
Date:   Fri, 8 Jul 2022 15:16:44 +0000
X-Google-Sender-Auth: gbMoRN-hQs574xXxRdw6cCCFLF8
Message-ID: <CALL7qtxcugKR_ObbMsuT-OOS-tn7hD64_=ng_H-YpVZfjn4Aug@mail.gmail.com>
Subject: Please reply to me as soon as possible okay.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

-- 
Hello sir.
Please I sent you a message and I have been waiting for your reply and
I could not see any. I want to know if you get any of my message to
you, kindly reply to me to notify me okay.
