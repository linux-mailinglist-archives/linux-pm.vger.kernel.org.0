Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60C849D45E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jan 2022 22:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiAZVRY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 16:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiAZVRX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 16:17:23 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE3AC06173B
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 13:17:23 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id i10so2534114ybt.10
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 13:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=HeTNr01RtMT3y1jwaE5DwhIVcnFwpxWhUzqMArakIPa9fir0IEZO/BgW13/OBi1N0a
         YrEGhtDTlO4F9gL4q7viTBXUuj+PhllRCpGVB9DFuTWtVObLUUwafUlogMyFrJT+7n9J
         UaT+aiZTA7Cd/FWxMsBVzpRLNh8rq5denFgP5xrKFPlHQbJnaoaw8Qw7CXBGroOGbKIr
         isjbyPSRjdL/xPNGh/od79Qq3cPbg3DyO9EC71Fwr6teRHKk8D2gRMQpWqkPw8Rqsk0k
         E2Sh1eprmuR3v6KCt998J2c8nxfYivzKo7vH3cMjxO6u2bQ9sfw8TbOU/L8cEoDc8GYc
         REWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=wYHXbSIqU0Hdq78UwJlP6LMNK2UNcHzg/zBaTUtgpGC3Z5QtrpfzRPJYnR41uY6f7m
         ZQrpoIY3TUvwaG2yO8VZ4TOzlhpyXo+6UAEYgo75fJvJpmmiVL8OaVhwPkdKnBrKmJ4b
         HDfyDju7FPRzFQBhlaFBdHGavohgrZ3WCQ3T9TNXgvz56tZh42ITdMOerTVbdOoyjuaa
         ISbYdusJhmgqzasLQ9VepT0D11C0GJpJLIAz7vqepqRqOn6iB0DbxCutuBBdi3pJ6dbO
         s4NHg427Yx+8fsUyTE//2AwdunvyZhX9D1mdx3o7gnuBwKUl/5Ud/aO5pwJB1vhqjkjJ
         a04A==
X-Gm-Message-State: AOAM533LzUOB/evXovH7lCNiNKuwaU1NK5HAv3ROMrFmfWH/DxYr3Exr
        qRVAkGRUtK+dewLyCGXtii9a1BXDnMKRCDJdgA==
X-Google-Smtp-Source: ABdhPJwzTSn8awA/m/Z8j+shhGFcdRgYltLxXFeuvmlWzJvfCJM6KDiT6KJ6gjFe0ysgEAzpz338Z+ie8K/z55R9okU=
X-Received: by 2002:a25:25d0:: with SMTP id l199mr1180595ybl.454.1643231842154;
 Wed, 26 Jan 2022 13:17:22 -0800 (PST)
MIME-Version: 1.0
Reply-To: martinahrivnakova@post.cz
Sender: compensattionoffice26@gmail.com
Received: by 2002:a05:7000:bd9e:0:0:0:0 with HTTP; Wed, 26 Jan 2022 13:17:21
 -0800 (PST)
From:   HANNIBAL SEHESTED <a.mboma0@gmail.com>
Date:   Wed, 26 Jan 2022 22:17:21 +0100
X-Google-Sender-Auth: StG8Sb3O3DPYacQ6mybFwfse4nI
Message-ID: <CAGyEYSSmU1rCSy33GwftRwh+DUprmb_6eABNuNMnAQ+mpG_6YA@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


