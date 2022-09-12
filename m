Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EF65B5CB3
	for <lists+linux-pm@lfdr.de>; Mon, 12 Sep 2022 16:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiILOve (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Sep 2022 10:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiILOvc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2022 10:51:32 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E7E33A29
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2022 07:51:31 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d25-20020a9d72d9000000b00655d70a1aeaso2937621otk.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2022 07:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=Kp7rHsZykhHetn/oXjjhkwKFbuAz0sIvGqSt9UTyuKsDmyV9TGbLsgouvv5b5wl0th
         beQ8SmOJLcvIwvco4tzbZT1Q7eWY3GSMdBAzfXdb7Kihq1zek4Ose50d19qbnTfYFbQt
         sMnkJanlkqbt4pp7i9KRuXHmHcBVvX4GY+z/KHfGww2dLXQf+GqCeOm2UC95fZYZ9WWW
         N0wdEVd6T3MDpYvA4ZJMoWnV+ZvTZ+/5QW770qa4W+t2vwq/dVI0/ahpu1EZGiocVK3m
         vN+4oYh93Z7G9Sv3qb3xhsdot1NufL88QGgTgQdg9bCQn7sEXz1E78M9rSd7zqMs++tg
         9fDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=aF9ScjoatNSXNYUen1n/A3zW9z+MjpX+A4GQNy9MUURe59ubi6vW1kk7brN95sVDZG
         FeLpriVMTjx/gjFLHhCYTNwFg+KJd91+QVIth5ARw4R2rvdFe6JHQqwcffmpmCMxLJ8N
         M7AOJkrPZkxheqAug9oOIEUrQnewHOlHijNAMJzSqvARrEQxBtfM5qOYcPsqh3FHR+pl
         7PzXRO0DV93LmkuLhjbD5u85W0ZZhqTmglLb8BSI/mgFrh5kph+F7rJ+SJbjUDek3ogz
         qJqrtwiogoM82RqVY99l1xfSjAl33gFU3k3ohagUmFb1YTmAsoYu+AtSd2fMSss2l4aR
         U0/g==
X-Gm-Message-State: ACgBeo1QInwGp1Nj8QJeQRMzpFQRD1iMMZ/ABnTOWEwU/Zvv6KtfxiKn
        SViAAR3/xPmfv9k1qBfRUl9NNme0eVgGYV8VAfg=
X-Google-Smtp-Source: AA6agR53kIrDdwNKDnZdbQhHm1JYiETjQFywYcHnMnc4EZ4dlE3cMRPp6GKXbcb2g9d/idLKk4/6ghc8zmkTCa6dx4Q=
X-Received: by 2002:a9d:7a8e:0:b0:655:e0a9:b3c6 with SMTP id
 l14-20020a9d7a8e000000b00655e0a9b3c6mr2545286otn.367.1662994290483; Mon, 12
 Sep 2022 07:51:30 -0700 (PDT)
MIME-Version: 1.0
Reply-To: edmondpamela60@gmail.com
Sender: b.donatusbrown808@gmail.com
Received: by 2002:a05:6358:2919:b0:b5:c1a9:732 with HTTP; Mon, 12 Sep 2022
 07:51:30 -0700 (PDT)
From:   Pamela Edmond <edmondpamela60@gmail.com>
Date:   Mon, 12 Sep 2022 14:51:30 +0000
X-Google-Sender-Auth: khJ70X_7QzJ5yULeAGfaKb5-hJQ
Message-ID: <CAAGWe+eXekfCA1XkuiVWffX=zCL5Pg-BGgyzCLphYMLudf_+iw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Good afternoon!

Recently I have forwarded you a necessary documentation.

Have you already seen it?
