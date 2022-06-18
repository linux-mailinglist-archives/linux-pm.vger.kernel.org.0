Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044435501FD
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jun 2022 04:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383861AbiFRCaN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 22:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiFRCaN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 22:30:13 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F34A69B64
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 19:30:12 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3176b6ed923so57128217b3.11
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 19:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=dcwrPtXldcZQuaUTRubP/TsWaJ05MpxYEGzdke58B18=;
        b=iWiJy7mjAoRvps48O4V/9DuAgx2o5BPbyBagNL1VmNJFyJxQJbuuRBMokOqy0xljz1
         qmJ6CbCW+emPjBYvX3+O3hIP69NT724nLvN4ifcCDrcQFXS0boENKH6OKh/GaG7bp5aW
         uSQH8PjQ1bSEe4JEMPfEpjEK+6OPWWZCxChdlqyVVE6I59Dmv3JS7CH/biPLGzObdWHm
         WZu7Azns1PXJ7npjsyJbdqzqO5vJgRgbW1OHAQ1P92ZUpVV2uDviFLGCk14pywaiI1q2
         lzmkqJ/5sdxUf/AY3h2XebT/LgbiWByYxAyUjWwqEuX0VDb72+0bI67cQS2B6ovYqRqK
         FZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=dcwrPtXldcZQuaUTRubP/TsWaJ05MpxYEGzdke58B18=;
        b=HtBEpYRKw599bQlwClSY4PO1YbCAzYYOn/BGrzRgVlkkxoVq85ZDZ4tRVwHNIsarGu
         96pYqlE/To8JYHTcB47YZzYENjUx0AdHIQjYJxlwg/bRyX+4kV/LkwBN/oHsCAwHeg5G
         xGpPI6mKoxlgfGyTffiHCXMsPqLWu5CkKmyNnWQ7Tu9CqHTSkE5efpmItT/Dkl58b9Fw
         RHyswp185EJHfDXpbGY8gZ2Qb84ly8CqIQXrX/wJHBTeeUakwR6qbc9ZYPuk1LmJExda
         NVaxzEOzelzKZKllnpxSy0PHblRZE5VOAwCpsnmS7N5O+lsqDoL6mNKfZ2H4qJhoDYH/
         hF2Q==
X-Gm-Message-State: AJIora+hdunE51YDylTcgleCWVu+ALMtshvOTw2FZs5umNYlWKOzd0E6
        mZA/3/W4iftt64H+x1WFj+c4QkSsk329apvk/HQ=
X-Google-Smtp-Source: AGRyM1tBUR8gtZ8zPk9JAJh0JPDEfE8ITJMoNoMKLp8SAdot4FO3bSmGPS0DNM6cQDoyb6LY/AFbBP4sEYSGqGo5lqE=
X-Received: by 2002:a81:1184:0:b0:317:7768:3050 with SMTP id
 126-20020a811184000000b0031777683050mr10554858ywr.368.1655519411273; Fri, 17
 Jun 2022 19:30:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:b381:0:0:0:0 with HTTP; Fri, 17 Jun 2022 19:30:10
 -0700 (PDT)
Reply-To: mrscecillelettytanm@gmail.com
From:   "Mrs.cecille Letty Tan" <smcpeterrobert@gmail.com>
Date:   Fri, 17 Jun 2022 19:30:10 -0700
Message-ID: <CAGzzBQ_MjWN8+xBCT-Rtbzutkdckjvv=Of=cP2BWuUim2PYGQA@mail.gmail.com>
Subject: Hello
To:     smcpeterrobert@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

How are you doing today, I hope you get my message urgently, please.
